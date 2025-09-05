Query:
  Summary:
     - Query ID: fe28a2e5-8a09-11f0-94e0-00163e341b96
     - Start Time: 2025-09-05 11:39:57
     - End Time: 2025-09-05 11:39:57
     - Total: 63ms
     - Query Type: Query
     - Query State: Finished
     - StarRocks Version: 3.5.4-1ce07c8
     - User: root
     - Default Db: tpch
     - Sql Statement: WITH RankedParts AS (
    SELECT 
        p.p_partkey,
        p.p_name,
        p.p_brand,
        p.p_type,
        p.p_size,
        p.p_retailprice,
        p.p_comment,
        ROW_NUMBER() OVER(PARTITION BY p.p_brand ORDER BY p.p_retailprice DESC) AS rn
    FROM 
        part p
    WHERE 
        p.p_size >= 10
),
TopExpensiveParts AS (
    SELECT 
        rp.p_partkey,
        rp.p_name,
        rp.p_brand,
        rp.p_retailprice
    FROM 
        RankedParts rp
    WHERE 
        rp.rn <= 5
),
SupplierDetails AS (
    SELECT 
        s.s_suppkey,
        s.s_name,
        s.s_address,
        s.s_phone,
        s.s_acctbal,
        s.s_comment
    FROM 
        supplier s
    WHERE 
        s.s_acctbal > 10000
)
SELECT 
    tp.p_name AS Part_Name,
    tp.p_brand AS Brand,
    COUNT(sd.s_suppkey) AS Supplier_Count,
    AVG(sd.s_acctbal) AS Average_Account_Balance
FROM 
    TopExpensiveParts tp
JOIN 
    partsupp ps ON tp.p_partkey = ps.ps_partkey
JOIN 
    SupplierDetails sd ON ps.ps_suppkey = sd.s_suppkey
GROUP BY 
    tp.p_name, tp.p_brand
ORDER BY 
    Average_Account_Balance DESC;
     - Variables: parallel_fragment_exec_instance_num=1,max_parallel_scan_instance_num=-1,pipeline_dop=0,enable_adaptive_sink_dop=true,enable_runtime_adaptive_dop=false,runtime_profile_report_interval=10,resource_group=default_wg
     - NonDefaultSessionVariables: {"sql_mode_v2":{"defaultValue":32,"actualValue":34},"query_timeout":{"defaultValue":300,"actualValue":10},"prefer_compute_node":{"defaultValue":false,"actualValue":true},"enable_adaptive_sink_dop":{"defaultValue":false,"actualValue":true},"enable_profile":{"defaultValue":false,"actualValue":true}}
     - Collect Profile Time: 6ms
     - IsProfileAsync: true
  Planner:
     - -- Parser[1] 0
     - -- Total[1] 7ms
     -     -- Analyzer[1] 0
     -         -- Lock[1] 0
     -         -- AnalyzeDatabase[3] 0
     -         -- AnalyzeTemporaryTable[3] 0
     -         -- AnalyzeTable[3] 0
     -     -- Transformer[1] 0
     -     -- Optimizer[1] 5ms
     -         -- MVPreprocess[1] 0
     -         -- MVTextRewrite[1] 0
     -         -- RuleBaseOptimize[1] 3ms
     -         -- CostBaseOptimize[1] 1ms
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
     - -- Deploy[1] 23ms
     -     -- DeployLockInternalTime[1] 23ms
     -         -- DeploySerializeConcurrencyTime[5] 1ms
     -         -- DeployStageByStageTime[15] 0
     -             -- DeployAsyncSendTime[7] 0
     -         -- DeployWaitTime[15] 21ms
     - DeployDataSize: 58115
    Reason:
  Execution:
     - Topology: {"rootId":21,"nodes":[{"id":21,"name":"MERGE_EXCHANGE","properties":{"sinkIds":[],"displayMem":true},"children":[20]},{"id":20,"name":"SORT","properties":{"sinkIds":[21],"displayMem":true},"children":[19]},{"id":19,"name":"AGGREGATION","properties":{"displayMem":true},"children":[18]},{"id":18,"name":"EXCHANGE","properties":{"displayMem":true},"children":[17]},{"id":17,"name":"AGGREGATION","properties":{"sinkIds":[18],"displayMem":true},"children":[16]},{"id":16,"name":"PROJECT","properties":{"displayMem":false},"children":[15]},{"id":15,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[8,14]},{"id":8,"name":"EXCHANGE","properties":{"displayMem":true},"children":[7]},{"id":14,"name":"EXCHANGE","properties":{"displayMem":true},"children":[13]},{"id":7,"name":"PROJECT","properties":{"sinkIds":[8],"displayMem":false},"children":[6]},{"id":13,"name":"PROJECT","properties":{"sinkIds":[14],"displayMem":false},"children":[12]},{"id":6,"name":"SELECT","properties":{"displayMem":false},"children":[5]},{"id":12,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[9,11]},{"id":5,"name":"ANALYTIC_EVAL","properties":{"displayMem":true},"children":[4]},{"id":9,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":11,"name":"EXCHANGE","properties":{"displayMem":true},"children":[10]},{"id":4,"name":"SORT","properties":{"displayMem":true},"children":[3]},{"id":10,"name":"OLAP_SCAN","properties":{"sinkIds":[11],"displayMem":false},"children":[]},{"id":3,"name":"EXCHANGE","properties":{"displayMem":true},"children":[2]},{"id":2,"name":"PARTITION_TOP_N","properties":{"sinkIds":[3],"displayMem":true},"children":[1]},{"id":1,"name":"PROJECT","properties":{"displayMem":false},"children":[0]},{"id":0,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]}]}
     - FrontendProfileMergeTime: 5.324ms
     - QueryAllocatedMemoryUsage: 538.353 MB
     - QueryCumulativeCpuTime: 1s54ms
     - QueryCumulativeNetworkTime: 1.776ms
     - QueryCumulativeOperatorTime: 59.495ms
     - QueryCumulativeScanTime: 19.012ms
     - QueryDeallocatedMemoryUsage: 451.392 MB
     - QueryExecutionWallTime: 47.255ms
     - QueryPeakMemoryUsagePerNode: 176.207 MB
     - QueryPeakScheduleTime: 41.390ms
     - QuerySpillBytes: 0.000 B
     - QuerySumMemoryUsage: 176.207 MB
     - ResultDeliverTime: 0ns
    Fragment 0:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: fe28a2e5-8a09-11f0-94e0-00163e341b97
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 1.104ms
       - InitialProcessDriverCount: 0
       - InitialProcessMem: 5.708 GB
       - InstanceAllocatedMemoryUsage: 278.391 KB
       - InstanceDeallocatedMemoryUsage: 64.422 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 213.969 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 12.746us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 41.403ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 41.360ms
             - FirstInputEmptyTime: 41.360ms
         - ScheduleCount: 1
         - ScheduleTime: 41.390ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        RESULT_SINK (plan_node_id=-1):
          CommonMetrics:
             - IsFinalSink
             - OperatorTotalTime: 69.605us
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
             - OperatorTotalTime: 1.060us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        LOCAL_EXCHANGE_SOURCE (plan_node_id=21):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 11.708us
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
         - ActiveTime: 357.611us
           - __MAX_OF_ActiveTime: 1.148ms
           - __MIN_OF_ActiveTime: 18.208us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 41.216ms
           - __MAX_OF_DriverTotalTime: 41.383ms
           - __MIN_OF_DriverTotalTime: 41.109ms
         - PeakDriverQueueSize: 42
           - __MAX_OF_PeakDriverQueueSize: 5
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 38.216ms
             - __MAX_OF_InputEmptyTime: 38.985ms
             - __MIN_OF_InputEmptyTime: 35.564ms
             - FirstInputEmptyTime: 2.411ms
               - __MAX_OF_FirstInputEmptyTime: 35.379ms
               - __MIN_OF_FirstInputEmptyTime: 83.218us
             - FollowupInputEmptyTime: 35.804ms
               - __MAX_OF_FollowupInputEmptyTime: 38.610ms
               - __MIN_OF_FollowupInputEmptyTime: 2.341ms
         - ScheduleCount: 77
           - __MAX_OF_ScheduleCount: 5
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 40.858ms
           - __MAX_OF_ScheduleTime: 41.102ms
           - __MIN_OF_ScheduleTime: 40.005ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 61
           - __MAX_OF_YieldByLocalWait: 4
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=21):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.640us
               - __MAX_OF_OperatorTotalTime: 20.363us
               - __MIN_OF_OperatorTotalTime: 319ns
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
        GLOBAL_PARALLEL_MERGE_SOURCE (plan_node_id=21):
          CommonMetrics:
             - OperatorTotalTime: 339.324us
               - __MAX_OF_OperatorTotalTime: 1.124ms
               - __MIN_OF_OperatorTotalTime: 7.524us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 337.693us
               - __MAX_OF_PullTotalTime: 1.123ms
               - __MIN_OF_PullTotalTime: 6.993us
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
             - OverallStageTime: 81.115us
               - __MAX_OF_OverallStageTime: 716.671us
               - __MIN_OF_OverallStageTime: 2.360us
               - 1-InitStageTime: 2.425us
                 - __MAX_OF_1-InitStageTime: 38.800us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 41.581us
                 - __MAX_OF_2-PrepareStageTime: 665.306us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 477ns
                 - __MAX_OF_3-ProcessStageTime: 7.642us
                 - __MIN_OF_3-ProcessStageTime: 0ns
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 171ns
                   - __MAX_OF_SortedRunProviderTime: 2.747us
                   - __MIN_OF_SortedRunProviderTime: 0ns
               - 4-SplitChunkStageTime: 2.220us
                 - __MAX_OF_4-SplitChunkStageTime: 21.634us
                 - __MIN_OF_4-SplitChunkStageTime: 349ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 32.730us
                 - __MAX_OF_5-FetchChunkStageTime: 484.786us
                 - __MIN_OF_5-FetchChunkStageTime: 304ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 182ns
                 - __MAX_OF_7-FinishedStageTime: 587ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 0ns
             - RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 1:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: fe28a2e5-8a09-11f0-94e0-00163e341b98
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.770ms
       - InitialProcessDriverCount: 17
       - InitialProcessMem: 5.709 GB
       - InstanceAllocatedMemoryUsage: 891.086 KB
       - InstanceDeallocatedMemoryUsage: 249.820 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 616.625 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - IsGroupExecution: false
         - ActiveTime: 123.724us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 33.123ms
         - PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - InputEmptyTime: 32.609ms
             - FirstInputEmptyTime: 32.609ms
         - ScheduleCount: 1
         - ScheduleTime: 32.999ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=21):
          CommonMetrics:
             - OperatorTotalTime: 137.431us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: fe28a2e58a0911f0-94e000163e341b97
             - DestID: 21
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 342.805us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 379.248us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 342.805us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 400.789us
        LOCAL_EXCHANGE_SOURCE (plan_node_id=20):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 6.633us
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
         - ActiveTime: 532.367us
           - __MAX_OF_ActiveTime: 1.217ms
           - __MIN_OF_ActiveTime: 17.355us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 32.550ms
           - __MAX_OF_DriverTotalTime: 32.625ms
           - __MIN_OF_DriverTotalTime: 32.527ms
         - PeakDriverQueueSize: 37
           - __MAX_OF_PeakDriverQueueSize: 4
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 30.790ms
             - __MAX_OF_InputEmptyTime: 31.096ms
             - __MIN_OF_InputEmptyTime: 30.543ms
             - FirstInputEmptyTime: 30.723ms
               - __MAX_OF_FirstInputEmptyTime: 30.837ms
               - __MIN_OF_FirstInputEmptyTime: 30.482ms
         - ScheduleCount: 62
           - __MAX_OF_ScheduleCount: 4
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 32.018ms
           - __MAX_OF_ScheduleTime: 32.568ms
           - __MIN_OF_ScheduleTime: 31.314ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 46
           - __MAX_OF_YieldByLocalWait: 3
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=20):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.234us
               - __MAX_OF_OperatorTotalTime: 11.840us
               - __MIN_OF_OperatorTotalTime: 337ns
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
        LOCAL_PARALLEL_MERGE_SOURCE (plan_node_id=20):
          CommonMetrics:
             - OperatorTotalTime: 518.946us
               - __MAX_OF_OperatorTotalTime: 1.205ms
               - __MIN_OF_OperatorTotalTime: 7.569us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 517.039us
               - __MAX_OF_PullTotalTime: 1.204ms
               - __MIN_OF_PullTotalTime: 7.249us
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
             - OverallStageTime: 43.859us
               - __MAX_OF_OverallStageTime: 574.187us
               - __MIN_OF_OverallStageTime: 3.029us
               - 1-InitStageTime: 5.323us
                 - __MAX_OF_1-InitStageTime: 85.177us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 30.211us
                 - __MAX_OF_2-PrepareStageTime: 483.385us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 5.408us
                 - __MAX_OF_3-ProcessStageTime: 34.831us
                 - __MIN_OF_3-ProcessStageTime: 1.252us
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 929ns
                   - __MAX_OF_SortedRunProviderTime: 1.201us
                   - __MIN_OF_SortedRunProviderTime: 448ns
               - 4-SplitChunkStageTime: 787ns
                 - __MAX_OF_4-SplitChunkStageTime: 5.551us
                 - __MIN_OF_4-SplitChunkStageTime: 99ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 791ns
                 - __MAX_OF_5-FetchChunkStageTime: 6.683us
                 - __MIN_OF_5-FetchChunkStageTime: 147ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 71ns
                 - __MAX_OF_7-FinishedStageTime: 304ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 18.429us
           - __MAX_OF_ActiveTime: 37.306us
           - __MIN_OF_ActiveTime: 12.136us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 30.285ms
           - __MAX_OF_DriverTotalTime: 30.511ms
           - __MIN_OF_DriverTotalTime: 30.195ms
         - PeakDriverQueueSize: 281
           - __MAX_OF_PeakDriverQueueSize: 31
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 30.055ms
             - __MAX_OF_InputEmptyTime: 30.440ms
             - __MIN_OF_InputEmptyTime: 29.817ms
             - FirstInputEmptyTime: 30.055ms
               - __MAX_OF_FirstInputEmptyTime: 30.440ms
               - __MIN_OF_FirstInputEmptyTime: 29.817ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 30.266ms
           - __MAX_OF_ScheduleTime: 30.474ms
           - __MIN_OF_ScheduleTime: 30.166ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_SORT_SINK (plan_node_id=20):
          CommonMetrics:
             - OperatorTotalTime: 18.281us
               - __MAX_OF_OperatorTotalTime: 35.401us
               - __MIN_OF_OperatorTotalTime: 12.308us
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
             - SortKeys: 24: avg DESC
             - SortType: All
             - BuildingTime: 0ns
             - InputRequiredMemory: 0.000 B
             - MergingTime: 3.806us
               - __MAX_OF_MergingTime: 5.881us
               - __MIN_OF_MergingTime: 2.534us
             - NumSortedRuns: 0
             - OutputTime: 165ns
               - __MAX_OF_OutputTime: 340ns
               - __MIN_OF_OutputTime: 48ns
             - SortingCnt: 0
             - SortingTime: 0ns
        AGGREGATE_BLOCKING_SOURCE (plan_node_id=19):
          CommonMetrics:
             - OperatorTotalTime: 17.210us
               - __MAX_OF_OperatorTotalTime: 27.696us
               - __MIN_OF_OperatorTotalTime: 11.888us
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
         - ActiveTime: 40.843us
           - __MAX_OF_ActiveTime: 339.981us
           - __MIN_OF_ActiveTime: 10.567us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 30.114ms
           - __MAX_OF_DriverTotalTime: 30.469ms
           - __MIN_OF_DriverTotalTime: 30.004ms
         - PeakDriverQueueSize: 95
           - __MAX_OF_PeakDriverQueueSize: 13
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 29.802ms
             - __MAX_OF_InputEmptyTime: 29.813ms
             - __MIN_OF_InputEmptyTime: 29.759ms
             - FirstInputEmptyTime: 29.802ms
               - __MAX_OF_FirstInputEmptyTime: 29.813ms
               - __MIN_OF_FirstInputEmptyTime: 29.759ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 30.073ms
           - __MAX_OF_ScheduleTime: 30.141ms
           - __MIN_OF_ScheduleTime: 29.981ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        AGGREGATE_BLOCKING_SINK (plan_node_id=19):
          CommonMetrics:
             - OperatorTotalTime: 19.826us
               - __MAX_OF_OperatorTotalTime: 70.642us
               - __MIN_OF_OperatorTotalTime: 11.631us
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
             - AggregateFunctions: count(23: count), avg(24: avg)
             - GroupingKeys: 2: p_name, 4: p_brand
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
        EXCHANGE_SOURCE (plan_node_id=18):
          CommonMetrics:
             - OperatorTotalTime: 14.178us
               - __MAX_OF_OperatorTotalTime: 28.239us
               - __MIN_OF_OperatorTotalTime: 7.495us
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
             - ReceiverProcessTotalTime: 657ns
               - __MAX_OF_ReceiverProcessTotalTime: 10.523us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 2:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: fe28a2e5-8a09-11f0-94e0-00163e341b99
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 4.666ms
       - InitialProcessDriverCount: 66
       - InitialProcessMem: 5.712 GB
       - InstanceAllocatedMemoryUsage: 1.181 MB
       - InstanceDeallocatedMemoryUsage: 382.117 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 822.320 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=2):
         - IsGroupExecution: false
         - ActiveTime: 19.946us
           - __MAX_OF_ActiveTime: 91.601us
           - __MIN_OF_ActiveTime: 5.759us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 25.259ms
           - __MAX_OF_DriverTotalTime: 25.296ms
           - __MIN_OF_DriverTotalTime: 25.216ms
         - PeakDriverQueueSize: 360
           - __MAX_OF_PeakDriverQueueSize: 30
           - __MIN_OF_PeakDriverQueueSize: 15
         - PendingTime: 0ns
           - InputEmptyTime: 23.863ms
             - __MAX_OF_InputEmptyTime: 24.326ms
             - __MIN_OF_InputEmptyTime: 23.694ms
             - FirstInputEmptyTime: 23.863ms
               - __MAX_OF_FirstInputEmptyTime: 24.326ms
               - __MIN_OF_FirstInputEmptyTime: 23.694ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 25.239ms
           - __MAX_OF_ScheduleTime: 25.290ms
           - __MIN_OF_ScheduleTime: 25.166ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=18):
          CommonMetrics:
             - OperatorTotalTime: 15.671us
               - __MAX_OF_OperatorTotalTime: 84.371us
               - __MIN_OF_OperatorTotalTime: 2.309us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: fe28a2e58a0911f0-94e000163e341b98
             - DestID: 18
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
             - NetworkTime: 362.622us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 628.061us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 362.622us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 780.987us
        AGGREGATE_STREAMING_SOURCE (plan_node_id=17):
          CommonMetrics:
             - OperatorTotalTime: 16.003us
               - __MAX_OF_OperatorTotalTime: 23.342us
               - __MIN_OF_OperatorTotalTime: 13.137us
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
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 14.733us
           - __MAX_OF_ActiveTime: 41.194us
           - __MIN_OF_ActiveTime: 7.586us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 23.905ms
           - __MAX_OF_DriverTotalTime: 24.379ms
           - __MIN_OF_DriverTotalTime: 23.720ms
         - PeakDriverQueueSize: 136
           - __MAX_OF_PeakDriverQueueSize: 16
           - __MIN_OF_PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - PreconditionBlockTime: 23.227ms
             - __MAX_OF_PreconditionBlockTime: 23.567ms
             - __MIN_OF_PreconditionBlockTime: 23.136ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 23.890ms
           - __MAX_OF_ScheduleTime: 24.338ms
           - __MIN_OF_ScheduleTime: 23.707ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        AGGREGATE_STREAMING_SINK (plan_node_id=17):
          CommonMetrics:
             - OperatorTotalTime: 18.819us
               - __MAX_OF_OperatorTotalTime: 43.288us
               - __MIN_OF_OperatorTotalTime: 11.681us
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
             - AggregateFunctions: count(16: s_suppkey), avg(21: s_acctbal)
             - GroupingKeys: 2: p_name, 4: p_brand
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
        PROJECT (plan_node_id=16):
          CommonMetrics:
             - OperatorTotalTime: 5.897us
               - __MAX_OF_OperatorTotalTime: 17.927us
               - __MIN_OF_OperatorTotalTime: 3.967us
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
        CHUNK_ACCUMULATE (plan_node_id=15):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 567ns
               - __MAX_OF_OperatorTotalTime: 840ns
               - __MIN_OF_OperatorTotalTime: 359ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=15):
          CommonMetrics:
             - OperatorTotalTime: 14.383us
               - __MAX_OF_OperatorTotalTime: 28.599us
               - __MIN_OF_OperatorTotalTime: 9.723us
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
             - DistributionMode: PARTITIONED
             - JoinType: INNER_JOIN
             - OtherJoinConjunctEvaluateTime: 0ns
             - OutputBuildColumnTime: 0ns
             - OutputProbeColumnTime: 0ns
             - PartitionProbeOverhead: 0ns
             - ProbeConjunctEvaluateTime: 0ns
             - SearchHashTableTime: 0ns
             - WhereConjunctEvaluateTime: 0ns
             - probeCount: 0
        EXCHANGE_SOURCE (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 15.674us
               - __MAX_OF_OperatorTotalTime: 33.634us
               - __MIN_OF_OperatorTotalTime: 9.631us
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
             - ReceiverProcessTotalTime: 0ns
             - RequestReceived: 0
             - WaitLockTime: 0ns
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 43.377us
           - __MAX_OF_ActiveTime: 112.175us
           - __MIN_OF_ActiveTime: 21.868us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 23.298ms
           - __MAX_OF_DriverTotalTime: 23.725ms
           - __MIN_OF_DriverTotalTime: 23.176ms
         - PeakDriverQueueSize: 152
           - __MAX_OF_PeakDriverQueueSize: 17
           - __MIN_OF_PeakDriverQueueSize: 2
         - PendingTime: 0ns
           - InputEmptyTime: 18.624ms
             - __MAX_OF_InputEmptyTime: 18.626ms
             - __MIN_OF_InputEmptyTime: 18.623ms
             - FirstInputEmptyTime: 18.624ms
               - __MAX_OF_FirstInputEmptyTime: 18.626ms
               - __MIN_OF_FirstInputEmptyTime: 18.623ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 23.255ms
           - __MAX_OF_ScheduleTime: 23.613ms
           - __MIN_OF_ScheduleTime: 23.117ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=15):
          CommonMetrics:
             - OperatorTotalTime: 38.406us
               - __MAX_OF_OperatorTotalTime: 100.859us
               - __MIN_OF_OperatorTotalTime: 22.512us
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
             - DistributionMode: PARTITIONED
             - JoinPredicates: 1: p_partkey = 11: ps_partkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 3.692us
               - __MAX_OF_BuildHashTableTime: 6.989us
               - __MIN_OF_BuildHashTableTime: 2.374us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 352.000 B
               - __MAX_OF_HashTableMemoryUsage: 22.000 B
               - __MIN_OF_HashTableMemoryUsage: 22.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MAX_OF_PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MIN_OF_PartialRuntimeMembershipFilterBytes: 0.000 B
             - PartitionNums: 16
               - __MAX_OF_PartitionNums: 1
               - __MIN_OF_PartitionNums: 1
             - RuntimeFilterBuildTime: 7.315us
               - __MAX_OF_RuntimeFilterBuildTime: 20.757us
               - __MIN_OF_RuntimeFilterBuildTime: 3.118us
             - RuntimeFilterNum: 0
        EXCHANGE_SOURCE (plan_node_id=14):
          CommonMetrics:
             - OperatorTotalTime: 11.827us
               - __MAX_OF_OperatorTotalTime: 18.568us
               - __MIN_OF_OperatorTotalTime: 7.021us
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
             - ReceiverProcessTotalTime: 425ns
               - __MAX_OF_ReceiverProcessTotalTime: 6.814us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 3:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: fe28a2e5-8a09-11f0-94e0-00163e341b9a
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 4.534ms
       - InitialProcessDriverCount: 114
       - InitialProcessMem: 5.718 GB
       - InstanceAllocatedMemoryUsage: 1.807 MB
       - InstanceDeallocatedMemoryUsage: 592.977 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.228 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 17.955us
           - __MAX_OF_ActiveTime: 143.383us
           - __MIN_OF_ActiveTime: 7.327us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 18.455ms
           - __MAX_OF_DriverTotalTime: 18.526ms
           - __MIN_OF_DriverTotalTime: 18.380ms
         - PeakDriverQueueSize: 408
           - __MAX_OF_PeakDriverQueueSize: 33
           - __MIN_OF_PeakDriverQueueSize: 18
         - PendingTime: 0ns
           - PreconditionBlockTime: 11.663ms
             - __MAX_OF_PreconditionBlockTime: 11.731ms
             - __MIN_OF_PreconditionBlockTime: 11.598ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 18.437ms
           - __MAX_OF_ScheduleTime: 18.514ms
           - __MIN_OF_ScheduleTime: 18.364ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=14):
          CommonMetrics:
             - OperatorTotalTime: 13.227us
               - __MAX_OF_OperatorTotalTime: 136.622us
               - __MIN_OF_OperatorTotalTime: 1.950us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: fe28a2e58a0911f0-94e000163e341b99
             - DestID: 14
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
             - NetworkTime: 720.466us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 776.932us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 720.466us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 5.238ms
        PROJECT (plan_node_id=13):
          CommonMetrics:
             - OperatorTotalTime: 5.399us
               - __MAX_OF_OperatorTotalTime: 6.280us
               - __MIN_OF_OperatorTotalTime: 4.781us
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
        CHUNK_ACCUMULATE (plan_node_id=12):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 388ns
               - __MAX_OF_OperatorTotalTime: 671ns
               - __MIN_OF_OperatorTotalTime: 276ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=12):
          CommonMetrics:
             - OperatorTotalTime: 6.751us
               - __MAX_OF_OperatorTotalTime: 13.072us
               - __MIN_OF_OperatorTotalTime: 5.433us
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
        CHUNK_ACCUMULATE (plan_node_id=9):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 437ns
               - __MAX_OF_OperatorTotalTime: 759ns
               - __MIN_OF_OperatorTotalTime: 334ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=9):
          CommonMetrics:
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 26.624us
               - __MAX_OF_OperatorTotalTime: 36.172us
               - __MIN_OF_OperatorTotalTime: 20.177us
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
         - ActiveTime: 26.053us
           - __MAX_OF_ActiveTime: 56.857us
           - __MIN_OF_ActiveTime: 17.785us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 12.923ms
           - __MAX_OF_DriverTotalTime: 13.042ms
           - __MIN_OF_DriverTotalTime: 12.745ms
         - PeakDriverQueueSize: 152
           - __MAX_OF_PeakDriverQueueSize: 17
           - __MIN_OF_PeakDriverQueueSize: 2
         - PendingTime: 0ns
           - PreconditionBlockTime: 11.516ms
             - __MAX_OF_PreconditionBlockTime: 11.541ms
             - __MIN_OF_PreconditionBlockTime: 11.474ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 12.897ms
           - __MAX_OF_ScheduleTime: 13.024ms
           - __MIN_OF_ScheduleTime: 12.688ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=9):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 373ns
               - __MAX_OF_OperatorTotalTime: 563ns
               - __MIN_OF_OperatorTotalTime: 249ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=9):
          CommonMetrics:
             - IsSubordinate
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 28.682us
               - __MAX_OF_OperatorTotalTime: 59.240us
               - __MIN_OF_OperatorTotalTime: 20.127us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 20.716us
               - __MAX_OF_PullTotalTime: 47.573us
               - __MIN_OF_PullTotalTime: 13.775us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 11.647us
               - __MAX_OF_CaptureTabletRowsetsTime: 20.707us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.590us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 374.683us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 11.793ms
         - PeakDriverQueueSize: 17
         - PendingTime: 0ns
           - InputEmptyTime: 8.794ms
             - FirstInputEmptyTime: 8.794ms
         - ScheduleCount: 1
         - ScheduleTime: 11.419ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=12):
          CommonMetrics:
             - OperatorTotalTime: 362.324us
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
             - JoinPredicates: 12: ps_suppkey = 16: s_suppkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 6.423us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 16.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 1
             - RuntimeFilterBuildTime: 19.920us
             - RuntimeFilterNum: 0
        LOCAL_EXCHANGE_SOURCE (plan_node_id=12):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 10.913us
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
         - ActiveTime: 7.849us
           - __MAX_OF_ActiveTime: 24.542us
           - __MIN_OF_ActiveTime: 4.054us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 8.633ms
           - __MAX_OF_DriverTotalTime: 8.802ms
           - __MIN_OF_DriverTotalTime: 8.429ms
         - PeakDriverQueueSize: 152
           - __MAX_OF_PeakDriverQueueSize: 17
           - __MIN_OF_PeakDriverQueueSize: 2
         - PendingTime: 0ns
           - InputEmptyTime: 6.050ms
             - __MAX_OF_InputEmptyTime: 6.055ms
             - __MIN_OF_InputEmptyTime: 6.045ms
             - FirstInputEmptyTime: 6.050ms
               - __MAX_OF_FirstInputEmptyTime: 6.055ms
               - __MIN_OF_FirstInputEmptyTime: 6.045ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 8.625ms
           - __MAX_OF_ScheduleTime: 8.790ms
           - __MIN_OF_ScheduleTime: 8.417ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=12):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 958ns
               - __MAX_OF_OperatorTotalTime: 7.118us
               - __MIN_OF_OperatorTotalTime: 363ns
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
        EXCHANGE_SOURCE (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 8.493us
               - __MAX_OF_OperatorTotalTime: 20.114us
               - __MIN_OF_OperatorTotalTime: 5.790us
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
             - ReceiverProcessTotalTime: 287ns
               - __MAX_OF_ReceiverProcessTotalTime: 4.592us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 4:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: fe28a2e5-8a09-11f0-94e0-00163e341b9b
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.342ms
       - InitialProcessDriverCount: 211
       - InitialProcessMem: 5.725 GB
       - InstanceAllocatedMemoryUsage: 7.973 MB
       - InstanceDeallocatedMemoryUsage: 5.888 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 2.365 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 1.069ms
           - __MAX_OF_ActiveTime: 1.546ms
           - __MIN_OF_ActiveTime: 511.667us
         - BlockByInputEmpty: 8
           - __MAX_OF_BlockByInputEmpty: 1
           - __MIN_OF_BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 6.078ms
           - __MAX_OF_DriverTotalTime: 6.802ms
           - __MIN_OF_DriverTotalTime: 5.183ms
         - PeakDriverQueueSize: 408
           - __MAX_OF_PeakDriverQueueSize: 33
           - __MIN_OF_PeakDriverQueueSize: 18
         - PendingTime: 0ns
           - PendingFinishTime: 1.098ms
             - __MAX_OF_PendingFinishTime: 1.543ms
             - __MIN_OF_PendingFinishTime: 329.910us
         - ScheduleCount: 25
           - __MAX_OF_ScheduleCount: 2
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 5.008ms
           - __MAX_OF_ScheduleTime: 6.269ms
           - __MIN_OF_ScheduleTime: 3.723ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 9.199us
               - __MAX_OF_OperatorTotalTime: 69.048us
               - __MIN_OF_OperatorTotalTime: 1.913us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: fe28a2e58a0911f0-94e000163e341b9a
             - DestID: 11
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 350.792us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 375.694us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 350.792us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 3.539ms
        CHUNK_ACCUMULATE (plan_node_id=10):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 2.676us
               - __MAX_OF_OperatorTotalTime: 3.634us
               - __MIN_OF_OperatorTotalTime: 2.068us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 504ns
               - __MAX_OF_PullTotalTime: 648ns
               - __MIN_OF_PullTotalTime: 394ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 1.618us
               - __MAX_OF_PushTotalTime: 2.047us
               - __MIN_OF_PushTotalTime: 1.191us
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=10):
          CommonMetrics:
             - OperatorTotalTime: 1.477ms
               - __MAX_OF_OperatorTotalTime: 1.987ms
               - __MIN_OF_OperatorTotalTime: 894.371us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 1.005ms
               - __MAX_OF_PullTotalTime: 1.483ms
               - __MIN_OF_PullTotalTime: 470.697us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - Predicates: 16: s_suppkey IS NOT NULL, 21: s_acctbal > 10000
             - Rollup: supplier
             - SharedScan: False
             - Table: supplier
             - AccessPathHits: 0
             - AccessPathUnhits: 0
             - BytesRead: 0.000 B
             - CachedPagesNum: 0
             - ChunkBufferCapacity: 1.024K (1024)
             - CompressedBytesRead: 0.000 B
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - IOTaskExecTime: 25.422us
               - __MAX_OF_IOTaskExecTime: 97.601us
               - __MIN_OF_IOTaskExecTime: 11.170us
               - CreateSegmentIter: 17.784us
                 - __MAX_OF_CreateSegmentIter: 97.583us
                 - __MIN_OF_CreateSegmentIter: 8.684us
               - GetDelVec: 0ns
               - GetDeltaColumnGroup: 4.580us
                 - __MAX_OF_GetDeltaColumnGroup: 76.201us
                 - __MIN_OF_GetDeltaColumnGroup: 745ns
               - GetRowsets: 3.251us
                 - __MAX_OF_GetRowsets: 5.715us
                 - __MIN_OF_GetRowsets: 1.908us
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
                 - SegmentZoneMapFilterRows: 100.000K (100000)
                   - __MAX_OF_SegmentZoneMapFilterRows: 1.563K (1563)
                   - __MIN_OF_SegmentZoneMapFilterRows: 1.562K (1562)
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
                 - SegmentsReadCount: 64
                   - __MAX_OF_SegmentsReadCount: 1
                   - __MIN_OF_SegmentsReadCount: 1
                 - TotalColumnsDataPageCount: 0
             - IOTaskWaitTime: 165.716us
               - __MAX_OF_IOTaskWaitTime: 718.462us
               - __MIN_OF_IOTaskWaitTime: 12.684us
             - MorselsCount: 64
               - __MAX_OF_MorselsCount: 4
               - __MIN_OF_MorselsCount: 4
             - PeakChunkBufferMemoryUsage: 896.031 KB
             - PeakChunkBufferSize: 2
             - PeakIOTasks: 1
               - __MAX_OF_PeakIOTasks: 2
               - __MIN_OF_PeakIOTasks: 1
             - PeakScanTaskQueueSize: 91
               - __MAX_OF_PeakScanTaskQueueSize: 11
               - __MIN_OF_PeakScanTaskQueueSize: 1
             - PrepareChunkSourceTime: 518.470us
               - __MAX_OF_PrepareChunkSourceTime: 639.884us
               - __MIN_OF_PrepareChunkSourceTime: 398.717us
             - PushdownAccessPaths: 0
             - PushdownPredicates: 2
             - RawRowsRead: 0
             - ReadPagesNum: 0
             - RowsRead: 0
             - RuntimeFilterEvalTime: 0ns
             - RuntimeFilterInputRows: 0
             - RuntimeFilterOutputRows: 0
             - ScanTime: 191.139us
               - __MAX_OF_ScanTime: 736.451us
               - __MIN_OF_ScanTime: 30.870us
             - SubmitTaskCount: 64
               - __MAX_OF_SubmitTaskCount: 4
               - __MIN_OF_SubmitTaskCount: 4
             - SubmitTaskTime: 464.273us
               - __MAX_OF_SubmitTaskTime: 965.246us
               - __MIN_OF_SubmitTaskTime: 51.402us
             - TabletCount: 64
             - UncompressedBytesRead: 0.000 B
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 46.641us
           - __MAX_OF_ActiveTime: 66.615us
           - __MIN_OF_ActiveTime: 20.054us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 206.500us
           - __MAX_OF_DriverTotalTime: 304.700us
           - __MIN_OF_DriverTotalTime: 122.409us
         - PeakDriverQueueSize: 35
           - __MAX_OF_PeakDriverQueueSize: 3
           - __MIN_OF_PeakDriverQueueSize: 0
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=10):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 387ns
               - __MAX_OF_OperatorTotalTime: 694ns
               - __MIN_OF_OperatorTotalTime: 259ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        OLAP_SCAN_PREPARE (plan_node_id=10):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 45.645us
               - __MAX_OF_OperatorTotalTime: 64.887us
               - __MIN_OF_OperatorTotalTime: 20.776us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 40.014us
               - __MAX_OF_PullTotalTime: 59.778us
               - __MIN_OF_PullTotalTime: 16.631us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.356us
               - __MAX_OF_CaptureTabletRowsetsTime: 14.725us
               - __MIN_OF_CaptureTabletRowsetsTime: 7.509us
    Fragment 5:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: fe28a2e5-8a09-11f0-94e0-00163e341b9c
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.352ms
       - InitialProcessDriverCount: 114
       - InitialProcessMem: 5.718 GB
       - InstanceAllocatedMemoryUsage: 1.540 MB
       - InstanceDeallocatedMemoryUsage: 276.898 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.246 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=2):
         - IsGroupExecution: false
         - ActiveTime: 0ns
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 29.054ms
           - __MAX_OF_DriverTotalTime: 29.111ms
           - __MIN_OF_DriverTotalTime: 28.958ms
         - PeakDriverQueueSize: 611
           - __MAX_OF_PeakDriverQueueSize: 47
           - __MIN_OF_PeakDriverQueueSize: 22
         - PendingTime: 0ns
           - InputEmptyTime: 8.811ms
             - __MAX_OF_InputEmptyTime: 8.871ms
             - __MIN_OF_InputEmptyTime: 8.792ms
             - FirstInputEmptyTime: 8.811ms
               - __MAX_OF_FirstInputEmptyTime: 8.871ms
               - __MIN_OF_FirstInputEmptyTime: 8.792ms
           - PreconditionBlockTime: 20.149ms
             - __MAX_OF_PreconditionBlockTime: 20.165ms
             - __MIN_OF_PreconditionBlockTime: 20.135ms
         - ScheduleCount: 0
         - ScheduleTime: 29.054ms
           - __MAX_OF_ScheduleTime: 29.111ms
           - __MIN_OF_ScheduleTime: 28.958ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 2.462us
               - __MAX_OF_OperatorTotalTime: 20.431us
               - __MIN_OF_OperatorTotalTime: 955ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: fe28a2e58a0911f0-94e000163e341b99
             - DestID: 8
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
             - NetworkTime: 0ns
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 0ns
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 0ns
             - RpcCount: 0
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 176.536us
        PROJECT (plan_node_id=7):
          CommonMetrics:
             - OperatorTotalTime: 5.204us
               - __MAX_OF_OperatorTotalTime: 10.298us
               - __MIN_OF_OperatorTotalTime: 3.695us
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
        SELECT (plan_node_id=6):
          CommonMetrics:
             - OperatorTotalTime: 5.054us
               - __MAX_OF_OperatorTotalTime: 5.947us
               - __MIN_OF_OperatorTotalTime: 4.024us
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
        ANALYTIC_SOURCE (plan_node_id=5):
          CommonMetrics:
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 14.429us
               - __MAX_OF_OperatorTotalTime: 36.218us
               - __MIN_OF_OperatorTotalTime: 9.129us
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
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 0ns
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 28.922ms
           - __MAX_OF_DriverTotalTime: 28.937ms
           - __MIN_OF_DriverTotalTime: 28.905ms
         - PeakDriverQueueSize: 474
           - __MAX_OF_PeakDriverQueueSize: 39
           - __MIN_OF_PeakDriverQueueSize: 8
         - PendingTime: 0ns
           - InputEmptyTime: 8.806ms
             - __MAX_OF_InputEmptyTime: 8.819ms
             - __MIN_OF_InputEmptyTime: 8.791ms
             - FirstInputEmptyTime: 8.806ms
               - __MAX_OF_FirstInputEmptyTime: 8.819ms
               - __MIN_OF_FirstInputEmptyTime: 8.791ms
           - PreconditionBlockTime: 20.114ms
             - __MAX_OF_PreconditionBlockTime: 20.119ms
             - __MIN_OF_PreconditionBlockTime: 20.111ms
         - ScheduleCount: 0
         - ScheduleTime: 28.922ms
           - __MAX_OF_ScheduleTime: 28.937ms
           - __MIN_OF_ScheduleTime: 28.905ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        ANALYTIC_SINK (plan_node_id=5):
          CommonMetrics:
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 10.913us
               - __MAX_OF_OperatorTotalTime: 17.579us
               - __MIN_OF_OperatorTotalTime: 7.032us
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
             - AggregateFunctions: row_number()
             - PartitionKeys: 4: p_brand
             - ProcessMode: Streaming/Cumulative
             - ColumnResizeTime: 0ns
             - PartitionSearchTime: 0ns
             - PeakBufferedRows: 0
             - PeerGroupSearchTime: 0ns
             - RemoveUnusedRowsCount: 0
             - RemoveUnusedTotalRows: 0
        LOCAL_PARALLEL_MERGE_SOURCE (plan_node_id=4):
          CommonMetrics:
             - OperatorTotalTime: 3.760us
               - __MAX_OF_OperatorTotalTime: 5.998us
               - __MIN_OF_OperatorTotalTime: 684ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - Limit: -1
             - Offset: 0
             - StreamingBatchSize: 16384
             - LateMaterializationMaxBufferChunkNum: 0
             - OverallStageCount: 0
               - 1-InitStageCount: 0
               - 2-PrepareStageCount: 0
               - 3-ProcessStageCount: 0
               - 4-SplitChunkStageCount: 0
               - 5-FetchChunkStageCount: 0
               - 6-PendingStageCount: 0
               - 7-FinishedStageCount: 0
             - OverallStageTime: 0ns
               - 1-InitStageTime: 0ns
               - 2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 0ns
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 0ns
               - 4-SplitChunkStageTime: 0ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 0ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 0ns
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 0ns
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 28.790ms
           - __MAX_OF_DriverTotalTime: 28.954ms
           - __MIN_OF_DriverTotalTime: 28.574ms
         - PeakDriverQueueSize: 174
           - __MAX_OF_PeakDriverQueueSize: 29
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 28.789ms
             - __MAX_OF_InputEmptyTime: 28.954ms
             - __MIN_OF_InputEmptyTime: 28.572ms
             - FirstInputEmptyTime: 28.789ms
               - __MAX_OF_FirstInputEmptyTime: 28.954ms
               - __MIN_OF_FirstInputEmptyTime: 28.572ms
         - ScheduleCount: 0
         - ScheduleTime: 28.790ms
           - __MAX_OF_ScheduleTime: 28.954ms
           - __MIN_OF_ScheduleTime: 28.574ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_SORT_SINK (plan_node_id=4):
          CommonMetrics:
             - OperatorTotalTime: 7.025us
               - __MAX_OF_OperatorTotalTime: 9.190us
               - __MIN_OF_OperatorTotalTime: 5.734us
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
             - MaxBufferedBytes: 268435456
             - MaxBufferedRows: 1073741824
             - SortKeys: 4: p_brand ASC, 8: p_retailprice DESC
             - SortType: All
             - BuildingTime: 0ns
             - InputRequiredMemory: 0.000 B
             - MergingTime: 0ns
             - NumSortedRuns: 0
             - OutputTime: 0ns
             - SortingCnt: 0
             - SortingTime: 0ns
        EXCHANGE_SOURCE (plan_node_id=3):
          CommonMetrics:
             - OperatorTotalTime: 13.057us
               - __MAX_OF_OperatorTotalTime: 23.036us
               - __MIN_OF_OperatorTotalTime: 8.861us
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
             - ReceiverProcessTotalTime: 0ns
             - RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 6:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: fe28a2e5-8a09-11f0-94e0-00163e341b9d
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.642ms
       - InitialProcessDriverCount: 211
       - InitialProcessMem: 5.725 GB
       - InstanceAllocatedMemoryUsage: 524.709 MB
       - InstanceDeallocatedMemoryUsage: 443.975 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 171.953 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=2):
         - IsGroupExecution: false
         - ActiveTime: 0ns
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 21.356ms
           - __MAX_OF_DriverTotalTime: 21.417ms
           - __MIN_OF_DriverTotalTime: 21.162ms
         - PeakDriverQueueSize: 262
           - __MAX_OF_PeakDriverQueueSize: 24
           - __MIN_OF_PeakDriverQueueSize: 9
         - PendingTime: 0ns
           - InputEmptyTime: 21.132ms
             - __MAX_OF_InputEmptyTime: 21.161ms
             - __MIN_OF_InputEmptyTime: 21.102ms
             - FirstInputEmptyTime: 21.132ms
               - __MAX_OF_FirstInputEmptyTime: 21.161ms
               - __MIN_OF_FirstInputEmptyTime: 21.102ms
         - ScheduleCount: 0
         - ScheduleTime: 21.356ms
           - __MAX_OF_ScheduleTime: 21.417ms
           - __MIN_OF_ScheduleTime: 21.162ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=3):
          CommonMetrics:
             - OperatorTotalTime: 2.980us
               - __MAX_OF_OperatorTotalTime: 30.915us
               - __MIN_OF_OperatorTotalTime: 708ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: fe28a2e58a0911f0-94e000163e341b9c
             - DestID: 3
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
             - NetworkTime: 0ns
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 0ns
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 0ns
             - RpcCount: 0
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 276.533us
        LOCAL_PARTITION_TOPN_SOURCE (plan_node_id=2):
          CommonMetrics:
             - OperatorTotalTime: 540ns
               - __MAX_OF_OperatorTotalTime: 911ns
               - __MIN_OF_OperatorTotalTime: 307ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 17.296ms
           - __MAX_OF_ActiveTime: 23.095ms
           - __MIN_OF_ActiveTime: 10.398ms
         - BlockByInputEmpty: 10
           - __MAX_OF_BlockByInputEmpty: 1
           - __MIN_OF_BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 22.961ms
           - __MAX_OF_DriverTotalTime: 23.428ms
           - __MIN_OF_DriverTotalTime: 21.737ms
         - PeakDriverQueueSize: 151
           - __MAX_OF_PeakDriverQueueSize: 35
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 3.715ms
             - __MAX_OF_InputEmptyTime: 12.727ms
             - __MIN_OF_InputEmptyTime: 0ns
             - FirstInputEmptyTime: 3.715ms
               - __MAX_OF_FirstInputEmptyTime: 12.727ms
               - __MIN_OF_FirstInputEmptyTime: 0ns
         - ScheduleCount: 26
           - __MAX_OF_ScheduleCount: 2
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 5.665ms
           - __MAX_OF_ScheduleTime: 12.825ms
           - __MIN_OF_ScheduleTime: 15.472us
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_PARTITION_TOPN_SINK (plan_node_id=2):
          CommonMetrics:
             - OperatorTotalTime: 12.200ms
               - __MAX_OF_OperatorTotalTime: 17.744ms
               - __MIN_OF_OperatorTotalTime: 8.577ms
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 237
               - __MAX_OF_PushChunkNum: 23
               - __MIN_OF_PushChunkNum: 10
             - PushRowNum: 779.520K (779520)
               - __MAX_OF_PushRowNum: 74.569K (74569)
               - __MIN_OF_PushRowNum: 33.631K (33631)
             - PushTotalTime: 12.187ms
               - __MAX_OF_PushTotalTime: 17.733ms
               - __MIN_OF_PushTotalTime: 8.567ms
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - IsPassThrough: No
             - ChunkBufferPeakMem: 0.000 B
             - ChunkBufferPeakSize: 0.000 B
             - PartitionNum: 0
        PROJECT (plan_node_id=1):
          CommonMetrics:
             - OperatorTotalTime: 61.598us
               - __MAX_OF_OperatorTotalTime: 121.382us
               - __MIN_OF_OperatorTotalTime: 38.653us
             - OutputChunkBytes: 48.140 MB
               - __MAX_OF_OutputChunkBytes: 4.604 MB
               - __MIN_OF_OutputChunkBytes: 2.077 MB
             - PullChunkNum: 237
               - __MAX_OF_PullChunkNum: 23
               - __MIN_OF_PullChunkNum: 10
             - PullRowNum: 779.520K (779520)
               - __MAX_OF_PullRowNum: 74.569K (74569)
               - __MIN_OF_PullRowNum: 33.631K (33631)
             - PullTotalTime: 2.197us
               - __MAX_OF_PullTotalTime: 3.459us
               - __MIN_OF_PullTotalTime: 1.395us
             - PushChunkNum: 237
               - __MAX_OF_PushChunkNum: 23
               - __MIN_OF_PushChunkNum: 10
             - PushRowNum: 779.520K (779520)
               - __MAX_OF_PushRowNum: 74.569K (74569)
               - __MIN_OF_PushRowNum: 33.631K (33631)
             - PushTotalTime: 55.240us
               - __MAX_OF_PushTotalTime: 113.397us
               - __MIN_OF_PushTotalTime: 33.376us
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 1.429us
               - __MAX_OF_CommonSubExprComputeTime: 2.544us
               - __MIN_OF_CommonSubExprComputeTime: 616ns
             - ExprComputeTime: 24.380us
               - __MAX_OF_ExprComputeTime: 41.761us
               - __MIN_OF_ExprComputeTime: 14.492us
        CHUNK_ACCUMULATE (plan_node_id=0):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 22.750us
               - __MAX_OF_OperatorTotalTime: 42.721us
               - __MIN_OF_OperatorTotalTime: 7.842us
             - OutputChunkBytes: 48.140 MB
               - __MAX_OF_OutputChunkBytes: 4.604 MB
               - __MIN_OF_OutputChunkBytes: 2.077 MB
             - PullChunkNum: 237
               - __MAX_OF_PullChunkNum: 23
               - __MIN_OF_PullChunkNum: 10
             - PullRowNum: 779.520K (779520)
               - __MAX_OF_PullRowNum: 74.569K (74569)
               - __MIN_OF_PullRowNum: 33.631K (33631)
             - PullTotalTime: 2.329us
               - __MAX_OF_PullTotalTime: 4.277us
               - __MIN_OF_PullTotalTime: 1.411us
             - PushChunkNum: 244
               - __MAX_OF_PushChunkNum: 24
               - __MIN_OF_PushChunkNum: 10
             - PushRowNum: 803.055K (803055)
               - __MAX_OF_PushRowNum: 77.937K (77937)
               - __MIN_OF_PushRowNum: 33.631K (33631)
             - PushTotalTime: 12.321us
               - __MAX_OF_PushTotalTime: 25.919us
               - __MIN_OF_PushTotalTime: 5.802us
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=0):
          CommonMetrics:
             - JoinRuntimeFilterEvaluate: 0
             - JoinRuntimeFilterHashTime: 0ns
             - JoinRuntimeFilterInputRows: 0
             - JoinRuntimeFilterOutputRows: 0
             - JoinRuntimeFilterTime: 0ns
             - OperatorTotalTime: 5.239ms
               - __MAX_OF_OperatorTotalTime: 14.695ms
               - __MIN_OF_OperatorTotalTime: 1.429ms
             - OutputChunkBytes: 49.593 MB
               - __MAX_OF_OutputChunkBytes: 4.812 MB
               - __MIN_OF_OutputChunkBytes: 2.077 MB
             - PullChunkNum: 244
               - __MAX_OF_PullChunkNum: 24
               - __MIN_OF_PullChunkNum: 10
             - PullRowNum: 803.055K (803055)
               - __MAX_OF_PullRowNum: 77.937K (77937)
               - __MIN_OF_PullRowNum: 33.631K (33631)
             - PullTotalTime: 4.497ms
               - __MAX_OF_PullTotalTime: 13.945ms
               - __MIN_OF_PullTotalTime: 714.017us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - Predicates: 6: p_size >= 10
             - Rollup: part
             - SharedScan: False
             - Table: part
             - AccessPathHits: 0
             - AccessPathUnhits: 0
             - BytesRead: 126.407 MB
               - __MAX_OF_BytesRead: 1.980 MB
               - __MIN_OF_BytesRead: 1.970 MB
             - CachedPagesNum: 1.856K (1856)
               - __MAX_OF_CachedPagesNum: 29
               - __MIN_OF_CachedPagesNum: 29
             - ChunkBufferCapacity: 1.024K (1024)
             - CompressedBytesRead: 0.000 B
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - IOTaskExecTime: 5.336ms
               - __MAX_OF_IOTaskExecTime: 16.059ms
               - __MIN_OF_IOTaskExecTime: 3.502ms
               - CreateSegmentIter: 31.806us
                 - __MAX_OF_CreateSegmentIter: 56.120us
                 - __MIN_OF_CreateSegmentIter: 18.350us
               - DictDecode: 397.243us
                 - __MAX_OF_DictDecode: 552.281us
                 - __MIN_OF_DictDecode: 256.905us
               - GetDelVec: 0ns
               - GetDeltaColumnGroup: 2.495us
                 - __MAX_OF_GetDeltaColumnGroup: 11.417us
                 - __MIN_OF_GetDeltaColumnGroup: 747ns
               - GetRowsets: 3.457us
                 - __MAX_OF_GetRowsets: 6.150us
                 - __MIN_OF_GetRowsets: 2.072us
               - IOTime: 0ns
               - LateMaterialize: 1.348ms
                 - __MAX_OF_LateMaterialize: 11.337ms
                 - __MIN_OF_LateMaterialize: 814.913us
               - ReadPKIndex: 0ns
               - SegmentInit: 178.546us
                 - __MAX_OF_SegmentInit: 3.881ms
                 - __MIN_OF_SegmentInit: 77.325us
                 - BitmapIndexFilter: 0ns
                 - BitmapIndexFilterRows: 0
                 - BitmapIndexIteratorInit: 4.893us
                   - __MAX_OF_BitmapIndexIteratorInit: 23.462us
                   - __MIN_OF_BitmapIndexIteratorInit: 2.717us
                 - BloomFilterFilter: 518ns
                   - __MAX_OF_BloomFilterFilter: 1.062us
                   - __MIN_OF_BloomFilterFilter: 293ns
                 - BloomFilterFilterRows: 0
                 - ColumnIteratorInit: 49.389us
                   - __MAX_OF_ColumnIteratorInit: 71.263us
                   - __MIN_OF_ColumnIteratorInit: 35.375us
                 - GetVectorRowRangesTime: 0ns
                 - GinFilter: 0ns
                 - GinFilterRows: 0
                 - ProcessVectorDistanceAndIdTime: 0ns
                 - RemainingRowsAfterShortKeyFilter: 2.000M (2000000)
                   - __MAX_OF_RemainingRowsAfterShortKeyFilter: 31.251K (31251)
                   - __MIN_OF_RemainingRowsAfterShortKeyFilter: 31.249K (31249)
                 - SegmentRuntimeZoneMapFilterRows: 0
                 - SegmentZoneMapFilterRows: 0
                 - ShortKeyFilter: 880ns
                   - __MAX_OF_ShortKeyFilter: 3.394us
                   - __MIN_OF_ShortKeyFilter: 501ns
                 - ShortKeyFilterRows: 0
                 - ShortKeyRangeNumber: 0
                 - VectorIndexFilterRows: 0
                 - VectorSearchTime: 0ns
                 - ZoneMapIndexFilterRows: 0
                 - ZoneMapIndexFiter: 6.906us
                   - __MAX_OF_ZoneMapIndexFiter: 11.950us
                   - __MIN_OF_ZoneMapIndexFiter: 4.880us
               - SegmentRead: 2.995ms
                 - __MAX_OF_SegmentRead: 10.461ms
                 - __MIN_OF_SegmentRead: 1.532ms
                 - BlockFetch: 2.418ms
                   - __MAX_OF_BlockFetch: 9.791ms
                   - __MIN_OF_BlockFetch: 940.891us
                 - BlockFetchCount: 512
                   - __MAX_OF_BlockFetchCount: 8
                   - __MIN_OF_BlockFetchCount: 8
                 - BlockSeek: 6.285us
                   - __MAX_OF_BlockSeek: 12.065us
                   - __MIN_OF_BlockSeek: 4.078us
                 - BlockSeekCount: 1.408K (1408)
                   - __MAX_OF_BlockSeekCount: 22
                   - __MIN_OF_BlockSeekCount: 22
                 - ChunkCopy: 517.863us
                   - __MAX_OF_ChunkCopy: 598.813us
                   - __MIN_OF_ChunkCopy: 408.064us
                 - DecompressT: 0ns
                 - DelVecFilterRows: 0
                 - PredFilter: 26.228us
                   - __MAX_OF_PredFilter: 37.273us
                   - __MIN_OF_PredFilter: 18.535us
                 - PredFilterRows: 359.342K (359342)
                   - __MAX_OF_PredFilterRows: 5.775K (5775)
                   - __MIN_OF_PredFilterRows: 5.501K (5501)
                 - RowsetsReadCount: 128
                   - __MAX_OF_RowsetsReadCount: 2
                   - __MIN_OF_RowsetsReadCount: 2
                 - SegmentsReadCount: 64
                   - __MAX_OF_SegmentsReadCount: 1
                   - __MIN_OF_SegmentsReadCount: 1
                 - TotalColumnsDataPageCount: 1.792K (1792)
                   - __MAX_OF_TotalColumnsDataPageCount: 28
                   - __MIN_OF_TotalColumnsDataPageCount: 28
             - IOTaskWaitTime: 1.700ms
               - __MAX_OF_IOTaskWaitTime: 13.018ms
               - __MIN_OF_IOTaskWaitTime: 26.528us
             - MorselsCount: 64
               - __MAX_OF_MorselsCount: 4
               - __MIN_OF_MorselsCount: 4
             - PeakChunkBufferMemoryUsage: 114.995 MB
             - PeakChunkBufferSize: 27
             - PeakIOTasks: 3
               - __MAX_OF_PeakIOTasks: 4
               - __MIN_OF_PeakIOTasks: 2
             - PeakScanTaskQueueSize: 138
               - __MAX_OF_PeakScanTaskQueueSize: 17
               - __MIN_OF_PeakScanTaskQueueSize: 0
             - PrepareChunkSourceTime: 976.063us
               - __MAX_OF_PrepareChunkSourceTime: 5.303ms
               - __MIN_OF_PrepareChunkSourceTime: 507.112us
             - PushdownAccessPaths: 0
             - PushdownPredicates: 1
             - RawRowsRead: 2.000M (2000000)
               - __MAX_OF_RawRowsRead: 31.251K (31251)
               - __MIN_OF_RawRowsRead: 31.249K (31249)
             - ReadPagesNum: 1.856K (1856)
               - __MAX_OF_ReadPagesNum: 29
               - __MIN_OF_ReadPagesNum: 29
             - RowsRead: 1.641M (1640658)
               - __MAX_OF_RowsRead: 25.749K (25749)
               - __MIN_OF_RowsRead: 25.475K (25475)
             - RuntimeFilterEvalTime: 0ns
             - RuntimeFilterInputRows: 0
             - RuntimeFilterOutputRows: 0
             - ScanTime: 7.037ms
               - __MAX_OF_ScanTime: 18.275ms
               - __MIN_OF_ScanTime: 3.581ms
             - SubmitTaskCount: 64
               - __MAX_OF_SubmitTaskCount: 4
               - __MIN_OF_SubmitTaskCount: 4
             - SubmitTaskTime: 3.394ms
               - __MAX_OF_SubmitTaskTime: 13.096ms
               - __MIN_OF_SubmitTaskTime: 4.737us
             - TabletCount: 64
             - UncompressedBytesRead: 0.000 B
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 42.252us
           - __MAX_OF_ActiveTime: 60.324us
           - __MIN_OF_ActiveTime: 24.519us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 201.178us
           - __MAX_OF_DriverTotalTime: 303.974us
           - __MIN_OF_DriverTotalTime: 116.524us
         - PeakDriverQueueSize: 64
           - __MAX_OF_PeakDriverQueueSize: 7
           - __MIN_OF_PeakDriverQueueSize: 0
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=0):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 376ns
               - __MAX_OF_OperatorTotalTime: 842ns
               - __MIN_OF_OperatorTotalTime: 264ns
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
             - OperatorTotalTime: 42.825us
               - __MAX_OF_OperatorTotalTime: 59.920us
               - __MIN_OF_OperatorTotalTime: 25.712us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 37.307us
               - __MAX_OF_PullTotalTime: 53.771us
               - __MIN_OF_PullTotalTime: 21.322us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.999us
               - __MAX_OF_CaptureTabletRowsetsTime: 21.029us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.591us
