#!/usr/bin/env python3
"""
Summarize slowest_operator JSON outputs into a CSV table.

Input: a directory containing many JSON files, each produced by
  benchmark/tools/extract_slowest_operator.py --json

Output CSV rows: one per input file (basename)
Columns: per operator TopMetrics metric, labeled as
  "<Operator>:<MetricName>_ms" and/or "<Operator>:<MetricName>_percent"
Values: metric value in milliseconds and/or percent, rounded to 3 decimals

Additionally, four summary rows are appended at the end:
- count: number of non-empty values per column
- sum: sum over rows (numeric)
- geomean: geometric mean over strictly positive values
- mean: arithmetic mean over non-empty values

Usage:
  python3 benchmark/tools/summarize_profile_analysis_csv.py \
    --input /path/to/results/profile_analysis \
    --output /path/to/summary.csv \
    [--value both|ms|percent]
"""

from __future__ import annotations

import argparse
import csv
import json
import os
from typing import Dict, List, Tuple
import sys


def collect_files(input_dir: str) -> List[str]:
    files: List[str] = []
    try:
        for name in os.listdir(input_dir):
            if name.endswith('.json'):
                files.append(os.path.join(input_dir, name))
    except FileNotFoundError:
        return []
    files.sort()
    return files


def load_json(path: str):
    with open(path, 'r', encoding='utf-8', errors='ignore') as f:
        return json.load(f)


def metric_columns_and_rows(paths: List[str], value_kind: str) -> Tuple[List[str], List[Tuple[str, Dict[str, str]]]]:
    # First pass: discover all columns (without plan_node_id); aggregate duplicate operator metrics per file
    columns_set = set()
    rows: List[Tuple[str, Dict[str, str]]] = []

    import statistics
    for p in paths:
        try:
            data = load_json(p)
        except Exception:
            continue

        # Aggregator for this file:
        #  if both: { "Operator:Metric_ms" -> float, "Operator:Metric_percent" -> float }
        #  else:    { "Operator:Metric" -> float }
        row_acc: Dict[str, float] = {}
        # Estimate total query time (ms) from TopMetrics ms/percent
        total_ms_candidates: List[float] = []

        if isinstance(data, list):
            for entry in data:
                operator = entry.get('Operator') or entry.get('operator') or 'UNKNOWN'
                top_metrics = entry.get('TopMetrics') or []
                for m in top_metrics:
                    metric_name = m.get('metric') or 'UNKNOWN_METRIC'
                    if value_kind == 'both':
                        # ms
                        val_ms = m.get('ms')
                        if val_ms is not None:
                            try:
                                v = float(val_ms)
                                col_ms = f"{operator}:{metric_name}_ms"
                                row_acc[col_ms] = row_acc.get(col_ms, 0.0) + v
                            except (TypeError, ValueError):
                                pass
                        # percent
                        val_pct = m.get('TimePercent')
                        if val_pct is not None:
                            try:
                                v = float(val_pct)
                                col_pct = f"{operator}:{metric_name}_percent"
                                row_acc[col_pct] = row_acc.get(col_pct, 0.0) + v
                            except (TypeError, ValueError):
                                pass
                        # candidate for total ms
                        if val_ms is not None and val_pct is not None:
                            try:
                                msf = float(val_ms)
                                pf = float(val_pct)
                                if pf > 0:
                                    total_ms_candidates.append(msf / pf)
                            except (TypeError, ValueError):
                                pass
                    else:
                        col = f"{operator}:{metric_name}"
                        if value_kind == 'percent':
                            val = m.get('TimePercent')
                        else:
                            val = m.get('ms')
                        if val is None:
                            continue
                        try:
                            v = float(val)
                        except (TypeError, ValueError):
                            continue
                        row_acc[col] = row_acc.get(col, 0.0) + v
                        # candidate for total ms
                        other = m.get('ms') if value_kind == 'percent' else m.get('TimePercent')
                        if val is not None and other is not None:
                            try:
                                msf = float(m.get('ms') or 0)
                                pf = float(m.get('TimePercent') or 0)
                                if msf > 0 and pf > 0:
                                    total_ms_candidates.append(msf / pf)
                            except (TypeError, ValueError):
                                pass

        # Update global columns set and build formatted row map
        # Add total(ms) if estimated
        if total_ms_candidates:
            try:
                total_ms = statistics.median(total_ms_candidates)
                row_acc['Total(ms)'] = total_ms
            except statistics.StatisticsError:
                pass
        for col in row_acc.keys():
            columns_set.add(col)
        row_formatted: Dict[str, str] = {k: f"{v:.3f}" for k, v in row_acc.items()}

        base = os.path.basename(p)
        parts = base.split('.')
        if len(parts) >= 2:
            file_label = parts[0] + '.' + parts[1]
        else:
            file_label = base
        rows.append((file_label, row_formatted))

    columns = sorted(columns_set)
    return columns, rows


def write_csv(columns: List[str], rows: List[Tuple[str, Dict[str, str]]], output_path: str | None):
    # Ensure Total(ms) appears first if present
    columns_sorted = columns[:]
    if 'Total(ms)' in columns_sorted:
        columns_sorted.remove('Total(ms)')
        columns_sorted = ['Total(ms)'] + columns_sorted
    header = ['file'] + columns_sorted
    if output_path:
        out_f = open(output_path, 'w', encoding='utf-8', newline='')
        close_needed = True
    else:
        out_f = None
        close_needed = False

    try:
        if out_f is None:
            writer = csv.writer(sys.stdout)
        else:
            writer = csv.writer(out_f)
        try:
            writer.writerow(header)
            # Accumulators for summary stats
            col_values: Dict[str, List[float]] = {c: [] for c in columns_sorted}

            for file_name, row_map in rows:
                row = [file_name]
                for c in columns_sorted:
                    sval = row_map.get(c, '')
                    row.append(sval)
                    if sval != '':
                        try:
                            col_values[c].append(float(sval))
                        except ValueError:
                            pass
                writer.writerow(row)

            # Build summary rows
            import math
            def fmt(x: float | None) -> str:
                return f"{x:.3f}" if x is not None else ''

            # count
            row = ['count']
            for c in columns_sorted:
                row.append(str(len(col_values[c])) if col_values[c] else '')
            writer.writerow(row)

            # sum
            row = ['sum']
            for c in columns_sorted:
                vals = col_values[c]
                row.append(fmt(sum(vals)) if vals else '')
            writer.writerow(row)

            # geomean over strictly positive values
            row = ['geomean']
            for c in columns_sorted:
                vals_pos = [v for v in col_values[c] if v > 0]
                if not vals_pos:
                    row.append('')
                else:
                    gm = math.exp(sum(math.log(v) for v in vals_pos) / len(vals_pos))
                    row.append(fmt(gm))
            writer.writerow(row)

            # mean over non-empty values
            row = ['mean']
            for c in columns_sorted:
                vals = col_values[c]
                if not vals:
                    row.append('')
                else:
                    row.append(fmt(sum(vals) / len(vals)))
            writer.writerow(row)
        except BrokenPipeError:
            # Allow piping to head/tail without noisy tracebacks
            pass
    finally:
        if close_needed and out_f is not None:
            out_f.close()


def write_html(columns: List[str], rows: List[Tuple[str, Dict[str, str]]], output_path: str | None, title: str = 'Profile Analysis'):
    # Build table data with summary rows (reuse logic similar to CSV)
    # Prepare numeric collections per column for summary and for coloring (exclude summary rows while computing color scale)
    # First, compute per-column numeric lists from data rows
    def to_float_or_none(s: str) -> float | None:
        try:
            return float(s)
        except Exception:
            return None

    # Build matrix of row values (strings) and collect numeric values for color scaling
    data_rows = []  # list of (label, [cell_str...])
    col_numeric_values: Dict[str, List[float]] = {c: [] for c in columns}
    for label, row_map in rows:
        row_vals = []
        for c in columns:
            sval = row_map.get(c, '')
            row_vals.append(sval)
            fv = to_float_or_none(sval)
            if fv is not None and label not in ('count', 'sum', 'geomean', 'mean'):
                col_numeric_values[c].append(fv)
        data_rows.append((label, row_vals))

    # Append summary rows (compute from rows as already formatted strings)
    import math
    def fmt(x: float | None) -> str:
        return f"{x:.3f}" if x is not None else ''

    # Recompute summary over numeric values in rows (excluding blanks)
    col_values_all: Dict[str, List[float]] = {c: [] for c in columns}
    for _, row_vals in data_rows:
        for idx, c in enumerate(columns):
            sval = row_vals[idx]
            fv = to_float_or_none(sval)
            if fv is not None:
                col_values_all[c].append(fv)

    def build_summary_row(name: str) -> list[str]:
        row = [name]
        if name == 'count':
            for c in columns:
                row.append(str(len(col_values_all[c])) if col_values_all[c] else '')
        elif name == 'sum':
            for c in columns:
                vals = col_values_all[c]
                row.append(fmt(sum(vals)) if vals else '')
        elif name == 'geomean':
            for c in columns:
                vals_pos = [v for v in col_values_all[c] if v > 0]
                if not vals_pos:
                    row.append('')
                else:
                    gm = math.exp(sum(math.log(v) for v in vals_pos) / len(vals_pos))
                    row.append(fmt(gm))
        elif name == 'mean':
            for c in columns:
                vals = col_values_all[c]
                if not vals:
                    row.append('')
                else:
                    row.append(fmt(sum(vals) / len(vals)))
        return row

    # Build summary rows (fixed order and fixed position at top)
    summary_rows: List[tuple[str, list[str]]] = []
    for name in ('count', 'sum', 'geomean', 'mean'):
        full = build_summary_row(name)
        summary_rows.append((full[0], full[1:]))

    # Group columns by operator and metric for multi-level header
    from collections import defaultdict
    group_map: Dict[str, Dict[str, Dict[str, int]]] = defaultdict(lambda: defaultdict(dict))
    for idx, c in enumerate(columns):
        if ':' in c:
            op, rest = c.split(':', 1)
        else:
            op, rest = c, ''
        kind = 'value'
        metric = rest
        if rest.endswith('_ms'):
            kind = 'ms'
            metric = rest[:-3]
        elif rest.endswith('_percent'):
            kind = 'percent'
            metric = rest[:-8]
        group_map[op][metric][kind] = idx

    # Order operators by descending total sum across all their subcolumns
    op_scores: Dict[str, float] = {}
    for op, metric_map in group_map.items():
        total = 0.0
        for kinds in metric_map.values():
            for orig_idx in kinds.values():
                col_name = columns[orig_idx]
                vals = col_values_all.get(col_name)
                if vals:
                    total += sum(vals)
        op_scores[op] = total
    operators_sorted = sorted(group_map.keys(), key=lambda o: op_scores.get(o, 0.0), reverse=True)
    kinds_order = ['ms', 'percent', 'value']
    flat_col_indices: List[int] = []
    flat_col_labels: List[str] = []
    flat_col_ops: List[str] = []
    operator_spans: List[tuple[str, int]] = []
    for op in operators_sorted:
        # Order metrics within a group by descending sum across all files and subcolumns
        def metric_score(metric_name: str) -> float:
            kinds = group_map[op][metric_name]
            score = 0.0
            for orig_idx in kinds.values():
                col_name = columns[orig_idx]
                vals = col_values_all.get(col_name)
                if vals:
                    score += sum(vals)
            return score

        metrics_sorted = sorted(group_map[op].keys(), key=metric_score, reverse=True)
        span = 0
        for metric in metrics_sorted:
            kinds = group_map[op][metric]
            for kind in kinds_order:
                if kind in kinds:
                    flat_col_indices.append(kinds[kind])
                    # Simplify metric name by removing trailing 'Time'
                    metric_short = metric[:-4] if metric.endswith('Time') else metric
                    label = metric_short if kind == 'value' else f"{metric_short} ({'%' if kind=='percent' else 'ms'})"
                    flat_col_labels.append(label)
                    flat_col_ops.append(op)
                    span += 1
        operator_spans.append((op, span))

    # Color mapping per flattened column
    col_max: Dict[int, float] = {}
    for new_idx, orig_idx in enumerate(flat_col_indices):
        orig_col = columns[orig_idx]
        vals = col_numeric_values[orig_col]
        col_max[new_idx] = max(vals) if vals else 0.0

    # Assign hues per group (each operator group uses one hue)
    nops = max(1, len(operators_sorted))
    op_to_hue: Dict[str, float] = {op: (idx * 360.0 / nops) for idx, op in enumerate(operators_sorted)}

    # Generate HTML with inline CSS and minimal JS for sorting
    def html_escape(s: str) -> str:
        return (s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;'))

    html_parts: List[str] = []
    html_parts.append('<!doctype html>')
    html_parts.append('<html><head><meta charset="utf-8"/>')
    html_parts.append(f'<title>{html_escape(title)}</title>')
    html_parts.append('<style>')
    html_parts.append('body{font-family:Arial,Helvetica,sans-serif;margin:16px;}')
    # Fix table width to a reasonable size; use container scroll when overflowing (doubled)
    html_parts.append('table{border-collapse:collapse;width:3200px;table-layout:fixed;}')
    html_parts.append('th,td{border:1px solid #ddd;padding:4px 6px;font-size:12px;white-space:nowrap;}')
    html_parts.append('th{position:sticky;top:0;background:#fafafa;cursor:pointer;}')
    html_parts.append('tr:nth-child(even){background:#fcfcfc;}')
    html_parts.append('.right{text-align:right;} .left{text-align:left;}')
    html_parts.append('.desc{font-size:18px;color:#374151;margin:28px 0 12px;}')
    html_parts.append('.desc code{background:#f3f4f6;padding:0 3px;border-radius:3px;}')
    html_parts.append('.active-col-header{outline:2px solid #f97316; outline-offset:-2px;}')
    html_parts.append('.active-col-cell{outline:2px solid #f97316; outline-offset:-2px;}')
    html_parts.append('</style>')
    html_parts.append('</head><body>')
    html_parts.append(f'<h3>{html_escape(title)}</h3>')
    html_parts.append('<div class="desc">')
    html_parts.append('<p>Grouped by Operator. Each group shows its metrics as sub-columns (ms and %). '
                      'Cell color intensity reflects the value normalized within that metric column.</p>')
    html_parts.append('<p>Default ordering: operator groups are sorted by the total <code>sum</code> across all files '
                      'and all sub-columns, in descending order.</p>')
    html_parts.append('<p>Sorting: click any metric header to sort rows (files) by that column in descending order. '
                      'The four summary rows (count/sum/geomean/mean) remain fixed at the top.</p>')
    html_parts.append('</div>')
    html_parts.append('<div style="overflow:auto; max-height: 80vh;">')
    html_parts.append('<table id="summaryTbl">')
    # Header with operator groups and metric subheaders
    html_parts.append('<thead>')
    # Group header row
    html_parts.append('<tr>')
    html_parts.append('<th data-col="-1" class="left" rowspan="2" title="file">file</th>')
    for op, span in operator_spans:
        if span > 0:
            html_parts.append(f'<th colspan="{span}" class="right" title="{html_escape(op)}">{html_escape(op)}</th>')
    html_parts.append('</tr>')
    # Subheader row (metrics)
    html_parts.append('<tr>')
    for i, label in enumerate(flat_col_labels):
        op = flat_col_ops[i]
        html_parts.append(f'<th class="right" data-op="{html_escape(op)}" data-subcol="{i}" title="{html_escape(label)}">{html_escape(label)}</th>')
    html_parts.append('</tr>')
    html_parts.append('</thead>')
    # Body
    html_parts.append('<tbody>')
    # Render summary rows first (fixed, not sortable), then data rows
    for label, row_vals in summary_rows + data_rows:
        html_parts.append('<tr>')
        html_parts.append(f'<td class="left">{html_escape(str(label))}</td>')
        is_summary_row = str(label) in ('count', 'sum', 'geomean', 'mean')
        for new_idx, orig_idx in enumerate(flat_col_indices):
            sval = row_vals[orig_idx]
            # background color based on normalized value
            if is_summary_row:
                # No background color for summary rows
                html_parts.append(f'<td class="right" data-col="{new_idx}" data-val="" style="background:none">{html_escape(sval)}</td>')
            else:
                fv = to_float_or_none(sval)
                norm = 0.0
                mx = col_max.get(new_idx, 0.0)
                if fv is not None and mx > 0:
                    norm = max(0.0, min(1.0, fv / mx))
                # Use one hue per operator group, vary lightness within the group
                op = flat_col_ops[new_idx]
                hue = op_to_hue.get(op, 200)
                light = 95 - int(norm * 55)  # 95% -> 40%
                bg = f'hsl({int(hue)},70%,{light}%)'
                html_parts.append(f'<td class="right" data-col="{new_idx}" data-val="{fv if fv is not None else ""}" style="background:{bg}">{html_escape(sval)}</td>')
        html_parts.append('</tr>')
    html_parts.append('</tbody>')
    html_parts.append('</table>')
    html_parts.append('</div>')

    # Minimal sorting: metric header click sorts rows by that column (summary rows fixed on top)
    html_parts.append('<script>\n(function(){\n'
                      '  const tbl = document.getElementById("summaryTbl");\n'
                      '  function splitRows(tbody){\n'
                      '    const all = Array.from(tbody.rows);\n'
                      '    const summary = all.slice(0,4);\n'
                      '    const data = all.slice(4);\n'
                      '    return {summary, data};\n'
                      '  }\n'
                      '  const sub = tbl.tHead.rows[1].cells;\n'
                      '  let activeCol = null;\n'
                      '  function setActive(ci){\n'
                      '    if(activeCol !== null){\n'
                      '      sub[activeCol].classList.remove("active-col-header");\n'
                      '      tbl.querySelectorAll(`td[data-col="${activeCol}"]`).forEach(c=>c.classList.remove("active-col-cell"));\n'
                      '    }\n'
                      '    activeCol = ci;\n'
                      '    sub[ci].classList.add("active-col-header");\n'
                      '    tbl.querySelectorAll(`td[data-col="${ci}"]`).forEach(c=>c.classList.add("active-col-cell"));\n'
                      '  }\n'
                      '  function sortBy(col){\n'
                      '    const tbody = tbl.tBodies[0];\n'
                      '    const {summary, data} = splitRows(tbody);\n'
                      '    data.sort((a,b)=>{\n'
                      '      const av = parseFloat(a.cells[col+1].getAttribute("data-val"));\n'
                      '      const bv = parseFloat(b.cells[col+1].getAttribute("data-val"));\n'
                      '      const aa = isNaN(av) ? -Infinity : av;\n'
                      '      const bb = isNaN(bv) ? -Infinity : bv;\n'
                      '      return bb - aa;\n'
                      '    });\n'
                      '    [...summary, ...data].forEach(r=>tbody.appendChild(r));\n'
                      '    setActive(col);\n'
                      '  }\n'
                      '  for(let i=0;i<sub.length;i++){\n'
                      '    ((ci)=>{ sub[ci].style.cursor = "pointer"; sub[ci].addEventListener("click", ()=>sortBy(ci)); })(i);\n'
                      '  }\n'
                      '})();\n</script>')
    html_parts.append('</body></html>')

    html_str = '\n'.join(html_parts)
    if output_path:
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html_str)
    else:
        try:
            sys.stdout.write(html_str)
        except BrokenPipeError:
            pass


def main():
    parser = argparse.ArgumentParser(description='Summarize slowest_operator JSON outputs into a CSV table')
    parser.add_argument('--input', required=True, help='Directory containing *.json files produced by extract_slowest_operator --json')
    parser.add_argument('--output', help='Output path (CSV or HTML depending on --format, default: stdout)')
    parser.add_argument('--value', choices=['both', 'ms', 'percent'], default='both', help='Metric value(s) to export (default: both)')
    parser.add_argument('--format', choices=['csv', 'html'], default='csv', help='Output format (default: csv)')
    args = parser.parse_args()

    paths = collect_files(args.input)
    if not paths:
        raise SystemExit(f'No json files found under: {args.input}')

    columns, rows = metric_columns_and_rows(paths, args.value)
    if args.format == 'html':
        write_html(columns, rows, args.output, title='Profile Analysis Summary')
    else:
        write_csv(columns, rows, args.output)


if __name__ == '__main__':
    main()


