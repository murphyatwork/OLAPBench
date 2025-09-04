#!/usr/bin/env python3
import argparse
import csv
import json
import math
import os
import statistics
from typing import Dict, List, Tuple
import sys


def load_csv(path: str) -> List[Dict[str, str]]:
    # Allow very large fields (e.g., result/plan columns)
    try:
        csv.field_size_limit(sys.maxsize)
    except Exception:
        pass
    with open(path, 'r') as f:
        return list(csv.DictReader(f))


def parse_times(cell: str) -> List[float]:
    try:
        arr = json.loads(cell, allow_nan=True)
        return [float(x) for x in arr if isinstance(x, (int, float))]
    except Exception:
        return []


def _parse_float_safe(value: str) -> float:
    try:
        v = float(value)
        if math.isnan(v):
            return math.nan
        return v
    except Exception:
        return math.nan


def aggregate(rows: List[Dict[str, str]]) -> Dict[str, Dict[str, any]]:
    out: Dict[str, Dict[str, any]] = {}
    for r in rows:
        name = r["query"].strip()
        state = r["state"].strip()
        med = _parse_float_safe(r.get("client_total_median", "nan"))
        if math.isnan(med):
            client_total = parse_times(r.get("client_total", "[]"))
            if len(client_total) > 0:
                try:
                    med = statistics.median(client_total)
                except Exception:
                    med = math.nan
        if math.isnan(med):
            # final fallback to total_median / execution_median if present
            med = _parse_float_safe(r.get("total_median", "nan"))
        if math.isnan(med):
            med = _parse_float_safe(r.get("execution_median", "nan"))
        out[name] = {
            "state": state,
            "median_ms": med,
        }
    return out


def read_sample(path: str) -> List[str]:
    names: List[str] = []
    with open(path, 'r') as f:
        for line in f:
            s = line.strip()
            if not s or s.startswith('#'):
                continue
            names.append(s)
    return names


def format_ms(v: float) -> str:
    if math.isnan(v):
        return "nan"
    return f"{v:.2f}"


def format_ratio(v: float) -> str:
    if math.isnan(v):
        return "nan"
    return f"{v:.2f}"


def _infer_sample_path(csv_path: str) -> str:
    # try replacing .csv with .sample.txt
    if csv_path.endswith('.csv'):
        candidate = csv_path[:-4] + '.sample.txt'
        if os.path.exists(candidate):
            return candidate
    # try sibling .sample.txt in same directory
    dirname = os.path.dirname(csv_path)
    try:
        for f in os.listdir(dirname):
            if f.endswith('.sample.txt'):
                return os.path.join(dirname, f)
    except Exception:
        pass
    return ''


def _choose_label(rows: List[Dict[str, str]], fallback: str) -> str:
    try:
        titles = [r.get('title') for r in rows if r.get('title')]
        if titles:
            return titles[0]
    except Exception:
        pass
    return fallback


def main():
    base = os.path.dirname(os.path.dirname(__file__))

    parser = argparse.ArgumentParser(description='Compare two OLAPBench result CSVs')
    parser.add_argument('--left-csv', type=str, help='Path to left CSV (e.g., StarRocks)')
    parser.add_argument('--right-csv', type=str, help='Path to right CSV (e.g., DuckDB)')
    parser.add_argument('--sample', type=str, default='', help='Optional sample manifest (.sample.txt). If omitted, inferred from CSVs')
    parser.add_argument('--left-label', type=str, default='', help='Optional label override for left')
    parser.add_argument('--right-label', type=str, default='', help='Optional label override for right')
    parser.add_argument('--output', type=str, default='', help='Optional output markdown file path')
    args = parser.parse_args()

    # Defaults preserve previous behavior if not provided
    left_csv = args.left_csv or os.path.join(base, 'results', 'starrocks_tpch', 'tpchSf10_queries_sqlstorm_v1.0.csv')
    right_csv = args.right_csv or os.path.join(base, 'results', 'duckdb_tpch', 'tpchSf10_queries_sqlstorm_v1.0.csv')

    # Load rows
    left_rows = load_csv(left_csv)
    right_rows = load_csv(right_csv)

    # Determine labels
    left_label = args.left_label or _choose_label(left_rows, os.path.basename(os.path.dirname(left_csv)))
    right_label = args.right_label or _choose_label(right_rows, os.path.basename(os.path.dirname(right_csv)))

    # Determine sample
    sample_path = args.sample
    if not sample_path:
        # prefer right, then left
        cand_right = _infer_sample_path(right_csv)
        cand_left = _infer_sample_path(left_csv)
        sample_path = cand_right or cand_left

    if sample_path and os.path.exists(sample_path):
        sample = read_sample(sample_path)
    else:
        # Fallback: intersect queries present in both CSVs
        left_q = {r['query'] for r in left_rows if 'query' in r}
        right_q = {r['query'] for r in right_rows if 'query' in r}
        sample = sorted(list(left_q & right_q))

    left = aggregate(left_rows)
    right = aggregate(right_rows)

    total = len(sample)
    matched = 0
    sr_ok = sr_err = sr_timeout = sr_other = 0
    dd_ok = dd_err = dd_timeout = dd_other = 0

    sr_times: List[float] = []
    dd_times: List[float] = []

    per_query: List[Tuple[str, str, float, str, float, float]] = []  # (name, left_state, left_ms, right_state, right_ms, ratio)

    for name in sample:
        if name not in left or name not in right:
            continue
        matched += 1
        s = left[name]
        d = right[name]

        s_ms = s["median_ms"]
        d_ms = d["median_ms"]
        ratio = math.nan
        if (
            s["state"] == 'success' and d["state"] == 'success' and
            not math.isnan(s_ms) and not math.isnan(d_ms) and d_ms > 0
        ):
            try:
                ratio = s_ms / d_ms
            except Exception:
                ratio = math.nan

        per_query.append((name, s["state"], s_ms, d["state"], d_ms, ratio))

        if s["state"] == 'success' and not math.isnan(s["median_ms"]):
            sr_ok += 1
            if s["median_ms"] > 0:
                sr_times.append(s["median_ms"])
        elif s["state"] == 'timeout':
            sr_timeout += 1
        elif s["state"] == 'error':
            sr_err += 1
        else:
            sr_other += 1

        if d["state"] == 'success' and not math.isnan(d["median_ms"]):
            dd_ok += 1
            if d["median_ms"] > 0:
                dd_times.append(d["median_ms"])
        elif d["state"] == 'timeout':
            dd_timeout += 1
        elif d["state"] == 'error':
            dd_err += 1
        else:
            dd_other += 1

    def stats(times: List[float]) -> Tuple[float, float, float]:
        if not times:
            return (math.nan, math.nan, math.nan)
        return (sum(times), statistics.geometric_mean([t for t in times if t > 0]) if any(t > 0 for t in times) else math.nan, statistics.median(times))

    sr_sum, sr_geo, sr_med = stats(sr_times)
    dd_sum, dd_geo, dd_med = stats(dd_times)

    out_path = args.output or os.path.join(base, 'results', f'comparison_{left_label}_vs_{right_label}.md')
    # Sort per-query by ratio descending, invalid ratios at the bottom
    def _per_query_sort_key(item: Tuple[str, str, float, str, float, float]):
        r = item[5]
        if math.isnan(r):
            return (1, 0.0)
        return (0, -r)

    per_query_sorted = sorted(per_query, key=_per_query_sort_key)

    with open(out_path, 'w') as out:
        out.write(f"## Comparison ({left_label} vs {right_label})\n\n")
        out.write(f"Sample size: {total}, matched rows: {matched}\n\n")
        out.write("### Summary\n")
        out.write(f"- {left_label}: ")
        out.write(f"success={sr_ok}, error={sr_err}, timeout={sr_timeout}, other={sr_other}, ")
        out.write(f"sum={format_ms(sr_sum)} ms, geomean={format_ms(sr_geo)} ms, median={format_ms(sr_med)} ms\n")
        out.write(f"- {right_label}: ")
        out.write(f"success={dd_ok}, error={dd_err}, timeout={dd_timeout}, other={dd_other}, ")
        out.write(f"sum={format_ms(dd_sum)} ms, geomean={format_ms(dd_geo)} ms, median={format_ms(dd_med)} ms\n\n")

        out.write("### Per-query (name, state/median_ms/ratio)\n\n")
        out.write(f"| name | {left_label} state | {left_label} median_ms | {right_label} state | {right_label} median_ms | ratio({left_label}/{right_label}) |\n")
        out.write("|---|---|---:|---|---:|---:|\n")
        for name, s_state, s_ms, d_state, d_ms, ratio in per_query_sorted:
            out.write(f"| {name} | {s_state} | {format_ms(s_ms)} | {d_state} | {format_ms(d_ms)} | {format_ratio(ratio)} |\n")

    print(f"Wrote report: {out_path}")


if __name__ == '__main__':
    main()


