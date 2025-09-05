Query:
  Summary:
     - Query ID: f68172bd-8a0a-11f0-94e0-00163e341b96
     - Start Time: 2025-09-05 11:46:53
     - End Time: 2025-09-05 11:46:53
     - Total: 92ms
     - Query Type: Query
     - Query State: Finished
     - StarRocks Version: 3.5.4-1ce07c8
     - User: root
     - Default Db: tpch
     - Sql Statement: SELECT 
    n.n_name AS nation_name,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS total_revenue,
    COUNT(DISTINCT o.o_orderkey) AS order_count,
    AVG(c.c_acctbal) AS average_account_balance
FROM 
    customer c
JOIN 
    orders o ON c.c_custkey = o.o_custkey
JOIN 
    lineitem l ON o.o_orderkey = l.l_orderkey
JOIN 
    supplier s ON l.l_suppkey = s.s_suppkey
JOIN 
    partsupp ps ON l.l_partkey = ps.ps_partkey AND s.s_suppkey = ps.ps_suppkey
JOIN 
    nation n ON s.s_nationkey = n.n_nationkey
WHERE 
    l.l_shipdate BETWEEN '1997-01-01' AND '1997-12-31'
    AND n.n_name IN ('USA', 'Germany', 'Japan')
GROUP BY 
    n.n_name
ORDER BY 
    total_revenue DESC
LIMIT 10;
     - Variables: parallel_fragment_exec_instance_num=1,max_parallel_scan_instance_num=-1,pipeline_dop=0,enable_adaptive_sink_dop=true,enable_runtime_adaptive_dop=false,runtime_profile_report_interval=10,resource_group=default_wg
     - NonDefaultSessionVariables: {"sql_mode_v2":{"defaultValue":32,"actualValue":34},"query_timeout":{"defaultValue":300,"actualValue":10},"prefer_compute_node":{"defaultValue":false,"actualValue":true},"enable_adaptive_sink_dop":{"defaultValue":false,"actualValue":true},"enable_profile":{"defaultValue":false,"actualValue":true}}
     - Collect Profile Time: 5ms
     - IsProfileAsync: true
  Planner:
     - -- Parser[1] 0
     - -- Total[1] 25ms
     -     -- Analyzer[1] 0
     -         -- Lock[1] 0
     -         -- AnalyzeDatabase[6] 0
     -         -- AnalyzeTemporaryTable[6] 0
     -         -- AnalyzeTable[6] 0
     -     -- Transformer[1] 0
     -     -- Optimizer[1] 20ms
     -         -- MVPreprocess[1] 0
     -         -- MVTextRewrite[1] 0
     -         -- RuleBaseOptimize[1] 11ms
     -         -- CostBaseOptimize[1] 7ms
     -         -- PhysicalRewrite[1] 0
     -         -- DynamicRewrite[1] 0
     -         -- PlanValidate[1] 0
     -             -- InputDependenciesChecker[1] 0
     -             -- TypeChecker[1] 0
     -             -- CTEUniqueChecker[1] 0
     -             -- ColumnReuseChecker[1] 0
     -     -- ExecPlanBuild[1] 2ms
     - -- Pending[1] 0
     - -- Prepare[1] 1ms
     - -- Deploy[1] 44ms
     -     -- DeployLockInternalTime[1] 44ms
     -         -- DeploySerializeConcurrencyTime[8] 1ms
     -         -- DeployStageByStageTime[24] 0
     -         -- DeployWaitTime[24] 42ms
     -             -- DeployAsyncSendTime[8] 0
     - DeployDataSize: 119351
    Reason:
  Execution:
     - Topology: {"rootId":26,"nodes":[{"id":26,"name":"MERGE_EXCHANGE","properties":{"sinkIds":[],"displayMem":true},"children":[25]},{"id":25,"name":"TOP_N","properties":{"sinkIds":[26],"displayMem":true},"children":[24]},{"id":24,"name":"AGGREGATION","properties":{"displayMem":true},"children":[23]},{"id":23,"name":"EXCHANGE","properties":{"displayMem":true},"children":[22]},{"id":22,"name":"AGGREGATION","properties":{"sinkIds":[23],"displayMem":true},"children":[21]},{"id":21,"name":"PROJECT","properties":{"displayMem":false},"children":[20]},{"id":20,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[0,19]},{"id":0,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":19,"name":"EXCHANGE","properties":{"displayMem":true},"children":[18]},{"id":18,"name":"PROJECT","properties":{"sinkIds":[19],"displayMem":false},"children":[17]},{"id":17,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[1,16]},{"id":1,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":16,"name":"EXCHANGE","properties":{"displayMem":true},"children":[15]},{"id":15,"name":"PROJECT","properties":{"sinkIds":[16],"displayMem":false},"children":[14]},{"id":14,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[2,13]},{"id":2,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":13,"name":"EXCHANGE","properties":{"displayMem":true},"children":[12]},{"id":12,"name":"PROJECT","properties":{"sinkIds":[13],"displayMem":false},"children":[11]},{"id":11,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[4,10]},{"id":4,"name":"PROJECT","properties":{"displayMem":false},"children":[3]},{"id":10,"name":"EXCHANGE","properties":{"displayMem":true},"children":[9]},{"id":3,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":9,"name":"PROJECT","properties":{"sinkIds":[10],"displayMem":false},"children":[8]},{"id":8,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[5,7]},{"id":5,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":7,"name":"EXCHANGE","properties":{"displayMem":true},"children":[6]},{"id":6,"name":"OLAP_SCAN","properties":{"sinkIds":[7],"displayMem":false},"children":[]}]}
     - FrontendProfileMergeTime: 6.260ms
     - QueryAllocatedMemoryUsage: 18.742 MB
     - QueryCumulativeCpuTime: 251.340ms
     - QueryCumulativeNetworkTime: 1.251ms
     - QueryCumulativeOperatorTime: 8.988ms
     - QueryCumulativeScanTime: 827.861us
     - QueryDeallocatedMemoryUsage: 10.543 MB
     - QueryExecutionWallTime: 55.030ms
     - QueryPeakMemoryUsagePerNode: 9.689 MB
     - QueryPeakScheduleTime: 50.722ms
     - QuerySpillBytes: 0.000 B
     - QuerySumMemoryUsage: 9.689 MB
     - ResultDeliverTime: 0ns
    Fragment 0:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: f68172bd-8a0a-11f0-94e0-00163e341b97
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 1.006ms
       - InitialProcessDriverCount: 0
       - InitialProcessMem: 7.098 GB
       - InstanceAllocatedMemoryUsage: 284.453 KB
       - InstanceDeallocatedMemoryUsage: 64.797 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 219.656 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 11.174us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 50.734ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 50.697ms
             - FirstInputEmptyTime: 50.697ms
         - ScheduleCount: 1
         - ScheduleTime: 50.722ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        RESULT_SINK (plan_node_id=-1):
          CommonMetrics:
             - IsFinalSink
             - OperatorTotalTime: 56.772us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - SinkType: MYSQL_PROTOCAL
             - AppendChunkTime: 0ns
               - ResultRendTime: 0ns
               - TupleConvertTime: 0ns
             - NumSentRows: 0
        CHUNK_ACCUMULATE (plan_node_id=-1):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 646ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        LIMIT (plan_node_id=26) (operator id=3):
          CommonMetrics:
             - OperatorTotalTime: 673ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        LOCAL_EXCHANGE_SOURCE (plan_node_id=26):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 9.776us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 68.205us
           - __MAX_OF_ActiveTime: 699.603us
           - __MIN_OF_ActiveTime: 14.827us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 50.654ms
           - __MAX_OF_DriverTotalTime: 50.709ms
           - __MIN_OF_DriverTotalTime: 50.629ms
         - PeakDriverQueueSize: 48
           - __MAX_OF_PeakDriverQueueSize: 7
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 49.187ms
             - __MAX_OF_InputEmptyTime: 49.499ms
             - __MIN_OF_InputEmptyTime: 48.830ms
             - FirstInputEmptyTime: 3.241ms
               - __MAX_OF_FirstInputEmptyTime: 48.830ms
               - __MIN_OF_FirstInputEmptyTime: 93.684us
             - FollowupInputEmptyTime: 45.946ms
               - __MAX_OF_FollowupInputEmptyTime: 49.141ms
               - __MIN_OF_FollowupInputEmptyTime: 0ns
         - ScheduleCount: 77
           - __MAX_OF_ScheduleCount: 5
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 50.586ms
           - __MAX_OF_ScheduleTime: 50.672ms
           - __MIN_OF_ScheduleTime: 49.989ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 61
           - __MAX_OF_YieldByLocalWait: 4
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=26):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.121us
               - __MAX_OF_OperatorTotalTime: 12.240us
               - __MIN_OF_OperatorTotalTime: 260ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ShuffleNum: 1
             - Type: Passthrough
             - LocalExchangePeakMemoryUsage: 0.000 B
        GLOBAL_PARALLEL_MERGE_SOURCE (plan_node_id=26):
          CommonMetrics:
             - OperatorTotalTime: 54.665us
               - __MAX_OF_OperatorTotalTime: 674.447us
               - __MIN_OF_OperatorTotalTime: 5.870us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 53.732us
               - __MAX_OF_PullTotalTime: 673.601us
               - __MIN_OF_PullTotalTime: 5.577us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - LateMaterialization: False
             - Limit: 10
             - Offset: 0
             - StreamingBatchSize: 262144
             - BufferUnplugCount: 0
             - BytesPassThrough: 0.000 B
             - BytesReceived: 0.000 B
             - ClosureBlockCount: 0
             - ClosureBlockTime: 0ns
             - DecompressChunkTime: 0ns
             - DeserializeChunkTime: 0ns
             - LateMaterializationMaxBufferChunkNum: 0
             - OverallStageCount: 86
               - __MAX_OF_OverallStageCount: 12
               - __MIN_OF_OverallStageCount: 4
               - 1-InitStageCount: 1
                 - __MAX_OF_1-InitStageCount: 1
                 - __MIN_OF_1-InitStageCount: 0
               - 2-PrepareStageCount: 4
                 - __MAX_OF_2-PrepareStageCount: 4
                 - __MIN_OF_2-PrepareStageCount: 0
               - 3-ProcessStageCount: 2
                 - __MAX_OF_3-ProcessStageCount: 2
                 - __MIN_OF_3-ProcessStageCount: 0
               - 4-SplitChunkStageCount: 32
                 - __MAX_OF_4-SplitChunkStageCount: 2
                 - __MIN_OF_4-SplitChunkStageCount: 2
               - 5-FetchChunkStageCount: 32
                 - __MAX_OF_5-FetchChunkStageCount: 2
                 - __MIN_OF_5-FetchChunkStageCount: 2
               - 6-PendingStageCount: 0
               - 7-FinishedStageCount: 15
                 - __MAX_OF_7-FinishedStageCount: 1
                 - __MIN_OF_7-FinishedStageCount: 0
             - OverallStageTime: 46.148us
               - __MAX_OF_OverallStageTime: 652.113us
               - __MIN_OF_OverallStageTime: 1.836us
               - 1-InitStageTime: 2.437us
                 - __MAX_OF_1-InitStageTime: 38.998us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 37.611us
                 - __MAX_OF_2-PrepareStageTime: 601.779us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 452ns
                 - __MAX_OF_3-ProcessStageTime: 7.239us
                 - __MIN_OF_3-ProcessStageTime: 0ns
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 147ns
                   - __MAX_OF_SortedRunProviderTime: 2.352us
                   - __MIN_OF_SortedRunProviderTime: 0ns
               - 4-SplitChunkStageTime: 2.215us
                 - __MAX_OF_4-SplitChunkStageTime: 7.600us
                 - __MIN_OF_4-SplitChunkStageTime: 364ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 2.198us
                 - __MAX_OF_5-FetchChunkStageTime: 13.959us
                 - __MIN_OF_5-FetchChunkStageTime: 279ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 45ns
                 - __MAX_OF_7-FinishedStageTime: 79ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 0ns
             - RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 1:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: f68172bd-8a0a-11f0-94e0-00163e341b98
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.442ms
       - InitialProcessDriverCount: 17
       - InitialProcessMem: 7.099 GB
       - InstanceAllocatedMemoryUsage: 884.930 KB
       - InstanceDeallocatedMemoryUsage: 232.703 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 662.430 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - IsGroupExecution: false
         - ActiveTime: 53.624us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 46.441ms
         - PeakDriverQueueSize: 2
         - PendingTime: 0ns
           - InputEmptyTime: 46.109ms
             - FirstInputEmptyTime: 46.109ms
         - ScheduleCount: 1
         - ScheduleTime: 46.388ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=26):
          CommonMetrics:
             - OperatorTotalTime: 65.049us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: f68172bd8a0a11f0-94e000163e341b97
             - DestID: 26
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 153.687us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 181.912us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 153.687us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 280.950us
        LIMIT (plan_node_id=25) (operator id=7):
          CommonMetrics:
             - OperatorTotalTime: 674ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        LOCAL_EXCHANGE_SOURCE (plan_node_id=25):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 3.913us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
      Pipeline (id=2):
         - IsGroupExecution: false
         - ActiveTime: 196.430us
           - __MAX_OF_ActiveTime: 340.125us
           - __MIN_OF_ActiveTime: 22.858us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 46.094ms
           - __MAX_OF_DriverTotalTime: 46.136ms
           - __MIN_OF_DriverTotalTime: 46.084ms
         - PeakDriverQueueSize: 27
           - __MAX_OF_PeakDriverQueueSize: 3
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 45.692ms
             - __MAX_OF_InputEmptyTime: 45.798ms
             - __MIN_OF_InputEmptyTime: 45.533ms
             - FirstInputEmptyTime: 45.692ms
               - __MAX_OF_FirstInputEmptyTime: 45.798ms
               - __MIN_OF_FirstInputEmptyTime: 45.533ms
         - ScheduleCount: 62
           - __MAX_OF_ScheduleCount: 4
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 45.897ms
           - __MAX_OF_ScheduleTime: 46.061ms
           - __MIN_OF_ScheduleTime: 45.796ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 46
           - __MAX_OF_YieldByLocalWait: 3
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=25):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.509us
               - __MAX_OF_OperatorTotalTime: 17.264us
               - __MIN_OF_OperatorTotalTime: 358ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ShuffleNum: 1
             - Type: Passthrough
             - LocalExchangePeakMemoryUsage: 0.000 B
        LOCAL_PARALLEL_MERGE_SOURCE (plan_node_id=25):
          CommonMetrics:
             - OperatorTotalTime: 186.084us
               - __MAX_OF_OperatorTotalTime: 316.326us
               - __MIN_OF_OperatorTotalTime: 15.996us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 185.163us
               - __MAX_OF_PullTotalTime: 309.028us
               - __MIN_OF_PullTotalTime: 15.593us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - LateMaterialization: False
             - Limit: 10
             - Offset: 0
             - StreamingBatchSize: 262144
             - LateMaterializationMaxBufferChunkNum: 0
             - OverallStageCount: 70
               - __MAX_OF_OverallStageCount: 11
               - __MIN_OF_OverallStageCount: 3
               - 1-InitStageCount: 1
                 - __MAX_OF_1-InitStageCount: 1
                 - __MIN_OF_1-InitStageCount: 0
               - 2-PrepareStageCount: 6
                 - __MAX_OF_2-PrepareStageCount: 6
                 - __MIN_OF_2-PrepareStageCount: 0
               - 3-ProcessStageCount: 16
                 - __MAX_OF_3-ProcessStageCount: 1
                 - __MIN_OF_3-ProcessStageCount: 1
               - 4-SplitChunkStageCount: 16
                 - __MAX_OF_4-SplitChunkStageCount: 1
                 - __MIN_OF_4-SplitChunkStageCount: 1
               - 5-FetchChunkStageCount: 16
                 - __MAX_OF_5-FetchChunkStageCount: 1
                 - __MIN_OF_5-FetchChunkStageCount: 1
               - 6-PendingStageCount: 0
               - 7-FinishedStageCount: 15
                 - __MAX_OF_7-FinishedStageCount: 1
                 - __MIN_OF_7-FinishedStageCount: 0
             - OverallStageTime: 28.945us
               - __MAX_OF_OverallStageTime: 293.647us
               - __MIN_OF_OverallStageTime: 3.979us
               - 1-InitStageTime: 3.432us
                 - __MAX_OF_1-InitStageTime: 54.915us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 14.253us
                 - __MAX_OF_2-PrepareStageTime: 228.048us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 2.396us
                 - __MAX_OF_3-ProcessStageTime: 5.377us
                 - __MIN_OF_3-ProcessStageTime: 826ns
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 811ns
                   - __MAX_OF_SortedRunProviderTime: 1.290us
                   - __MIN_OF_SortedRunProviderTime: 374ns
               - 4-SplitChunkStageTime: 3.516us
                 - __MAX_OF_4-SplitChunkStageTime: 24.360us
                 - __MIN_OF_4-SplitChunkStageTime: 410ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 4.297us
                 - __MAX_OF_5-FetchChunkStageTime: 9.582us
                 - __MIN_OF_5-FetchChunkStageTime: 323ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 63ns
                 - __MAX_OF_7-FinishedStageTime: 94ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 14.107us
           - __MAX_OF_ActiveTime: 50.529us
           - __MIN_OF_ActiveTime: 6.983us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 45.469ms
           - __MAX_OF_DriverTotalTime: 45.563ms
           - __MIN_OF_DriverTotalTime: 45.388ms
         - PeakDriverQueueSize: 213
           - __MAX_OF_PeakDriverQueueSize: 30
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 45.134ms
             - __MAX_OF_InputEmptyTime: 45.191ms
             - __MIN_OF_InputEmptyTime: 44.963ms
             - FirstInputEmptyTime: 45.134ms
               - __MAX_OF_FirstInputEmptyTime: 45.191ms
               - __MIN_OF_FirstInputEmptyTime: 44.963ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 45.455ms
           - __MAX_OF_ScheduleTime: 45.521ms
           - __MIN_OF_ScheduleTime: 45.375ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_SORT_SINK (plan_node_id=25):
          CommonMetrics:
             - OperatorTotalTime: 13.447us
               - __MAX_OF_OperatorTotalTime: 27.062us
               - __MIN_OF_OperatorTotalTime: 7.061us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - SortKeys: 51: sum DESC
             - SortType: TopN
             - BuildingTime: 138ns
               - __MAX_OF_BuildingTime: 336ns
               - __MIN_OF_BuildingTime: 32ns
             - MergingTime: 0ns
             - OutputTime: 113ns
               - __MAX_OF_OutputTime: 176ns
               - __MIN_OF_OutputTime: 50ns
             - SortFilterCost: 0ns
             - SortFilterRows: 0
             - SortingCnt: 0
             - SortingTime: 0ns
        AGGREGATE_BLOCKING_SOURCE (plan_node_id=24):
          CommonMetrics:
             - OperatorTotalTime: 11.492us
               - __MAX_OF_OperatorTotalTime: 27.447us
               - __MIN_OF_OperatorTotalTime: 7.965us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 29.388us
           - __MAX_OF_ActiveTime: 256.535us
           - __MIN_OF_ActiveTime: 10.047us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 45.235ms
           - __MAX_OF_DriverTotalTime: 45.432ms
           - __MIN_OF_DriverTotalTime: 45.137ms
         - PeakDriverQueueSize: 106
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 44.957ms
             - __MAX_OF_InputEmptyTime: 44.961ms
             - __MIN_OF_InputEmptyTime: 44.934ms
             - FirstInputEmptyTime: 44.957ms
               - __MAX_OF_FirstInputEmptyTime: 44.961ms
               - __MIN_OF_FirstInputEmptyTime: 44.934ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 45.206ms
           - __MAX_OF_ScheduleTime: 45.417ms
           - __MIN_OF_ScheduleTime: 45.110ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        AGGREGATE_BLOCKING_SINK (plan_node_id=24):
          CommonMetrics:
             - OperatorTotalTime: 27.021us
               - __MAX_OF_OperatorTotalTime: 254.804us
               - __MIN_OF_OperatorTotalTime: 9.099us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - AggregateFunctions: sum(51: sum), multi_distinct_count(52: count), avg(53: avg)
             - GroupingKeys: 47: n_name
             - AggComputeTime: 0ns
             - AggFuncComputeTime: 0ns
             - ChunkBufferPeakMem: 0.000 B
             - ChunkBufferPeakSize: 0
             - ExprComputeTime: 0ns
             - ExprReleaseTime: 0ns
             - GetResultsTime: 0ns
             - HashTableMemoryUsage: 384.000 B
               - __MAX_OF_HashTableMemoryUsage: 24.000 B
               - __MIN_OF_HashTableMemoryUsage: 24.000 B
             - HashTableSize: 0
             - InputRowCount: 0
             - PassThroughRowCount: 0
             - ResultAggAppendTime: 0ns
             - ResultGroupByAppendTime: 0ns
             - ResultIteratorTime: 0ns
             - RowsReturned: 0
             - StateAllocate: 0ns
             - StateDestroy: 0ns
             - StreamingTime: 0ns
        EXCHANGE_SOURCE (plan_node_id=23):
          CommonMetrics:
             - OperatorTotalTime: 10.256us
               - __MAX_OF_OperatorTotalTime: 21.545us
               - __MIN_OF_OperatorTotalTime: 7.471us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - BufferUnplugCount: 0
             - BytesPassThrough: 0.000 B
             - BytesReceived: 0.000 B
             - ClosureBlockCount: 0
             - ClosureBlockTime: 0ns
             - DecompressChunkTime: 0ns
             - DeserializeChunkTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 398ns
               - __MAX_OF_ReceiverProcessTotalTime: 6.373us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 2:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: f68172bd-8a0a-11f0-94e0-00163e341b99
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 4.049ms
       - InitialProcessDriverCount: 66
       - InitialProcessMem: 7.102 GB
       - InstanceAllocatedMemoryUsage: 2.435 MB
       - InstanceDeallocatedMemoryUsage: 1.427 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.526 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - IsGroupExecution: true
         - ActiveTime: 26.159us
           - __MAX_OF_ActiveTime: 330.221us
           - __MIN_OF_ActiveTime: 4.451us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 35.636ms
           - __MAX_OF_DriverTotalTime: 35.962ms
           - __MIN_OF_DriverTotalTime: 35.580ms
         - PeakDriverQueueSize: 200
           - __MAX_OF_PeakDriverQueueSize: 20
           - __MIN_OF_PeakDriverQueueSize: 5
         - PendingTime: 0ns
           - InputEmptyTime: 35.479ms
             - __MAX_OF_InputEmptyTime: 35.510ms
             - __MIN_OF_InputEmptyTime: 35.455ms
             - FirstInputEmptyTime: 35.479ms
               - __MAX_OF_FirstInputEmptyTime: 35.510ms
               - __MIN_OF_FirstInputEmptyTime: 35.455ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 35.610ms
           - __MAX_OF_ScheduleTime: 35.689ms
           - __MIN_OF_ScheduleTime: 35.573ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        GROUP_EXCHANGE_SINK (plan_node_id=22):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 21.361us
               - __MAX_OF_OperatorTotalTime: 325.255us
               - __MIN_OF_OperatorTotalTime: 566ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ShuffleNum: 16
             - Type: Passthrough
             - GroupLocalExchangePeakMemoryUsage: 0.000 B
        AGGREGATE_STREAMING_SOURCE (plan_node_id=22):
          CommonMetrics:
             - OperatorTotalTime: 9.777us
               - __MAX_OF_OperatorTotalTime: 22.182us
               - __MIN_OF_OperatorTotalTime: 4.592us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
      Pipeline (id=2):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: true
         - ActiveTime: 15.241us
           - __MAX_OF_ActiveTime: 94.151us
           - __MIN_OF_ActiveTime: 7.040us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 35.547ms
           - __MAX_OF_DriverTotalTime: 35.624ms
           - __MIN_OF_DriverTotalTime: 35.489ms
         - PeakDriverQueueSize: 376
           - __MAX_OF_PeakDriverQueueSize: 31
           - __MIN_OF_PeakDriverQueueSize: 16
         - PendingTime: 0ns
           - PreconditionBlockTime: 35.213ms
             - __MAX_OF_PreconditionBlockTime: 35.250ms
             - __MIN_OF_PreconditionBlockTime: 35.179ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 35.531ms
           - __MAX_OF_ScheduleTime: 35.603ms
           - __MIN_OF_ScheduleTime: 35.477ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        AGGREGATE_STREAMING_SINK (plan_node_id=22):
          CommonMetrics:
             - OperatorTotalTime: 20.829us
               - __MAX_OF_OperatorTotalTime: 98.417us
               - __MIN_OF_OperatorTotalTime: 9.329us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - AggregateFunctions: sum(50: expr), multi_distinct_count(9: o_orderkey), avg(6: c_acctbal)
             - GroupingKeys: 47: n_name
             - AggComputeTime: 0ns
             - AggFuncComputeTime: 0ns
             - ChunkBufferPeakMem: 0.000 B
             - ChunkBufferPeakSize: 0
             - ExprComputeTime: 0ns
             - ExprReleaseTime: 0ns
             - GetResultsTime: 0ns
             - HashTableMemoryUsage: 384.000 B
               - __MAX_OF_HashTableMemoryUsage: 24.000 B
               - __MIN_OF_HashTableMemoryUsage: 24.000 B
             - HashTableSize: 0
             - InputRowCount: 0
             - PassThroughRowCount: 0
             - ResultAggAppendTime: 0ns
             - ResultGroupByAppendTime: 0ns
             - ResultIteratorTime: 0ns
             - RowsReturned: 0
             - StateAllocate: 0ns
             - StateDestroy: 0ns
             - StreamingTime: 0ns
        PROJECT (plan_node_id=21):
          CommonMetrics:
             - OperatorTotalTime: 5.850us
               - __MAX_OF_OperatorTotalTime: 15.148us
               - __MIN_OF_OperatorTotalTime: 3.640us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 0ns
        CHUNK_ACCUMULATE (plan_node_id=20):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 412ns
               - __MAX_OF_OperatorTotalTime: 674ns
               - __MIN_OF_OperatorTotalTime: 294ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=20):
          CommonMetrics:
             - OperatorTotalTime: 11.738us
               - __MAX_OF_OperatorTotalTime: 19.888us
               - __MIN_OF_OperatorTotalTime: 9.019us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: LOCAL_HASH_BUCKET
             - JoinType: INNER_JOIN
             - OtherJoinConjunctEvaluateTime: 0ns
             - OutputBuildColumnTime: 0ns
             - OutputProbeColumnTime: 0ns
             - PartitionProbeOverhead: 0ns
             - ProbeConjunctEvaluateTime: 0ns
             - SearchHashTableTime: 0ns
             - WhereConjunctEvaluateTime: 0ns
             - probeCount: 0
        CHUNK_ACCUMULATE (plan_node_id=0):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 392ns
               - __MAX_OF_OperatorTotalTime: 648ns
               - __MIN_OF_OperatorTotalTime: 300ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=0):
          CommonMetrics:
             - RuntimeFilterDesc: <4: BloomFilter> <5: BloomFilter> 
             - OperatorTotalTime: 21.752us
               - __MAX_OF_OperatorTotalTime: 27.809us
               - __MIN_OF_OperatorTotalTime: 19.156us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 2
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - SharedScan: False
             - ChunkBufferCapacity: 1.024K (1024)
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - MorselsCount: 0
             - PeakChunkBufferMemoryUsage: 0.000 B
             - PeakChunkBufferSize: 0
             - PeakIOTasks: 0
             - PeakScanTaskQueueSize: 0
             - PrepareChunkSourceTime: 0ns
             - SubmitTaskCount: 0
             - SubmitTaskTime: 0ns
             - TabletCount: 64
      Pipeline (id=1):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: true
         - ActiveTime: 21.092us
           - __MAX_OF_ActiveTime: 30.979us
           - __MIN_OF_ActiveTime: 12.618us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 35.452ms
           - __MAX_OF_DriverTotalTime: 35.577ms
           - __MIN_OF_DriverTotalTime: 35.368ms
         - PeakDriverQueueSize: 120
           - __MAX_OF_PeakDriverQueueSize: 15
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 35.150ms
             - __MAX_OF_PreconditionBlockTime: 35.159ms
             - __MIN_OF_PreconditionBlockTime: 35.140ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 35.431ms
           - __MAX_OF_ScheduleTime: 35.553ms
           - __MIN_OF_ScheduleTime: 35.337ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=0):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 355ns
               - __MAX_OF_OperatorTotalTime: 528ns
               - __MIN_OF_OperatorTotalTime: 268ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=0):
          CommonMetrics:
             - IsSubordinate
             - RuntimeFilterDesc: <4: BloomFilter> <5: BloomFilter> 
             - OperatorTotalTime: 23.082us
               - __MAX_OF_OperatorTotalTime: 32.975us
               - __MIN_OF_OperatorTotalTime: 13.774us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 16.966us
               - __MAX_OF_PullTotalTime: 25.556us
               - __MIN_OF_PullTotalTime: 9.587us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 2
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 11.549us
               - __MAX_OF_CaptureTabletRowsetsTime: 20.146us
               - __MIN_OF_CaptureTabletRowsetsTime: 9.648us
      Pipeline (id=4):
         - IsGroupExecution: false
         - ActiveTime: 11.298us
           - __MAX_OF_ActiveTime: 56.477us
           - __MIN_OF_ActiveTime: 4.272us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 36.721ms
           - __MAX_OF_DriverTotalTime: 36.753ms
           - __MIN_OF_DriverTotalTime: 36.700ms
         - PeakDriverQueueSize: 267
           - __MAX_OF_PeakDriverQueueSize: 25
           - __MIN_OF_PeakDriverQueueSize: 9
         - PendingTime: 0ns
           - InputEmptyTime: 35.850ms
             - __MAX_OF_InputEmptyTime: 35.995ms
             - __MIN_OF_InputEmptyTime: 35.706ms
             - FirstInputEmptyTime: 35.850ms
               - __MAX_OF_FirstInputEmptyTime: 35.995ms
               - __MIN_OF_FirstInputEmptyTime: 35.706ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 36.710ms
           - __MAX_OF_ScheduleTime: 36.744ms
           - __MIN_OF_ScheduleTime: 36.677ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=23):
          CommonMetrics:
             - OperatorTotalTime: 7.239us
               - __MAX_OF_OperatorTotalTime: 48.680us
               - __MIN_OF_OperatorTotalTime: 1.436us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: f68172bd8a0a11f0-94e000163e341b98
             - DestID: 23
             - PartType: HASH_PARTITIONED
             - PipelineLevelShuffle: Yes
             - ShuffleNumPerChannel: 16
             - TotalShuffleNum: 16
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 175.748us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 391.394us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 175.748us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 633.293us
        LOCAL_EXCHANGE_SOURCE (plan_node_id=22):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 2.048us
               - __MAX_OF_OperatorTotalTime: 4.232us
               - __MIN_OF_OperatorTotalTime: 975ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 95.339us
           - __MAX_OF_ActiveTime: 273.439us
           - __MIN_OF_ActiveTime: 64.870us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 35.121ms
           - __MAX_OF_DriverTotalTime: 35.548ms
           - __MIN_OF_DriverTotalTime: 35.027ms
         - PeakDriverQueueSize: 83
           - __MAX_OF_PeakDriverQueueSize: 12
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 34.813ms
             - __MAX_OF_InputEmptyTime: 34.820ms
             - __MIN_OF_InputEmptyTime: 34.784ms
             - FirstInputEmptyTime: 34.813ms
               - __MAX_OF_FirstInputEmptyTime: 34.820ms
               - __MIN_OF_FirstInputEmptyTime: 34.784ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 35.026ms
           - __MAX_OF_ScheduleTime: 35.274ms
           - __MIN_OF_ScheduleTime: 34.952ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=20):
          CommonMetrics:
             - OperatorTotalTime: 89.405us
               - __MAX_OF_OperatorTotalTime: 263.061us
               - __MIN_OF_OperatorTotalTime: 61.821us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: LOCAL_HASH_BUCKET
             - JoinPredicates: 41: ps_partkey = 19: l_partkey, 42: ps_suppkey = 34: s_suppkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 2.446us
               - __MAX_OF_BuildHashTableTime: 3.073us
               - __MIN_OF_BuildHashTableTime: 2.105us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 928.000 B
               - __MAX_OF_HashTableMemoryUsage: 58.000 B
               - __MIN_OF_HashTableMemoryUsage: 58.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MAX_OF_PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MIN_OF_PartialRuntimeMembershipFilterBytes: 0.000 B
             - PartitionNums: 256
               - __MAX_OF_PartitionNums: 16
               - __MIN_OF_PartitionNums: 16
             - RuntimeFilterBuildTime: 7.215us
               - __MAX_OF_RuntimeFilterBuildTime: 16.923us
               - __MIN_OF_RuntimeFilterBuildTime: 3.658us
             - RuntimeFilterNum: 0
        EXCHANGE_SOURCE (plan_node_id=19):
          CommonMetrics:
             - OperatorTotalTime: 9.677us
               - __MAX_OF_OperatorTotalTime: 19.810us
               - __MIN_OF_OperatorTotalTime: 7.229us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - BufferUnplugCount: 0
             - BytesPassThrough: 0.000 B
             - BytesReceived: 0.000 B
             - ClosureBlockCount: 0
             - ClosureBlockTime: 0ns
             - DecompressChunkTime: 0ns
             - DeserializeChunkTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 182ns
               - __MAX_OF_ReceiverProcessTotalTime: 2.919us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 3:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: f68172bd-8a0a-11f0-94e0-00163e341b9a
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.950ms
       - InitialProcessDriverCount: 114
       - InitialProcessMem: 7.109 GB
       - InstanceAllocatedMemoryUsage: 1.978 MB
       - InstanceDeallocatedMemoryUsage: 1.227 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.294 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=2):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 12.847us
           - __MAX_OF_ActiveTime: 62.167us
           - __MIN_OF_ActiveTime: 6.608us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 28.332ms
           - __MAX_OF_DriverTotalTime: 28.618ms
           - __MIN_OF_DriverTotalTime: 28.038ms
         - PeakDriverQueueSize: 419
           - __MAX_OF_PeakDriverQueueSize: 39
           - __MIN_OF_PeakDriverQueueSize: 15
         - PendingTime: 0ns
           - PreconditionBlockTime: 27.476ms
             - __MAX_OF_PreconditionBlockTime: 27.526ms
             - __MIN_OF_PreconditionBlockTime: 27.432ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 28.319ms
           - __MAX_OF_ScheduleTime: 28.594ms
           - __MIN_OF_ScheduleTime: 28.022ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=19):
          CommonMetrics:
             - OperatorTotalTime: 8.558us
               - __MAX_OF_OperatorTotalTime: 58.278us
               - __MIN_OF_OperatorTotalTime: 2.430us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 64
             - DestFragments: f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99, f68172bd8a0a11f0-94e000163e341b99
             - DestID: 19
             - PartType: BUCKET_SHUFFLE_HASH_PARTITIONED
             - PipelineLevelShuffle: Yes
             - ShuffleNumPerChannel: 1
             - TotalShuffleNum: 64
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 172.798us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 358.712us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 172.798us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 419.834us
        PROJECT (plan_node_id=18):
          CommonMetrics:
             - OperatorTotalTime: 4.594us
               - __MAX_OF_OperatorTotalTime: 5.797us
               - __MIN_OF_OperatorTotalTime: 3.445us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 0ns
        CHUNK_ACCUMULATE (plan_node_id=17):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 402ns
               - __MAX_OF_OperatorTotalTime: 564ns
               - __MIN_OF_OperatorTotalTime: 327ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=17):
          CommonMetrics:
             - OperatorTotalTime: 10.221us
               - __MAX_OF_OperatorTotalTime: 13.507us
               - __MIN_OF_OperatorTotalTime: 7.311us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: LOCAL_HASH_BUCKET
             - JoinType: INNER_JOIN
             - OtherJoinConjunctEvaluateTime: 0ns
             - OutputBuildColumnTime: 0ns
             - OutputProbeColumnTime: 0ns
             - PartitionProbeOverhead: 0ns
             - ProbeConjunctEvaluateTime: 0ns
             - SearchHashTableTime: 0ns
             - WhereConjunctEvaluateTime: 0ns
             - probeCount: 0
        CHUNK_ACCUMULATE (plan_node_id=1):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 403ns
               - __MAX_OF_OperatorTotalTime: 633ns
               - __MIN_OF_OperatorTotalTime: 250ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=1):
          CommonMetrics:
             - RuntimeFilterDesc: <3: BloomFilter> 
             - OperatorTotalTime: 20.513us
               - __MAX_OF_OperatorTotalTime: 24.031us
               - __MIN_OF_OperatorTotalTime: 15.521us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - SharedScan: False
             - ChunkBufferCapacity: 1.024K (1024)
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - MorselsCount: 0
             - PeakChunkBufferMemoryUsage: 0.000 B
             - PeakChunkBufferSize: 0
             - PeakIOTasks: 0
             - PeakScanTaskQueueSize: 0
             - PrepareChunkSourceTime: 0ns
             - SubmitTaskCount: 0
             - SubmitTaskTime: 0ns
             - TabletCount: 64
      Pipeline (id=1):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 22.563us
           - __MAX_OF_ActiveTime: 30.796us
           - __MIN_OF_ActiveTime: 15.688us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 27.566ms
           - __MAX_OF_DriverTotalTime: 27.652ms
           - __MIN_OF_DriverTotalTime: 27.505ms
         - PeakDriverQueueSize: 136
           - __MAX_OF_PeakDriverQueueSize: 16
           - __MIN_OF_PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - PreconditionBlockTime: 27.400ms
             - __MAX_OF_PreconditionBlockTime: 27.411ms
             - __MIN_OF_PreconditionBlockTime: 27.386ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 27.544ms
           - __MAX_OF_ScheduleTime: 27.630ms
           - __MIN_OF_ScheduleTime: 27.484ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=1):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 350ns
               - __MAX_OF_OperatorTotalTime: 637ns
               - __MIN_OF_OperatorTotalTime: 237ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=1):
          CommonMetrics:
             - IsSubordinate
             - RuntimeFilterDesc: <3: BloomFilter> 
             - OperatorTotalTime: 24.416us
               - __MAX_OF_OperatorTotalTime: 31.402us
               - __MIN_OF_OperatorTotalTime: 17.653us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 18.010us
               - __MAX_OF_PullTotalTime: 25.335us
               - __MIN_OF_PullTotalTime: 11.711us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.174us
               - __MAX_OF_CaptureTabletRowsetsTime: 15.226us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.148us
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 89.599us
           - __MAX_OF_ActiveTime: 267.295us
           - __MIN_OF_ActiveTime: 50.721us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 27.401ms
           - __MAX_OF_DriverTotalTime: 27.665ms
           - __MIN_OF_DriverTotalTime: 27.242ms
         - PeakDriverQueueSize: 95
           - __MAX_OF_PeakDriverQueueSize: 13
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 27.132ms
             - __MAX_OF_InputEmptyTime: 27.137ms
             - __MIN_OF_InputEmptyTime: 27.107ms
             - FirstInputEmptyTime: 27.132ms
               - __MAX_OF_FirstInputEmptyTime: 27.137ms
               - __MIN_OF_FirstInputEmptyTime: 27.107ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 27.311ms
           - __MAX_OF_ScheduleTime: 27.499ms
           - __MIN_OF_ScheduleTime: 27.149ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=17):
          CommonMetrics:
             - OperatorTotalTime: 84.468us
               - __MAX_OF_OperatorTotalTime: 256.248us
               - __MIN_OF_OperatorTotalTime: 48.577us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: LOCAL_HASH_BUCKET
             - JoinPredicates: 1: c_custkey = 10: o_custkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 2.440us
               - __MAX_OF_BuildHashTableTime: 3.293us
               - __MIN_OF_BuildHashTableTime: 1.419us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 864.000 B
               - __MAX_OF_HashTableMemoryUsage: 54.000 B
               - __MIN_OF_HashTableMemoryUsage: 54.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MAX_OF_PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MIN_OF_PartialRuntimeMembershipFilterBytes: 0.000 B
             - PartitionNums: 256
               - __MAX_OF_PartitionNums: 16
               - __MIN_OF_PartitionNums: 16
             - RuntimeFilterBuildTime: 4.808us
               - __MAX_OF_RuntimeFilterBuildTime: 12.364us
               - __MIN_OF_RuntimeFilterBuildTime: 2.266us
             - RuntimeFilterNum: 0
        EXCHANGE_SOURCE (plan_node_id=16):
          CommonMetrics:
             - OperatorTotalTime: 9.571us
               - __MAX_OF_OperatorTotalTime: 18.753us
               - __MIN_OF_OperatorTotalTime: 6.332us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - BufferUnplugCount: 0
             - BytesPassThrough: 0.000 B
             - BytesReceived: 0.000 B
             - ClosureBlockCount: 0
             - ClosureBlockTime: 0ns
             - DecompressChunkTime: 0ns
             - DeserializeChunkTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 190ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.049us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 4:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: f68172bd-8a0a-11f0-94e0-00163e341b9b
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.927ms
       - InitialProcessDriverCount: 162
       - InitialProcessMem: 7.113 GB
       - InstanceAllocatedMemoryUsage: 1.979 MB
       - InstanceDeallocatedMemoryUsage: 1.190 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.294 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=2):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 16.275us
           - __MAX_OF_ActiveTime: 58.520us
           - __MIN_OF_ActiveTime: 5.940us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 21.183ms
           - __MAX_OF_DriverTotalTime: 21.357ms
           - __MIN_OF_DriverTotalTime: 20.991ms
         - PeakDriverQueueSize: 387
           - __MAX_OF_PeakDriverQueueSize: 36
           - __MIN_OF_PeakDriverQueueSize: 15
         - PendingTime: 0ns
           - PreconditionBlockTime: 20.362ms
             - __MAX_OF_PreconditionBlockTime: 20.510ms
             - __MIN_OF_PreconditionBlockTime: 20.310ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 21.167ms
           - __MAX_OF_ScheduleTime: 21.349ms
           - __MIN_OF_ScheduleTime: 20.948ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=16):
          CommonMetrics:
             - OperatorTotalTime: 11.676us
               - __MAX_OF_OperatorTotalTime: 53.884us
               - __MIN_OF_OperatorTotalTime: 2.282us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 64
             - DestFragments: f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a, f68172bd8a0a11f0-94e000163e341b9a
             - DestID: 16
             - PartType: BUCKET_SHUFFLE_HASH_PARTITIONED
             - PipelineLevelShuffle: Yes
             - ShuffleNumPerChannel: 1
             - TotalShuffleNum: 64
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 176.184us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 315.192us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 176.184us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 430.296us
        PROJECT (plan_node_id=15):
          CommonMetrics:
             - OperatorTotalTime: 3.664us
               - __MAX_OF_OperatorTotalTime: 5.415us
               - __MIN_OF_OperatorTotalTime: 2.560us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 0ns
        CHUNK_ACCUMULATE (plan_node_id=14):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 404ns
               - __MAX_OF_OperatorTotalTime: 690ns
               - __MIN_OF_OperatorTotalTime: 331ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=14):
          CommonMetrics:
             - OperatorTotalTime: 9.708us
               - __MAX_OF_OperatorTotalTime: 16.891us
               - __MIN_OF_OperatorTotalTime: 7.385us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: LOCAL_HASH_BUCKET
             - JoinType: INNER_JOIN
             - OtherJoinConjunctEvaluateTime: 0ns
             - OutputBuildColumnTime: 0ns
             - OutputProbeColumnTime: 0ns
             - PartitionProbeOverhead: 0ns
             - ProbeConjunctEvaluateTime: 0ns
             - SearchHashTableTime: 0ns
             - WhereConjunctEvaluateTime: 0ns
             - probeCount: 0
        CHUNK_ACCUMULATE (plan_node_id=2):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 342ns
               - __MAX_OF_OperatorTotalTime: 443ns
               - __MIN_OF_OperatorTotalTime: 272ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=2):
          CommonMetrics:
             - RuntimeFilterDesc: <2: BloomFilter> 
             - OperatorTotalTime: 19.918us
               - __MAX_OF_OperatorTotalTime: 28.605us
               - __MIN_OF_OperatorTotalTime: 16.252us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - SharedScan: False
             - ChunkBufferCapacity: 1.024K (1024)
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - MorselsCount: 0
             - PeakChunkBufferMemoryUsage: 0.000 B
             - PeakChunkBufferSize: 0
             - PeakIOTasks: 0
             - PeakScanTaskQueueSize: 0
             - PrepareChunkSourceTime: 0ns
             - SubmitTaskCount: 0
             - SubmitTaskTime: 0ns
             - TabletCount: 64
      Pipeline (id=1):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 27.847us
           - __MAX_OF_ActiveTime: 43.329us
           - __MIN_OF_ActiveTime: 16.629us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 20.555ms
           - __MAX_OF_DriverTotalTime: 20.615ms
           - __MIN_OF_DriverTotalTime: 20.476ms
         - PeakDriverQueueSize: 152
           - __MAX_OF_PeakDriverQueueSize: 17
           - __MIN_OF_PeakDriverQueueSize: 2
         - PendingTime: 0ns
           - PreconditionBlockTime: 20.282ms
             - __MAX_OF_PreconditionBlockTime: 20.289ms
             - __MIN_OF_PreconditionBlockTime: 20.274ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 20.527ms
           - __MAX_OF_ScheduleTime: 20.576ms
           - __MIN_OF_ScheduleTime: 20.451ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=2):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 358ns
               - __MAX_OF_OperatorTotalTime: 658ns
               - __MIN_OF_OperatorTotalTime: 264ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=2):
          CommonMetrics:
             - IsSubordinate
             - RuntimeFilterDesc: <2: BloomFilter> 
             - OperatorTotalTime: 29.816us
               - __MAX_OF_OperatorTotalTime: 44.676us
               - __MIN_OF_OperatorTotalTime: 19.051us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 22.791us
               - __MAX_OF_PullTotalTime: 36.699us
               - __MIN_OF_PullTotalTime: 13.024us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 9.786us
               - __MAX_OF_CaptureTabletRowsetsTime: 15.067us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.157us
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 99.813us
           - __MAX_OF_ActiveTime: 409.717us
           - __MIN_OF_ActiveTime: 67.465us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 20.261ms
           - __MAX_OF_DriverTotalTime: 20.564ms
           - __MIN_OF_DriverTotalTime: 20.138ms
         - PeakDriverQueueSize: 106
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 19.933ms
             - __MAX_OF_InputEmptyTime: 19.938ms
             - __MIN_OF_InputEmptyTime: 19.901ms
             - FirstInputEmptyTime: 19.933ms
               - __MAX_OF_FirstInputEmptyTime: 19.938ms
               - __MIN_OF_FirstInputEmptyTime: 19.901ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 20.161ms
           - __MAX_OF_ScheduleTime: 20.374ms
           - __MIN_OF_ScheduleTime: 20.054ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=14):
          CommonMetrics:
             - OperatorTotalTime: 95.044us
               - __MAX_OF_OperatorTotalTime: 406.414us
               - __MIN_OF_OperatorTotalTime: 65.007us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: LOCAL_HASH_BUCKET
             - JoinPredicates: 9: o_orderkey = 18: l_orderkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 2.458us
               - __MAX_OF_BuildHashTableTime: 3.610us
               - __MIN_OF_BuildHashTableTime: 1.627us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 768.000 B
               - __MAX_OF_HashTableMemoryUsage: 48.000 B
               - __MIN_OF_HashTableMemoryUsage: 48.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MAX_OF_PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MIN_OF_PartialRuntimeMembershipFilterBytes: 0.000 B
             - PartitionNums: 256
               - __MAX_OF_PartitionNums: 16
               - __MIN_OF_PartitionNums: 16
             - RuntimeFilterBuildTime: 5.251us
               - __MAX_OF_RuntimeFilterBuildTime: 13.144us
               - __MIN_OF_RuntimeFilterBuildTime: 3.639us
             - RuntimeFilterNum: 0
        EXCHANGE_SOURCE (plan_node_id=13):
          CommonMetrics:
             - OperatorTotalTime: 9.578us
               - __MAX_OF_OperatorTotalTime: 21.786us
               - __MIN_OF_OperatorTotalTime: 7.341us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - BufferUnplugCount: 0
             - BytesPassThrough: 0.000 B
             - BytesReceived: 0.000 B
             - ClosureBlockCount: 0
             - ClosureBlockTime: 0ns
             - DecompressChunkTime: 0ns
             - DeserializeChunkTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 241ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.865us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 5:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: f68172bd-8a0a-11f0-94e0-00163e341b9c
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.097ms
       - InitialProcessDriverCount: 210
       - InitialProcessMem: 7.118 GB
       - InstanceAllocatedMemoryUsage: 2.226 MB
       - InstanceDeallocatedMemoryUsage: 720.852 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.522 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 10.499us
           - __MAX_OF_ActiveTime: 55.335us
           - __MIN_OF_ActiveTime: 4.052us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 14.054ms
           - __MAX_OF_DriverTotalTime: 14.212ms
           - __MIN_OF_DriverTotalTime: 13.845ms
         - PeakDriverQueueSize: 269
           - __MAX_OF_PeakDriverQueueSize: 36
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 13.164ms
             - __MAX_OF_PreconditionBlockTime: 13.315ms
             - __MIN_OF_PreconditionBlockTime: 12.987ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 14.044ms
           - __MAX_OF_ScheduleTime: 14.204ms
           - __MIN_OF_ScheduleTime: 13.835ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=13):
          CommonMetrics:
             - OperatorTotalTime: 7.293us
               - __MAX_OF_OperatorTotalTime: 49.973us
               - __MIN_OF_OperatorTotalTime: 1.264us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 64
             - DestFragments: f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b, f68172bd8a0a11f0-94e000163e341b9b
             - DestID: 13
             - PartType: BUCKET_SHUFFLE_HASH_PARTITIONED
             - PipelineLevelShuffle: Yes
             - ShuffleNumPerChannel: 1
             - TotalShuffleNum: 64
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 182.029us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 393.004us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 182.029us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 510.205us
        PROJECT (plan_node_id=12):
          CommonMetrics:
             - OperatorTotalTime: 3.776us
               - __MAX_OF_OperatorTotalTime: 4.558us
               - __MIN_OF_OperatorTotalTime: 2.942us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 0ns
        CHUNK_ACCUMULATE (plan_node_id=11):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 405ns
               - __MAX_OF_OperatorTotalTime: 587ns
               - __MIN_OF_OperatorTotalTime: 306ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 4.950us
               - __MAX_OF_OperatorTotalTime: 9.104us
               - __MIN_OF_OperatorTotalTime: 3.145us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: BROADCAST
             - JoinType: INNER_JOIN
             - OtherJoinConjunctEvaluateTime: 0ns
             - OutputBuildColumnTime: 0ns
             - OutputProbeColumnTime: 0ns
             - PartitionProbeOverhead: 0ns
             - ProbeConjunctEvaluateTime: 0ns
             - SearchHashTableTime: 0ns
             - WhereConjunctEvaluateTime: 0ns
             - probeCount: 0
        PROJECT (plan_node_id=4):
          CommonMetrics:
             - OperatorTotalTime: 4.139us
               - __MAX_OF_OperatorTotalTime: 5.373us
               - __MIN_OF_OperatorTotalTime: 2.988us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 0ns
        CHUNK_ACCUMULATE (plan_node_id=3):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 376ns
               - __MAX_OF_OperatorTotalTime: 546ns
               - __MIN_OF_OperatorTotalTime: 305ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=3):
          CommonMetrics:
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 19.749us
               - __MAX_OF_OperatorTotalTime: 24.703us
               - __MIN_OF_OperatorTotalTime: 14.528us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - SharedScan: False
             - ChunkBufferCapacity: 1.024K (1024)
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - MorselsCount: 0
             - PeakChunkBufferMemoryUsage: 0.000 B
             - PeakChunkBufferSize: 0
             - PeakIOTasks: 0
             - PeakScanTaskQueueSize: 0
             - PrepareChunkSourceTime: 0ns
             - SubmitTaskCount: 0
             - SubmitTaskTime: 0ns
             - TabletCount: 64
      Pipeline (id=2):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 43.333us
           - __MAX_OF_ActiveTime: 65.336us
           - __MIN_OF_ActiveTime: 22.057us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 12.902ms
           - __MAX_OF_DriverTotalTime: 13.093ms
           - __MIN_OF_DriverTotalTime: 12.779ms
         - PeakDriverQueueSize: 3
           - __MAX_OF_PeakDriverQueueSize: 1
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 12.815ms
             - __MAX_OF_PreconditionBlockTime: 12.975ms
             - __MIN_OF_PreconditionBlockTime: 12.677ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 12.859ms
           - __MAX_OF_ScheduleTime: 13.050ms
           - __MIN_OF_ScheduleTime: 12.719ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=3):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 342ns
               - __MAX_OF_OperatorTotalTime: 529ns
               - __MIN_OF_OperatorTotalTime: 278ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=3):
          CommonMetrics:
             - IsSubordinate
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 44.771us
               - __MAX_OF_OperatorTotalTime: 66.646us
               - __MIN_OF_OperatorTotalTime: 24.293us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 38.754us
               - __MAX_OF_PullTotalTime: 59.321us
               - __MIN_OF_PullTotalTime: 19.546us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 12.772us
               - __MAX_OF_CaptureTabletRowsetsTime: 26.271us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.832us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 747.808us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 13.396ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 12.586ms
             - FirstInputEmptyTime: 12.586ms
         - ScheduleCount: 1
         - ScheduleTime: 12.649ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 744.147us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: BROADCAST
             - JoinPredicates: 20: l_suppkey = 34: s_suppkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 4.137us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 16.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 1
             - RuntimeFilterBuildTime: 11.989us
             - RuntimeFilterNum: 0
        LOCAL_EXCHANGE_SOURCE (plan_node_id=11):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 6.465us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 12.009us
           - __MAX_OF_ActiveTime: 72.437us
           - __MIN_OF_ActiveTime: 5.687us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 12.835ms
           - __MAX_OF_DriverTotalTime: 16.732ms
           - __MIN_OF_DriverTotalTime: 12.547ms
         - PeakDriverQueueSize: 152
           - __MAX_OF_PeakDriverQueueSize: 17
           - __MIN_OF_PeakDriverQueueSize: 2
         - PendingTime: 0ns
           - InputEmptyTime: 12.304ms
             - __MAX_OF_InputEmptyTime: 12.328ms
             - __MIN_OF_InputEmptyTime: 12.298ms
             - FirstInputEmptyTime: 12.304ms
               - __MAX_OF_FirstInputEmptyTime: 12.328ms
               - __MIN_OF_FirstInputEmptyTime: 12.298ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 12.823ms
           - __MAX_OF_ScheduleTime: 16.726ms
           - __MIN_OF_ScheduleTime: 12.538ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=11):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.008us
               - __MAX_OF_OperatorTotalTime: 55.019us
               - __MIN_OF_OperatorTotalTime: 381ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ShuffleNum: 1
             - Type: Passthrough
             - LocalExchangePeakMemoryUsage: 0.000 B
        EXCHANGE_SOURCE (plan_node_id=10):
          CommonMetrics:
             - OperatorTotalTime: 9.191us
               - __MAX_OF_OperatorTotalTime: 16.854us
               - __MIN_OF_OperatorTotalTime: 6.473us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - BufferUnplugCount: 0
             - BytesPassThrough: 0.000 B
             - BytesReceived: 0.000 B
             - ClosureBlockCount: 0
             - ClosureBlockTime: 0ns
             - DecompressChunkTime: 0ns
             - DeserializeChunkTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 193ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.094us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 6:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: f68172bd-8a0a-11f0-94e0-00163e341b9d
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.129ms
       - InitialProcessDriverCount: 259
       - InitialProcessMem: 7.122 GB
       - InstanceAllocatedMemoryUsage: 1.800 MB
       - InstanceDeallocatedMemoryUsage: 619.766 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.195 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 13.639us
           - __MAX_OF_ActiveTime: 77.826us
           - __MIN_OF_ActiveTime: 5.031us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 6.801ms
           - __MAX_OF_DriverTotalTime: 6.818ms
           - __MIN_OF_DriverTotalTime: 6.792ms
         - PeakDriverQueueSize: 408
           - __MAX_OF_PeakDriverQueueSize: 33
           - __MIN_OF_PeakDriverQueueSize: 18
         - PendingTime: 0ns
           - PreconditionBlockTime: 6.118ms
             - __MAX_OF_PreconditionBlockTime: 6.149ms
             - __MIN_OF_PreconditionBlockTime: 6.091ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 6.788ms
           - __MAX_OF_ScheduleTime: 6.809ms
           - __MIN_OF_ScheduleTime: 6.737ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=10):
          CommonMetrics:
             - OperatorTotalTime: 9.713us
               - __MAX_OF_OperatorTotalTime: 70.563us
               - __MIN_OF_OperatorTotalTime: 1.509us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: f68172bd8a0a11f0-94e000163e341b9c
             - DestID: 10
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 192.859us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 216.234us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 192.859us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 479.979us
        PROJECT (plan_node_id=9):
          CommonMetrics:
             - OperatorTotalTime: 4.186us
               - __MAX_OF_OperatorTotalTime: 5.629us
               - __MIN_OF_OperatorTotalTime: 2.364us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 0ns
        CHUNK_ACCUMULATE (plan_node_id=8):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 366ns
               - __MAX_OF_OperatorTotalTime: 458ns
               - __MIN_OF_OperatorTotalTime: 267ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 5.500us
               - __MAX_OF_OperatorTotalTime: 11.042us
               - __MIN_OF_OperatorTotalTime: 3.687us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: BROADCAST
             - JoinType: INNER_JOIN
             - OtherJoinConjunctEvaluateTime: 0ns
             - OutputBuildColumnTime: 0ns
             - OutputProbeColumnTime: 0ns
             - PartitionProbeOverhead: 0ns
             - ProbeConjunctEvaluateTime: 0ns
             - SearchHashTableTime: 0ns
             - WhereConjunctEvaluateTime: 0ns
             - probeCount: 0
        CHUNK_ACCUMULATE (plan_node_id=5):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 352ns
               - __MAX_OF_OperatorTotalTime: 743ns
               - __MIN_OF_OperatorTotalTime: 229ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=5):
          CommonMetrics:
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 29.914us
               - __MAX_OF_OperatorTotalTime: 42.457us
               - __MIN_OF_OperatorTotalTime: 15.892us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - SharedScan: False
             - ChunkBufferCapacity: 1.024K (1024)
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - MorselsCount: 0
             - PeakChunkBufferMemoryUsage: 0.000 B
             - PeakChunkBufferSize: 0
             - PeakIOTasks: 0
             - PeakScanTaskQueueSize: 0
             - PrepareChunkSourceTime: 0ns
             - SubmitTaskCount: 0
             - SubmitTaskTime: 0ns
             - TabletCount: 64
      Pipeline (id=2):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 24.490us
           - __MAX_OF_ActiveTime: 33.102us
           - __MIN_OF_ActiveTime: 15.428us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 6.330ms
           - __MAX_OF_DriverTotalTime: 6.411ms
           - __MIN_OF_DriverTotalTime: 6.268ms
         - PeakDriverQueueSize: 120
           - __MAX_OF_PeakDriverQueueSize: 15
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 6.067ms
             - __MAX_OF_PreconditionBlockTime: 6.073ms
             - __MIN_OF_PreconditionBlockTime: 6.062ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 6.306ms
           - __MAX_OF_ScheduleTime: 6.378ms
           - __MIN_OF_ScheduleTime: 6.246ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=5):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 398ns
               - __MAX_OF_OperatorTotalTime: 615ns
               - __MIN_OF_OperatorTotalTime: 280ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=5):
          CommonMetrics:
             - IsSubordinate
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 29.367us
               - __MAX_OF_OperatorTotalTime: 51.846us
               - __MIN_OF_OperatorTotalTime: 18.114us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 19.561us
               - __MAX_OF_PullTotalTime: 26.491us
               - __MIN_OF_PullTotalTime: 12.068us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 16.168us
               - __MAX_OF_CaptureTabletRowsetsTime: 25.577us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.264us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 223.869us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 6.240ms
         - PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - InputEmptyTime: 5.952ms
             - FirstInputEmptyTime: 5.952ms
         - ScheduleCount: 1
         - ScheduleTime: 6.016ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 220.384us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - DistributionMode: BROADCAST
             - JoinPredicates: 37: s_nationkey = 46: n_nationkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 3.452us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 16.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 16
             - RuntimeFilterBuildTime: 15.303us
             - RuntimeFilterNum: 0
        LOCAL_EXCHANGE_SOURCE (plan_node_id=8):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.861us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 9.502us
           - __MAX_OF_ActiveTime: 20.831us
           - __MIN_OF_ActiveTime: 4.936us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 5.960ms
           - __MAX_OF_DriverTotalTime: 6.034ms
           - __MIN_OF_DriverTotalTime: 5.890ms
         - PeakDriverQueueSize: 107
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 5.756ms
             - __MAX_OF_InputEmptyTime: 5.760ms
             - __MIN_OF_InputEmptyTime: 5.737ms
             - FirstInputEmptyTime: 5.756ms
               - __MAX_OF_FirstInputEmptyTime: 5.760ms
               - __MIN_OF_FirstInputEmptyTime: 5.737ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 5.951ms
           - __MAX_OF_ScheduleTime: 6.027ms
           - __MIN_OF_ScheduleTime: 5.881ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=8):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 841ns
               - __MAX_OF_OperatorTotalTime: 4.278us
               - __MIN_OF_OperatorTotalTime: 346ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ShuffleNum: 1
             - Type: Passthrough
             - LocalExchangePeakMemoryUsage: 0.000 B
        EXCHANGE_SOURCE (plan_node_id=7):
          CommonMetrics:
             - OperatorTotalTime: 10.791us
               - __MAX_OF_OperatorTotalTime: 20.279us
               - __MIN_OF_OperatorTotalTime: 7.555us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - BufferUnplugCount: 0
             - BytesPassThrough: 0.000 B
             - BytesReceived: 0.000 B
             - ClosureBlockCount: 0
             - ClosureBlockTime: 0ns
             - DecompressChunkTime: 0ns
             - DeserializeChunkTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 320ns
               - __MAX_OF_ReceiverProcessTotalTime: 5.133us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 7:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: f68172bd-8a0a-11f0-94e0-00163e341b9e
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.222ms
       - InitialProcessDriverCount: 308
       - InitialProcessMem: 7.125 GB
       - InstanceAllocatedMemoryUsage: 7.182 MB
       - InstanceDeallocatedMemoryUsage: 5.099 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 2.083 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 1.180ms
           - __MAX_OF_ActiveTime: 1.737ms
           - __MIN_OF_ActiveTime: 813.415us
         - BlockByInputEmpty: 10
           - __MAX_OF_BlockByInputEmpty: 1
           - __MIN_OF_BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 2.337ms
           - __MAX_OF_DriverTotalTime: 2.754ms
           - __MIN_OF_DriverTotalTime: 2.088ms
         - PeakDriverQueueSize: 115
           - __MAX_OF_PeakDriverQueueSize: 32
           - __MIN_OF_PeakDriverQueueSize: 0
         - ScheduleCount: 26
           - __MAX_OF_ScheduleCount: 2
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 1.157ms
           - __MAX_OF_ScheduleTime: 1.605ms
           - __MIN_OF_ScheduleTime: 400.652us
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=7):
          CommonMetrics:
             - OperatorTotalTime: 9.180us
               - __MAX_OF_OperatorTotalTime: 70.678us
               - __MIN_OF_OperatorTotalTime: 2.448us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: f68172bd8a0a11f0-94e000163e341b9d
             - DestID: 7
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 198.388us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 362.403us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 198.388us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 731.272us
        CHUNK_ACCUMULATE (plan_node_id=6):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 2.435us
               - __MAX_OF_OperatorTotalTime: 3.249us
               - __MIN_OF_OperatorTotalTime: 1.896us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 450ns
               - __MAX_OF_PullTotalTime: 573ns
               - __MIN_OF_PullTotalTime: 367ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 1.536us
               - __MAX_OF_PushTotalTime: 2.240us
               - __MIN_OF_PushTotalTime: 1.105us
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=6):
          CommonMetrics:
             - OperatorTotalTime: 1.527ms
               - __MAX_OF_OperatorTotalTime: 2.006ms
               - __MIN_OF_OperatorTotalTime: 1.273ms
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 1.131ms
               - __MAX_OF_PullTotalTime: 1.644ms
               - __MIN_OF_PullTotalTime: 766.306us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - Predicates: 47: n_name IN ('USA', 'Germany', 'Japan')
             - Rollup: nation
             - SharedScan: False
             - Table: nation
             - AccessPathHits: 0
             - AccessPathUnhits: 0
             - BytesRead: 0.000 B
             - CachedPagesNum: 0
             - ChunkBufferCapacity: 1.024K (1024)
             - CompressedBytesRead: 0.000 B
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - IOTaskExecTime: 25.862us
               - __MAX_OF_IOTaskExecTime: 53.470us
               - __MIN_OF_IOTaskExecTime: 10us
               - CreateSegmentIter: 10.051us
                 - __MAX_OF_CreateSegmentIter: 23.844us
                 - __MIN_OF_CreateSegmentIter: 4.883us
               - GetDelVec: 0ns
               - GetDeltaColumnGroup: 954ns
                 - __MAX_OF_GetDeltaColumnGroup: 7.551us
                 - __MIN_OF_GetDeltaColumnGroup: 0ns
               - GetRowsets: 3.093us
                 - __MAX_OF_GetRowsets: 6.454us
                 - __MIN_OF_GetRowsets: 1.931us
               - IOTime: 0ns
               - ReadPKIndex: 0ns
               - SegmentInit: 0ns
                 - BitmapIndexFilter: 0ns
                 - BitmapIndexFilterRows: 0
                 - BitmapIndexIteratorInit: 0ns
                 - BloomFilterFilter: 0ns
                 - BloomFilterFilterRows: 0
                 - ColumnIteratorInit: 0ns
                 - GetVectorRowRangesTime: 0ns
                 - GinFilter: 0ns
                 - GinFilterRows: 0
                 - ProcessVectorDistanceAndIdTime: 0ns
                 - RemainingRowsAfterShortKeyFilter: 0
                 - SegmentRuntimeZoneMapFilterRows: 0
                 - SegmentZoneMapFilterRows: 25
                   - __MAX_OF_SegmentZoneMapFilterRows: 1
                   - __MIN_OF_SegmentZoneMapFilterRows: 0
                 - ShortKeyFilter: 0ns
                 - ShortKeyFilterRows: 0
                 - ShortKeyRangeNumber: 0
                 - VectorIndexFilterRows: 0
                 - VectorSearchTime: 0ns
                 - ZoneMapIndexFilterRows: 0
                 - ZoneMapIndexFiter: 0ns
               - SegmentRead: 0ns
                 - BlockFetch: 0ns
                 - BlockFetchCount: 0
                 - BlockSeek: 0ns
                 - BlockSeekCount: 0
                 - ChunkCopy: 0ns
                 - DecompressT: 0ns
                 - DelVecFilterRows: 0
                 - PredFilter: 0ns
                 - PredFilterRows: 0
                 - RowsetsReadCount: 128
                   - __MAX_OF_RowsetsReadCount: 2
                   - __MIN_OF_RowsetsReadCount: 2
                 - SegmentsReadCount: 25
                   - __MAX_OF_SegmentsReadCount: 1
                   - __MIN_OF_SegmentsReadCount: 0
                 - TotalColumnsDataPageCount: 0
             - IOTaskWaitTime: 187.854us
               - __MAX_OF_IOTaskWaitTime: 808.301us
               - __MIN_OF_IOTaskWaitTime: 23.459us
             - MorselsCount: 64
               - __MAX_OF_MorselsCount: 4
               - __MIN_OF_MorselsCount: 4
             - PeakChunkBufferMemoryUsage: 120.018 KB
             - PeakChunkBufferSize: 2
             - PeakIOTasks: 1
             - PeakScanTaskQueueSize: 45
               - __MAX_OF_PeakScanTaskQueueSize: 5
               - __MIN_OF_PeakScanTaskQueueSize: 1
             - PrepareChunkSourceTime: 490.427us
               - __MAX_OF_PrepareChunkSourceTime: 573.769us
               - __MIN_OF_PrepareChunkSourceTime: 407.457us
             - PushdownAccessPaths: 0
             - PushdownPredicates: 1
             - RawRowsRead: 0
             - ReadPagesNum: 0
             - RowsRead: 0
             - RuntimeFilterEvalTime: 0ns
             - RuntimeFilterInputRows: 0
             - RuntimeFilterOutputRows: 0
             - ScanTime: 213.716us
               - __MAX_OF_ScanTime: 827.861us
               - __MIN_OF_ScanTime: 39.348us
             - SubmitTaskCount: 64
               - __MAX_OF_SubmitTaskCount: 4
               - __MIN_OF_SubmitTaskCount: 4
             - SubmitTaskTime: 619.181us
               - __MAX_OF_SubmitTaskTime: 1.098ms
               - __MIN_OF_SubmitTaskTime: 288.212us
             - TabletCount: 64
             - UncompressedBytesRead: 0.000 B
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 31.912us
           - __MAX_OF_ActiveTime: 53.753us
           - __MIN_OF_ActiveTime: 14.726us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 113.378us
           - __MAX_OF_DriverTotalTime: 180.519us
           - __MIN_OF_DriverTotalTime: 35.922us
         - PeakDriverQueueSize: 28
           - __MAX_OF_PeakDriverQueueSize: 3
           - __MIN_OF_PeakDriverQueueSize: 0
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=6):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 334ns
               - __MAX_OF_OperatorTotalTime: 596ns
               - __MIN_OF_OperatorTotalTime: 197ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=6):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 32.312us
               - __MAX_OF_OperatorTotalTime: 53.113us
               - __MIN_OF_OperatorTotalTime: 15.693us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 27.173us
               - __MAX_OF_PullTotalTime: 46.812us
               - __MIN_OF_PullTotalTime: 12.208us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.976us
               - __MAX_OF_CaptureTabletRowsetsTime: 14.196us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.978us
