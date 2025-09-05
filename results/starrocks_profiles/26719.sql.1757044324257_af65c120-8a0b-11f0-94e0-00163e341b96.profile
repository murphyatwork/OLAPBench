Query:
  Summary:
     - Query ID: af65c120-8a0b-11f0-94e0-00163e341b96
     - Start Time: 2025-09-05 11:52:04
     - End Time: 2025-09-05 11:52:04
     - Total: 109ms
     - Query Type: Query
     - Query State: Finished
     - StarRocks Version: 3.5.4-1ce07c8
     - User: root
     - Default Db: tpch
     - Sql Statement: SELECT 
    p.p_name,
    SUM(l.l_quantity) AS total_quantity,
    AVG(l.l_extendedprice) AS average_price,
    COUNT(DISTINCT o.o_orderkey) AS order_count,
    CONCAT('Total: ', CAST(SUM(l.l_extendedprice) AS CHAR), ', Average: ', CAST(AVG(l.l_extendedprice) AS CHAR)) AS price_summary
FROM 
    part p
JOIN 
    lineitem l ON p.p_partkey = l.l_partkey
JOIN 
    orders o ON l.l_orderkey = o.o_orderkey
JOIN 
    partsupp ps ON p.p_partkey = ps.ps_partkey
JOIN 
    supplier s ON ps.ps_suppkey = s.s_suppkey
JOIN 
    nation n ON s.s_nationkey = n.n_nationkey
JOIN 
    region r ON n.n_regionkey = r.r_regionkey
WHERE 
    n.n_name LIKE '%land%' 
    AND r.r_name = 'Europe'
    AND l.l_shipdate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY 
    p.p_name
HAVING 
    SUM(l.l_quantity) > 100
ORDER BY 
    total_quantity DESC;
     - Variables: parallel_fragment_exec_instance_num=1,max_parallel_scan_instance_num=-1,pipeline_dop=0,enable_adaptive_sink_dop=true,enable_runtime_adaptive_dop=false,runtime_profile_report_interval=10,resource_group=default_wg
     - NonDefaultSessionVariables: {"sql_mode_v2":{"defaultValue":32,"actualValue":34},"query_timeout":{"defaultValue":300,"actualValue":10},"prefer_compute_node":{"defaultValue":false,"actualValue":true},"enable_adaptive_sink_dop":{"defaultValue":false,"actualValue":true},"enable_profile":{"defaultValue":false,"actualValue":true}}
     - Collect Profile Time: 1ms
     - IsProfileAsync: true
  Planner:
     - -- Parser[1] 1ms
     - -- Total[1] 36ms
     -     -- Analyzer[1] 0
     -         -- Lock[1] 0
     -         -- AnalyzeDatabase[7] 0
     -         -- AnalyzeTemporaryTable[7] 0
     -         -- AnalyzeTable[7] 0
     -     -- Transformer[1] 1ms
     -     -- Optimizer[1] 33ms
     -         -- MVPreprocess[1] 0
     -         -- MVTextRewrite[1] 0
     -         -- RuleBaseOptimize[1] 21ms
     -         -- CostBaseOptimize[1] 11ms
     -         -- PhysicalRewrite[1] 0
     -         -- DynamicRewrite[1] 0
     -         -- PlanValidate[1] 0
     -             -- InputDependenciesChecker[1] 0
     -             -- TypeChecker[1] 0
     -             -- CTEUniqueChecker[1] 0
     -             -- ColumnReuseChecker[1] 0
     -     -- ExecPlanBuild[1] 0
     - -- Pending[1] 0
     - -- Prepare[1] 0
     - -- Deploy[1] 44ms
     -     -- DeployLockInternalTime[1] 44ms
     -         -- DeploySerializeConcurrencyTime[9] 2ms
     -         -- DeployStageByStageTime[27] 0
     -         -- DeployWaitTime[27] 41ms
     -             -- DeployAsyncSendTime[9] 0
     - DeployDataSize: 121580
    Reason:
  Execution:
     - Topology: {"rootId":33,"nodes":[{"id":33,"name":"MERGE_EXCHANGE","properties":{"sinkIds":[],"displayMem":true},"children":[32]},{"id":32,"name":"SORT","properties":{"sinkIds":[33],"displayMem":true},"children":[31]},{"id":31,"name":"PROJECT","properties":{"displayMem":false},"children":[30]},{"id":30,"name":"AGGREGATION","properties":{"displayMem":true},"children":[29]},{"id":29,"name":"EXCHANGE","properties":{"displayMem":true},"children":[28]},{"id":28,"name":"AGGREGATION","properties":{"sinkIds":[29],"displayMem":true},"children":[27]},{"id":27,"name":"PROJECT","properties":{"displayMem":false},"children":[26]},{"id":26,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[0,25]},{"id":0,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":25,"name":"EXCHANGE","properties":{"displayMem":true},"children":[24]},{"id":24,"name":"PROJECT","properties":{"sinkIds":[25],"displayMem":false},"children":[23]},{"id":23,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[2,22]},{"id":2,"name":"PROJECT","properties":{"displayMem":false},"children":[1]},{"id":22,"name":"EXCHANGE","properties":{"displayMem":true},"children":[21]},{"id":1,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":21,"name":"PROJECT","properties":{"sinkIds":[22],"displayMem":false},"children":[20]},{"id":20,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[3,19]},{"id":3,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":19,"name":"EXCHANGE","properties":{"displayMem":true},"children":[18]},{"id":18,"name":"PROJECT","properties":{"sinkIds":[19],"displayMem":false},"children":[17]},{"id":17,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[4,16]},{"id":4,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":16,"name":"EXCHANGE","properties":{"displayMem":true},"children":[15]},{"id":15,"name":"PROJECT","properties":{"sinkIds":[16],"displayMem":false},"children":[14]},{"id":14,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[5,13]},{"id":5,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":13,"name":"EXCHANGE","properties":{"displayMem":true},"children":[12]},{"id":12,"name":"PROJECT","properties":{"sinkIds":[13],"displayMem":false},"children":[11]},{"id":11,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[7,10]},{"id":7,"name":"PROJECT","properties":{"displayMem":false},"children":[6]},{"id":10,"name":"EXCHANGE","properties":{"displayMem":true},"children":[9]},{"id":6,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":9,"name":"PROJECT","properties":{"sinkIds":[10],"displayMem":false},"children":[8]},{"id":8,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]}]}
     - FrontendProfileMergeTime: 7.752ms
     - QueryAllocatedMemoryUsage: 19.248 MB
     - QueryCumulativeCpuTime: 273.988ms
     - QueryCumulativeNetworkTime: 1.909ms
     - QueryCumulativeOperatorTime: 12.066ms
     - QueryCumulativeScanTime: 703.257us
     - QueryDeallocatedMemoryUsage: 8.347 MB
     - QueryExecutionWallTime: 60.479ms
     - QueryPeakMemoryUsagePerNode: 11.250 MB
     - QueryPeakScheduleTime: 57.717ms
     - QuerySpillBytes: 0.000 B
     - QuerySumMemoryUsage: 11.250 MB
     - ResultDeliverTime: 0ns
    Fragment 0:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b97
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 1.419ms
       - InitialProcessDriverCount: 0
       - InitialProcessMem: 9.358 GB
       - InstanceAllocatedMemoryUsage: 283.000 KB
       - InstanceDeallocatedMemoryUsage: 64.500 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 218.500 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 19.383us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 57.736ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 57.690ms
             - FirstInputEmptyTime: 57.690ms
         - ScheduleCount: 1
         - ScheduleTime: 57.717ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        RESULT_SINK (plan_node_id=-1):
          CommonMetrics:
             - IsFinalSink
             - OperatorTotalTime: 79.553us
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
             - OperatorTotalTime: 736ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        LOCAL_EXCHANGE_SOURCE (plan_node_id=33):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 20.490us
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
         - ActiveTime: 287.724us
           - __MAX_OF_ActiveTime: 980.856us
           - __MIN_OF_ActiveTime: 20.240us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 57.585ms
           - __MAX_OF_DriverTotalTime: 57.705ms
           - __MIN_OF_DriverTotalTime: 57.488ms
         - PeakDriverQueueSize: 50
           - __MAX_OF_PeakDriverQueueSize: 6
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 54.590ms
             - __MAX_OF_InputEmptyTime: 55.286ms
             - __MIN_OF_InputEmptyTime: 51.445ms
             - FirstInputEmptyTime: 3.372ms
               - __MAX_OF_FirstInputEmptyTime: 51.198ms
               - __MIN_OF_FirstInputEmptyTime: 94.461us
             - FollowupInputEmptyTime: 51.218ms
               - __MAX_OF_FollowupInputEmptyTime: 54.994ms
               - __MIN_OF_FollowupInputEmptyTime: 3.126ms
         - ScheduleCount: 77
           - __MAX_OF_ScheduleCount: 5
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 57.297ms
           - __MAX_OF_ScheduleTime: 57.494ms
           - __MIN_OF_ScheduleTime: 56.565ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 61
           - __MAX_OF_YieldByLocalWait: 4
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=33):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.165us
               - __MAX_OF_OperatorTotalTime: 12.004us
               - __MIN_OF_OperatorTotalTime: 354ns
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
        GLOBAL_PARALLEL_MERGE_SOURCE (plan_node_id=33):
          CommonMetrics:
             - OperatorTotalTime: 269.743us
               - __MAX_OF_OperatorTotalTime: 945.148us
               - __MIN_OF_OperatorTotalTime: 7.454us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 268.554us
               - __MAX_OF_PullTotalTime: 944.403us
               - __MIN_OF_PullTotalTime: 6.956us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - LateMaterialization: False
             - Limit: -1
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
             - OverallStageTime: 65.164us
               - __MAX_OF_OverallStageTime: 684.395us
               - __MIN_OF_OverallStageTime: 2.385us
               - 1-InitStageTime: 2.694us
                 - __MAX_OF_1-InitStageTime: 43.105us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 39.292us
                 - __MAX_OF_2-PrepareStageTime: 628.681us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 470ns
                 - __MAX_OF_3-ProcessStageTime: 7.530us
                 - __MIN_OF_3-ProcessStageTime: 0ns
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 140ns
                   - __MAX_OF_SortedRunProviderTime: 2.255us
                   - __MIN_OF_SortedRunProviderTime: 0ns
               - 4-SplitChunkStageTime: 1.581us
                 - __MAX_OF_4-SplitChunkStageTime: 8.450us
                 - __MIN_OF_4-SplitChunkStageTime: 571ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 18.881us
                 - __MAX_OF_5-FetchChunkStageTime: 276.617us
                 - __MIN_OF_5-FetchChunkStageTime: 282ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 136ns
                 - __MAX_OF_7-FinishedStageTime: 211ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 0ns
             - RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 1:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b98
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.353ms
       - InitialProcessDriverCount: 17
       - InitialProcessMem: 9.359 GB
       - InstanceAllocatedMemoryUsage: 1.135 MB
       - InstanceDeallocatedMemoryUsage: 323.828 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 861.141 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - IsGroupExecution: false
         - ActiveTime: 58.273us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 48.175ms
         - PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - InputEmptyTime: 47.783ms
             - FirstInputEmptyTime: 47.783ms
         - ScheduleCount: 1
         - ScheduleTime: 48.116ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=33):
          CommonMetrics:
             - OperatorTotalTime: 70.111us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: af65c1208a0b11f0-94e000163e341b97
             - DestID: 33
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 250.737us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 299.383us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 250.737us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 346.166us
        LOCAL_EXCHANGE_SOURCE (plan_node_id=32):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 3.967us
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
         - ActiveTime: 176.549us
           - __MAX_OF_ActiveTime: 420.780us
           - __MIN_OF_ActiveTime: 22.285us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 47.781ms
           - __MAX_OF_DriverTotalTime: 47.866ms
           - __MIN_OF_DriverTotalTime: 47.762ms
         - PeakDriverQueueSize: 34
           - __MAX_OF_PeakDriverQueueSize: 3
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 47.409ms
             - __MAX_OF_InputEmptyTime: 47.520ms
             - __MIN_OF_InputEmptyTime: 47.203ms
             - FirstInputEmptyTime: 47.409ms
               - __MAX_OF_FirstInputEmptyTime: 47.520ms
               - __MIN_OF_FirstInputEmptyTime: 47.203ms
         - ScheduleCount: 62
           - __MAX_OF_ScheduleCount: 4
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 47.604ms
           - __MAX_OF_ScheduleTime: 47.745ms
           - __MIN_OF_ScheduleTime: 47.446ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 46
           - __MAX_OF_YieldByLocalWait: 3
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=32):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 2.407us
               - __MAX_OF_OperatorTotalTime: 31.760us
               - __MIN_OF_OperatorTotalTime: 349ns
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
        LOCAL_PARALLEL_MERGE_SOURCE (plan_node_id=32):
          CommonMetrics:
             - OperatorTotalTime: 160.562us
               - __MAX_OF_OperatorTotalTime: 372.381us
               - __MIN_OF_OperatorTotalTime: 12.106us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 158.892us
               - __MAX_OF_PullTotalTime: 354.988us
               - __MIN_OF_PullTotalTime: 11.423us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - LateMaterialization: False
             - Limit: -1
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
             - OverallStageTime: 33.222us
               - __MAX_OF_OverallStageTime: 331.001us
               - __MIN_OF_OverallStageTime: 3.631us
               - 1-InitStageTime: 4.319us
                 - __MAX_OF_1-InitStageTime: 69.113us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 15.776us
                 - __MAX_OF_2-PrepareStageTime: 252.418us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 6.414us
                 - __MAX_OF_3-ProcessStageTime: 16us
                 - __MIN_OF_3-ProcessStageTime: 1.431us
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 1.027us
                   - __MAX_OF_SortedRunProviderTime: 5.912us
                   - __MIN_OF_SortedRunProviderTime: 476ns
               - 4-SplitChunkStageTime: 2.386us
                 - __MAX_OF_4-SplitChunkStageTime: 15.009us
                 - __MIN_OF_4-SplitChunkStageTime: 388ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 2.810us
                 - __MAX_OF_5-FetchChunkStageTime: 17.086us
                 - __MIN_OF_5-FetchChunkStageTime: 290ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 74ns
                 - __MAX_OF_7-FinishedStageTime: 153ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 22.979us
           - __MAX_OF_ActiveTime: 37.446us
           - __MIN_OF_ActiveTime: 15.281us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 47.207ms
           - __MAX_OF_DriverTotalTime: 47.242ms
           - __MIN_OF_DriverTotalTime: 47.187ms
         - PeakDriverQueueSize: 345
           - __MAX_OF_PeakDriverQueueSize: 30
           - __MIN_OF_PeakDriverQueueSize: 13
         - PendingTime: 0ns
           - InputEmptyTime: 47.037ms
             - __MAX_OF_InputEmptyTime: 47.079ms
             - __MIN_OF_InputEmptyTime: 46.976ms
             - FirstInputEmptyTime: 47.037ms
               - __MAX_OF_FirstInputEmptyTime: 47.079ms
               - __MIN_OF_FirstInputEmptyTime: 46.976ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 47.184ms
           - __MAX_OF_ScheduleTime: 47.225ms
           - __MIN_OF_ScheduleTime: 47.165ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_SORT_SINK (plan_node_id=32):
          CommonMetrics:
             - OperatorTotalTime: 18.439us
               - __MAX_OF_OperatorTotalTime: 32.004us
               - __MIN_OF_OperatorTotalTime: 13.117us
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
             - LateMaterialization: False
             - MaxBufferedBytes: 268435456
             - MaxBufferedRows: 1073741824
             - SortKeys: 54: sum DESC
             - SortType: All
             - BuildingTime: 0ns
             - InputRequiredMemory: 0.000 B
             - MergingTime: 4.518us
               - __MAX_OF_MergingTime: 9.519us
               - __MIN_OF_MergingTime: 2.777us
             - NumSortedRuns: 0
             - OutputTime: 106ns
               - __MAX_OF_OutputTime: 215ns
               - __MIN_OF_OutputTime: 60ns
             - SortingCnt: 0
             - SortingTime: 0ns
        PROJECT (plan_node_id=31):
          CommonMetrics:
             - OperatorTotalTime: 4.859us
               - __MAX_OF_OperatorTotalTime: 5.914us
               - __MIN_OF_OperatorTotalTime: 3.701us
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
        CHUNK_ACCUMULATE (plan_node_id=30):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 622ns
               - __MAX_OF_OperatorTotalTime: 807ns
               - __MIN_OF_OperatorTotalTime: 480ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        AGGREGATE_BLOCKING_SOURCE (plan_node_id=30):
          CommonMetrics:
             - OperatorTotalTime: 15.281us
               - __MAX_OF_OperatorTotalTime: 31.318us
               - __MIN_OF_OperatorTotalTime: 11.473us
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
         - ActiveTime: 41.590us
           - __MAX_OF_ActiveTime: 286.273us
           - __MIN_OF_ActiveTime: 10.494us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 47.098ms
           - __MAX_OF_DriverTotalTime: 47.189ms
           - __MIN_OF_DriverTotalTime: 47.022ms
         - PeakDriverQueueSize: 106
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 46.727ms
             - __MAX_OF_InputEmptyTime: 46.732ms
             - __MIN_OF_InputEmptyTime: 46.698ms
             - FirstInputEmptyTime: 46.727ms
               - __MAX_OF_FirstInputEmptyTime: 46.732ms
               - __MIN_OF_FirstInputEmptyTime: 46.698ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 47.057ms
           - __MAX_OF_ScheduleTime: 47.150ms
           - __MIN_OF_ScheduleTime: 46.735ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        AGGREGATE_BLOCKING_SINK (plan_node_id=30):
          CommonMetrics:
             - OperatorTotalTime: 25.980us
               - __MAX_OF_OperatorTotalTime: 136.446us
               - __MIN_OF_OperatorTotalTime: 11.310us
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
             - AggregateFunctions: sum(54: sum), avg(55: avg), multi_distinct_count(56: count), sum(57: sum)
             - GroupingKeys: 2: p_name
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
        EXCHANGE_SOURCE (plan_node_id=29):
          CommonMetrics:
             - OperatorTotalTime: 28.776us
               - __MAX_OF_OperatorTotalTime: 264.975us
               - __MIN_OF_OperatorTotalTime: 8.050us
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
             - ReceiverProcessTotalTime: 233ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.743us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 2:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b99
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 5.567ms
       - InitialProcessDriverCount: 66
       - InitialProcessMem: 9.363 GB
       - InstanceAllocatedMemoryUsage: 2.407 MB
       - InstanceDeallocatedMemoryUsage: 1.281 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.516 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - IsGroupExecution: true
         - ActiveTime: 29.649us
           - __MAX_OF_ActiveTime: 385.595us
           - __MIN_OF_ActiveTime: 4.038us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 38.646ms
           - __MAX_OF_DriverTotalTime: 39.015ms
           - __MIN_OF_DriverTotalTime: 38.577ms
         - PeakDriverQueueSize: 250
           - __MAX_OF_PeakDriverQueueSize: 22
           - __MIN_OF_PeakDriverQueueSize: 10
         - PendingTime: 0ns
           - InputEmptyTime: 38.461ms
             - __MAX_OF_InputEmptyTime: 38.553ms
             - __MIN_OF_InputEmptyTime: 38.369ms
             - FirstInputEmptyTime: 38.461ms
               - __MAX_OF_FirstInputEmptyTime: 38.553ms
               - __MIN_OF_FirstInputEmptyTime: 38.369ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 38.616ms
           - __MAX_OF_ScheduleTime: 38.720ms
           - __MIN_OF_ScheduleTime: 38.570ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        GROUP_EXCHANGE_SINK (plan_node_id=28):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 24.843us
               - __MAX_OF_OperatorTotalTime: 380.012us
               - __MIN_OF_OperatorTotalTime: 511ns
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
        AGGREGATE_STREAMING_SOURCE (plan_node_id=28):
          CommonMetrics:
             - OperatorTotalTime: 10.835us
               - __MAX_OF_OperatorTotalTime: 18.546us
               - __MIN_OF_OperatorTotalTime: 4.329us
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
         - ActiveTime: 22.793us
           - __MAX_OF_ActiveTime: 111.284us
           - __MIN_OF_ActiveTime: 7.248us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 38.527ms
           - __MAX_OF_DriverTotalTime: 38.647ms
           - __MIN_OF_DriverTotalTime: 38.423ms
         - PeakDriverQueueSize: 439
           - __MAX_OF_PeakDriverQueueSize: 38
           - __MIN_OF_PeakDriverQueueSize: 16
         - PendingTime: 0ns
           - PreconditionBlockTime: 38.185ms
             - __MAX_OF_PreconditionBlockTime: 38.313ms
             - __MIN_OF_PreconditionBlockTime: 38.095ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 38.504ms
           - __MAX_OF_ScheduleTime: 38.638ms
           - __MIN_OF_ScheduleTime: 38.411ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        AGGREGATE_STREAMING_SINK (plan_node_id=28):
          CommonMetrics:
             - OperatorTotalTime: 26.784us
               - __MAX_OF_OperatorTotalTime: 119.080us
               - __MIN_OF_OperatorTotalTime: 11.307us
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
             - AggregateFunctions: sum(14: l_quantity), avg(15: l_extendedprice), multi_distinct_count(26: o_orderkey), sum(15: l_extendedprice)
             - GroupingKeys: 2: p_name
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
        PROJECT (plan_node_id=27):
          CommonMetrics:
             - OperatorTotalTime: 4.954us
               - __MAX_OF_OperatorTotalTime: 10.876us
               - __MIN_OF_OperatorTotalTime: 3.655us
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
        CHUNK_ACCUMULATE (plan_node_id=26):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.141us
               - __MAX_OF_OperatorTotalTime: 11.268us
               - __MIN_OF_OperatorTotalTime: 353ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=26):
          CommonMetrics:
             - OperatorTotalTime: 12.646us
               - __MAX_OF_OperatorTotalTime: 31.232us
               - __MIN_OF_OperatorTotalTime: 8.832us
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
             - OperatorTotalTime: 768ns
               - __MAX_OF_OperatorTotalTime: 6.255us
               - __MIN_OF_OperatorTotalTime: 309ns
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
             - RuntimeFilterDesc: <5: BloomFilter> 
             - OperatorTotalTime: 27.261us
               - __MAX_OF_OperatorTotalTime: 42.824us
               - __MIN_OF_OperatorTotalTime: 19.396us
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
         - IsGroupExecution: true
         - ActiveTime: 26.450us
           - __MAX_OF_ActiveTime: 33.457us
           - __MIN_OF_ActiveTime: 11.081us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 38.409ms
           - __MAX_OF_DriverTotalTime: 38.544ms
           - __MIN_OF_DriverTotalTime: 38.295ms
         - PeakDriverQueueSize: 120
           - __MAX_OF_PeakDriverQueueSize: 15
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 38.049ms
             - __MAX_OF_PreconditionBlockTime: 38.062ms
             - __MIN_OF_PreconditionBlockTime: 38.036ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 38.382ms
           - __MAX_OF_ScheduleTime: 38.519ms
           - __MIN_OF_ScheduleTime: 38.263ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=0):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 358ns
               - __MAX_OF_OperatorTotalTime: 667ns
               - __MIN_OF_OperatorTotalTime: 266ns
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
             - RuntimeFilterDesc: <5: BloomFilter> 
             - OperatorTotalTime: 28.250us
               - __MAX_OF_OperatorTotalTime: 40.410us
               - __MIN_OF_OperatorTotalTime: 12.381us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 21.267us
               - __MAX_OF_PullTotalTime: 28.395us
               - __MIN_OF_PullTotalTime: 8.280us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.358us
               - __MAX_OF_CaptureTabletRowsetsTime: 20.131us
               - __MIN_OF_CaptureTabletRowsetsTime: 7.890us
      Pipeline (id=4):
         - IsGroupExecution: false
         - ActiveTime: 15.577us
           - __MAX_OF_ActiveTime: 66.828us
           - __MIN_OF_ActiveTime: 4.234us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 39.718ms
           - __MAX_OF_DriverTotalTime: 39.759ms
           - __MIN_OF_DriverTotalTime: 39.693ms
         - PeakDriverQueueSize: 360
           - __MAX_OF_PeakDriverQueueSize: 30
           - __MIN_OF_PeakDriverQueueSize: 15
         - PendingTime: 0ns
           - InputEmptyTime: 38.900ms
             - __MAX_OF_InputEmptyTime: 39.046ms
             - __MIN_OF_InputEmptyTime: 38.713ms
             - FirstInputEmptyTime: 38.900ms
               - __MAX_OF_FirstInputEmptyTime: 39.046ms
               - __MIN_OF_FirstInputEmptyTime: 38.713ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 39.703ms
           - __MAX_OF_ScheduleTime: 39.737ms
           - __MIN_OF_ScheduleTime: 39.681ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=29):
          CommonMetrics:
             - OperatorTotalTime: 7.876us
               - __MAX_OF_OperatorTotalTime: 50.060us
               - __MIN_OF_OperatorTotalTime: 1.480us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: af65c1208a0b11f0-94e000163e341b98
             - DestID: 29
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
             - NetworkTime: 226.640us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 322.937us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 226.640us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 572.725us
        LOCAL_EXCHANGE_SOURCE (plan_node_id=28):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.353us
               - __MAX_OF_OperatorTotalTime: 13.555us
               - __MIN_OF_OperatorTotalTime: 1.216us
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
         - ActiveTime: 114.764us
           - __MAX_OF_ActiveTime: 469.466us
           - __MIN_OF_ActiveTime: 66.025us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 38.076ms
           - __MAX_OF_DriverTotalTime: 38.513ms
           - __MIN_OF_DriverTotalTime: 37.904ms
         - PeakDriverQueueSize: 106
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 37.773ms
             - __MAX_OF_InputEmptyTime: 37.778ms
             - __MIN_OF_InputEmptyTime: 37.749ms
             - FirstInputEmptyTime: 37.773ms
               - __MAX_OF_FirstInputEmptyTime: 37.778ms
               - __MIN_OF_FirstInputEmptyTime: 37.749ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 37.962ms
           - __MAX_OF_ScheduleTime: 38.397ms
           - __MIN_OF_ScheduleTime: 37.780ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=26):
          CommonMetrics:
             - OperatorTotalTime: 108.002us
               - __MAX_OF_OperatorTotalTime: 465.535us
               - __MIN_OF_OperatorTotalTime: 61.395us
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
             - JoinPredicates: 26: o_orderkey = 10: l_orderkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 3.074us
               - __MAX_OF_BuildHashTableTime: 8.294us
               - __MIN_OF_BuildHashTableTime: 1.484us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 576.000 B
               - __MAX_OF_HashTableMemoryUsage: 36.000 B
               - __MIN_OF_HashTableMemoryUsage: 36.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MAX_OF_PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MIN_OF_PartialRuntimeMembershipFilterBytes: 0.000 B
             - PartitionNums: 256
               - __MAX_OF_PartitionNums: 16
               - __MIN_OF_PartitionNums: 16
             - RuntimeFilterBuildTime: 6.872us
               - __MAX_OF_RuntimeFilterBuildTime: 17.934us
               - __MIN_OF_RuntimeFilterBuildTime: 2.340us
             - RuntimeFilterNum: 0
        EXCHANGE_SOURCE (plan_node_id=25):
          CommonMetrics:
             - OperatorTotalTime: 12.702us
               - __MAX_OF_OperatorTotalTime: 29.398us
               - __MIN_OF_OperatorTotalTime: 7.025us
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
             - ReceiverProcessTotalTime: 199ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.198us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 3:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b9a
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.858ms
       - InitialProcessDriverCount: 114
       - InitialProcessMem: 9.369 GB
       - InstanceAllocatedMemoryUsage: 2.171 MB
       - InstanceDeallocatedMemoryUsage: 710.789 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.477 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 14.517us
           - __MAX_OF_ActiveTime: 55.988us
           - __MIN_OF_ActiveTime: 6.970us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 33.087ms
           - __MAX_OF_DriverTotalTime: 33.235ms
           - __MIN_OF_DriverTotalTime: 32.702ms
         - PeakDriverQueueSize: 438
           - __MAX_OF_PeakDriverQueueSize: 38
           - __MIN_OF_PeakDriverQueueSize: 16
         - PendingTime: 0ns
           - PreconditionBlockTime: 31.977ms
             - __MAX_OF_PreconditionBlockTime: 32.040ms
             - __MIN_OF_PreconditionBlockTime: 31.928ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 33.073ms
           - __MAX_OF_ScheduleTime: 33.221ms
           - __MIN_OF_ScheduleTime: 32.687ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=25):
          CommonMetrics:
             - OperatorTotalTime: 10.577us
               - __MAX_OF_OperatorTotalTime: 51.736us
               - __MIN_OF_OperatorTotalTime: 2.218us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 64
             - DestFragments: af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99, af65c1208a0b11f0-94e000163e341b99
             - DestID: 25
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
             - NetworkTime: 228.697us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 424.543us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 228.697us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 542.889us
        PROJECT (plan_node_id=24):
          CommonMetrics:
             - OperatorTotalTime: 4.642us
               - __MAX_OF_OperatorTotalTime: 5.782us
               - __MIN_OF_OperatorTotalTime: 3.805us
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
        CHUNK_ACCUMULATE (plan_node_id=23):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 385ns
               - __MAX_OF_OperatorTotalTime: 474ns
               - __MIN_OF_OperatorTotalTime: 298ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=23):
          CommonMetrics:
             - OperatorTotalTime: 5.583us
               - __MAX_OF_OperatorTotalTime: 9.705us
               - __MIN_OF_OperatorTotalTime: 3.563us
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
        PROJECT (plan_node_id=2):
          CommonMetrics:
             - OperatorTotalTime: 4.662us
               - __MAX_OF_OperatorTotalTime: 11.140us
               - __MIN_OF_OperatorTotalTime: 2.944us
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
        CHUNK_ACCUMULATE (plan_node_id=1):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 343ns
               - __MAX_OF_OperatorTotalTime: 464ns
               - __MIN_OF_OperatorTotalTime: 277ns
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
             - RuntimeFilterDesc: <4: BloomFilter> 
             - OperatorTotalTime: 22.770us
               - __MAX_OF_OperatorTotalTime: 30.189us
               - __MIN_OF_OperatorTotalTime: 16.617us
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
         - ActiveTime: 32.758us
           - __MAX_OF_ActiveTime: 49.244us
           - __MIN_OF_ActiveTime: 20.341us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 32.178ms
           - __MAX_OF_DriverTotalTime: 32.244ms
           - __MIN_OF_DriverTotalTime: 32.115ms
         - PeakDriverQueueSize: 120
           - __MAX_OF_PeakDriverQueueSize: 15
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 31.888ms
             - __MAX_OF_PreconditionBlockTime: 31.898ms
             - __MIN_OF_PreconditionBlockTime: 31.878ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 32.145ms
           - __MAX_OF_ScheduleTime: 32.224ms
           - __MIN_OF_ScheduleTime: 32.067ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=1):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 350ns
               - __MAX_OF_OperatorTotalTime: 641ns
               - __MIN_OF_OperatorTotalTime: 279ns
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
             - RuntimeFilterDesc: <4: BloomFilter> 
             - OperatorTotalTime: 35.306us
               - __MAX_OF_OperatorTotalTime: 50.930us
               - __MIN_OF_OperatorTotalTime: 23.769us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 28.118us
               - __MAX_OF_PullTotalTime: 43.910us
               - __MIN_OF_PullTotalTime: 16.986us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.280us
               - __MAX_OF_CaptureTabletRowsetsTime: 17.346us
               - __MIN_OF_CaptureTabletRowsetsTime: 7.726us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 281.944us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 32.093ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 31.782ms
             - FirstInputEmptyTime: 31.782ms
         - ScheduleCount: 1
         - ScheduleTime: 31.811ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=23):
          CommonMetrics:
             - OperatorTotalTime: 277.726us
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
             - JoinPredicates: 11: l_partkey = 1: p_partkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 2.400us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 16.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 16
             - RuntimeFilterBuildTime: 8.521us
             - RuntimeFilterNum: 0
        LOCAL_EXCHANGE_SOURCE (plan_node_id=23):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.209us
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
         - ActiveTime: 8.593us
           - __MAX_OF_ActiveTime: 18.647us
           - __MIN_OF_ActiveTime: 4.974us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 31.760ms
           - __MAX_OF_DriverTotalTime: 31.823ms
           - __MIN_OF_DriverTotalTime: 31.538ms
         - PeakDriverQueueSize: 80
           - __MAX_OF_PeakDriverQueueSize: 12
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 31.511ms
             - __MAX_OF_InputEmptyTime: 31.517ms
             - __MIN_OF_InputEmptyTime: 31.481ms
             - FirstInputEmptyTime: 31.511ms
               - __MAX_OF_FirstInputEmptyTime: 31.517ms
               - __MIN_OF_FirstInputEmptyTime: 31.481ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 31.751ms
           - __MAX_OF_ScheduleTime: 31.818ms
           - __MIN_OF_ScheduleTime: 31.519ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=23):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 698ns
               - __MAX_OF_OperatorTotalTime: 3.136us
               - __MIN_OF_OperatorTotalTime: 352ns
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
        EXCHANGE_SOURCE (plan_node_id=22):
          CommonMetrics:
             - OperatorTotalTime: 9.185us
               - __MAX_OF_OperatorTotalTime: 18.375us
               - __MIN_OF_OperatorTotalTime: 6.262us
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
             - ReceiverProcessTotalTime: 226ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.617us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 4:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b9b
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 4.042ms
       - InitialProcessDriverCount: 163
       - InitialProcessMem: 9.373 GB
       - InstanceAllocatedMemoryUsage: 1.789 MB
       - InstanceDeallocatedMemoryUsage: 608.461 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.194 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=2):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 11.977us
           - __MAX_OF_ActiveTime: 52.846us
           - __MIN_OF_ActiveTime: 5.370us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 27.071ms
           - __MAX_OF_DriverTotalTime: 27.214ms
           - __MIN_OF_DriverTotalTime: 26.794ms
         - PeakDriverQueueSize: 365
           - __MAX_OF_PeakDriverQueueSize: 39
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 26.015ms
             - __MAX_OF_PreconditionBlockTime: 26.242ms
             - __MIN_OF_PreconditionBlockTime: 25.871ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 27.059ms
           - __MAX_OF_ScheduleTime: 27.205ms
           - __MIN_OF_ScheduleTime: 26.785ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=22):
          CommonMetrics:
             - OperatorTotalTime: 8.300us
               - __MAX_OF_OperatorTotalTime: 48.190us
               - __MIN_OF_OperatorTotalTime: 1.903us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: af65c1208a0b11f0-94e000163e341b9a
             - DestID: 22
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 198.853us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 439.581us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 198.853us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 518.318us
        PROJECT (plan_node_id=21):
          CommonMetrics:
             - OperatorTotalTime: 4.442us
               - __MAX_OF_OperatorTotalTime: 9.463us
               - __MIN_OF_OperatorTotalTime: 3.165us
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
             - OperatorTotalTime: 458ns
               - __MAX_OF_OperatorTotalTime: 657ns
               - __MIN_OF_OperatorTotalTime: 322ns
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
             - OperatorTotalTime: 8.054us
               - __MAX_OF_OperatorTotalTime: 11.162us
               - __MIN_OF_OperatorTotalTime: 6.403us
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
        CHUNK_ACCUMULATE (plan_node_id=3):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 392ns
               - __MAX_OF_OperatorTotalTime: 588ns
               - __MIN_OF_OperatorTotalTime: 324ns
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
             - RuntimeFilterDesc: <3: BloomFilter> 
             - OperatorTotalTime: 23.948us
               - __MAX_OF_OperatorTotalTime: 31.805us
               - __MIN_OF_OperatorTotalTime: 19.486us
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
         - ActiveTime: 33.921us
           - __MAX_OF_ActiveTime: 53.238us
           - __MIN_OF_ActiveTime: 21.725us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 26.118ms
           - __MAX_OF_DriverTotalTime: 26.341ms
           - __MIN_OF_DriverTotalTime: 25.915ms
         - PeakDriverQueueSize: 155
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 25.933ms
             - __MAX_OF_PreconditionBlockTime: 26.150ms
             - __MIN_OF_PreconditionBlockTime: 25.723ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 26.084ms
           - __MAX_OF_ScheduleTime: 26.310ms
           - __MIN_OF_ScheduleTime: 25.862ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=3):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 322ns
               - __MAX_OF_OperatorTotalTime: 389ns
               - __MIN_OF_OperatorTotalTime: 263ns
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
             - RuntimeFilterDesc: <3: BloomFilter> 
             - OperatorTotalTime: 36.063us
               - __MAX_OF_OperatorTotalTime: 55.244us
               - __MIN_OF_OperatorTotalTime: 23.528us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 29.403us
               - __MAX_OF_PullTotalTime: 48.843us
               - __MIN_OF_PullTotalTime: 17.281us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.320us
               - __MAX_OF_CaptureTabletRowsetsTime: 17.412us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.573us
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 59.650us
           - __MAX_OF_ActiveTime: 657.772us
           - __MIN_OF_ActiveTime: 15.442us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 25.725ms
           - __MAX_OF_DriverTotalTime: 26.342ms
           - __MIN_OF_DriverTotalTime: 25.663ms
         - PeakDriverQueueSize: 106
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 25.503ms
             - __MAX_OF_InputEmptyTime: 25.512ms
             - __MIN_OF_InputEmptyTime: 25.490ms
             - FirstInputEmptyTime: 25.503ms
               - __MAX_OF_FirstInputEmptyTime: 25.512ms
               - __MIN_OF_FirstInputEmptyTime: 25.490ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 25.665ms
           - __MAX_OF_ScheduleTime: 25.712ms
           - __MIN_OF_ScheduleTime: 25.642ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=20):
          CommonMetrics:
             - OperatorTotalTime: 56.870us
               - __MAX_OF_OperatorTotalTime: 645.072us
               - __MIN_OF_OperatorTotalTime: 12.974us
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
             - JoinPredicates: 1: p_partkey = 35: ps_partkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 2.735us
               - __MAX_OF_BuildHashTableTime: 3.516us
               - __MIN_OF_BuildHashTableTime: 1.875us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 96.000 B
               - __MAX_OF_HashTableMemoryUsage: 6.000 B
               - __MIN_OF_HashTableMemoryUsage: 6.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MAX_OF_PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MIN_OF_PartialRuntimeMembershipFilterBytes: 0.000 B
             - PartitionNums: 16
               - __MAX_OF_PartitionNums: 1
               - __MIN_OF_PartitionNums: 1
             - RuntimeFilterBuildTime: 5.414us
               - __MAX_OF_RuntimeFilterBuildTime: 12.542us
               - __MIN_OF_RuntimeFilterBuildTime: 3.435us
             - RuntimeFilterNum: 0
        EXCHANGE_SOURCE (plan_node_id=19):
          CommonMetrics:
             - OperatorTotalTime: 11.151us
               - __MAX_OF_OperatorTotalTime: 20.965us
               - __MIN_OF_OperatorTotalTime: 7.843us
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
             - ReceiverProcessTotalTime: 249ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.993us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 5:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b9c
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.735ms
       - InitialProcessDriverCount: 211
       - InitialProcessMem: 9.377 GB
       - InstanceAllocatedMemoryUsage: 1.979 MB
       - InstanceDeallocatedMemoryUsage: 594.766 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.398 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 9.566us
           - __MAX_OF_ActiveTime: 51.668us
           - __MIN_OF_ActiveTime: 3.958us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 20.535ms
           - __MAX_OF_DriverTotalTime: 20.602ms
           - __MIN_OF_DriverTotalTime: 20.363ms
         - PeakDriverQueueSize: 105
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 19.765ms
             - __MAX_OF_PreconditionBlockTime: 19.921ms
             - __MIN_OF_PreconditionBlockTime: 19.641ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 20.526ms
           - __MAX_OF_ScheduleTime: 20.594ms
           - __MIN_OF_ScheduleTime: 20.352ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=19):
          CommonMetrics:
             - OperatorTotalTime: 6.518us
               - __MAX_OF_OperatorTotalTime: 47.592us
               - __MIN_OF_OperatorTotalTime: 1.307us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 64
             - DestFragments: af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b, af65c1208a0b11f0-94e000163e341b9b
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
             - NetworkTime: 192.015us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 362.694us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 192.015us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 443.856us
        PROJECT (plan_node_id=18):
          CommonMetrics:
             - OperatorTotalTime: 4.917us
               - __MAX_OF_OperatorTotalTime: 6.240us
               - __MIN_OF_OperatorTotalTime: 3.050us
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
             - OperatorTotalTime: 415ns
               - __MAX_OF_OperatorTotalTime: 744ns
               - __MIN_OF_OperatorTotalTime: 322ns
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
             - OperatorTotalTime: 5.298us
               - __MAX_OF_OperatorTotalTime: 9.701us
               - __MIN_OF_OperatorTotalTime: 3.712us
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
        CHUNK_ACCUMULATE (plan_node_id=4):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 397ns
               - __MAX_OF_OperatorTotalTime: 662ns
               - __MIN_OF_OperatorTotalTime: 287ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=4):
          CommonMetrics:
             - RuntimeFilterDesc: <2: BloomFilter> 
             - OperatorTotalTime: 22.607us
               - __MAX_OF_OperatorTotalTime: 29.545us
               - __MIN_OF_OperatorTotalTime: 15.245us
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
         - ActiveTime: 24.081us
           - __MAX_OF_ActiveTime: 48.301us
           - __MIN_OF_ActiveTime: 12.319us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 19.551ms
           - __MAX_OF_DriverTotalTime: 19.715ms
           - __MIN_OF_DriverTotalTime: 19.422ms
         - PeakDriverQueueSize: 2
           - __MAX_OF_PeakDriverQueueSize: 1
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 19.486ms
             - __MAX_OF_PreconditionBlockTime: 19.612ms
             - __MIN_OF_PreconditionBlockTime: 19.335ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 19.527ms
           - __MAX_OF_ScheduleTime: 19.685ms
           - __MIN_OF_ScheduleTime: 19.383ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=4):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 325ns
               - __MAX_OF_OperatorTotalTime: 563ns
               - __MIN_OF_OperatorTotalTime: 260ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=4):
          CommonMetrics:
             - IsSubordinate
             - RuntimeFilterDesc: <2: BloomFilter> 
             - OperatorTotalTime: 24.656us
               - __MAX_OF_OperatorTotalTime: 42.655us
               - __MIN_OF_OperatorTotalTime: 13.383us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 19.250us
               - __MAX_OF_PullTotalTime: 36.730us
               - __MIN_OF_PullTotalTime: 9.436us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 9.892us
               - __MAX_OF_CaptureTabletRowsetsTime: 16.300us
               - __MIN_OF_CaptureTabletRowsetsTime: 6.968us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 680.825us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 19.969ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 19.215ms
             - FirstInputEmptyTime: 19.215ms
         - ScheduleCount: 1
         - ScheduleTime: 19.288ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=17):
          CommonMetrics:
             - OperatorTotalTime: 677.922us
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
             - JoinPredicates: 36: ps_suppkey = 40: s_suppkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 3.274us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 6.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 1
             - RuntimeFilterBuildTime: 19.234us
             - RuntimeFilterNum: 0
        LOCAL_EXCHANGE_SOURCE (plan_node_id=17):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.574us
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
         - ActiveTime: 28.007us
           - __MAX_OF_ActiveTime: 217.053us
           - __MIN_OF_ActiveTime: 5.409us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 19.173ms
           - __MAX_OF_DriverTotalTime: 19.315ms
           - __MIN_OF_DriverTotalTime: 19.117ms
         - PeakDriverQueueSize: 110
           - __MAX_OF_PeakDriverQueueSize: 28
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 18.874ms
             - __MAX_OF_InputEmptyTime: 18.884ms
             - __MIN_OF_InputEmptyTime: 18.829ms
             - FirstInputEmptyTime: 18.874ms
               - __MAX_OF_FirstInputEmptyTime: 18.884ms
               - __MIN_OF_FirstInputEmptyTime: 18.829ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 19.145ms
           - __MAX_OF_ScheduleTime: 19.308ms
           - __MIN_OF_ScheduleTime: 18.902ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=17):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 5.494us
               - __MAX_OF_OperatorTotalTime: 66.912us
               - __MIN_OF_OperatorTotalTime: 461ns
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
        EXCHANGE_SOURCE (plan_node_id=16):
          CommonMetrics:
             - OperatorTotalTime: 24.101us
               - __MAX_OF_OperatorTotalTime: 215.910us
               - __MIN_OF_OperatorTotalTime: 6.470us
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
             - ReceiverProcessTotalTime: 1.008us
               - __MAX_OF_ReceiverProcessTotalTime: 16.135us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 6:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b9d
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.126ms
       - InitialProcessDriverCount: 260
       - InitialProcessMem: 9.381 GB
       - InstanceAllocatedMemoryUsage: 1.798 MB
       - InstanceDeallocatedMemoryUsage: 591.055 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.221 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 14.607us
           - __MAX_OF_ActiveTime: 89.292us
           - __MIN_OF_ActiveTime: 4.448us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 14.375ms
           - __MAX_OF_DriverTotalTime: 14.408ms
           - __MIN_OF_DriverTotalTime: 14.358ms
         - PeakDriverQueueSize: 398
           - __MAX_OF_PeakDriverQueueSize: 32
           - __MIN_OF_PeakDriverQueueSize: 19
         - PendingTime: 0ns
           - PreconditionBlockTime: 13.498ms
             - __MAX_OF_PreconditionBlockTime: 13.570ms
             - __MIN_OF_PreconditionBlockTime: 13.436ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 14.361ms
           - __MAX_OF_ScheduleTime: 14.386ms
           - __MIN_OF_ScheduleTime: 14.304ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=16):
          CommonMetrics:
             - OperatorTotalTime: 8.927us
               - __MAX_OF_OperatorTotalTime: 67.432us
               - __MIN_OF_OperatorTotalTime: 1.568us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: af65c1208a0b11f0-94e000163e341b9c
             - DestID: 16
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 283.529us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 391.207us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 283.529us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 642.075us
        PROJECT (plan_node_id=15):
          CommonMetrics:
             - OperatorTotalTime: 4.292us
               - __MAX_OF_OperatorTotalTime: 5.079us
               - __MIN_OF_OperatorTotalTime: 3.247us
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
             - OperatorTotalTime: 418ns
               - __MAX_OF_OperatorTotalTime: 623ns
               - __MIN_OF_OperatorTotalTime: 320ns
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
             - OperatorTotalTime: 5.563us
               - __MAX_OF_OperatorTotalTime: 12.755us
               - __MIN_OF_OperatorTotalTime: 3.698us
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
             - OperatorTotalTime: 308ns
               - __MAX_OF_OperatorTotalTime: 363ns
               - __MIN_OF_OperatorTotalTime: 211ns
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
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 24.298us
               - __MAX_OF_OperatorTotalTime: 39.980us
               - __MIN_OF_OperatorTotalTime: 14.655us
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
         - ActiveTime: 34.819us
           - __MAX_OF_ActiveTime: 47.601us
           - __MIN_OF_ActiveTime: 22.955us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 13.701ms
           - __MAX_OF_DriverTotalTime: 13.855ms
           - __MIN_OF_DriverTotalTime: 13.613ms
         - PeakDriverQueueSize: 168
           - __MAX_OF_PeakDriverQueueSize: 18
           - __MIN_OF_PeakDriverQueueSize: 3
         - PendingTime: 0ns
           - PreconditionBlockTime: 13.371ms
             - __MAX_OF_PreconditionBlockTime: 13.392ms
             - __MIN_OF_PreconditionBlockTime: 13.344ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 13.667ms
           - __MAX_OF_ScheduleTime: 13.819ms
           - __MIN_OF_ScheduleTime: 13.581ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=5):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 348ns
               - __MAX_OF_OperatorTotalTime: 555ns
               - __MIN_OF_OperatorTotalTime: 293ns
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
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 37.824us
               - __MAX_OF_OperatorTotalTime: 53.575us
               - __MIN_OF_OperatorTotalTime: 23.452us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 27.450us
               - __MAX_OF_PullTotalTime: 42.518us
               - __MIN_OF_PullTotalTime: 17.936us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.214us
               - __MAX_OF_CaptureTabletRowsetsTime: 13.511us
               - __MIN_OF_CaptureTabletRowsetsTime: 7.348us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 317.657us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 13.608ms
         - PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - InputEmptyTime: 13.225ms
             - FirstInputEmptyTime: 13.225ms
         - ScheduleCount: 1
         - ScheduleTime: 13.290ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=14):
          CommonMetrics:
             - OperatorTotalTime: 308.419us
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
             - JoinPredicates: 43: s_nationkey = 47: n_nationkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 3.235us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 6.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 1
             - RuntimeFilterBuildTime: 10.750us
             - RuntimeFilterNum: 0
        LOCAL_EXCHANGE_SOURCE (plan_node_id=14):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.272us
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
         - ActiveTime: 10.436us
           - __MAX_OF_ActiveTime: 21.909us
           - __MIN_OF_ActiveTime: 5.176us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 13.184ms
           - __MAX_OF_DriverTotalTime: 13.252ms
           - __MIN_OF_DriverTotalTime: 13.118ms
         - PeakDriverQueueSize: 106
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 12.949ms
             - __MAX_OF_InputEmptyTime: 12.956ms
             - __MIN_OF_InputEmptyTime: 12.918ms
             - FirstInputEmptyTime: 12.949ms
               - __MAX_OF_FirstInputEmptyTime: 12.956ms
               - __MIN_OF_FirstInputEmptyTime: 12.918ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 13.173ms
           - __MAX_OF_ScheduleTime: 13.243ms
           - __MIN_OF_ScheduleTime: 13.110ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=14):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 729ns
               - __MAX_OF_OperatorTotalTime: 4.123us
               - __MIN_OF_OperatorTotalTime: 313ns
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
        EXCHANGE_SOURCE (plan_node_id=13):
          CommonMetrics:
             - OperatorTotalTime: 10.950us
               - __MAX_OF_OperatorTotalTime: 22.040us
               - __MIN_OF_OperatorTotalTime: 6.371us
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
             - ReceiverProcessTotalTime: 201ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.224us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 7:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b9e
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.200ms
       - InitialProcessDriverCount: 309
       - InitialProcessMem: 9.384 GB
       - InstanceAllocatedMemoryUsage: 1.951 MB
       - InstanceDeallocatedMemoryUsage: 665.273 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.301 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 11.817us
           - __MAX_OF_ActiveTime: 65.310us
           - __MIN_OF_ActiveTime: 3.935us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 8.964ms
           - __MAX_OF_DriverTotalTime: 9.213ms
           - __MIN_OF_DriverTotalTime: 8.593ms
         - PeakDriverQueueSize: 174
           - __MAX_OF_PeakDriverQueueSize: 32
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 7.844ms
             - __MAX_OF_PreconditionBlockTime: 8.028ms
             - __MIN_OF_PreconditionBlockTime: 7.679ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 8.952ms
           - __MAX_OF_ScheduleTime: 9.208ms
           - __MIN_OF_ScheduleTime: 8.585ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=13):
          CommonMetrics:
             - OperatorTotalTime: 8.022us
               - __MAX_OF_OperatorTotalTime: 59.079us
               - __MIN_OF_OperatorTotalTime: 1.191us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: af65c1208a0b11f0-94e000163e341b9d
             - DestID: 13
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 254.262us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 449.053us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 254.262us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 552.582us
        PROJECT (plan_node_id=12):
          CommonMetrics:
             - OperatorTotalTime: 5.371us
               - __MAX_OF_OperatorTotalTime: 12.176us
               - __MIN_OF_OperatorTotalTime: 3.316us
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
             - OperatorTotalTime: 402ns
               - __MAX_OF_OperatorTotalTime: 604ns
               - __MIN_OF_OperatorTotalTime: 302ns
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
             - OperatorTotalTime: 6.064us
               - __MAX_OF_OperatorTotalTime: 14.790us
               - __MIN_OF_OperatorTotalTime: 3.754us
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
        PROJECT (plan_node_id=7):
          CommonMetrics:
             - OperatorTotalTime: 6.228us
               - __MAX_OF_OperatorTotalTime: 19.632us
               - __MIN_OF_OperatorTotalTime: 2.305us
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
        CHUNK_ACCUMULATE (plan_node_id=6):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 341ns
               - __MAX_OF_OperatorTotalTime: 623ns
               - __MIN_OF_OperatorTotalTime: 223ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=6):
          CommonMetrics:
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 26.285us
               - __MAX_OF_OperatorTotalTime: 37.894us
               - __MIN_OF_OperatorTotalTime: 16.258us
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
         - ActiveTime: 26.752us
           - __MAX_OF_ActiveTime: 44.927us
           - __MIN_OF_ActiveTime: 12.451us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 7.548ms
           - __MAX_OF_DriverTotalTime: 7.704ms
           - __MIN_OF_DriverTotalTime: 7.322ms
         - PeakDriverQueueSize: 35
           - __MAX_OF_PeakDriverQueueSize: 15
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 7.427ms
             - __MAX_OF_PreconditionBlockTime: 7.620ms
             - __MIN_OF_PreconditionBlockTime: 7.123ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 7.521ms
           - __MAX_OF_ScheduleTime: 7.673ms
           - __MIN_OF_ScheduleTime: 7.291ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=6):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 344ns
               - __MAX_OF_OperatorTotalTime: 606ns
               - __MIN_OF_OperatorTotalTime: 258ns
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
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 30.323us
               - __MAX_OF_OperatorTotalTime: 47.907us
               - __MIN_OF_OperatorTotalTime: 15.453us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 22.083us
               - __MAX_OF_PullTotalTime: 39.876us
               - __MIN_OF_PullTotalTime: 10.210us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.281us
               - __MAX_OF_CaptureTabletRowsetsTime: 19.638us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.356us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 1.016ms
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 8.093ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 7.032ms
             - FirstInputEmptyTime: 7.032ms
         - ScheduleCount: 1
         - ScheduleTime: 7.076ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 1.013ms
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
             - SetFinishingTime: 1.005ms
          UniqueMetrics:
             - DistributionMode: BROADCAST
             - JoinPredicates: 49: n_regionkey = 51: r_regionkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 4.642us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 6.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 1
             - RuntimeFilterBuildTime: 19.472us
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
         - ActiveTime: 15.338us
           - __MAX_OF_ActiveTime: 39.183us
           - __MIN_OF_ActiveTime: 7.534us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 7.013ms
           - __MAX_OF_DriverTotalTime: 7.098ms
           - __MIN_OF_DriverTotalTime: 6.940ms
         - PeakDriverQueueSize: 75
           - __MAX_OF_PeakDriverQueueSize: 11
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 6.758ms
             - __MAX_OF_InputEmptyTime: 6.772ms
             - __MIN_OF_InputEmptyTime: 6.715ms
             - FirstInputEmptyTime: 6.758ms
               - __MAX_OF_FirstInputEmptyTime: 6.772ms
               - __MIN_OF_FirstInputEmptyTime: 6.715ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 6.998ms
           - __MAX_OF_ScheduleTime: 7.090ms
           - __MIN_OF_ScheduleTime: 6.927ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=11):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.845us
               - __MAX_OF_OperatorTotalTime: 21.513us
               - __MIN_OF_OperatorTotalTime: 364ns
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
             - OperatorTotalTime: 14.419us
               - __MAX_OF_OperatorTotalTime: 26.052us
               - __MIN_OF_OperatorTotalTime: 6.985us
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
             - ReceiverProcessTotalTime: 286ns
               - __MAX_OF_ReceiverProcessTotalTime: 4.589us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 8:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: af65c120-8a0b-11f0-94e0-00163e341b9f
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.522ms
       - InitialProcessDriverCount: 358
       - InitialProcessMem: 9.388 GB
       - InstanceAllocatedMemoryUsage: 5.743 MB
       - InstanceDeallocatedMemoryUsage: 3.591 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 2.151 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 1.119ms
           - __MAX_OF_ActiveTime: 1.588ms
           - __MIN_OF_ActiveTime: 621.735us
         - BlockByInputEmpty: 3
           - __MAX_OF_BlockByInputEmpty: 1
           - __MIN_OF_BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 2.536ms
           - __MAX_OF_DriverTotalTime: 2.716ms
           - __MIN_OF_DriverTotalTime: 2.414ms
         - PeakDriverQueueSize: 157
           - __MAX_OF_PeakDriverQueueSize: 17
           - __MIN_OF_PeakDriverQueueSize: 4
         - PendingTime: 0ns
           - PendingFinishTime: 1.145ms
             - __MAX_OF_PendingFinishTime: 1.671ms
             - __MIN_OF_PendingFinishTime: 587.427us
         - ScheduleCount: 19
           - __MAX_OF_ScheduleCount: 2
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 1.416ms
           - __MAX_OF_ScheduleTime: 1.893ms
           - __MIN_OF_ScheduleTime: 837.713us
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=10):
          CommonMetrics:
             - OperatorTotalTime: 9.464us
               - __MAX_OF_OperatorTotalTime: 73.669us
               - __MIN_OF_OperatorTotalTime: 1.837us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: af65c1208a0b11f0-94e000163e341b9e
             - DestID: 10
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 274.964us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 636.728us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 274.964us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 1.239ms
        PROJECT (plan_node_id=9):
          CommonMetrics:
             - OperatorTotalTime: 4.024us
               - __MAX_OF_OperatorTotalTime: 5.247us
               - __MIN_OF_OperatorTotalTime: 3.239us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 387ns
               - __MAX_OF_PullTotalTime: 486ns
               - __MIN_OF_PullTotalTime: 320ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 553ns
               - __MAX_OF_PushTotalTime: 714ns
               - __MIN_OF_PushTotalTime: 385ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 0ns
        CHUNK_ACCUMULATE (plan_node_id=8):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 2.383us
               - __MAX_OF_OperatorTotalTime: 2.915us
               - __MIN_OF_OperatorTotalTime: 2.017us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 438ns
               - __MAX_OF_PullTotalTime: 626ns
               - __MIN_OF_PullTotalTime: 338ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 1.464us
               - __MAX_OF_PushTotalTime: 1.819us
               - __MIN_OF_PushTotalTime: 1.221us
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 1.510ms
               - __MAX_OF_OperatorTotalTime: 1.896ms
               - __MIN_OF_OperatorTotalTime: 1.021ms
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 1.064ms
               - __MAX_OF_PullTotalTime: 1.473ms
               - __MIN_OF_PullTotalTime: 584.036us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - Predicates: 52: r_name = 'Europe'
             - Rollup: region
             - SharedScan: False
             - Table: region
             - AccessPathHits: 0
             - AccessPathUnhits: 0
             - BytesRead: 0.000 B
             - CachedPagesNum: 0
             - ChunkBufferCapacity: 1.024K (1024)
             - CompressedBytesRead: 0.000 B
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - IOTaskExecTime: 17.956us
               - __MAX_OF_IOTaskExecTime: 65.831us
               - __MIN_OF_IOTaskExecTime: 7.255us
               - CreateSegmentIter: 8.666us
                 - __MAX_OF_CreateSegmentIter: 27.286us
                 - __MIN_OF_CreateSegmentIter: 4.352us
               - GetDelVec: 0ns
               - GetDeltaColumnGroup: 208ns
                 - __MAX_OF_GetDeltaColumnGroup: 4.628us
                 - __MIN_OF_GetDeltaColumnGroup: 0ns
               - GetRowsets: 3.293us
                 - __MAX_OF_GetRowsets: 11.616us
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
                 - SegmentZoneMapFilterRows: 5
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
                 - SegmentsReadCount: 5
                   - __MAX_OF_SegmentsReadCount: 1
                   - __MIN_OF_SegmentsReadCount: 0
                 - TotalColumnsDataPageCount: 0
             - IOTaskWaitTime: 177.634us
               - __MAX_OF_IOTaskWaitTime: 688.919us
               - __MIN_OF_IOTaskWaitTime: 15.387us
             - MorselsCount: 64
               - __MAX_OF_MorselsCount: 4
               - __MIN_OF_MorselsCount: 4
             - PeakChunkBufferMemoryUsage: 540.026 KB
             - PeakChunkBufferSize: 3
             - PeakIOTasks: 1
               - __MAX_OF_PeakIOTasks: 2
               - __MIN_OF_PeakIOTasks: 0
             - PeakScanTaskQueueSize: 56
               - __MAX_OF_PeakScanTaskQueueSize: 6
               - __MIN_OF_PeakScanTaskQueueSize: 1
             - PrepareChunkSourceTime: 466.494us
               - __MAX_OF_PrepareChunkSourceTime: 565.889us
               - __MIN_OF_PrepareChunkSourceTime: 384.836us
             - PushdownAccessPaths: 0
             - PushdownPredicates: 1
             - RawRowsRead: 0
             - ReadPagesNum: 0
             - RowsRead: 0
             - RuntimeFilterEvalTime: 0ns
             - RuntimeFilterInputRows: 0
             - RuntimeFilterOutputRows: 0
             - ScanTime: 195.591us
               - __MAX_OF_ScanTime: 703.257us
               - __MIN_OF_ScanTime: 22.642us
             - SubmitTaskCount: 64
               - __MAX_OF_SubmitTaskCount: 4
               - __MIN_OF_SubmitTaskCount: 4
             - SubmitTaskTime: 572.431us
               - __MAX_OF_SubmitTaskTime: 877.234us
               - __MIN_OF_SubmitTaskTime: 154.076us
             - TabletCount: 64
             - UncompressedBytesRead: 0.000 B
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 46.916us
           - __MAX_OF_ActiveTime: 73.753us
           - __MIN_OF_ActiveTime: 24.250us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 250.086us
           - __MAX_OF_DriverTotalTime: 528.935us
           - __MIN_OF_DriverTotalTime: 105.470us
         - PeakDriverQueueSize: 40
           - __MAX_OF_PeakDriverQueueSize: 5
           - __MIN_OF_PeakDriverQueueSize: 0
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=8):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 687ns
               - __MAX_OF_OperatorTotalTime: 4.450us
               - __MIN_OF_OperatorTotalTime: 263ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=8):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 46.846us
               - __MAX_OF_OperatorTotalTime: 72.541us
               - __MIN_OF_OperatorTotalTime: 23.967us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 41.299us
               - __MAX_OF_PullTotalTime: 66.095us
               - __MIN_OF_PullTotalTime: 20.013us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 13.155us
               - __MAX_OF_CaptureTabletRowsetsTime: 25.313us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.292us
