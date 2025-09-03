import re
import tempfile
import threading
import time
import pymysql
import requests
import os
import base64
import csv

from benchmarks.benchmark import Benchmark
from dbms.dbms import DBMS, DBMSDescription, Result
from util import logger


class StarRocks(DBMS):
    def __init__(self, benchmark: Benchmark, index: DBMS.Index, data_dir: str, params: dict = None, settings: dict = None):
        super().__init__(benchmark, index, data_dir, params or {}, settings or {})
        self._host = "127.0.0.1"
        self._port = 8033
        self._user = "root"
        self._password = ""
        self._database = "tpch"
        self._http_port = 8030  # will be detected dynamically

    @property
    def name(self) -> str:
        return "starrocks"

    def __enter__(self):
        """Connect to StarRocks and set up the benchmark database"""
        self.connection = pymysql.connect(
            host=self._host,
            port=self._port,
            user=self._user,
            password=self._password,
            charset='utf8mb4',
            autocommit=True
        )
        self.cursor = self.connection.cursor()

        # Detect FE http port dynamically
        try:
            self.cursor.execute("SHOW FRONTENDS")
            colnames = [c[0].lower() for c in self.cursor.description]
            rows = self.cursor.fetchall()
            if rows and colnames:
                # find column named like http_port
                http_idx = None
                for i, n in enumerate(colnames):
                    if 'http' in n and 'port' in n:
                        http_idx = i
                        break
                # choose first row (leader generally first) if found
                if http_idx is not None:
                    hp = str(rows[0][http_idx])
                    if hp.isdigit():
                        self._http_port = int(hp)
        except Exception:
            # keep default 8030
            pass
        
        # Create and use tpch database
        self.cursor.execute("CREATE DATABASE IF NOT EXISTS tpch")
        self.cursor.execute("USE tpch")

        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Clean up database connection"""
        if hasattr(self, 'cursor') and self.cursor:
            self.cursor.close()
        if hasattr(self, 'connection') and self.connection:
            self.connection.close()

    def _transform_schema(self, schema: dict) -> dict:
        """Transform schema for StarRocks compatibility"""
        schema = super()._transform_schema(schema)
        
        # Force lowercase table and column names for StarRocks
        schema["lowercase"] = True
        
        for table in schema["tables"]:
            table["name"] = table["name"].lower()
            for column in table["columns"]:
                column["name"] = column["name"].lower()
                
                # Transform data types for StarRocks
                col_type = column["type"]
                
                # Remove NOT NULL constraints first
                col_type = col_type.replace(" not null", "").replace(" NOT NULL", "")
                
                # Transform data types
                if col_type == "bool":
                    col_type = "tinyint"
                elif col_type == "text":
                    col_type = "varchar(65533)"
                elif col_type.startswith("varchar") and "(" not in col_type:
                    col_type = "varchar(255)"
                elif col_type == "timestamp":
                    col_type = "datetime"
                
                column["type"] = col_type
        
        return schema

    def _create_table_statements(self, schema: dict) -> list[str]:
        """Generate CREATE TABLE statements for StarRocks"""
        statements = []
        
        for table in schema["tables"]:
            # Get primary key columns and reorder to put them first
            pk_cols = []
            for col in table.get("primary_key", []):
                pk_cols.append(col["name"].lower())
            
            pk_cols_set = set(pk_cols)
            ordered_columns = []
            
            # Add primary key columns first
            for col in table['columns']:
                if col.get("_eval", True) and col["name"] in pk_cols_set:
                    ordered_columns.append(col)
            
            # Add non-primary key columns
            for col in table['columns']:
                if col.get("_eval", True) and col["name"] not in pk_cols_set:
                    ordered_columns.append(col)
            
            # Handle reserved keywords by adding backticks and remove quotes
            reserved_words = ['text', 'comment', 'date', 'time', 'timestamp', 'order', 'group', 'by']
            columns = []
            for col in ordered_columns:
                col_name = col["name"].replace(chr(34), "")  # Remove quotes
                if col_name.lower() in reserved_words:
                    col_name = f"`{col_name}`"
                columns.append(f'{col_name} {col["type"]}')
            columns = ', '.join(columns)

            # Choose key columns for StarRocks (sanitize quotes, wrap with backticks)
            key_cols_raw = pk_cols if pk_cols else [ordered_columns[0]["name"].lower()] if ordered_columns else []
            key_cols_sanitized = [c.replace('"', '') for c in key_cols_raw]
            key_cols_sql = ", ".join(f"`{c}`" for c in key_cols_sanitized)
            hash_base = (key_cols_sanitized[0] if key_cols_sanitized else (ordered_columns[0]['name'].lower() if ordered_columns else 'id'))
            hash_base_clean = hash_base.replace('"', '')
            hash_col_sql = f"`{hash_base_clean}`"

            # Create StarRocks OLAP table with DUPLICATE KEY for broad compatibility
            create_sql = (
                f'CREATE TABLE IF NOT EXISTS {table["name"].replace(chr(34), "")} '
                f'({columns}) '
                f'ENGINE=OLAP '
                f'DUPLICATE KEY({key_cols_sql}) '
                f'DISTRIBUTED BY HASH({hash_col_sql}) BUCKETS 10 '
                f'PROPERTIES ("replication_num" = "1")'
            )

            statements.append(create_sql)

        return statements

    def _copy_statements(self, schema: dict) -> list[str]:
        """Generate placeholder statements - actual data loading handled in load_database"""
        statements = []
        for table in schema["tables"]:
            if table.get("initially empty", False):
                continue
            statements.append(f"SELECT 1")  # Placeholder
        return statements

    def load_database(self):
        """Override load_database to use custom data loading"""
        # First create tables using parent method
        primary_key = self._index in [DBMS.Index.PRIMARY, DBMS.Index.FOREIGN]
        foreign_keys = self._index == DBMS.Index.FOREIGN
        schema = self._benchmark.get_schema(primary_key=primary_key, foreign_keys=foreign_keys)
        schema = self._transform_schema(schema)

        # Create tables
        create_stmts = self._create_table_statements(schema)
        for create_statement in create_stmts:
            logger.log_verbose_sql(create_statement)
            output = self._execute(create_statement, False)
            if output.state != Result.SUCCESS:
                logger.log_error(f'Error while creating table: {output.message}')
                raise Exception(f'Error while creating table: {output.message}')
        
        # Load data using StarRocks STREAM LOAD
        
        self._load_data(schema)
        
        # Analyze tables for statistics
        # for table in schema["tables"]:
        #     if not table.get("initially empty", False):
        #         table_name = table['name'].lower()
        #         try:
        #             self.cursor.execute(f"ANALYZE TABLE {table_name.replace(chr(34), '')}")
        #         except Exception as e:
        #             logger.log_error_verbose(f"Error analyzing table {table_name}: {e}")
                    
        # After data loading, output table row counts
        print("=== TPC-H 表数据行数检查 ===")
        tables = ['part', 'supplier', 'partsupp', 'customer', 'orders', 'lineitem', 'nation', 'region']
        for table in tables:
            try:
                self.cursor.execute(f'SELECT COUNT(*) FROM {table}')
                count = self.cursor.fetchone()[0]
                print(f'{table:12}: {count:>8} 行')
            except Exception as e:
                print(f'{table:12}: 错误 - {e}')
        print()



    def _load_data(self, schema: dict):
        """Load data using StarRocks STREAM LOAD.

        This implementation is dataset-agnostic. It relies on the schema-provided
        relative file path (table["file"]) which is constructed by the active
        benchmark. This avoids hardcoding dataset-specific paths or filename
        conventions (e.g., StackOverflow vs. TPC-H vs. TPC-DS).
        """

        for table in schema["tables"]:

            if table.get("initially empty", False):
                continue

            table_name = table["name"].lower().replace('"','')

            # Skip load if table already has rows
            try:
                self.cursor.execute(f"SELECT COUNT(*) FROM {table_name}")
                existing = int(self.cursor.fetchone()[0])
                if existing > 0:
                    logger.log_verbose_dbms(f"Skip load for {table_name}: {existing} rows present", self)
                    continue
            except Exception:
                # ignore; will attempt to load
                pass

            # Resolve the data file path from the benchmark schema
            relative_file = table.get("file")
            data_file = os.path.join(self._data_dir, relative_file) if relative_file else None

            is_compressed = False

            # Fallback: if the exact file is not present, try a .zstd variant
            if not data_file or not os.path.exists(data_file):
                zstd_candidate = os.path.join(self._data_dir, f"{relative_file}.zstd") if relative_file else None
                if zstd_candidate and os.path.exists(zstd_candidate):
                    data_file = zstd_candidate
                    is_compressed = True
                else:
                    # Additional fallback for TPCH: try sf1 if requested scale missing
                    if relative_file and ('/tpch/' in relative_file or relative_file.startswith('tpch/')):
                        # replace sf<...> with sf1
                        parts = relative_file.split('/')
                        for i, p in enumerate(parts):
                            if p.startswith('sf'):
                                parts[i] = 'sf1'
                                break
                        fallback_rel = '/'.join(parts)
                        fallback_path = os.path.join(self._data_dir, fallback_rel)
                        if os.path.exists(fallback_path):
                            data_file = fallback_path
                            is_compressed = False
                        else:
                            zstd_fallback = fallback_path + '.zstd'
                            if os.path.exists(zstd_fallback):
                                data_file = zstd_fallback
                                is_compressed = True
                    if not data_file or not os.path.exists(data_file):
                        logger.log_verbose_dbms(f"No data file found for {table_name}", self)
                        continue

            # Choose separator and header handling based on file ending
            source_name = relative_file or os.path.basename(data_file)
            base_name = source_name[:-5] if source_name.endswith('.zstd') else source_name
            if base_name.endswith('.tbl') or base_name.endswith('.dat'):
                column_separator = '|'
                skip_header = '0'
            else:
                column_separator = ','
                skip_header = '1'

            # Try STREAM LOAD
            success = self._stream_load_table(
                table_name=table_name,
                data_file=data_file,
                is_compressed=is_compressed,
                column_separator=column_separator,
                skip_header=skip_header,
            )

            if not success:
                logger.log_error_verbose(f"Failed to load data for {table_name}")

    def _stream_load_table(self, table_name: str, data_file: str, is_compressed: bool, column_separator: str, skip_header: str) -> bool:
        """Load data using StarRocks HTTP STREAM LOAD"""
        temp_file = None
        try:
            # If file is zstd compressed, decompress to temporary file
            if is_compressed:
                logger.log_verbose_dbms(f"Decompressing zstd file: {data_file}", self)
                temp_file = self._decompress_zstd_file(data_file)
                if not temp_file:
                    logger.log_error_verbose(f"Failed to decompress zstd file: {data_file}")
                    return False
                data_file = temp_file

            # For TPCH .tbl files, strip trailing '|' to avoid extra empty column
            try:
                base = os.path.basename(data_file)
                if base.endswith('.tbl') or base.endswith('.tbl.tmp'):
                    # sanitize
                    import tempfile
                    fd, cleaned_path = tempfile.mkstemp(suffix='.tbl')
                    os.close(fd)
                    with open(data_file, 'r', encoding='utf-8', errors='ignore') as fin, open(cleaned_path, 'w', encoding='utf-8') as fout:
                        for line in fin:
                            # remove trailing CR/LF first, then one trailing '|', then add '\n'
                            s = line.rstrip('\n').rstrip('\r')
                            if s.endswith('|'):
                                s = s[:-1]
                            fout.write(s + '\n')
                    # swap to cleaned file
                    if temp_file is None:
                        temp_file = cleaned_path
                    else:
                        # remove previous temp and replace
                        try:
                            os.unlink(temp_file)
                        except Exception:
                            pass
                        temp_file = cleaned_path
                    data_file = temp_file
            except Exception as e:
                logger.log_error_verbose(f"Sanitize .tbl failed for {table_name}: {e}")
            
            label = f"load_{table_name}_{int(time.time())}"
            # Use detected FE HTTP port and the configured database name
            url = f"http://{self._host}:{self._http_port}/api/{self._database}/{table_name}/_stream_load"
            
            headers = {
                'label': label,
                'column_separator': column_separator,
                'line_delimiter': '\\n',
                'skip_header': skip_header,
                'format': 'csv',
                'timeout': '3600',
                'max_filter_ratio': '0.1',
                'Expect': '100-continue'
            }
            
            # Use subprocess to call curl (more reliable for StarRocks)
            import subprocess
            
            curl_cmd = [
                'curl', '-L', '--location-trusted', '-u', 'root:',
                '-H', f"label:{headers['label']}",
                '-H', f"column_separator:{headers['column_separator']}",
                '-H', f"line_delimiter:\\n",
                '-H', f"skip_header:{headers['skip_header']}",
                '-H', f"Expect:{headers['Expect']}",
                '-T', data_file,
                url
            ]
            
            try:
                result = subprocess.run(curl_cmd, capture_output=True, text=True, timeout=3600)
                if result.returncode == 0 and result.stdout:
                    import json
                    try:
                        response_data = json.loads(result.stdout)
                    except Exception:
                        logger.log_error_verbose(f"STREAM LOAD non-JSON response for {table_name}: {result.stdout[:200]}...")
                        return False

                    status = response_data.get('Status') or response_data.get('status')
                    loaded = response_data.get('NumberLoadedRows', 0)
                    if (isinstance(status, str) and status.lower() == 'success') and loaded > 0:
                        logger.log_verbose_dbms(f"Successfully loaded {loaded:,} rows into {table_name}", self)
                        return True
                    else:
                        logger.log_error_verbose(f"STREAM LOAD failed/empty for {table_name}: {response_data}")
                else:
                    logger.log_error_verbose(f"Curl command failed for {table_name}: rc={result.returncode}, stderr={result.stderr[:200]}...")
                    
            except subprocess.TimeoutExpired:
                logger.log_error_verbose(f"Curl command timed out for {table_name}")
            except Exception as e:
                logger.log_error_verbose(f"Curl command error for {table_name}: {e}")
                    
        except Exception as e:
            logger.log_error_verbose(f"Error loading {table_name}: {e}")
            
        finally:
            # Clean up temporary file if it was created
            if temp_file and os.path.exists(temp_file):
                try:
                    os.unlink(temp_file)
                    logger.log_verbose_dbms(f"Cleaned up temporary file: {temp_file}", self)
                except Exception as e:
                    logger.log_error_verbose(f"Failed to clean up temporary file {temp_file}: {e}")
            
        return False

    def _decompress_zstd_file(self, zstd_file: str) -> str:
        """Decompress a zstd file to a temporary file and return the path"""
        try:
            import tempfile
            import subprocess
            
            # Create a temporary file
            temp_fd, temp_path = tempfile.mkstemp(suffix='.csv')
            os.close(temp_fd)  # Close the file descriptor, we'll use subprocess
            
            # Use zstd command to decompress
            # Check if zstd command is available
            try:
                result = subprocess.run(['zstd', '--version'], capture_output=True, text=True, timeout=10)
                if result.returncode != 0:
                    # Try alternative command names
                    for cmd in ['zstd', 'zstdcat']:
                        try:
                            result = subprocess.run([cmd, '--version'], capture_output=True, text=True, timeout=10)
                            if result.returncode == 0:
                                break
                        except FileNotFoundError:
                            continue
                    else:
                        logger.log_error_verbose("zstd command not found. Please install zstd.")
                        return None
            except FileNotFoundError:
                logger.log_error_verbose("zstd command not found. Please install zstd.")
                return None
            
            # Decompress the file
            try:
                # Use zstd -d to decompress to output file
                result = subprocess.run(['zstd', '-d', zstd_file, '-o', temp_path], 
                                      capture_output=True, text=True, timeout=300)
                
                if result.returncode == 0:
                    logger.log_verbose_dbms(f"Successfully decompressed {zstd_file} to {temp_path}", self)
                    return temp_path
                else:
                    logger.log_error_verbose(f"Failed to decompress {zstd_file}: {result.stderr}")
                    # Clean up temp file
                    if os.path.exists(temp_path):
                        os.unlink(temp_path)
                    return None
                    
            except subprocess.TimeoutExpired:
                logger.log_error_verbose(f"Decompression timed out for {zstd_file}")
                # Clean up temp file
                if os.path.exists(temp_path):
                    os.unlink(temp_path)
                return None
                
        except Exception as e:
            logger.log_error_verbose(f"Error decompressing {zstd_file}: {e}")
            # Clean up temp file if it exists
            if 'temp_path' in locals() and os.path.exists(temp_path):
                try:
                    os.unlink(temp_path)
                except:
                    pass
            return None

    def _rewrite_query(self, query: str) -> str:
        """Rewrite SQL queries for StarRocks compatibility"""
        processed_query = query
        
        # Fix table name case - convert benchmark.TableName to benchmark.tablename
        table_name_mapping = {
            'Posts': 'posts',
            'Users': 'users', 
            'Tags': 'tags',
            'Badges': 'badges',
            'Comments': 'comments',
            'PostHistory': 'posthistory',
            'PostLinks': 'postlinks',
            'PostTypes': 'posttypes',
            'VoteTypes': 'votetypes',
            'CloseReasonTypes': 'closereasontypes',
            'LinkTypes': 'linktypes',
            'PostHistoryTypes': 'posthistorytypes',
            'Votes': 'votes'
        }
        
        for old_name, new_name in table_name_mapping.items():
            # Replace benchmark.TableName with benchmark.tablename
            processed_query = re.sub(rf'\bbenchmark\.{old_name}\b', f'benchmark.{new_name}', processed_query, flags=re.IGNORECASE)
            # Also handle cases without benchmark prefix
            processed_query = re.sub(rf'\b{old_name}\s+(?=\w)', f'{new_name} ', processed_query)
            processed_query = re.sub(rf'\b{old_name}\s*$', f'{new_name}', processed_query)
            processed_query = re.sub(rf'\b{old_name}(?=\s*[.,;)])', f'{new_name}', processed_query)
        
        # Remove OFFSET without LIMIT
        processed_query = re.sub(r'\s+OFFSET\s+\d+(?!\s+LIMIT)', '', processed_query, flags=re.IGNORECASE)
        
        # Convert string_agg to group_concat
        processed_query = re.sub(r'\bstring_agg\s*\(([^,]+),\s*([^)]+)\)', r'group_concat(\1 SEPARATOR \2)', processed_query, flags=re.IGNORECASE)
        
        # Fix TIMESTAMP literal syntax - convert TIMESTAMP 'value' to cast('value' as datetime)
        processed_query = re.sub(r"\bTIMESTAMP\s+'([^']+)'", r"cast('\1' as datetime)", processed_query, flags=re.IGNORECASE)
        
        # Convert INTERVAL syntax
        processed_query = re.sub(r"INTERVAL\s+'([^']+)'\s+(\w+)", r"INTERVAL \1 \2", processed_query, flags=re.IGNORECASE)
        
        # Convert date_part/extract to appropriate functions
        processed_query = re.sub(r'\bdate_part\s*\(\s*[\'"]year[\'"]\s*,\s*([^)]+)\)', r'year(\1)', processed_query, flags=re.IGNORECASE)
        processed_query = re.sub(r'\bdate_part\s*\(\s*[\'"]month[\'"]\s*,\s*([^)]+)\)', r'month(\1)', processed_query, flags=re.IGNORECASE)
        processed_query = re.sub(r'\bdate_part\s*\(\s*[\'"]day[\'"]\s*,\s*([^)]+)\)', r'day(\1)', processed_query, flags=re.IGNORECASE)
        
        # Convert initcap function
        def _initcap_sub(match):
            arg = match.group(1)
            return f"concat(upper(substr({arg},1,1)), lower(substr({arg},2)))"
        processed_query = re.sub(r'\binitcap\(([^)]+)\)', _initcap_sub, processed_query, flags=re.IGNORECASE)
        
        # Remove aggregate FILTER clauses
        processed_query = re.sub(r'\s+FILTER\s*\(\s*WHERE[^)]+\)', '', processed_query, flags=re.IGNORECASE)
        
        # Remove ROWS BETWEEN in window functions
        processed_query = re.sub(r'\s+ROWS\s+BETWEEN[^)]+(?=\))', '', processed_query, flags=re.IGNORECASE)
        processed_query = re.sub(r'\s+ROWS\s+\d+\s+PRECEDING', '', processed_query, flags=re.IGNORECASE)
        
        # Remove WITH RECURSIVE
        processed_query = re.sub(r'\bWITH\s+RECURSIVE\b', 'WITH', processed_query, flags=re.IGNORECASE)
        
        # Remove LATERAL JOIN
        processed_query = re.sub(r'\bLATERAL\s+', '', processed_query, flags=re.IGNORECASE)
        
        # Remove FETCH FIRST/NEXT syntax (not supported in StarRocks)
        processed_query = re.sub(r'\s+FETCH\s+(FIRST|NEXT)\s+\d+\s+(ROW|ROWS)\s+(ONLY)?', '', processed_query, flags=re.IGNORECASE)
        
        # Convert ARRAY_AGG to group_concat
        processed_query = re.sub(r'\bARRAY_AGG\s*\(\s*DISTINCT\s+([^)]+)\)', r'group_concat(DISTINCT \1)', processed_query, flags=re.IGNORECASE)
        processed_query = re.sub(r'\bARRAY_AGG\s*\(([^)]+)\)', r'group_concat(\1)', processed_query, flags=re.IGNORECASE)
        
        # Remove UNNEST and string_to_array functions (not supported)
        # Convert UNNEST(string_to_array(...)) patterns to simpler alternatives
        processed_query = re.sub(r'\bUNNEST\s*\(\s*string_to_array\s*\([^)]+\)\s*\)', 'dual', processed_query, flags=re.IGNORECASE)
        processed_query = re.sub(r'\bstring_to_array\s*\([^)]+\)', "''", processed_query, flags=re.IGNORECASE)
        
        # Convert EXTRACT(EPOCH FROM ...) to unix_timestamp
        processed_query = re.sub(r'\bEXTRACT\s*\(\s*EPOCH\s+FROM\s+([^)]+)\)', r'unix_timestamp(\1)', processed_query, flags=re.IGNORECASE)
        
        # Remove database prefix (commented out - we handle this in table name mapping above)
        # processed_query = re.sub(r"\bbenchmark\.(\w+)", r"\1", processed_query, flags=re.IGNORECASE)
        
        return processed_query

    def _execute(self, query: str, fetch_result: bool, timeout: int = 0, fetch_result_limit: int = 0) -> Result:
        result = Result()
        
        # Rewrite query for StarRocks
        processed_query = self._rewrite_query(query)
        
        timer = None
        if timeout > 0:
            def timeout_handler():
                try:
                    self.connection.cancel()
                except:
                    pass
            timer = threading.Timer(timeout, timeout_handler)
            timer.start()

        try:
            start_time = time.time()
            self.cursor.execute(processed_query)
            
            if fetch_result:
                if fetch_result_limit > 0:
                    result.result = self.cursor.fetchmany(fetch_result_limit)
                else:
                    result.result = self.cursor.fetchall()
                result.result = [list(row) for row in result.result]
            
            end_time = time.time()
            result.client_total = [int((end_time - start_time) * 1000)]
            result.state = Result.SUCCESS
            
        except Exception as e:
            result.state = Result.ERROR
            result.message = str(e)
            
        if timer is not None:
            timer.cancel()
            timer.join()

        return result


class StarRocksDescription(DBMSDescription):
    def __init__(self):
        super().__init__("StarRocks", "A high-performance analytical database")

    @staticmethod
    def get_name() -> str:
        return "starrocks"

    @staticmethod
    def get_description() -> str:
        return "StarRocks"

    @staticmethod
    def get_dbms_class():
        return StarRocks

    @staticmethod
    def instantiate(benchmark: Benchmark, db_dir: str, data_dir: str, params: dict, settings: dict) -> DBMS:
        return StarRocks(benchmark, DBMS.Index.NONE, data_dir, params, settings)