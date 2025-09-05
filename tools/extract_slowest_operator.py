#!/usr/bin/env python3
"""
Extract the slowest operator(s) profile from a StarRocks runtime profile file.

The profile format is pseudo-YAML with hierarchical sections:
  - Fragment N:
      Pipeline (id=X):
          OPERATOR_NAME (plan_node_id=...):
              CommonMetrics:
                - OperatorTotalTime: ...

We scan all operators, parse OperatorTotalTime, pick the top-N (default 1),
and output their full profile blocks exactly as they appear in the file,
along with context.

Usage:
  python3 benchmark/tools/extract_slowest_operator.py /path/to/profile [-n TOP] [--json]
  
Notes:
- Inside each operator's UniqueMetrics block, time-like metrics (keys containing 'Time')
  are reordered in descending duration while keeping their nested details together.
  Non-time metrics remain, appended after time metrics in their original order.
"""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from typing import List, Optional, Tuple
import json


_RE_FRAGMENT = re.compile(r"^\s*Fragment\s+(\d+):\s*$")
_RE_PIPELINE = re.compile(r"^\s*Pipeline\s*\(id=(\d+)\):\s*$")
# Operator header: ALLCAPS plus underscores and spaces, optional (plan_node_id=..):
_RE_OPERATOR_HDR = re.compile(
    r"^(?P<indent>\s+)(?P<name>[A-Z][A-Z0-9_ ]*)(?:\s*\(plan_node_id=(?P<pid>[^)]*)\))?:\s*$"
)
_RE_OPERATOR_TOTAL = re.compile(r"^\s*-\s*OperatorTotalTime:\s*(?P<val>.+?)\s*$")
_RE_BULLET_KV = re.compile(r"^\s*-\s*(?P<key>[^:]+):\s*(?P<val>.*?)\s*$")
_RE_QUERY_EXEC_WALL = re.compile(r"^\s*-\s*QueryExecutionWallTime:\s*(?P<val>.+?)\s*$")


@dataclass
class OperatorContext:
    fragment_id: Optional[int]
    pipeline_id: Optional[int]
    plan_node_id: Optional[int]
    operator_name: str
    operator_total_ns: int
    operator_total_str: str
    block_lines: List[str]
    # Lazily materialized version of block_lines with UniqueMetrics reordered
    block_lines_reordered: Optional[List[str]] = None


def _parse_time_to_ns(value: str) -> int:
    """Parse StarRocks time strings like '1s474ms', '85.6us', '0ns' into nanoseconds.

    Supports concatenated units without spaces. Recognized units: h, m, s, ms, us/µs, ns.
    """
    s = value.strip()
    if not s or s == "0":
        return 0

    # Remove spaces to normalize forms like "1.23 ms" → "1.23ms"
    s = s.replace(" ", "")

    # Map units to multipliers in nanoseconds
    unit_to_ns = {
        "h": 3_600_000_000_000,
        "m": 60_000_000_000,
        "s": 1_000_000_000,
        "ms": 1_000_000,
        "us": 1_000,
        "µs": 1_000,
        "ns": 1,
    }

    # Tokenize: number followed by unit; prefer longest unit match (ms over m)
    # We'll scan left-to-right greedily.
    total_ns = 0
    i = 0
    n = len(s)
    while i < n:
        # Extract number (int or float)
        num_match = re.match(r"(\d+(?:\.\d+)?)", s[i:])
        if not num_match:
            # If we can't parse further, stop to avoid infinite loop
            break
        num_str = num_match.group(1)
        i += len(num_str)

        # Extract unit. Try two-char units first (ms, us, µs, ns), then single-char (h, m, s)
        unit = None
        for cand in ("ms", "us", "µs", "ns", "h", "m", "s"):
            if s[i:].startswith(cand):
                unit = cand
                i += len(cand)
                break

        if unit is None:
            # No recognizable unit → assume seconds if nothing else
            unit = "s"

        try:
            num = float(num_str)
        except ValueError:
            # Skip malformed token
            continue

        total_ns += int(num * unit_to_ns[unit])

    return total_ns


def _leading_spaces_count(line: str) -> int:
    return len(line) - len(line.lstrip(" "))


def _capture_operator_block(lines: List[str], start_idx: int) -> Tuple[List[str], int, Optional[int]]:
    """Capture an operator block starting at start_idx.

    Returns (block_lines, end_idx_exclusive, operator_total_ns) where end_idx_exclusive
    is the index of the first line after the block.
    """
    header_line = lines[start_idx]
    header_indent = _leading_spaces_count(header_line)
    block: List[str] = [header_line.rstrip("\n")]  # keep without trailing newlines
    operator_total_ns: Optional[int] = None

    i = start_idx + 1
    while i < len(lines):
        line = lines[i]
        # Stop when indentation is less than or equal to header, i.e., next sibling or higher level
        if _leading_spaces_count(line) <= header_indent and line.strip():
            break
        block.append(line.rstrip("\n"))

        # Parse OperatorTotalTime if present on this line exactly
        m_total = _RE_OPERATOR_TOTAL.match(line)
        if m_total:
            val = m_total.group("val")
            operator_total_ns = _parse_time_to_ns(val)

        i += 1

    return block, i, operator_total_ns


def collect_all_operators(lines: List[str]) -> List[OperatorContext]:
    current_fragment: Optional[int] = None
    current_pipeline: Optional[int] = None
    results: List[OperatorContext] = []

    i = 0
    while i < len(lines):
        line = lines[i]

        # Track fragment context
        m_frag = _RE_FRAGMENT.match(line)
        if m_frag:
            current_fragment = int(m_frag.group(1))
            i += 1
            continue

        # Track pipeline context
        m_pipe = _RE_PIPELINE.match(line)
        if m_pipe:
            current_pipeline = int(m_pipe.group(1))
            i += 1
            continue

        # Detect operator header only if inside a pipeline
        if current_pipeline is not None:
            m_op = _RE_OPERATOR_HDR.match(line)
            if m_op:
                op_name = m_op.group("name").strip()
                pid_raw = m_op.group("pid")
                try:
                    plan_node_id = int(pid_raw) if pid_raw is not None else None
                except ValueError:
                    plan_node_id = None
                block, end_idx, op_total_ns = _capture_operator_block(lines, i)

                if op_total_ns is not None:
                    ctx = OperatorContext(
                        fragment_id=current_fragment,
                        pipeline_id=current_pipeline,
                        plan_node_id=plan_node_id,
                        operator_name=op_name,
                        operator_total_ns=op_total_ns,
                        operator_total_str=f"{op_total_ns / 1_000_000:.3f} ms",
                        block_lines=block,
                    )
                    results.append(ctx)

                i = end_idx
                continue

        i += 1

    return results


def _extract_unique_time_metrics(block_lines: List[str]) -> List[Tuple[str, str, int]]:
    """Extract (key, original_value, ns) for time-like metrics under UniqueMetrics, sorted desc by ns.

    Only direct children under the UniqueMetrics header are considered; nested __MAX_OF_/__MIN_OF_ entries are ignored.
    A metric is considered time-like if its key contains 'Time'.
    """
    # Find UniqueMetrics header line index and its indent
    header_idx: Optional[int] = None
    header_indent: Optional[int] = None
    for idx, ln in enumerate(block_lines):
        if ln.strip() == "UniqueMetrics:":
            header_idx = idx
            header_indent = _leading_spaces_count(ln)
            break
    if header_idx is None or header_indent is None:
        return []

    results: List[Tuple[str, str, int]] = []
    i = header_idx + 1
    while i < len(block_lines):
        ln = block_lines[i]
        if not ln.strip():
            i += 1
            continue
        indent = _leading_spaces_count(ln)
        # Stop when leaving UniqueMetrics block
        if indent <= header_indent:
            break
        # Only take direct children (exactly one indent level deeper; empirically +3 spaces)
        if indent == header_indent + 3:
            m = _RE_BULLET_KV.match(ln)
            if m:
                key = m.group("key").strip()
                val = m.group("val").strip()
                if key.startswith("__MAX_OF_") or key.startswith("__MIN_OF_"):
                    i += 1
                    continue
                if "Time" in key:
                    ns = _parse_time_to_ns(val)
                    results.append((key, val, ns))
        i += 1

    results.sort(key=lambda x: x[2], reverse=True)
    return results


def _reorder_unique_metrics(block_lines: List[str]) -> List[str]:
    """Return a copy of block_lines with UniqueMetrics entries reordered:
    - Time-like metrics (key contains 'Time') sorted descending by parsed duration
    - Non-time metrics kept in their original relative order, appended after

    Keeps indentation and nested detail lines (like __MAX_OF_*) intact per metric.
    """
    # Locate UniqueMetrics header and block extent
    try:
        header_idx = next(i for i, ln in enumerate(block_lines) if ln.strip() == "UniqueMetrics:")
    except StopIteration:
        return block_lines

    header_indent = _leading_spaces_count(block_lines[header_idx])
    # Find end of UniqueMetrics block
    end_idx = header_idx + 1
    while end_idx < len(block_lines):
        ln = block_lines[end_idx]
        if ln.strip() and _leading_spaces_count(ln) <= header_indent:
            break
        end_idx += 1

    # Partition UniqueMetrics block into entries (top-level bullets and their nested lines)
    entries: List[Tuple[str, List[str], Optional[int], bool]] = []
    # tuple: (key, lines, time_ns_or_None, is_time_metric)

    i = header_idx + 1
    while i < end_idx:
        ln = block_lines[i]
        if not ln.strip():
            # blank lines can be preserved with previous entry or skipped
            i += 1
            continue
        indent = _leading_spaces_count(ln)
        if indent == header_indent + 3:
            # Start of a new top-level metric in UniqueMetrics
            m = _RE_BULLET_KV.match(ln)
            key = m.group("key").strip() if m else ln.strip()
            # Capture all subsequent lines belonging to this metric until next top-level metric or end
            group_lines: List[str] = [ln]
            j = i + 1
            while j < end_idx:
                lnj = block_lines[j]
                if lnj.strip() and _leading_spaces_count(lnj) == header_indent + 3 and _RE_BULLET_KV.match(lnj):
                    break
                group_lines.append(lnj)
                j += 1

            # Determine if time-like and parse value
            time_ns: Optional[int] = None
            is_time = False
            if m:
                val = m.group("val").strip()
                if "Time" in key:
                    is_time = True
                    time_ns = _parse_time_to_ns(val)

            entries.append((key, group_lines, time_ns, is_time))
            i = j
            continue

        # If nested deeper, attach to previous entry if exists
        if entries:
            entries[-1][1].append(ln)
        i += 1

    # Sort time metrics by time_ns desc; keep non-time metrics in original order
    time_entries = [e for e in entries if e[3]]
    non_time_entries = [e for e in entries if not e[3]]
    time_entries.sort(key=lambda e: (e[2] or 0), reverse=True)

    # Rebuild block_lines
    new_lines = list(block_lines[:header_idx + 1])
    for _, lines, _, _ in time_entries:
        new_lines.extend(lines)
    for _, lines, _, _ in non_time_entries:
        new_lines.extend(lines)
    new_lines.extend(block_lines[end_idx:])
    return new_lines


def _extract_query_execution_wall_time_ns(lines: List[str]) -> Optional[int]:
    """Extract Execution.QueryExecutionWallTime in nanoseconds from the full profile lines."""
    for ln in lines:
        m = _RE_QUERY_EXEC_WALL.match(ln)
        if m:
            return _parse_time_to_ns(m.group("val"))
    return None


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(description="Extract the slowest operator from a StarRocks profile file.")
    parser.add_argument("profile_path", help="Path to the .profile file")
    parser.add_argument("-n", "--top", type=int, default=1, help="Show top-N slowest operators (default: 1)")
    parser.add_argument("--json", action="store_true", help="Output JSON instead of text")
    args = parser.parse_args(argv)

    try:
        with open(args.profile_path, "r", encoding="utf-8", errors="ignore") as f:
            lines = f.readlines()
    except OSError as exc:
        print(f"Failed to read file: {exc}", file=sys.stderr)
        return 1

    operators = collect_all_operators(lines)
    if not operators:
        print("No operator with OperatorTotalTime found.")
        return 2

    operators.sort(key=lambda x: x.operator_total_ns, reverse=True)
    top_n = max(1, args.top)
    selection = operators[:top_n]

    if args.json:
        total_wall_ns = _extract_query_execution_wall_time_ns(lines) or 0
        json_list = []
        for op in selection:
            times = _extract_unique_time_metrics(op.block_lines)
            total_times_ns = sum(ns for _, _, ns in times)
            selected_metrics = []
            if total_times_ns > 0:
                cumulative = 0
                for key, val, ns in times:
                    item = {
                        "metric": key,
                        "value": val,
                        "ms": round(ns / 1_000_000.0, 3),
                    }
                    if total_wall_ns > 0:
                        item["TimePercent"] = round(ns / total_wall_ns, 3)
                    selected_metrics.append(item)
                    cumulative += ns
                    if cumulative / total_times_ns >= 0.8:
                        break
            operator_percent = round(op.operator_total_ns / total_wall_ns, 3) if total_wall_ns > 0 else 0.0
            json_list.append({
                "Operator": op.operator_name,
                "PlanNodeId": op.plan_node_id,
                "OperatorTotalTime": op.operator_total_str,
                "OperatorTotalTimeMs": round(op.operator_total_ns / 1_000_000.0, 3),
                "TimePercent": operator_percent,
                "TopMetrics": selected_metrics,
            })
        print(json.dumps(json_list, ensure_ascii=False, indent=2))
        return 0

    for idx, op in enumerate(selection, start=1):
        frag = f"{op.fragment_id}" if op.fragment_id is not None else "?"
        pipe = f"{op.pipeline_id}" if op.pipeline_id is not None else "?"
        print(f"#{idx} Slowest Operator by OperatorTotalTime:\n- Fragment: {frag}\n- Pipeline: {pipe}\n- Operator: {op.operator_name}\n- OperatorTotalTime: {op.operator_total_str}")
        # Reorder UniqueMetrics within the original block before printing
        if op.block_lines_reordered is None:
            op.block_lines_reordered = _reorder_unique_metrics(op.block_lines)
        print("\n----- Operator Profile Block -----")
        for ln in op.block_lines_reordered:
            print(ln)
        if idx < len(selection):
            print("\n========================================\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())


