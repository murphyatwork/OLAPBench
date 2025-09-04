#!/usr/bin/env python3
from __future__ import annotations

import argparse
import csv
import itertools
import math
import os
import random
import sys
from dataclasses import dataclass, field
from statistics import median, geometric_mean
from typing import Dict, List

import simplejson as json
from dotenv import load_dotenv

from benchmarks.benchmark import benchmark_arguments, benchmarks, Benchmark
from dbms.dbms import Result, database_systems
from util import logger, formatter, schemajson
from util.resultcsv import ResultCSV
from util.template import Template

workdir = os.getcwd()
csv.field_size_limit(sys.maxsize)


@dataclass
class System:
    title: str
    dbms: str
    params: dict
    settings: dict


@dataclass
class Runtime:
    title: str

    queries: int = 0
    success: int = 0
    error: int = 0
    fatal: int = 0
    oom: int = 0
    timeout: int = 0
    global_timeout: int = 0

    global_time: float = 0
    times: List[float] = field(default_factory=lambda: [])


def run_benchmark(benchmark: Benchmark, systems: List[System], definition: dict, result_dir: str, db_dir: str, data_dir: str):
    logger.log_driver(f"Preparing {benchmark.description}")
    dbms_descriptions = database_systems()

    timeout = definition.get("timeout", definition.get("settings", {}).get("timeout", 0))
    global_timeout = definition.get("global_timeout", definition.get("settings", {}).get("global_timeout", 0)) * 1000
    fetch_result = definition.get("fetch_result", definition.get("settings", {}).get("fetch_result", True))
    fetch_result_limit = definition.get("fetch_result_limit", definition.get("settings", {}).get("fetch_result_limit", 0))
    query_seed = definition.get("query_seed", definition.get("settings", {}).get("query_seed", None))
    query_limit = definition.get("query_limit", definition.get("settings", {}).get("query_limit", 0))

    benchmark.dbgen()

    result_name = os.path.join(result_dir, benchmark.result_name)
    result_csv = result_name + ".csv"
    executed_queries = {}
    failed_query = (None, None)
    benchmark_type = definition.get("type", "queries")

    if definition.get("clear", False):
        clear(benchmark, result_dir)

    runtimes: Dict[Runtime] = {}
    for system in systems:
        runtimes[system.title] = Runtime(title=system.title)
        executed_queries[system.title] = []

    if os.path.exists(result_csv) and benchmark_type == "queries":
        logger.log_driver(f"Found results in {result_csv}, skipping already executed queries")
        with open(result_csv, 'r') as csv_file:
            reader = csv.DictReader(csv_file)

            for row in reader:
                title = row["title"]
                query = row["query"]
                state = row["state"]
                times = [float(x) for x in json.loads(row["client_total"], allow_nan=True)]

                if title not in runtimes:
                    continue

                executed_queries[title].append(query)

                runtimes[title].queries += 1
                try:
                    if state not in [Result.FATAL, Result.GLOBAL_TIMEOUT]:
                        assert len(times) > 0
                        med_time = median(times)
                        runtimes[title].global_time += med_time
                        # Only add positive times for geometric mean calculation
                        if med_time > 0:
                            runtimes[title].times.append(med_time)
                        else:
                            logger.log_warn_verbose(f"Skipping non-positive median runtime {med_time} for {title}, query {query}")
                except Exception as e:
                    logger.log_warn_verbose(f"Exception while processing times for {title}, query {query}: {e}")

                try:
                    match state:
                        case Result.SUCCESS:
                            runtimes[title].success += 1
                        case Result.ERROR:
                            runtimes[title].error += 1
                        case Result.FATAL:
                            runtimes[title].fatal += 1
                        case Result.OOM:
                            runtimes[title].oom += 1
                        case Result.TIMEOUT:
                            runtimes[title].timeout += 1
                        case Result.GLOBAL_TIMEOUT:
                            runtimes[title].global_timeout += 1
                except Exception as e:
                    logger.log_warn_verbose(f"Exception while updating result counters for {title}, query {query}: {e}")

    if os.path.exists(result_csv + "_current") and benchmark_type == "queries":
        with open(result_csv + "_current", 'r') as file:
            title, query = file.readline().split(",")
            failed_query = (title, query)
            logger.log_driver(f"Last execution of {query} failed in {title}")

    with ResultCSV(result_csv, append=True) as result_csv_file:
        for system in systems:
            logger.log_header(system.title)
            logger.log_driver(f"Running {system.title} on {benchmark.result_name} (dbms: {system.dbms}, params: {system.params}, settings: {system.settings})")

            # Prepare the benchmark
            match benchmark_type:
                case "queries":
                    umbra_planner = system.params.get("umbra_planner", False)
                    queries = benchmark.queries("umbra" if umbra_planner else system.dbms)

                    # Determine a global sample of query names (consistent across systems)
                    selected_names = None
                    if query_limit and query_limit > 0:
                        try:
                            all_names = [f for f in os.listdir(benchmark.queries_path) if f.endswith(".sql")]
                            all_names.sort()
                            if query_seed is not None:
                                random.seed(query_seed)
                                random.shuffle(all_names)
                            selected_names = all_names[:query_limit]
                        except Exception as e:
                            logger.log_warn_verbose(f"Failed to determine sampled queries: {e}")

                        # Persist sample manifest for reproducibility
                        try:
                            with open(result_name + ".sample.txt", 'w') as sample_file:
                                if query_seed is not None:
                                    sample_file.write(f"# seed={query_seed}\n")
                                sample_file.write(f"# limit={query_limit}\n")
                                for n in (selected_names or []):
                                    sample_file.write(n + "\n")
                        except Exception as e:
                            logger.log_warn_verbose(f"Failed to write sample manifest: {e}")

                    # Apply sampling (preserve selected_names order), otherwise optionally shuffle
                    if selected_names is not None:
                        query_map = {name: query for (name, query) in queries}
                        queries = [(name, query_map[name]) for name in selected_names if name in query_map]
                    elif query_seed is not None:
                        random.seed(query_seed)
                        random.shuffle(queries)

                    # Filter out executed queries
                    if system.title in executed_queries:
                        queries = [(name, query) for name, query in queries if name not in executed_queries[system.title]]

                    # Plan the queries with Umbra
                    if umbra_planner and len(queries) != 0:
                        logger.log_driver("Using Umbra planner")
                        umbra_planner_params = system.params.get("umbra_planner_parameter", {})
                        umbra_planner_settings = system.params.get("umbra_planner_settings", {})
                        with dbms_descriptions["umbradev"].instantiate(benchmark, db_dir, data_dir, umbra_planner_params, umbra_planner_settings) as umbra:
                            umbra.load_database()

                            umbra_queries = []
                            with logger.LogProgress("Planning queries...", len(queries)) as progress:
                                for (name, query) in queries:
                                    progress.next(f'Planning {name}...')
                                    umbra_query = umbra.plan_query(query, system.dbms)
                                    if umbra_query is not None:
                                        umbra_queries.append((name, umbra_query))
                                    else:
                                        logger.log_warn_verbose(f"Query {name} not supported by Umbra")
                                    progress.finish()
                            queries = umbra_queries

                    if len(queries) == 0:
                        runtime = runtimes[system.title]
                        rsum = formatter.format_time(sum(runtime.times))
                        # Filter out non-positive values for geometric mean calculation
                        positive_times = [t for t in runtime.times if t > 0]
                        rgeomean = formatter.format_time(math.nan if len(positive_times) == 0 else geometric_mean(positive_times))
                        rmedian = formatter.format_time(math.nan if len(runtime.times) == 0 else median(runtime.times))

                        logger.log_driver(
                            f"total runtime {rsum} (geomean: {rgeomean}, median: {rmedian}) of {runtime.queries} queries (success: {runtime.success}, error: {runtime.error}, fatal: {runtime.fatal}, oom: {runtime.oom}, timeout: {runtime.timeout}, global timeout: {runtime.global_timeout})")
                        continue

            with dbms_descriptions[system.dbms].instantiate(benchmark, db_dir, data_dir, system.params, system.settings) as dbms:
                dbms.load_database()

                if benchmark_type == "queries":
                    logger.log_driver("Benchmarking queries")

                    repetitions = definition["repetitions"]
                    warmup = definition["warmup"]

                    with logger.LogProgress("Running queries...", len(queries) * (repetitions + warmup), base=repetitions + warmup) as progress:
                        for (name, query) in queries:
                            result = Result()

                            if system.title == failed_query[0] and name == failed_query[1]:
                                # Fatal error in the last execution of the query
                                result.state = Result.FATAL
                                result.message = "olapbench: system crash!"
                            elif runtimes[system.title].global_time > global_timeout and global_timeout > 0:
                                # Global timeout reached
                                result.state = Result.GLOBAL_TIMEOUT
                                result.message = "olapbench: global timeout!"

                            result_csv_file.start_olap(system.title, name)

                            progress.next(f'Running {name}...')
                            # Expose current SQL filename to DBMS for profiling file naming
                            try:
                                setattr(dbms, "_current_query_name", name)
                            except Exception:
                                pass
                            if result.state == Result.SUCCESS:
                                for i in range(warmup):
                                    dbms._execute(query, fetch_result, timeout=timeout, fetch_result_limit=fetch_result_limit)
                                    progress.finish()

                                for i in range(repetitions):
                                    result.merge(dbms._execute(query, fetch_result, timeout=timeout, fetch_result_limit=fetch_result_limit))
                                    progress.finish()

                            med = median(result.client_total) if len(result.client_total) > 0 else math.nan
                            if not math.isnan(med):
                                runtimes[system.title].global_time += med

                            if runtimes[system.title].global_time > global_timeout and global_timeout > 0:
                                result = Result()
                                result.state = Result.GLOBAL_TIMEOUT
                                med = math.nan

                            query_plan = definition.get("query_plan", {})
                            retrieve_query_plan = query_plan.get("retrieve", False)
                            if retrieve_query_plan and result.state == Result.SUCCESS:
                                system_representation = query_plan.get("system_representation", False)
                                result.plan = dbms.retrieve_query_plan(query, include_system_representation=system_representation)

                            result.round(3)
                            result_csv_file.olap(system.title, system.dbms, dbms.version, name, result)

                            lname = name.ljust(10)
                            lmessage = ""
                            match result.state:
                                case Result.SUCCESS:
                                    lmessage = "success (" + str(result.rows) + " rows)"
                                    runtimes[system.title].success += 1
                                case Result.ERROR:
                                    lmessage = "error (" + result.message.replace("\n", " ")[:40] + ")"
                                    runtimes[system.title].error += 1
                                case Result.FATAL:
                                    lmessage = "fatal error"
                                    runtimes[system.title].fatal += 1
                                case Result.OOM:
                                    lmessage = "out of memory"
                                    runtimes[system.title].oom += 1
                                case Result.TIMEOUT:
                                    lmessage = "query timeout"
                                    runtimes[system.title].timeout += 1
                                case Result.GLOBAL_TIMEOUT:
                                    lmessage = "global timeout"
                                    runtimes[system.title].global_timeout += 1

                            runtimes[system.title].queries += 1
                            if result.state not in [Result.ERROR, Result.FATAL, Result.GLOBAL_TIMEOUT]:
                                assert not math.isnan(med)
                                # Only add positive times for geometric mean calculation
                                if med > 0:
                                    runtimes[system.title].times.append(med)
                                else:
                                    logger.log_warn_verbose(f"Skipping non-positive runtime {med} for query {name} on {system.title}")

                            logger.log_verbose_dbms(f'{lname} {formatter.format_time(med)} {lmessage}', dbms)

                    runtime = runtimes[system.title]
                    rsum = formatter.format_time(sum(runtime.times))
                    # Filter out non-positive values for geometric mean calculation
                    positive_times = [t for t in runtime.times if t > 0]
                    rgeomean = formatter.format_time(math.nan if len(positive_times) == 0 else geometric_mean(positive_times))
                    rmedian = formatter.format_time(math.nan if len(runtime.times) == 0 else median(runtime.times))

                    logger.log_driver(
                        f"total runtime {rsum} (geomean: {rgeomean}, median: {rmedian}) of {runtime.queries} queries (success: {runtime.success}, error: {runtime.error}, fatal: {runtime.fatal}, oom: {runtime.oom}, timeout: {runtime.timeout}, global timeout: {runtime.global_timeout})")

                elif benchmark_type == "launch":
                    logger.log_dbms(f"Connect to {system.title} using `{dbms.connection_string()}`", dbms)
                    input("Press Enter to continue...")

                else:
                    raise ValueError("benchmark type not supported")


def unfold(d: dict) -> List[dict]:
    """
    Unfolds a dictionary with list values into a list of dictionaries with all possible combinations of the values.

    Args:
        d (dict): A dictionary where the values are either lists or single elements.

    Returns:
        List[dict]: A list of dictionaries, each representing a unique combination of the input dictionary's values.
    """
    if not d:
        return [{}]

    keys, values = zip(*((k, v if isinstance(v, list) else [v]) for k, v in d.items()))
    return [dict(zip(keys, combination)) for combination in itertools.product(*values)]


def clear(benchmark: Benchmark, result_dir: str):
    """
    Deletes result files associated with the given benchmark.

    Args:
        benchmark (Benchmark): The benchmark object containing the unique name used to identify the result files.
    """

    def delete_file(file_path):
        try:
            os.remove(file_path)
        except FileNotFoundError:
            pass
        except Exception as e:
            logger.log_warn_verbose(f"Failed to delete {file_path}: {e}")

    result_name = os.path.join(result_dir, benchmark.result_name)
    logger.log_driver(f"Clearing results for {result_name}")

    files_to_delete = [result_name + ext for ext in [".csv", ".csv_current"]]
    for file_path in files_to_delete:
        delete_file(file_path)


def run_benchmarks(args):
    benchmark_descriptions = benchmarks()

    if args.env is not None:
        load_dotenv(dotenv_path=args.env, verbose=True)

    logger.set_verbose(args.verbose)
    logger.set_very_verbose(args.very_verbose)

    definition = schemajson.load(os.path.join(workdir, args.json), "benchmark.schema.json")

    result_dir = os.path.join(workdir, definition["output"])
    db_dir = os.path.join(workdir, args.db)
    data_dir = os.path.join(workdir, args.data)

    os.makedirs(result_dir, exist_ok=True)
    os.makedirs(db_dir, exist_ok=True)
    os.makedirs(data_dir, exist_ok=True)

    systems: List[System] = []
    for system in definition["systems"]:
        if "disabled" in system and system["disabled"]:
            continue

        params: dict = {}
        if "parameter" in system.keys():
            params = system["parameter"]

        if "parameter" in definition.keys():
            for key in definition["parameter"].keys():
                if key not in params.keys():
                    params[key] = definition["parameter"][key]

        settings: dict = {}
        if "settings" in system.keys():
            settings = system["settings"]

        if "settings" in definition.keys():
            for key in definition["settings"].keys():
                if key not in settings.keys():
                    settings[key] = definition["settings"][key]

        for params in unfold(params):
            for settings in unfold(settings):
                # fill the title
                template = Template(system["title"])
                title = template.substitute(**settings, **params)

                systems.append(System(title, system["dbms"], params, settings))

    definition["type"] = "launch" if args.launch else "queries"
    definition["clear"] = args.clear

    if args.benchmark == "default":
        for bs in definition["benchmarks"]:
            queries = None if "queries" not in bs else bs["queries"]
            excluded_queries = None if "excluded_queries" not in bs else bs["excluded_queries"]
            bs["queries"] = None
            for b in unfold(bs):
                if "disabled" in b and b["disabled"]:
                    continue

                benchmark = benchmark_descriptions[b["name"]].instantiate(data_dir, b, included_queries=queries, excluded_queries=excluded_queries)
                run_benchmark(benchmark, systems, definition, result_dir, db_dir, data_dir)
    else:
        # Get benchmark configuration from definition
        benchmark_config = None
        for bs in definition["benchmarks"]:
            if bs["name"] == args.benchmark:
                benchmark_config = bs
                break
        
        if benchmark_config is None:
            # Fallback to default configuration
            benchmark_config = {"name": args.benchmark}
        
        benchmark = benchmark_descriptions[args.benchmark].instantiate(data_dir, benchmark_config)
        run_benchmark(benchmark, systems, definition, result_dir, db_dir, data_dir)


def main():
    logger.log_header("OLAPBench")
    
    # Check if virtual environment is activated
    if not os.getenv("VIRTUAL_ENV"):
        venv_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), ".venv")
        if os.path.exists(venv_path):
            logger.log_driver(f"Virtual environment detected but not activated. To activate it, run:\n   source {venv_path}/bin/activate\n   python3 benchmark.py [options]")
        else:
            logger.log_warn(f"Virtual environment not found at {venv_path}. Please ensure the virtual environment is properly set up.")

    parser = argparse.ArgumentParser(description="Run a benchmark")
    parser.add_argument("-j", "--json", dest="json", required=True, type=str, help="path to the benchmark's json definition")
    parser.add_argument("-v", "--verbose", dest="verbose", default=False, action="store_true", help="verbose output")
    parser.add_argument("-vv", "--very-verbose", dest="very_verbose", default=False, action="store_true", help="very verbose output")
    parser.add_argument("--db", dest="db", type=str, default="db", help="directory where to store the databases (default: ./db)")
    parser.add_argument("--data", dest="data", type=str, default="data", help="directory where to store the data (default: ./data)")
    parser.add_argument("--env", dest="env", type=str, default=None, help="file containing environment variables")
    parser.add_argument("--clear", dest="clear", default=False, action="store_true", help="Clear the results")
    parser.add_argument("--launch", default=False, action="store_true", help="Only launch the database without running any queries")
    benchmark_arguments(parser)

    args = parser.parse_args()

    run_benchmarks(args)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        logger.log_error(e)
        raise e
