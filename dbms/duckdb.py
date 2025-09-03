import os
import tempfile
import threading
import time
import subprocess
import json

from benchmarks.benchmark import Benchmark
from dbms.dbms import DBMS, Result, DBMSDescription
from queryplan.parsers.duckdbparser import DuckDBParser
from queryplan.queryplan import QueryPlan
from util import logger, sql

class DuckDB(DBMS):

    def __init__(self, benchmark: Benchmark, db_dir: str, data_dir: str, params: dict, settings: dict):
        super().__init__(benchmark, db_dir, data_dir, params, settings)
        self.db_file = None
        self.process = None

    @property
    def name(self) -> str:
        return "duckdb"

    def connection_string(self) -> str:
        return f"duckdb://{self.db_file}"

    def _connect(self):
        """连接到本地DuckDB"""
        try:
            # 先创建数据库文件（如果不存在）
            if not os.path.exists(self.db_file):
                # 使用DuckDB创建数据库文件
                duckdb_path = "/home/disk6/murphy/duckdb"
                cmd = [duckdb_path, self.db_file, "-c", "SELECT 1"]
                subprocess.run(cmd, check=True, capture_output=True, text=True)
            
            # 测试连接
            test_query = "SELECT 1 as test"
            result = self._execute_query(test_query)
            if result and result.get('status') == 'success':
                logger.log_verbose_dbms(f"Established connection to {self.name}", self)
            else:
                raise Exception(f"Unable to connect to {self.name}")
                
        except Exception as e:
            raise Exception(f"Connection failed: {e}")

    def _execute_query(self, query: str, timeout: int = 0):
        """执行SQL查询"""
        try:
            # 构建DuckDB命令
            duckdb_path = "/home/disk6/murphy/duckdb"
            cmd = [duckdb_path, self.db_file, "-json", "-separator", ","]
            
            # 设置超时
            if timeout > 0:
                # 在Linux上使用timeout命令
                cmd = ["timeout", str(timeout)] + cmd
            
            # 执行查询
            process = subprocess.Popen(
                cmd,
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            
            stdout, stderr = process.communicate(input=query)
            
            if process.returncode != 0:
                return {
                    'status': 'error',
                    'error': stderr.strip() if stderr else 'Unknown error',
                    'stdout': stdout.strip()
                }
            
            # 解析JSON输出
            try:
                if stdout.strip():
                    result = json.loads(stdout)
                    return {
                        'status': 'success',
                        'result': result,
                        'stdout': stdout.strip()
                    }
                else:
                    return {
                        'status': 'success',
                        'result': [],
                        'stdout': ''
                    }
            except json.JSONDecodeError:
                return {
                    'status': 'success',
                    'result': [],
                    'stdout': stdout.strip()
                }
                
        except subprocess.TimeoutExpired:
            process.kill()
            return {
                'status': 'timeout',
                'error': 'Query execution timed out',
                'stdout': '',
                'stderr': ''
            }
        except Exception as e:
            return {
                'status': 'error',
                'error': str(e),
                'stdout': '',
                'stderr': ''
            }

    def __enter__(self):
        # 准备数据库目录
        self.host_dir = tempfile.TemporaryDirectory(dir=self._db_dir)
        
        # 设置数据库文件路径
        self.db_file = os.path.join(self._db_dir, "benchmark.duckdb")
        
        # 删除现有的数据库文件，确保完全干净的状态
        if os.path.exists(self.db_file):
            os.remove(self.db_file)
        
        # 连接到本地DuckDB
        self._connect()
        
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.host_dir:
            self.host_dir.cleanup()

    def _create_table_statements(self, schema: dict) -> list[str]:
        return sql.create_table_statements(schema, alter_table=False)

    def _copy_statements(self, schema: dict) -> list[str]:
        if self._benchmark.name == "clickbench":
            schema["null"] = "\\c"
            schema["quote"] = "\\b"
        if self._benchmark.unique_name.startswith("stackoverflow_math") or (self._version in ["0.8.0", "0.8.1", "0.9.0", "0.9.1", "0.9.2", "0.10.2"] and schema["format"] == "csv"):
            return sql.copy_statements_duckdb_csv_singlethreaded(schema, self._data_dir)
        return sql.copy_statements_postgres(schema, self._data_dir, supports_text=False)

    def _execute(self, query: str, fetch_result: bool, timeout: int = 0, fetch_result_limit: int = 0) -> Result:
        output = Result()

        # 测量整个查询执行的客户端耗时
        import time
        start_time = time.perf_counter()
        result = self._execute_query(query, timeout)
        duration_ms = (time.perf_counter() - start_time) * 1000.0

        if result['status'] == 'success':
            output.state = Result.SUCCESS
            output.rows = len(result['result']) if result['result'] else 0
            output.client_total.append(duration_ms)

            if fetch_result:
                output.result = result['result']

        elif result['status'] == 'timeout':
            output.state = Result.TIMEOUT
            output.message = result['error']
            # 采用设定的超时值（毫秒）作为记录，贴合其他后端的约定
            output.client_total.append(timeout * 1000)

        else:
            output.state = Result.ERROR
            output.message = result['error']
            # 记录到返回前的实际耗时，便于排查
            output.client_total.append(duration_ms)

        return output

    def retrieve_query_plan(self, query: str, include_system_representation: bool = False) -> QueryPlan:
        explain_query = "EXPLAIN (FORMAT JSON) " + query.strip()
        result = self._execute_query(explain_query)
        
        if result['status'] == 'success' and result['result']:
            try:
                json_plan = result['result']
                plan_parser = DuckDBParser(include_system_representation=include_system_representation)
                query_plan = plan_parser.parse_json_plan(query, json_plan)
                return query_plan
            except Exception as e:
                logger.log_error_verbose(f"Failed to parse query plan: {e}")
                return None
        return None


class DuckDBDescription(DBMSDescription):
    @staticmethod
    def get_name() -> str:
        return 'duckdb'

    @staticmethod
    def get_description() -> str:
        return 'DuckDB (Local)'

    @staticmethod
    def instantiate(benchmark: Benchmark, db_dir: str, data_dir: str, params: dict, settings: dict) -> DBMS:
        return DuckDB(benchmark, db_dir, data_dir, params, settings)
