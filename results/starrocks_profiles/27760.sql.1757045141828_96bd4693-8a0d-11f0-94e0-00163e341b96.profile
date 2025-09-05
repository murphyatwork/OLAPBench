Query:
  Summary:
     - Query ID: 96bd4693-8a0d-11f0-94e0-00163e341b96
     - Start Time: 2025-09-05 12:05:41
     - End Time: 2025-09-05 12:05:41
     - Total: 54ms
     - Query Type: Query
     - Query State: Finished
     - StarRocks Version: 3.5.4-1ce07c8
     - User: root
     - Default Db: tpch
     - Sql Statement: WITH StringProcessed AS (
    SELECT 
        p.p_partkey,
        CONCAT(
            'Part: ',
            p.p_name,
            ' | Manufacturer: ',
            p.p_mfgr,
            ' | Brand: ',
            p.p_brand,
            ' | Type: ',
            p.p_type,
            ' | Size: ',
            CAST(p.p_size AS VARCHAR),
            ' | Retail Price: $',
            CAST(p.p_retailprice AS VARCHAR),
            ' | Comment: ',
            p.p_comment
        ) AS processed_string
    FROM 
        part p
),
RegionSupplier AS (
    SELECT 
        r.r_name AS region_name,
        s.s_name AS supplier_name,
        s.s_address AS supplier_address
    FROM 
        supplier s
    JOIN 
        nation n ON s.s_nationkey = n.n_nationkey
    JOIN 
        region r ON n.n_regionkey = r.r_regionkey
),
CombinedData AS (
    SELECT 
        sp.processed_string,
        rs.region_name,
        rs.supplier_name,
        rs.supplier_address
    FROM 
        StringProcessed sp
    CROSS JOIN 
        RegionSupplier rs
)
SELECT 
    processed_string,
    region_name,
    supplier_name,
    supplier_address
FROM 
    CombinedData
WHERE 
    region_name LIKE '%West%'
ORDER BY 
    supplier_name, 
    processed_string;
     - Variables: parallel_fragment_exec_instance_num=1,max_parallel_scan_instance_num=-1,pipeline_dop=0,enable_adaptive_sink_dop=true,enable_runtime_adaptive_dop=false,runtime_profile_report_interval=10,resource_group=default_wg
     - NonDefaultSessionVariables: {"sql_mode_v2":{"defaultValue":32,"actualValue":34},"query_timeout":{"defaultValue":300,"actualValue":10},"prefer_compute_node":{"defaultValue":false,"actualValue":true},"enable_adaptive_sink_dop":{"defaultValue":false,"actualValue":true},"enable_profile":{"defaultValue":false,"actualValue":true}}
     - Collect Profile Time: 1ms
     - IsProfileAsync: true
  Planner:
     - -- Parser[1] 1ms
     - -- Total[1] 5ms
     -     -- Analyzer[1] 0
     -         -- Lock[1] 0
     -         -- AnalyzeDatabase[4] 0
     -         -- AnalyzeTemporaryTable[4] 0
     -         -- AnalyzeTable[4] 0
     -     -- Transformer[1] 0
     -     -- Optimizer[1] 3ms
     -         -- MVPreprocess[1] 0
     -         -- MVTextRewrite[1] 0
     -         -- RuleBaseOptimize[1] 2ms
     -         -- CostBaseOptimize[1] 0
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
     - -- Deploy[1] 20ms
     -     -- DeployLockInternalTime[1] 20ms
     -         -- DeploySerializeConcurrencyTime[5] 0
     -         -- DeployStageByStageTime[15] 0
     -         -- DeployWaitTime[15] 18ms
     -             -- DeployAsyncSendTime[5] 0
     - DeployDataSize: 54127
    Reason:
  Execution:
     - Topology: {"rootId":14,"nodes":[{"id":14,"name":"MERGE_EXCHANGE","properties":{"sinkIds":[],"displayMem":true},"children":[13]},{"id":13,"name":"SORT","properties":{"sinkIds":[14],"displayMem":true},"children":[12]},{"id":12,"name":"NEST_LOOP_JOIN","properties":{"displayMem":true},"children":[1,11]},{"id":1,"name":"PROJECT","properties":{"displayMem":false},"children":[0]},{"id":11,"name":"EXCHANGE","properties":{"displayMem":true},"children":[10]},{"id":0,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":10,"name":"PROJECT","properties":{"sinkIds":[11],"displayMem":false},"children":[9]},{"id":9,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[2,8]},{"id":2,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":8,"name":"EXCHANGE","properties":{"displayMem":true},"children":[7]},{"id":7,"name":"PROJECT","properties":{"sinkIds":[8],"displayMem":false},"children":[6]},{"id":6,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[3,5]},{"id":3,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":5,"name":"EXCHANGE","properties":{"displayMem":true},"children":[4]},{"id":4,"name":"OLAP_SCAN","properties":{"sinkIds":[5],"displayMem":false},"children":[]}]}
     - FrontendProfileMergeTime: 4.540ms
     - QueryAllocatedMemoryUsage: 648.487 MB
     - QueryCumulativeCpuTime: 357.924ms
     - QueryCumulativeNetworkTime: 898.857us
     - QueryCumulativeOperatorTime: 31.261ms
     - QueryCumulativeScanTime: 12.191ms
     - QueryDeallocatedMemoryUsage: 641.133 MB
     - QueryExecutionWallTime: 41.830ms
     - QueryPeakMemoryUsagePerNode: 156.134 MB
     - QueryPeakScheduleTime: 39.536ms
     - QuerySpillBytes: 0.000 B
     - QuerySumMemoryUsage: 156.134 MB
     - ResultDeliverTime: 0ns
    Fragment 0:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 96bd4693-8a0d-11f0-94e0-00163e341b97
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 996.792us
       - InitialProcessDriverCount: 0
       - InitialProcessMem: 10.687 GB
       - InstanceAllocatedMemoryUsage: 279.742 KB
       - InstanceDeallocatedMemoryUsage: 64.477 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 215.266 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 12.711us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 39.549ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 39.508ms
             - FirstInputEmptyTime: 39.508ms
         - ScheduleCount: 1
         - ScheduleTime: 39.536ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        RESULT_SINK (plan_node_id=-1):
          CommonMetrics:
             - IsFinalSink
             - OperatorTotalTime: 53.679us
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
             - OperatorTotalTime: 1.069us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        LOCAL_EXCHANGE_SOURCE (plan_node_id=14):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 11.433us
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
         - ActiveTime: 230.285us
           - __MAX_OF_ActiveTime: 836.750us
           - __MIN_OF_ActiveTime: 24.170us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 39.415ms
           - __MAX_OF_DriverTotalTime: 39.525ms
           - __MIN_OF_DriverTotalTime: 39.345ms
         - PeakDriverQueueSize: 30
           - __MAX_OF_PeakDriverQueueSize: 4
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 36.563ms
             - __MAX_OF_InputEmptyTime: 37.228ms
             - __MIN_OF_InputEmptyTime: 33.213ms
             - FirstInputEmptyTime: 2.256ms
               - __MAX_OF_FirstInputEmptyTime: 33.059ms
               - __MIN_OF_FirstInputEmptyTime: 86.347us
             - FollowupInputEmptyTime: 34.307ms
               - __MAX_OF_FollowupInputEmptyTime: 36.881ms
               - __MIN_OF_FollowupInputEmptyTime: 3.271ms
         - ScheduleCount: 77
           - __MAX_OF_ScheduleCount: 5
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 39.184ms
           - __MAX_OF_ScheduleTime: 39.338ms
           - __MIN_OF_ScheduleTime: 38.539ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 61
           - __MAX_OF_YieldByLocalWait: 4
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=14):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.370us
               - __MAX_OF_OperatorTotalTime: 15.493us
               - __MIN_OF_OperatorTotalTime: 279ns
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
        GLOBAL_PARALLEL_MERGE_SOURCE (plan_node_id=14):
          CommonMetrics:
             - OperatorTotalTime: 214.729us
               - __MAX_OF_OperatorTotalTime: 814.580us
               - __MIN_OF_OperatorTotalTime: 15.250us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 213.517us
               - __MAX_OF_PullTotalTime: 814.063us
               - __MIN_OF_PullTotalTime: 14.821us
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
             - OverallStageTime: 56.178us
               - __MAX_OF_OverallStageTime: 583.088us
               - __MIN_OF_OverallStageTime: 2.182us
               - 1-InitStageTime: 2.632us
                 - __MAX_OF_1-InitStageTime: 42.116us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 32.882us
                 - __MAX_OF_2-PrepareStageTime: 526.121us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 516ns
                 - __MAX_OF_3-ProcessStageTime: 8.264us
                 - __MIN_OF_3-ProcessStageTime: 0ns
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 207ns
                   - __MAX_OF_SortedRunProviderTime: 3.314us
                   - __MIN_OF_SortedRunProviderTime: 0ns
               - 4-SplitChunkStageTime: 1.511us
                 - __MAX_OF_4-SplitChunkStageTime: 9.642us
                 - __MIN_OF_4-SplitChunkStageTime: 299ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 17.068us
                 - __MAX_OF_5-FetchChunkStageTime: 247.071us
                 - __MIN_OF_5-FetchChunkStageTime: 354ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 103ns
                 - __MAX_OF_7-FinishedStageTime: 302ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 0ns
             - RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 1:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 96bd4693-8a0d-11f0-94e0-00163e341b98
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.662ms
       - InitialProcessDriverCount: 17
       - InitialProcessMem: 10.688 GB
       - InstanceAllocatedMemoryUsage: 636.801 MB
       - InstanceDeallocatedMemoryUsage: 634.152 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 151.377 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=4):
         - IsGroupExecution: false
         - ActiveTime: 110.270us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 29.381ms
         - PeakDriverQueueSize: 4
         - PendingTime: 0ns
           - InputEmptyTime: 28.941ms
             - FirstInputEmptyTime: 28.941ms
         - ScheduleCount: 1
         - ScheduleTime: 29.271ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=14):
          CommonMetrics:
             - OperatorTotalTime: 117.938us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: 96bd46938a0d11f0-94e000163e341b97
             - DestID: 14
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 292.927us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 331.400us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 292.927us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 322.140us
        LOCAL_EXCHANGE_SOURCE (plan_node_id=13):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 5.839us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
      Pipeline (id=3):
         - IsGroupExecution: false
         - ActiveTime: 244.602us
           - __MAX_OF_ActiveTime: 516.866us
           - __MIN_OF_ActiveTime: 23.015us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 28.940ms
           - __MAX_OF_DriverTotalTime: 28.997ms
           - __MIN_OF_DriverTotalTime: 28.923ms
         - PeakDriverQueueSize: 26
           - __MAX_OF_PeakDriverQueueSize: 4
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 28.471ms
             - __MAX_OF_InputEmptyTime: 28.654ms
             - __MIN_OF_InputEmptyTime: 28.170ms
             - FirstInputEmptyTime: 28.471ms
               - __MAX_OF_FirstInputEmptyTime: 28.654ms
               - __MIN_OF_FirstInputEmptyTime: 28.170ms
         - ScheduleCount: 62
           - __MAX_OF_ScheduleCount: 4
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 28.696ms
           - __MAX_OF_ScheduleTime: 28.902ms
           - __MIN_OF_ScheduleTime: 28.422ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 46
           - __MAX_OF_YieldByLocalWait: 3
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=13):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 2.556us
               - __MAX_OF_OperatorTotalTime: 33.472us
               - __MIN_OF_OperatorTotalTime: 300ns
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
        LOCAL_PARALLEL_MERGE_SOURCE (plan_node_id=13):
          CommonMetrics:
             - OperatorTotalTime: 229.936us
               - __MAX_OF_OperatorTotalTime: 494.979us
               - __MIN_OF_OperatorTotalTime: 11.652us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 229.202us
               - __MAX_OF_PullTotalTime: 494.226us
               - __MIN_OF_PullTotalTime: 10.991us
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
             - OverallStageTime: 41.582us
               - __MAX_OF_OverallStageTime: 469.966us
               - __MIN_OF_OverallStageTime: 4.342us
               - 1-InitStageTime: 4.693us
                 - __MAX_OF_1-InitStageTime: 75.095us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 23.648us
                 - __MAX_OF_2-PrepareStageTime: 378.380us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 4.441us
                 - __MAX_OF_3-ProcessStageTime: 17.700us
                 - __MIN_OF_3-ProcessStageTime: 2.293us
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 1.080us
                   - __MAX_OF_SortedRunProviderTime: 1.419us
                   - __MIN_OF_SortedRunProviderTime: 855ns
               - 4-SplitChunkStageTime: 1.818us
                 - __MAX_OF_4-SplitChunkStageTime: 17.512us
                 - __MIN_OF_4-SplitChunkStageTime: 304ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 5.863us
                 - __MAX_OF_5-FetchChunkStageTime: 16.595us
                 - __MIN_OF_5-FetchChunkStageTime: 280ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 60ns
                 - __MAX_OF_7-FinishedStageTime: 80ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
      Pipeline (id=2):
         - IsGroupExecution: false
         - ActiveTime: 6.948ms
           - __MAX_OF_ActiveTime: 11.695ms
           - __MIN_OF_ActiveTime: 739.725us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 23.938ms
           - __MAX_OF_DriverTotalTime: 28.729ms
           - __MIN_OF_DriverTotalTime: 17.737ms
         - PeakDriverQueueSize: 152
           - __MAX_OF_PeakDriverQueueSize: 17
           - __MIN_OF_PeakDriverQueueSize: 2
         - PendingTime: 0ns
           - PreconditionBlockTime: 16.802ms
             - __MAX_OF_PreconditionBlockTime: 16.806ms
             - __MIN_OF_PreconditionBlockTime: 16.799ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 16.990ms
           - __MAX_OF_ScheduleTime: 17.034ms
           - __MIN_OF_ScheduleTime: 16.960ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_SORT_SINK (plan_node_id=13):
          CommonMetrics:
             - OperatorTotalTime: 23.459us
               - __MAX_OF_OperatorTotalTime: 57.297us
               - __MIN_OF_OperatorTotalTime: 13.473us
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
             - SortKeys: 12: s_name ASC, 10: concat ASC
             - SortType: All
             - BuildingTime: 0ns
             - InputRequiredMemory: 0.000 B
             - MergingTime: 5.278us
               - __MAX_OF_MergingTime: 8.907us
               - __MIN_OF_MergingTime: 3.694us
             - NumSortedRuns: 0
             - OutputTime: 108ns
               - __MAX_OF_OutputTime: 272ns
               - __MIN_OF_OutputTime: 46ns
             - SortingCnt: 0
             - SortingTime: 0ns
        NESTLOOP_JOIN_PROBE (plan_node_id=12):
          CommonMetrics:
             - OperatorTotalTime: 9.948us
               - __MAX_OF_OperatorTotalTime: 14.621us
               - __MIN_OF_OperatorTotalTime: 7.903us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 877ns
               - __MAX_OF_PullTotalTime: 1.678us
               - __MIN_OF_PullTotalTime: 451ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - JoinConjuncts
             - JoinType: CROSS_JOIN
             - PermuteRows: 0
        PROJECT (plan_node_id=1):
          CommonMetrics:
             - OperatorTotalTime: 1.915ms
               - __MAX_OF_OperatorTotalTime: 3.299ms
               - __MIN_OF_OperatorTotalTime: 3.973us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 12
               - __MAX_OF_PushChunkNum: 1
               - __MIN_OF_PushChunkNum: 0
             - PushRowNum: 49.152K (49152)
               - __MAX_OF_PushRowNum: 4.096K (4096)
               - __MIN_OF_PushRowNum: 0
             - PushTotalTime: 1.906ms
               - __MAX_OF_PushTotalTime: 3.286ms
               - __MIN_OF_PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 144ns
               - __MAX_OF_CommonSubExprComputeTime: 305ns
               - __MIN_OF_CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 1.903ms
               - __MAX_OF_ExprComputeTime: 3.281ms
               - __MIN_OF_ExprComputeTime: 0ns
        OLAP_SCAN (plan_node_id=0):
          CommonMetrics:
             - JoinRuntimeFilterEvaluate: 0
             - JoinRuntimeFilterHashTime: 0ns
             - JoinRuntimeFilterInputRows: 0
             - JoinRuntimeFilterOutputRows: 0
             - JoinRuntimeFilterTime: 0ns
             - OperatorTotalTime: 5.476ms
               - __MAX_OF_OperatorTotalTime: 10.101ms
               - __MIN_OF_OperatorTotalTime: 1.232ms
             - OutputChunkBytes: 5.994 MB
               - __MAX_OF_OutputChunkBytes: 512.096 KB
               - __MIN_OF_OutputChunkBytes: 0.000 B
             - PullChunkNum: 12
               - __MAX_OF_PullChunkNum: 1
               - __MIN_OF_PullChunkNum: 0
             - PullRowNum: 49.152K (49152)
               - __MAX_OF_PullRowNum: 4.096K (4096)
               - __MIN_OF_PullRowNum: 0
             - PullTotalTime: 4.516ms
               - __MAX_OF_PullTotalTime: 9.242ms
               - __MIN_OF_PullTotalTime: 701.555us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - Rollup: part
             - SharedScan: False
             - Table: part
             - AccessPathHits: 0
             - AccessPathUnhits: 0
             - BytesRead: 106.690 MB
               - __MAX_OF_BytesRead: 3.813 MB
               - __MIN_OF_BytesRead: 0.000 B
             - CachedPagesNum: 1.176K (1176)
               - __MAX_OF_CachedPagesNum: 42
               - __MIN_OF_CachedPagesNum: 0
             - ChunkBufferCapacity: 1.024K (1024)
             - CompressedBytesRead: 0.000 B
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - IOTaskExecTime: 1.549ms
               - __MAX_OF_IOTaskExecTime: 4.385ms
               - __MIN_OF_IOTaskExecTime: 0ns
               - CreateSegmentIter: 8.744us
                 - __MAX_OF_CreateSegmentIter: 39.482us
                 - __MIN_OF_CreateSegmentIter: 0ns
               - GetDelVec: 0ns
               - GetDeltaColumnGroup: 1.239us
                 - __MAX_OF_GetDeltaColumnGroup: 10.855us
                 - __MIN_OF_GetDeltaColumnGroup: 0ns
               - GetRowsets: 1.528us
                 - __MAX_OF_GetRowsets: 5.946us
                 - __MIN_OF_GetRowsets: 0ns
               - IOTime: 0ns
               - ReadPKIndex: 0ns
               - SegmentInit: 60.712us
                 - __MAX_OF_SegmentInit: 171.370us
                 - __MIN_OF_SegmentInit: 0ns
                 - BitmapIndexFilter: 0ns
                 - BitmapIndexFilterRows: 0
                 - BitmapIndexIteratorInit: 2.328us
                   - __MAX_OF_BitmapIndexIteratorInit: 15.701us
                   - __MIN_OF_BitmapIndexIteratorInit: 0ns
                 - BloomFilterFilter: 0ns
                 - BloomFilterFilterRows: 0
                 - ColumnIteratorInit: 22.505us
                   - __MAX_OF_ColumnIteratorInit: 67.504us
                   - __MIN_OF_ColumnIteratorInit: 0ns
                 - GetVectorRowRangesTime: 0ns
                 - GinFilter: 0ns
                 - GinFilterRows: 0
                 - ProcessVectorDistanceAndIdTime: 0ns
                 - RemainingRowsAfterShortKeyFilter: 1.000M (1000000)
                   - __MAX_OF_RemainingRowsAfterShortKeyFilter: 31.251K (31251)
                   - __MIN_OF_RemainingRowsAfterShortKeyFilter: 0
                 - SegmentRuntimeZoneMapFilterRows: 0
                 - SegmentZoneMapFilterRows: 0
                 - ShortKeyFilter: 397ns
                   - __MAX_OF_ShortKeyFilter: 1.121us
                   - __MIN_OF_ShortKeyFilter: 0ns
                 - ShortKeyFilterRows: 0
                 - ShortKeyRangeNumber: 0
                 - VectorIndexFilterRows: 0
                 - VectorSearchTime: 0ns
                 - ZoneMapIndexFilterRows: 0
                 - ZoneMapIndexFiter: 745ns
                   - __MAX_OF_ZoneMapIndexFiter: 11.404us
                   - __MIN_OF_ZoneMapIndexFiter: 0ns
               - SegmentRead: 1.347ms
                 - __MAX_OF_SegmentRead: 3.432ms
                 - __MIN_OF_SegmentRead: 0ns
                 - BlockFetch: 1.361ms
                   - __MAX_OF_BlockFetch: 3.356ms
                   - __MIN_OF_BlockFetch: 0ns
                 - BlockFetchCount: 240
                   - __MAX_OF_BlockFetchCount: 8
                   - __MIN_OF_BlockFetchCount: 0
                 - BlockSeek: 22.484us
                   - __MAX_OF_BlockSeek: 64.740us
                   - __MIN_OF_BlockSeek: 0ns
                 - BlockSeekCount: 990
                   - __MAX_OF_BlockSeekCount: 33
                   - __MIN_OF_BlockSeekCount: 0
                 - ChunkCopy: 0ns
                 - DecompressT: 0ns
                 - DelVecFilterRows: 0
                 - PredFilter: 0ns
                 - PredFilterRows: 0
                 - RowsetsReadCount: 64
                   - __MAX_OF_RowsetsReadCount: 2
                   - __MIN_OF_RowsetsReadCount: 0
                 - SegmentsReadCount: 32
                   - __MAX_OF_SegmentsReadCount: 1
                   - __MIN_OF_SegmentsReadCount: 0
                 - TotalColumnsDataPageCount: 1.248K (1248)
                   - __MAX_OF_TotalColumnsDataPageCount: 39
                   - __MIN_OF_TotalColumnsDataPageCount: 0
             - IOTaskWaitTime: 1.235ms
               - __MAX_OF_IOTaskWaitTime: 8.541ms
               - __MIN_OF_IOTaskWaitTime: 0ns
             - MorselsCount: 64
               - __MAX_OF_MorselsCount: 4
               - __MIN_OF_MorselsCount: 4
             - PeakChunkBufferMemoryUsage: 0.000 B
             - PeakChunkBufferSize: 0
             - PeakIOTasks: 3
               - __MAX_OF_PeakIOTasks: 4
               - __MIN_OF_PeakIOTasks: 1
             - PeakScanTaskQueueSize: 104
               - __MAX_OF_PeakScanTaskQueueSize: 9
               - __MIN_OF_PeakScanTaskQueueSize: 5
             - PrepareChunkSourceTime: 684.676us
               - __MAX_OF_PrepareChunkSourceTime: 852.993us
               - __MIN_OF_PrepareChunkSourceTime: 572.156us
             - PushdownAccessPaths: 0
             - PushdownPredicates: 0
             - RawRowsRead: 875.000K (875000)
               - __MAX_OF_RawRowsRead: 31.251K (31251)
               - __MIN_OF_RawRowsRead: 0
             - ReadPagesNum: 1.176K (1176)
               - __MAX_OF_ReadPagesNum: 42
               - __MIN_OF_ReadPagesNum: 0
             - RowsRead: 875.000K (875000)
               - __MAX_OF_RowsRead: 31.251K (31251)
               - __MIN_OF_RowsRead: 0
             - RuntimeFilterEvalTime: 0ns
             - RuntimeFilterInputRows: 0
             - RuntimeFilterOutputRows: 0
             - ScanTime: 2.158ms
               - __MAX_OF_ScanTime: 11.450ms
               - __MIN_OF_ScanTime: 0ns
             - SubmitTaskCount: 64
               - __MAX_OF_SubmitTaskCount: 4
               - __MIN_OF_SubmitTaskCount: 4
             - SubmitTaskTime: 3.797ms
               - __MAX_OF_SubmitTaskTime: 8.636ms
               - __MIN_OF_SubmitTaskTime: 69.023us
             - TabletCount: 64
             - UncompressedBytesRead: 0.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 31.541us
           - __MAX_OF_ActiveTime: 55.003us
           - __MIN_OF_ActiveTime: 14.744us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 133.338us
           - __MAX_OF_DriverTotalTime: 243.920us
           - __MIN_OF_DriverTotalTime: 48.633us
         - PeakDriverQueueSize: 26
           - __MAX_OF_PeakDriverQueueSize: 4
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
             - OperatorTotalTime: 379ns
               - __MAX_OF_OperatorTotalTime: 548ns
               - __MIN_OF_OperatorTotalTime: 275ns
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
             - OperatorTotalTime: 31.700us
               - __MAX_OF_OperatorTotalTime: 52.867us
               - __MIN_OF_OperatorTotalTime: 15.505us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 26.614us
               - __MAX_OF_PullTotalTime: 47.270us
               - __MIN_OF_PullTotalTime: 12.161us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 11.227us
               - __MAX_OF_CaptureTabletRowsetsTime: 21.122us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.946us
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 19.511us
           - __MAX_OF_ActiveTime: 69.545us
           - __MIN_OF_ActiveTime: 10.713us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 17.151ms
           - __MAX_OF_DriverTotalTime: 17.344ms
           - __MIN_OF_DriverTotalTime: 17.066ms
         - PeakDriverQueueSize: 107
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 16.921ms
             - __MAX_OF_InputEmptyTime: 16.927ms
             - __MIN_OF_InputEmptyTime: 16.899ms
             - FirstInputEmptyTime: 16.921ms
               - __MAX_OF_FirstInputEmptyTime: 16.927ms
               - __MIN_OF_FirstInputEmptyTime: 16.899ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 17.132ms
           - __MAX_OF_ScheduleTime: 17.319ms
           - __MIN_OF_ScheduleTime: 17.044ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NESTLOOP_JOIN_BUILD (plan_node_id=12):
          CommonMetrics:
             - OperatorTotalTime: 19.387us
               - __MAX_OF_OperatorTotalTime: 61.543us
               - __MIN_OF_OperatorTotalTime: 13.075us
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
             - NumBuilders: 16
             - BuildChunks: 0
             - BuildRows: 0
        EXCHANGE_SOURCE (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 9.834us
               - __MAX_OF_OperatorTotalTime: 17.843us
               - __MIN_OF_OperatorTotalTime: 6.315us
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
             - ReceiverProcessTotalTime: 205ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.280us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 2:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 96bd4693-8a0d-11f0-94e0-00163e341b99
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 5.171ms
       - InitialProcessDriverCount: 82
       - InitialProcessMem: 10.691 GB
       - InstanceAllocatedMemoryUsage: 1.806 MB
       - InstanceDeallocatedMemoryUsage: 591.977 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.228 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 11.636us
           - __MAX_OF_ActiveTime: 47.938us
           - __MIN_OF_ActiveTime: 7.388us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 12.422ms
           - __MAX_OF_DriverTotalTime: 12.545ms
           - __MIN_OF_DriverTotalTime: 12.127ms
         - PeakDriverQueueSize: 449
           - __MAX_OF_PeakDriverQueueSize: 35
           - __MIN_OF_PeakDriverQueueSize: 19
         - PendingTime: 0ns
           - PreconditionBlockTime: 11.547ms
             - __MAX_OF_PreconditionBlockTime: 11.608ms
             - __MIN_OF_PreconditionBlockTime: 11.497ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 12.411ms
           - __MAX_OF_ScheduleTime: 12.526ms
           - __MIN_OF_ScheduleTime: 12.118ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 6.970us
               - __MAX_OF_OperatorTotalTime: 43.966us
               - __MIN_OF_OperatorTotalTime: 2.518us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: 96bd46938a0d11f0-94e000163e341b98
             - DestID: 11
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 185.157us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 336.673us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 185.157us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 380.202us
        PROJECT (plan_node_id=10):
          CommonMetrics:
             - OperatorTotalTime: 4.598us
               - __MAX_OF_OperatorTotalTime: 5.441us
               - __MIN_OF_OperatorTotalTime: 3.106us
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
        CHUNK_ACCUMULATE (plan_node_id=9):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 416ns
               - __MAX_OF_OperatorTotalTime: 640ns
               - __MIN_OF_OperatorTotalTime: 298ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=9):
          CommonMetrics:
             - OperatorTotalTime: 5.496us
               - __MAX_OF_OperatorTotalTime: 14.319us
               - __MIN_OF_OperatorTotalTime: 4.118us
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
        CHUNK_ACCUMULATE (plan_node_id=2):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 349ns
               - __MAX_OF_OperatorTotalTime: 566ns
               - __MIN_OF_OperatorTotalTime: 256ns
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
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 20.060us
               - __MAX_OF_OperatorTotalTime: 25.333us
               - __MIN_OF_OperatorTotalTime: 14.985us
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
         - ActiveTime: 24.170us
           - __MAX_OF_ActiveTime: 30.311us
           - __MIN_OF_ActiveTime: 17.947us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 11.696ms
           - __MAX_OF_DriverTotalTime: 11.781ms
           - __MIN_OF_DriverTotalTime: 11.623ms
         - PeakDriverQueueSize: 168
           - __MAX_OF_PeakDriverQueueSize: 18
           - __MIN_OF_PeakDriverQueueSize: 3
         - PendingTime: 0ns
           - PreconditionBlockTime: 11.459ms
             - __MAX_OF_PreconditionBlockTime: 11.468ms
             - __MIN_OF_PreconditionBlockTime: 11.449ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 11.671ms
           - __MAX_OF_ScheduleTime: 11.756ms
           - __MIN_OF_ScheduleTime: 11.598ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=2):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 368ns
               - __MAX_OF_OperatorTotalTime: 612ns
               - __MIN_OF_OperatorTotalTime: 266ns
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
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 26.349us
               - __MAX_OF_OperatorTotalTime: 31.452us
               - __MIN_OF_OperatorTotalTime: 20.254us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 19.535us
               - __MAX_OF_PullTotalTime: 25.059us
               - __MIN_OF_PullTotalTime: 14.451us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.974us
               - __MAX_OF_CaptureTabletRowsetsTime: 16.684us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.626us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 240.646us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 11.664ms
         - PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - InputEmptyTime: 11.375ms
             - FirstInputEmptyTime: 11.375ms
         - ScheduleCount: 1
         - ScheduleTime: 11.423ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=9):
          CommonMetrics:
             - OperatorTotalTime: 237.350us
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
             - JoinPredicates: 14: s_nationkey = 18: n_nationkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 4.160us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 16.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 1
             - RuntimeFilterBuildTime: 12.579us
             - RuntimeFilterNum: 0
        LOCAL_EXCHANGE_SOURCE (plan_node_id=9):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.802us
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
         - ActiveTime: 10.360us
           - __MAX_OF_ActiveTime: 22.087us
           - __MIN_OF_ActiveTime: 5.253us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 11.346ms
           - __MAX_OF_DriverTotalTime: 11.427ms
           - __MIN_OF_DriverTotalTime: 11.295ms
         - PeakDriverQueueSize: 107
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 11.166ms
             - __MAX_OF_InputEmptyTime: 11.171ms
             - __MIN_OF_InputEmptyTime: 11.138ms
             - FirstInputEmptyTime: 11.166ms
               - __MAX_OF_FirstInputEmptyTime: 11.171ms
               - __MIN_OF_FirstInputEmptyTime: 11.138ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 11.335ms
           - __MAX_OF_ScheduleTime: 11.405ms
           - __MIN_OF_ScheduleTime: 11.286ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=9):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 773ns
               - __MAX_OF_OperatorTotalTime: 4.351us
               - __MIN_OF_OperatorTotalTime: 312ns
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
        EXCHANGE_SOURCE (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 12.454us
               - __MAX_OF_OperatorTotalTime: 24.704us
               - __MIN_OF_OperatorTotalTime: 7.238us
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
             - ReceiverProcessTotalTime: 224ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.588us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 3:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 96bd4693-8a0d-11f0-94e0-00163e341b9a
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.932ms
       - InitialProcessDriverCount: 131
       - InitialProcessMem: 10.695 GB
       - InstanceAllocatedMemoryUsage: 1.799 MB
       - InstanceDeallocatedMemoryUsage: 622.516 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.191 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=3):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 12.378us
           - __MAX_OF_ActiveTime: 55.917us
           - __MIN_OF_ActiveTime: 6.841us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 6.870ms
           - __MAX_OF_DriverTotalTime: 6.966ms
           - __MIN_OF_DriverTotalTime: 6.629ms
         - PeakDriverQueueSize: 422
           - __MAX_OF_PeakDriverQueueSize: 35
           - __MIN_OF_PeakDriverQueueSize: 17
         - PendingTime: 0ns
           - PreconditionBlockTime: 5.932ms
             - __MAX_OF_PreconditionBlockTime: 5.971ms
             - __MIN_OF_PreconditionBlockTime: 5.895ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 6.857ms
           - __MAX_OF_ScheduleTime: 6.959ms
           - __MIN_OF_ScheduleTime: 6.616ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 8.565us
               - __MAX_OF_OperatorTotalTime: 51.971us
               - __MIN_OF_OperatorTotalTime: 2.440us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: 96bd46938a0d11f0-94e000163e341b99
             - DestID: 8
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 202.924us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 363.578us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 202.924us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 447.921us
        PROJECT (plan_node_id=7):
          CommonMetrics:
             - OperatorTotalTime: 4.367us
               - __MAX_OF_OperatorTotalTime: 6.279us
               - __MIN_OF_OperatorTotalTime: 2.578us
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
             - OperatorTotalTime: 400ns
               - __MAX_OF_OperatorTotalTime: 644ns
               - __MIN_OF_OperatorTotalTime: 315ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=6):
          CommonMetrics:
             - OperatorTotalTime: 5.099us
               - __MAX_OF_OperatorTotalTime: 9.355us
               - __MIN_OF_OperatorTotalTime: 3.523us
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
        CHUNK_ACCUMULATE (plan_node_id=3):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 356ns
               - __MAX_OF_OperatorTotalTime: 736ns
               - __MIN_OF_OperatorTotalTime: 175ns
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
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 21.185us
               - __MAX_OF_OperatorTotalTime: 26.115us
               - __MIN_OF_OperatorTotalTime: 14.342us
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
         - ActiveTime: 28.513us
           - __MAX_OF_ActiveTime: 37.702us
           - __MIN_OF_ActiveTime: 19.067us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 6.151ms
           - __MAX_OF_DriverTotalTime: 6.222ms
           - __MIN_OF_DriverTotalTime: 6.091ms
         - PeakDriverQueueSize: 136
           - __MAX_OF_PeakDriverQueueSize: 16
           - __MIN_OF_PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - PreconditionBlockTime: 5.858ms
             - __MAX_OF_PreconditionBlockTime: 5.867ms
             - __MIN_OF_PreconditionBlockTime: 5.849ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 6.122ms
           - __MAX_OF_ScheduleTime: 6.194ms
           - __MIN_OF_ScheduleTime: 6.055ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=3):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 349ns
               - __MAX_OF_OperatorTotalTime: 447ns
               - __MIN_OF_OperatorTotalTime: 268ns
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
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 31.413us
               - __MAX_OF_OperatorTotalTime: 39.614us
               - __MIN_OF_OperatorTotalTime: 21.669us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 23.219us
               - __MAX_OF_PullTotalTime: 31.624us
               - __MIN_OF_PullTotalTime: 15.104us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.090us
               - __MAX_OF_CaptureTabletRowsetsTime: 13.980us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.076us
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 228.894us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 6.202ms
         - PeakDriverQueueSize: 1
         - PendingTime: 0ns
           - InputEmptyTime: 5.722ms
             - FirstInputEmptyTime: 5.722ms
         - ScheduleCount: 1
         - ScheduleTime: 5.973ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=6):
          CommonMetrics:
             - OperatorTotalTime: 226.486us
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
             - JoinPredicates: 20: n_regionkey = 22: r_regionkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 3.071us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 16.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
             - PartitionNums: 16
             - RuntimeFilterBuildTime: 14.844us
             - RuntimeFilterNum: 0
        LOCAL_EXCHANGE_SOURCE (plan_node_id=6):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.843us
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
         - ActiveTime: 9.223us
           - __MAX_OF_ActiveTime: 22.615us
           - __MIN_OF_ActiveTime: 5.161us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 5.683ms
           - __MAX_OF_DriverTotalTime: 5.735ms
           - __MIN_OF_DriverTotalTime: 5.644ms
         - PeakDriverQueueSize: 81
           - __MAX_OF_PeakDriverQueueSize: 12
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 5.486ms
             - __MAX_OF_InputEmptyTime: 5.492ms
             - __MIN_OF_InputEmptyTime: 5.460ms
             - FirstInputEmptyTime: 5.486ms
               - __MAX_OF_FirstInputEmptyTime: 5.492ms
               - __MIN_OF_FirstInputEmptyTime: 5.460ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 5.674ms
           - __MAX_OF_ScheduleTime: 5.712ms
           - __MIN_OF_ScheduleTime: 5.625ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=6):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 791ns
               - __MAX_OF_OperatorTotalTime: 4.248us
               - __MIN_OF_OperatorTotalTime: 361ns
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
        EXCHANGE_SOURCE (plan_node_id=5):
          CommonMetrics:
             - OperatorTotalTime: 10.718us
               - __MAX_OF_OperatorTotalTime: 19.906us
               - __MIN_OF_OperatorTotalTime: 6.581us
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
             - ReceiverProcessTotalTime: 253ns
               - __MAX_OF_ReceiverProcessTotalTime: 4.062us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 4:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 96bd4693-8a0d-11f0-94e0-00163e341b9b
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.496ms
       - InitialProcessDriverCount: 180
       - InitialProcessMem: 10.698 GB
       - InstanceAllocatedMemoryUsage: 7.808 MB
       - InstanceDeallocatedMemoryUsage: 5.732 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 2.098 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 1.353ms
           - __MAX_OF_ActiveTime: 1.852ms
           - __MIN_OF_ActiveTime: 764.491us
         - BlockByInputEmpty: 8
           - __MAX_OF_BlockByInputEmpty: 1
           - __MIN_OF_BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 2.572ms
           - __MAX_OF_DriverTotalTime: 2.744ms
           - __MIN_OF_DriverTotalTime: 2.408ms
         - PeakDriverQueueSize: 286
           - __MAX_OF_PeakDriverQueueSize: 38
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PendingFinishTime: 1.023ms
             - __MAX_OF_PendingFinishTime: 1.404ms
             - __MIN_OF_PendingFinishTime: 425.844us
         - ScheduleCount: 25
           - __MAX_OF_ScheduleCount: 2
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 1.219ms
           - __MAX_OF_ScheduleTime: 1.670ms
           - __MIN_OF_ScheduleTime: 612.575us
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=5):
          CommonMetrics:
             - OperatorTotalTime: 8.921us
               - __MAX_OF_OperatorTotalTime: 61.027us
               - __MIN_OF_OperatorTotalTime: 1.492us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: 96bd46938a0d11f0-94e000163e341b9a
             - DestID: 5
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 217.849us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 405.860us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 217.849us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 906.199us
        CHUNK_ACCUMULATE (plan_node_id=4):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 2.338us
               - __MAX_OF_OperatorTotalTime: 3.068us
               - __MIN_OF_OperatorTotalTime: 1.862us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 469ns
               - __MAX_OF_PullTotalTime: 705ns
               - __MIN_OF_PullTotalTime: 374ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 1.399us
               - __MAX_OF_PushTotalTime: 1.906us
               - __MIN_OF_PushTotalTime: 1.028us
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=4):
          CommonMetrics:
             - OperatorTotalTime: 1.686ms
               - __MAX_OF_OperatorTotalTime: 2.124ms
               - __MIN_OF_OperatorTotalTime: 1.047ms
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 1.301ms
               - __MAX_OF_PullTotalTime: 1.755ms
               - __MIN_OF_PullTotalTime: 702.661us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - Predicates: 23: r_name LIKE '%West%'
             - Rollup: region
             - SharedScan: False
             - Table: region
             - AccessPathHits: 0
             - AccessPathUnhits: 0
             - BytesRead: 79.000 B
               - __MAX_OF_BytesRead: 20.000 B
               - __MIN_OF_BytesRead: 0.000 B
             - CachedPagesNum: 5
               - __MAX_OF_CachedPagesNum: 1
               - __MIN_OF_CachedPagesNum: 0
             - ChunkBufferCapacity: 1.024K (1024)
             - CompressedBytesRead: 0.000 B
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - IOTaskExecTime: 38.166us
               - __MAX_OF_IOTaskExecTime: 216.848us
               - __MIN_OF_IOTaskExecTime: 11.359us
               - CreateSegmentIter: 9.055us
                 - __MAX_OF_CreateSegmentIter: 44.807us
                 - __MIN_OF_CreateSegmentIter: 4.598us
               - GetDelVec: 0ns
               - GetDeltaColumnGroup: 189ns
                 - __MAX_OF_GetDeltaColumnGroup: 4.072us
                 - __MIN_OF_GetDeltaColumnGroup: 0ns
               - GetRowsets: 3.121us
                 - __MAX_OF_GetRowsets: 5.270us
                 - __MIN_OF_GetRowsets: 2.065us
               - IOTime: 0ns
               - ReadPKIndex: 0ns
               - SegmentInit: 7.309us
                 - __MAX_OF_SegmentInit: 138.067us
                 - __MIN_OF_SegmentInit: 0ns
                 - BitmapIndexFilter: 0ns
                 - BitmapIndexFilterRows: 0
                 - BitmapIndexIteratorInit: 280ns
                   - __MAX_OF_BitmapIndexIteratorInit: 6.411us
                   - __MIN_OF_BitmapIndexIteratorInit: 0ns
                 - BloomFilterFilter: 47ns
                   - __MAX_OF_BloomFilterFilter: 956ns
                   - __MIN_OF_BloomFilterFilter: 0ns
                 - BloomFilterFilterRows: 0
                 - ColumnIteratorInit: 3.257us
                   - __MAX_OF_ColumnIteratorInit: 52.865us
                   - __MIN_OF_ColumnIteratorInit: 0ns
                 - GetVectorRowRangesTime: 0ns
                 - GinFilter: 0ns
                 - GinFilterRows: 0
                 - ProcessVectorDistanceAndIdTime: 0ns
                 - RemainingRowsAfterShortKeyFilter: 5
                   - __MAX_OF_RemainingRowsAfterShortKeyFilter: 1
                   - __MIN_OF_RemainingRowsAfterShortKeyFilter: 0
                 - SegmentRuntimeZoneMapFilterRows: 0
                 - SegmentZoneMapFilterRows: 0
                 - ShortKeyFilter: 71ns
                   - __MAX_OF_ShortKeyFilter: 1.733us
                   - __MIN_OF_ShortKeyFilter: 0ns
                 - ShortKeyFilterRows: 0
                 - ShortKeyRangeNumber: 0
                 - VectorIndexFilterRows: 0
                 - VectorSearchTime: 0ns
                 - ZoneMapIndexFilterRows: 0
                 - ZoneMapIndexFiter: 433ns
                   - __MAX_OF_ZoneMapIndexFiter: 9.003us
                   - __MIN_OF_ZoneMapIndexFiter: 0ns
               - SegmentRead: 64ns
                 - __MAX_OF_SegmentRead: 1.650us
                 - __MIN_OF_SegmentRead: 0ns
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
                 - TotalColumnsDataPageCount: 10
                   - __MAX_OF_TotalColumnsDataPageCount: 2
                   - __MIN_OF_TotalColumnsDataPageCount: 0
             - IOTaskWaitTime: 218.825us
               - __MAX_OF_IOTaskWaitTime: 689.743us
               - __MIN_OF_IOTaskWaitTime: 15.605us
             - MorselsCount: 64
               - __MAX_OF_MorselsCount: 4
               - __MIN_OF_MorselsCount: 4
             - PeakChunkBufferMemoryUsage: 680.100 KB
             - PeakChunkBufferSize: 2
             - PeakIOTasks: 1
             - PeakScanTaskQueueSize: 45
               - __MAX_OF_PeakScanTaskQueueSize: 5
               - __MIN_OF_PeakScanTaskQueueSize: 1
             - PrepareChunkSourceTime: 523.613us
               - __MAX_OF_PrepareChunkSourceTime: 628.083us
               - __MIN_OF_PrepareChunkSourceTime: 425.054us
             - PushdownAccessPaths: 0
             - PushdownPredicates: 1
             - RawRowsRead: 0
             - ReadPagesNum: 5
               - __MAX_OF_ReadPagesNum: 1
               - __MIN_OF_ReadPagesNum: 0
             - RowsRead: 0
             - RuntimeFilterEvalTime: 0ns
             - RuntimeFilterInputRows: 0
             - RuntimeFilterOutputRows: 0
             - ScanTime: 256.992us
               - __MAX_OF_ScanTime: 741.229us
               - __MIN_OF_ScanTime: 28.116us
             - SubmitTaskCount: 64
               - __MAX_OF_SubmitTaskCount: 4
               - __MIN_OF_SubmitTaskCount: 4
             - SubmitTaskTime: 750.315us
               - __MAX_OF_SubmitTaskTime: 1.158ms
               - __MIN_OF_SubmitTaskTime: 175.640us
             - TabletCount: 64
             - UncompressedBytesRead: 0.000 B
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 27.469us
           - __MAX_OF_ActiveTime: 42.847us
           - __MIN_OF_ActiveTime: 12.464us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 125.557us
           - __MAX_OF_DriverTotalTime: 229.442us
           - __MIN_OF_DriverTotalTime: 30.455us
         - PeakDriverQueueSize: 28
           - __MAX_OF_PeakDriverQueueSize: 4
           - __MIN_OF_PeakDriverQueueSize: 0
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=4):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 402ns
               - __MAX_OF_OperatorTotalTime: 862ns
               - __MIN_OF_OperatorTotalTime: 152ns
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
             - OperatorTotalTime: 27.996us
               - __MAX_OF_OperatorTotalTime: 43.161us
               - __MIN_OF_OperatorTotalTime: 12.880us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 22.799us
               - __MAX_OF_PullTotalTime: 38.566us
               - __MIN_OF_PullTotalTime: 9.957us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 10.896us
               - __MAX_OF_CaptureTabletRowsetsTime: 26.827us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.680us
