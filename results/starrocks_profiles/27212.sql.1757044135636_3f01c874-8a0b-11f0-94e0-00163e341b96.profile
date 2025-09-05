Query:
  Summary:
     - Query ID: 3f01c874-8a0b-11f0-94e0-00163e341b96
     - Start Time: 2025-09-05 11:48:55
     - End Time: 2025-09-05 11:48:55
     - Total: 48ms
     - Query Type: Query
     - Query State: Finished
     - StarRocks Version: 3.5.4-1ce07c8
     - User: root
     - Default Db: tpch
     - Sql Statement: WITH PartDetails AS (
    SELECT 
        p.p_partkey,
        p.p_name,
        p.p_mfgr,
        LENGTH(p.p_name) AS name_length,
        UPPER(p.p_comment) AS upper_comment,
        CONCAT('Brand: ', p.p_brand, ', Type: ', p.p_type) AS brand_type,
        REPLACE(p.p_comment, 'quality', 'quality-assured') AS modified_comment
    FROM 
        part p
),
SupplierDetails AS (
    SELECT 
        s.s_suppkey,
        s.s_name,
        s.s_nationkey,
        SUBSTRING(s.s_address, 1, 20) AS short_address,
        CONCAT(SUBSTRING(s.s_phone, 1, 3), '-', SUBSTRING(s.s_phone, 4, 3), '-', SUBSTRING(s.s_phone, 7, 8)) AS formatted_phone
    FROM 
        supplier s
),
CustomerDetails AS (
    SELECT 
        c.c_custkey,
        c.c_name,
        c.c_mktsegment,
        LENGTH(c.c_name) AS cust_name_length,
        CONCAT(c.c_address, ' - ', c.c_phone) AS address_phone_combined
    FROM 
        customer c
)
SELECT 
    pd.p_name,
    std.s_name,
    cd.c_name,
    cd.cust_name_length,
    pd.name_length,
    pd.upper_comment,
    pd.brand_type,
    pd.modified_comment,
    std.short_address,
    std.formatted_phone,
    cd.address_phone_combined
FROM 
    PartDetails pd
JOIN 
    SupplierDetails std ON pd.p_partkey = std.s_nationkey
JOIN 
    CustomerDetails cd ON std.s_nationkey = cd.c_custkey
WHERE 
    pd.name_length > 10 AND
    std.formatted_phone LIKE '123-%'
ORDER BY 
    pd.p_partkey, std.s_name, cd.c_name;
     - Variables: parallel_fragment_exec_instance_num=1,max_parallel_scan_instance_num=-1,pipeline_dop=0,enable_adaptive_sink_dop=true,enable_runtime_adaptive_dop=false,runtime_profile_report_interval=10,resource_group=default_wg
     - NonDefaultSessionVariables: {"sql_mode_v2":{"defaultValue":32,"actualValue":34},"query_timeout":{"defaultValue":300,"actualValue":10},"prefer_compute_node":{"defaultValue":false,"actualValue":true},"enable_adaptive_sink_dop":{"defaultValue":false,"actualValue":true},"enable_profile":{"defaultValue":false,"actualValue":true}}
     - Collect Profile Time: 5ms
     - IsProfileAsync: true
  Planner:
     - -- Parser[1] 2ms
     - -- Total[1] 8ms
     -     -- Analyzer[1] 0
     -         -- Lock[1] 0
     -         -- AnalyzeDatabase[3] 0
     -         -- AnalyzeTemporaryTable[3] 0
     -         -- AnalyzeTable[3] 0
     -     -- Transformer[1] 1ms
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
     - -- Deploy[1] 21ms
     -     -- DeployLockInternalTime[1] 21ms
     -         -- DeploySerializeConcurrencyTime[4] 1ms
     -         -- DeployStageByStageTime[12] 0
     -         -- DeployWaitTime[12] 19ms
     -             -- DeployAsyncSendTime[4] 0
     - DeployDataSize: 75977
    Reason:
  Execution:
     - Topology: {"rootId":13,"nodes":[{"id":13,"name":"PROJECT","properties":{"sinkIds":[],"displayMem":false},"children":[12]},{"id":12,"name":"MERGE_EXCHANGE","properties":{"displayMem":true},"children":[11]},{"id":11,"name":"SORT","properties":{"sinkIds":[12],"displayMem":true},"children":[10]},{"id":10,"name":"PROJECT","properties":{"displayMem":false},"children":[9]},{"id":9,"name":"HASH_JOIN","properties":{"displayMem":true},"children":[1,8]},{"id":1,"name":"PROJECT","properties":{"displayMem":false},"children":[0]},{"id":8,"name":"EXCHANGE","properties":{"displayMem":true},"children":[7]},{"id":0,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":7,"name":"HASH_JOIN","properties":{"sinkIds":[8],"displayMem":true},"children":[3,6]},{"id":3,"name":"PROJECT","properties":{"displayMem":false},"children":[2]},{"id":6,"name":"EXCHANGE","properties":{"displayMem":true},"children":[5]},{"id":2,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]},{"id":5,"name":"PROJECT","properties":{"sinkIds":[6],"displayMem":false},"children":[4]},{"id":4,"name":"OLAP_SCAN","properties":{"displayMem":false},"children":[]}]}
     - FrontendProfileMergeTime: 3.337ms
     - QueryAllocatedMemoryUsage: 43.120 MB
     - QueryCumulativeCpuTime: 125.668ms
     - QueryCumulativeNetworkTime: 564.698us
     - QueryCumulativeOperatorTime: 6.787ms
     - QueryCumulativeScanTime: 1.534ms
     - QueryDeallocatedMemoryUsage: 37.993 MB
     - QueryExecutionWallTime: 28.961ms
     - QueryPeakMemoryUsagePerNode: 7.508 MB
     - QueryPeakScheduleTime: 24.133ms
     - QuerySpillBytes: 0.000 B
     - QuerySumMemoryUsage: 7.508 MB
     - ResultDeliverTime: 0ns
    Fragment 0:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 3f01c874-8a0b-11f0-94e0-00163e341b97
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 1.104ms
       - InitialProcessDriverCount: 16
       - InitialProcessMem: 9.237 GB
       - InstanceAllocatedMemoryUsage: 349.273 KB
       - InstanceDeallocatedMemoryUsage: 66.930 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 282.344 KB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 10.808us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 24.144ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 24.106ms
             - FirstInputEmptyTime: 24.106ms
         - ScheduleCount: 1
         - ScheduleTime: 24.133ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        RESULT_SINK (plan_node_id=-1):
          CommonMetrics:
             - IsFinalSink
             - OperatorTotalTime: 46.861us
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
             - OperatorTotalTime: 664ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        PROJECT (plan_node_id=13):
          CommonMetrics:
             - OperatorTotalTime: 3.956us
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
        LOCAL_EXCHANGE_SOURCE (plan_node_id=12):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 8.757us
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
         - ActiveTime: 83.709us
           - __MAX_OF_ActiveTime: 819.818us
           - __MIN_OF_ActiveTime: 17.481us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 24.073ms
           - __MAX_OF_DriverTotalTime: 24.125ms
           - __MIN_OF_DriverTotalTime: 24.053ms
         - PeakDriverQueueSize: 45
           - __MAX_OF_PeakDriverQueueSize: 8
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 22.534ms
             - __MAX_OF_InputEmptyTime: 22.934ms
             - __MIN_OF_InputEmptyTime: 22.130ms
             - FirstInputEmptyTime: 1.597ms
               - __MAX_OF_FirstInputEmptyTime: 22.130ms
               - __MIN_OF_FirstInputEmptyTime: 72.351us
             - FollowupInputEmptyTime: 20.937ms
               - __MAX_OF_FollowupInputEmptyTime: 22.511ms
               - __MIN_OF_FollowupInputEmptyTime: 0ns
         - ScheduleCount: 77
           - __MAX_OF_ScheduleCount: 5
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 23.990ms
           - __MAX_OF_ScheduleTime: 24.085ms
           - __MIN_OF_ScheduleTime: 23.263ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 61
           - __MAX_OF_YieldByLocalWait: 4
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=12):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.413us
               - __MAX_OF_OperatorTotalTime: 16.196us
               - __MIN_OF_OperatorTotalTime: 336ns
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
        GLOBAL_PARALLEL_MERGE_SOURCE (plan_node_id=12):
          CommonMetrics:
             - OperatorTotalTime: 69.175us
               - __MAX_OF_OperatorTotalTime: 798.025us
               - __MIN_OF_OperatorTotalTime: 6.281us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 68.086us
               - __MAX_OF_PullTotalTime: 797.085us
               - __MIN_OF_PullTotalTime: 5.764us
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
             - OverallStageTime: 55.250us
               - __MAX_OF_OverallStageTime: 779.140us
               - __MIN_OF_OverallStageTime: 2.213us
               - 1-InitStageTime: 1.865us
                 - __MAX_OF_1-InitStageTime: 29.848us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 45.839us
                 - __MAX_OF_2-PrepareStageTime: 733.427us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 539ns
                 - __MAX_OF_3-ProcessStageTime: 8.628us
                 - __MIN_OF_3-ProcessStageTime: 0ns
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 173ns
                   - __MAX_OF_SortedRunProviderTime: 2.776us
                   - __MIN_OF_SortedRunProviderTime: 0ns
               - 4-SplitChunkStageTime: 2.114us
                 - __MAX_OF_4-SplitChunkStageTime: 11.282us
                 - __MIN_OF_4-SplitChunkStageTime: 401ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 3.517us
                 - __MAX_OF_5-FetchChunkStageTime: 18.122us
                 - __MIN_OF_5-FetchChunkStageTime: 493ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 57ns
                 - __MAX_OF_7-FinishedStageTime: 101ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
             - PeakBufferMemoryBytes: 0.000 B
             - ReceiverProcessTotalTime: 0ns
             - RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 1:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 3f01c874-8a0b-11f0-94e0-00163e341b98
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 3.603ms
       - InitialProcessDriverCount: 65
       - InitialProcessMem: 9.242 GB
       - InstanceAllocatedMemoryUsage: 2.342 MB
       - InstanceDeallocatedMemoryUsage: 853.352 KB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.533 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=4):
         - IsGroupExecution: false
         - ActiveTime: 54.673us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 1
         - DriverTotalTime: 17.199ms
         - PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 16.790ms
             - FirstInputEmptyTime: 16.790ms
         - ScheduleCount: 1
         - ScheduleTime: 17.144ms
         - TotalDegreeOfParallelism: 1
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=12):
          CommonMetrics:
             - OperatorTotalTime: 60.289us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 1
             - DestFragments: 3f01c8748a0b11f0-94e000163e341b97
             - DestID: 12
             - PartType: UNPARTITIONED
             - BytesPassThrough: 0.000 B
             - BytesSent: 0.000 B
             - BytesUnsent: 0.000 B
             - CompressTime: 0ns
             - CompressedBytes: 0.000 B
             - NetworkBandwidth: 0.000 B/sec
             - NetworkTime: 168.700us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 203.248us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 168.700us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 363.692us
        LOCAL_EXCHANGE_SOURCE (plan_node_id=11):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 4.772us
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
         - ActiveTime: 180.367us
           - __MAX_OF_ActiveTime: 308.399us
           - __MIN_OF_ActiveTime: 58.736us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 16.787ms
           - __MAX_OF_DriverTotalTime: 16.813ms
           - __MIN_OF_DriverTotalTime: 16.778ms
         - PeakDriverQueueSize: 13
           - __MAX_OF_PeakDriverQueueSize: 2
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 16.468ms
             - __MAX_OF_InputEmptyTime: 16.562ms
             - __MIN_OF_InputEmptyTime: 16.297ms
             - FirstInputEmptyTime: 16.468ms
               - __MAX_OF_FirstInputEmptyTime: 16.562ms
               - __MIN_OF_FirstInputEmptyTime: 16.297ms
         - ScheduleCount: 62
           - __MAX_OF_ScheduleCount: 4
           - __MIN_OF_ScheduleCount: 3
         - ScheduleTime: 16.607ms
           - __MAX_OF_ScheduleTime: 16.732ms
           - __MIN_OF_ScheduleTime: 16.494ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 46
           - __MAX_OF_YieldByLocalWait: 3
           - __MIN_OF_YieldByLocalWait: 2
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_EXCHANGE_SINK (plan_node_id=11):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 1.919us
               - __MAX_OF_OperatorTotalTime: 22.727us
               - __MIN_OF_OperatorTotalTime: 370ns
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
        LOCAL_PARALLEL_MERGE_SOURCE (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 169.991us
               - __MAX_OF_OperatorTotalTime: 294.092us
               - __MIN_OF_OperatorTotalTime: 49.586us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 168.264us
               - __MAX_OF_PullTotalTime: 293.423us
               - __MIN_OF_PullTotalTime: 48.321us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - LateMaterialization: True
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
             - OverallStageTime: 26.412us
               - __MAX_OF_OverallStageTime: 287.444us
               - __MIN_OF_OverallStageTime: 4.182us
               - 1-InitStageTime: 3.703us
                 - __MAX_OF_1-InitStageTime: 59.260us
                 - __MIN_OF_1-InitStageTime: 0ns
               - 2-PrepareStageTime: 13.957us
                 - __MAX_OF_2-PrepareStageTime: 223.315us
                 - __MIN_OF_2-PrepareStageTime: 0ns
               - 3-ProcessStageTime: 2.890us
                 - __MAX_OF_3-ProcessStageTime: 8.757us
                 - __MIN_OF_3-ProcessStageTime: 1.880us
                 - LateMaterializationGenerateOrdinalTime: 0ns
                 - SortedRunProviderTime: 709ns
                   - __MAX_OF_SortedRunProviderTime: 1.068us
                   - __MIN_OF_SortedRunProviderTime: 566ns
               - 4-SplitChunkStageTime: 3.292us
                 - __MAX_OF_4-SplitChunkStageTime: 12.314us
                 - __MIN_OF_4-SplitChunkStageTime: 456ns
                 - LateMaterializationRestoreAccordingToOrdinalTime: 0ns
               - 5-FetchChunkStageTime: 1.435us
                 - __MAX_OF_5-FetchChunkStageTime: 16.690us
                 - __MIN_OF_5-FetchChunkStageTime: 210ns
               - 6-PendingStageTime: 0ns
               - 7-FinishedStageTime: 68ns
                 - __MAX_OF_7-FinishedStageTime: 95ns
                 - __MIN_OF_7-FinishedStageTime: 0ns
      Pipeline (id=2):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 23.580us
           - __MAX_OF_ActiveTime: 36.672us
           - __MIN_OF_ActiveTime: 13.368us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 16.270ms
           - __MAX_OF_DriverTotalTime: 16.326ms
           - __MIN_OF_DriverTotalTime: 16.237ms
         - PeakDriverQueueSize: 443
           - __MAX_OF_PeakDriverQueueSize: 42
           - __MIN_OF_PeakDriverQueueSize: 16
         - PendingTime: 0ns
           - PreconditionBlockTime: 16.017ms
             - __MAX_OF_PreconditionBlockTime: 16.073ms
             - __MIN_OF_PreconditionBlockTime: 15.969ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 16.247ms
           - __MAX_OF_ScheduleTime: 16.292ms
           - __MIN_OF_ScheduleTime: 16.204ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        LOCAL_SORT_SINK (plan_node_id=11):
          CommonMetrics:
             - OperatorTotalTime: 21.661us
               - __MAX_OF_OperatorTotalTime: 34.582us
               - __MIN_OF_OperatorTotalTime: 12.276us
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
             - SortKeys: 1: p_partkey ASC, 15: s_name ASC, 24: c_name ASC
             - SortType: All
             - BuildingTime: 0ns
             - InputRequiredMemory: 0.000 B
             - MergingTime: 5.010us
               - __MAX_OF_MergingTime: 18.119us
               - __MIN_OF_MergingTime: 3.022us
             - NumSortedRuns: 0
             - OutputTime: 73ns
               - __MAX_OF_OutputTime: 176ns
               - __MIN_OF_OutputTime: 40ns
             - SortingCnt: 0
             - SortingTime: 0ns
        PROJECT (plan_node_id=10):
          CommonMetrics:
             - OperatorTotalTime: 4.327us
               - __MAX_OF_OperatorTotalTime: 6.200us
               - __MIN_OF_OperatorTotalTime: 3.586us
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
             - OperatorTotalTime: 448ns
               - __MAX_OF_OperatorTotalTime: 661ns
               - __MIN_OF_OperatorTotalTime: 351ns
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
             - OperatorTotalTime: 12.195us
               - __MAX_OF_OperatorTotalTime: 17.317us
               - __MIN_OF_OperatorTotalTime: 10.074us
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
        PROJECT (plan_node_id=1):
          CommonMetrics:
             - OperatorTotalTime: 4.461us
               - __MAX_OF_OperatorTotalTime: 6.238us
               - __MIN_OF_OperatorTotalTime: 3.365us
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
        CHUNK_ACCUMULATE (plan_node_id=0):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 380ns
               - __MAX_OF_OperatorTotalTime: 649ns
               - __MIN_OF_OperatorTotalTime: 291ns
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
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 22.760us
               - __MAX_OF_OperatorTotalTime: 28.036us
               - __MIN_OF_OperatorTotalTime: 17.174us
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
         - ActiveTime: 26.048us
           - __MAX_OF_ActiveTime: 44.087us
           - __MIN_OF_ActiveTime: 18.924us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 16.207ms
           - __MAX_OF_DriverTotalTime: 16.314ms
           - __MIN_OF_DriverTotalTime: 16.133ms
         - PeakDriverQueueSize: 120
           - __MAX_OF_PeakDriverQueueSize: 15
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - PreconditionBlockTime: 15.924ms
             - __MAX_OF_PreconditionBlockTime: 15.941ms
             - __MIN_OF_PreconditionBlockTime: 15.908ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 16.181ms
           - __MAX_OF_ScheduleTime: 16.278ms
           - __MIN_OF_ScheduleTime: 16.105ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=0):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 403ns
               - __MAX_OF_OperatorTotalTime: 769ns
               - __MIN_OF_OperatorTotalTime: 288ns
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
             - RuntimeFilterDesc: <1: BloomFilter> 
             - OperatorTotalTime: 27.852us
               - __MAX_OF_OperatorTotalTime: 47.256us
               - __MIN_OF_OperatorTotalTime: 20.029us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 21.036us
               - __MAX_OF_PullTotalTime: 38.104us
               - __MIN_OF_PullTotalTime: 14.939us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 11.565us
               - __MAX_OF_CaptureTabletRowsetsTime: 19.367us
               - __MIN_OF_CaptureTabletRowsetsTime: 9.502us
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 39.925us
           - __MAX_OF_ActiveTime: 262.994us
           - __MIN_OF_ActiveTime: 18.896us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 15.918ms
           - __MAX_OF_DriverTotalTime: 16.120ms
           - __MIN_OF_DriverTotalTime: 15.812ms
         - PeakDriverQueueSize: 106
           - __MAX_OF_PeakDriverQueueSize: 14
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 15.634ms
             - __MAX_OF_InputEmptyTime: 15.640ms
             - __MIN_OF_InputEmptyTime: 15.602ms
             - FirstInputEmptyTime: 15.634ms
               - __MAX_OF_FirstInputEmptyTime: 15.640ms
               - __MIN_OF_FirstInputEmptyTime: 15.602ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 15.879ms
           - __MAX_OF_ScheduleTime: 16.067ms
           - __MIN_OF_ScheduleTime: 15.790ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=9):
          CommonMetrics:
             - OperatorTotalTime: 34.739us
               - __MAX_OF_OperatorTotalTime: 250.334us
               - __MIN_OF_OperatorTotalTime: 16.076us
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
             - JoinPredicates: 23: c_custkey = 17: s_nationkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 5.214us
               - __MAX_OF_BuildHashTableTime: 6.562us
               - __MIN_OF_BuildHashTableTime: 3.531us
             - BuildKeysPerBucket%: 0
             - CopyRightTableChunkTime: 0ns
             - HashTableMemoryUsage: 1.375 KB
               - __MAX_OF_HashTableMemoryUsage: 88.000 B
               - __MIN_OF_HashTableMemoryUsage: 88.000 B
             - PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MAX_OF_PartialRuntimeMembershipFilterBytes: 64.000 B
               - __MIN_OF_PartialRuntimeMembershipFilterBytes: 0.000 B
             - PartitionNums: 16
               - __MAX_OF_PartitionNums: 1
               - __MIN_OF_PartitionNums: 1
             - RuntimeFilterBuildTime: 6.413us
               - __MAX_OF_RuntimeFilterBuildTime: 14.943us
               - __MIN_OF_RuntimeFilterBuildTime: 3.717us
             - RuntimeFilterNum: 0
        EXCHANGE_SOURCE (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 11.476us
               - __MAX_OF_OperatorTotalTime: 24.815us
               - __MIN_OF_OperatorTotalTime: 8.242us
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
             - ReceiverProcessTotalTime: 225ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.606us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 2:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 3f01c874-8a0b-11f0-94e0-00163e341b99
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.773ms
       - InitialProcessDriverCount: 170
       - InitialProcessMem: 9.254 GB
       - InstanceAllocatedMemoryUsage: 2.011 MB
       - InstanceDeallocatedMemoryUsage: 1.149 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 1.314 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=2):
         - LocalRfWaitingSet: 1
         - IsGroupExecution: false
         - ActiveTime: 23.734us
           - __MAX_OF_ActiveTime: 62.271us
           - __MIN_OF_ActiveTime: 6.436us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 8.754ms
           - __MAX_OF_DriverTotalTime: 8.841ms
           - __MIN_OF_DriverTotalTime: 8.431ms
         - PeakDriverQueueSize: 480
           - __MAX_OF_PeakDriverQueueSize: 39
           - __MIN_OF_PeakDriverQueueSize: 18
         - PendingTime: 0ns
           - PreconditionBlockTime: 7.721ms
             - __MAX_OF_PreconditionBlockTime: 7.806ms
             - __MIN_OF_PreconditionBlockTime: 7.655ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 8.730ms
           - __MAX_OF_ScheduleTime: 8.832ms
           - __MIN_OF_ScheduleTime: 8.421ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=8):
          CommonMetrics:
             - OperatorTotalTime: 20.153us
               - __MAX_OF_OperatorTotalTime: 58.807us
               - __MIN_OF_OperatorTotalTime: 2.762us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 64
             - DestFragments: 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98, 3f01c8748a0b11f0-94e000163e341b98
             - DestID: 8
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
             - NetworkTime: 191.938us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 408.934us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 191.938us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 479.715us
        CHUNK_ACCUMULATE (plan_node_id=7):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 458ns
               - __MAX_OF_OperatorTotalTime: 699ns
               - __MIN_OF_OperatorTotalTime: 337ns
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
        HASH_JOIN_PROBE (plan_node_id=7):
          CommonMetrics:
             - OperatorTotalTime: 9.998us
               - __MAX_OF_OperatorTotalTime: 12.152us
               - __MIN_OF_OperatorTotalTime: 8.245us
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
        PROJECT (plan_node_id=3):
          CommonMetrics:
             - OperatorTotalTime: 4.392us
               - __MAX_OF_OperatorTotalTime: 6.005us
               - __MIN_OF_OperatorTotalTime: 2.805us
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
        CHUNK_ACCUMULATE (plan_node_id=2):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 385ns
               - __MAX_OF_OperatorTotalTime: 557ns
               - __MIN_OF_OperatorTotalTime: 336ns
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
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 22.732us
               - __MAX_OF_OperatorTotalTime: 28.155us
               - __MIN_OF_OperatorTotalTime: 18.304us
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
         - ActiveTime: 31.522us
           - __MAX_OF_ActiveTime: 40.640us
           - __MIN_OF_ActiveTime: 22.666us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 7.948ms
           - __MAX_OF_DriverTotalTime: 8.072ms
           - __MIN_OF_DriverTotalTime: 7.872ms
         - PeakDriverQueueSize: 152
           - __MAX_OF_PeakDriverQueueSize: 17
           - __MIN_OF_PeakDriverQueueSize: 2
         - PendingTime: 0ns
           - PreconditionBlockTime: 7.615ms
             - __MAX_OF_PreconditionBlockTime: 7.627ms
             - __MIN_OF_PreconditionBlockTime: 7.602ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 7.916ms
           - __MAX_OF_ScheduleTime: 8.050ms
           - __MIN_OF_ScheduleTime: 7.840ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        NOOP_SINK (plan_node_id=2):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 359ns
               - __MAX_OF_OperatorTotalTime: 401ns
               - __MIN_OF_OperatorTotalTime: 304ns
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
             - RuntimeFilterDesc: <0: BloomFilter> 
             - OperatorTotalTime: 34.776us
               - __MAX_OF_OperatorTotalTime: 44.775us
               - __MIN_OF_OperatorTotalTime: 24.744us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 26.295us
               - __MAX_OF_PullTotalTime: 35.222us
               - __MIN_OF_PullTotalTime: 18.611us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 1
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 11.120us
               - __MAX_OF_CaptureTabletRowsetsTime: 17.598us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.822us
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 79.544us
           - __MAX_OF_ActiveTime: 333.292us
           - __MIN_OF_ActiveTime: 41.929us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 7.569ms
           - __MAX_OF_DriverTotalTime: 7.853ms
           - __MIN_OF_DriverTotalTime: 7.499ms
         - PeakDriverQueueSize: 81
           - __MAX_OF_PeakDriverQueueSize: 12
           - __MIN_OF_PeakDriverQueueSize: 0
         - PendingTime: 0ns
           - InputEmptyTime: 7.334ms
             - __MAX_OF_InputEmptyTime: 7.343ms
             - __MIN_OF_InputEmptyTime: 7.304ms
             - FirstInputEmptyTime: 7.334ms
               - __MAX_OF_FirstInputEmptyTime: 7.343ms
               - __MIN_OF_FirstInputEmptyTime: 7.304ms
         - ScheduleCount: 16
           - __MAX_OF_ScheduleCount: 1
           - __MIN_OF_ScheduleCount: 1
         - ScheduleTime: 7.489ms
           - __MAX_OF_ScheduleTime: 7.529ms
           - __MIN_OF_ScheduleTime: 7.437ms
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        HASH_JOIN_BUILD (plan_node_id=7):
          CommonMetrics:
             - OperatorTotalTime: 73.970us
               - __MAX_OF_OperatorTotalTime: 325.319us
               - __MIN_OF_OperatorTotalTime: 39.057us
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
             - JoinPredicates: 1: p_partkey = 17: s_nationkey
             - JoinType: INNER_JOIN
             - BuildBuckets: 0
             - BuildConjunctEvaluateTime: 0ns
             - BuildHashTableTime: 2.298us
               - __MAX_OF_BuildHashTableTime: 3.301us
               - __MIN_OF_BuildHashTableTime: 1.359us
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
             - RuntimeFilterBuildTime: 5.766us
               - __MAX_OF_RuntimeFilterBuildTime: 16.470us
               - __MIN_OF_RuntimeFilterBuildTime: 3.051us
             - RuntimeFilterNum: 0
        EXCHANGE_SOURCE (plan_node_id=6):
          CommonMetrics:
             - OperatorTotalTime: 12.686us
               - __MAX_OF_OperatorTotalTime: 21.737us
               - __MIN_OF_OperatorTotalTime: 7.958us
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
             - ReceiverProcessTotalTime: 243ns
               - __MAX_OF_ReceiverProcessTotalTime: 3.900us
               - __MIN_OF_ReceiverProcessTotalTime: 0ns
             - RequestReceived: 1
               - __MAX_OF_RequestReceived: 1
               - __MIN_OF_RequestReceived: 0
             - WaitLockTime: 0ns
    Fragment 3:
       - BackendAddresses: 172.26.95.146:9060
       - InstanceIds: 3f01c874-8a0b-11f0-94e0-00163e341b9a
       - EnableEventScheduler: true
       - BackendNum: 1
       - BackendProfileMergeTime: 2.173ms
       - InitialProcessDriverCount: 130
       - InitialProcessMem: 9.246 GB
       - InstanceAllocatedMemoryUsage: 38.427 MB
       - InstanceDeallocatedMemoryUsage: 35.946 MB
       - InstanceNum: 1
       - InstancePeakMemoryUsage: 4.467 MB
       - JITCounter: 0
       - JITTotalCostTime: 0ns
       - QueryMemoryLimit: -1.000 B
      Pipeline (id=1):
         - IsGroupExecution: false
         - ActiveTime: 1.491ms
           - __MAX_OF_ActiveTime: 2.147ms
           - __MIN_OF_ActiveTime: 957.850us
         - BlockByInputEmpty: 35
           - __MAX_OF_BlockByInputEmpty: 4
           - __MIN_OF_BlockByInputEmpty: 1
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 3.123ms
           - __MAX_OF_DriverTotalTime: 3.232ms
           - __MIN_OF_DriverTotalTime: 2.885ms
         - PeakDriverQueueSize: 334
           - __MAX_OF_PeakDriverQueueSize: 39
           - __MIN_OF_PeakDriverQueueSize: 0
         - ScheduleCount: 52
           - __MAX_OF_ScheduleCount: 6
           - __MIN_OF_ScheduleCount: 2
         - ScheduleTime: 1.631ms
           - __MAX_OF_ScheduleTime: 2.262ms
           - __MIN_OF_ScheduleTime: 951.034us
         - TotalDegreeOfParallelism: 16
         - YieldByLocalWait: 0
         - YieldByPreempt: 0
         - YieldByTimeLimit: 0
        EXCHANGE_SINK (plan_node_id=6):
          CommonMetrics:
             - OperatorTotalTime: 9.472us
               - __MAX_OF_OperatorTotalTime: 59.295us
               - __MIN_OF_OperatorTotalTime: 2.452us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 0ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
          UniqueMetrics:
             - ChannelNum: 64
             - DestFragments: 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99, 3f01c8748a0b11f0-94e000163e341b99
             - DestID: 6
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
             - NetworkTime: 204.060us
             - OverallThroughput: 0.000 B/sec
             - OverallTime: 370.823us
             - PassThroughBufferPeakMemoryUsage: 0.000 B
             - RawInputBytes: 0.000 B
             - RequestSent: 0
             - RequestUnsent: 0
             - RpcAvgTime: 204.060us
             - RpcCount: 1
             - SerializeChunkTime: 0ns
             - SerializedBytes: 0.000 B
             - ShuffleChunkAppendCounter: 0
             - ShuffleChunkAppendTime: 0ns
             - ShuffleHashTime: 0ns
             - WaitTime: 839.792us
        PROJECT (plan_node_id=5):
          CommonMetrics:
             - OperatorTotalTime: 4.663us
               - __MAX_OF_OperatorTotalTime: 5.752us
               - __MIN_OF_OperatorTotalTime: 3.363us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 498ns
               - __MAX_OF_PullTotalTime: 790ns
               - __MIN_OF_PullTotalTime: 372ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 797ns
               - __MAX_OF_PushTotalTime: 1.231us
               - __MIN_OF_PushTotalTime: 515ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CommonSubExprComputeTime: 0ns
             - ExprComputeTime: 0ns
        CHUNK_ACCUMULATE (plan_node_id=4):
          CommonMetrics:
             - IsSubordinate
             - OperatorTotalTime: 3.218us
               - __MAX_OF_OperatorTotalTime: 4.428us
               - __MIN_OF_OperatorTotalTime: 2.528us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 547ns
               - __MAX_OF_PullTotalTime: 662ns
               - __MIN_OF_PullTotalTime: 415ns
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 2.129us
               - __MAX_OF_PushTotalTime: 3.378us
               - __MIN_OF_PushTotalTime: 1.511us
          UniqueMetrics:
        OLAP_SCAN (plan_node_id=4):
          CommonMetrics:
             - OperatorTotalTime: 1.777ms
               - __MAX_OF_OperatorTotalTime: 2.407ms
               - __MIN_OF_OperatorTotalTime: 1.266ms
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 1.341ms
               - __MAX_OF_PullTotalTime: 2.014ms
               - __MIN_OF_PullTotalTime: 849.817us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - MorselQueueType: fixed_morsel_queue
             - Predicates: concat(substring(18: s_phone, 1, 3), '-', substring(18: s_phone, 4, 3), '-', substring(18: s_phone, 7, 8)) LIKE '123-%'
             - Rollup: supplier
             - SharedScan: False
             - Table: supplier
             - AccessPathHits: 0
             - AccessPathUnhits: 0
             - BytesRead: 7.435 MB
               - __MAX_OF_BytesRead: 119.867 KB
               - __MIN_OF_BytesRead: 118.181 KB
             - CachedPagesNum: 256
               - __MAX_OF_CachedPagesNum: 4
               - __MIN_OF_CachedPagesNum: 4
             - ChunkBufferCapacity: 1.024K (1024)
             - CompressedBytesRead: 0.000 B
             - DefaultChunkBufferCapacity: 1.024K (1024)
             - IOTaskExecTime: 524.193us
               - __MAX_OF_IOTaskExecTime: 712.137us
               - __MIN_OF_IOTaskExecTime: 361.990us
               - CreateSegmentIter: 16.959us
                 - __MAX_OF_CreateSegmentIter: 33.348us
                 - __MIN_OF_CreateSegmentIter: 9.265us
               - ExprFilterRows: 100.000K (100000)
                 - __MAX_OF_ExprFilterRows: 1.563K (1563)
                 - __MIN_OF_ExprFilterRows: 1.562K (1562)
               - ExprFilterTime: 244.249us
                 - __MAX_OF_ExprFilterTime: 344.410us
                 - __MIN_OF_ExprFilterTime: 145.764us
               - GetDelVec: 0ns
               - GetDeltaColumnGroup: 2.097us
                 - __MAX_OF_GetDeltaColumnGroup: 9.279us
                 - __MIN_OF_GetDeltaColumnGroup: 626ns
               - GetRowsets: 3.771us
                 - __MAX_OF_GetRowsets: 19.837us
                 - __MIN_OF_GetRowsets: 2.231us
               - IOTime: 0ns
               - ReadPKIndex: 0ns
               - SegmentInit: 73.560us
                 - __MAX_OF_SegmentInit: 102.276us
                 - __MIN_OF_SegmentInit: 48.705us
                 - BitmapIndexFilter: 0ns
                 - BitmapIndexFilterRows: 0
                 - BitmapIndexIteratorInit: 3.078us
                   - __MAX_OF_BitmapIndexIteratorInit: 5.292us
                   - __MIN_OF_BitmapIndexIteratorInit: 1.683us
                 - BloomFilterFilter: 0ns
                 - BloomFilterFilterRows: 0
                 - ColumnIteratorInit: 34.614us
                   - __MAX_OF_ColumnIteratorInit: 50.786us
                   - __MIN_OF_ColumnIteratorInit: 23.791us
                 - GetVectorRowRangesTime: 0ns
                 - GinFilter: 0ns
                 - GinFilterRows: 0
                 - ProcessVectorDistanceAndIdTime: 0ns
                 - RemainingRowsAfterShortKeyFilter: 100.000K (100000)
                   - __MAX_OF_RemainingRowsAfterShortKeyFilter: 1.563K (1563)
                   - __MIN_OF_RemainingRowsAfterShortKeyFilter: 1.562K (1562)
                 - SegmentRuntimeZoneMapFilterRows: 0
                 - SegmentZoneMapFilterRows: 0
                 - ShortKeyFilter: 716ns
                   - __MAX_OF_ShortKeyFilter: 1.404us
                   - __MIN_OF_ShortKeyFilter: 443ns
                 - ShortKeyFilterRows: 0
                 - ShortKeyRangeNumber: 0
                 - VectorIndexFilterRows: 0
                 - VectorSearchTime: 0ns
                 - ZoneMapIndexFilterRows: 0
                 - ZoneMapIndexFiter: 1.101us
                   - __MAX_OF_ZoneMapIndexFiter: 2.080us
                   - __MIN_OF_ZoneMapIndexFiter: 654ns
               - SegmentRead: 120.972us
                 - __MAX_OF_SegmentRead: 162.722us
                 - __MIN_OF_SegmentRead: 89.212us
                 - BlockFetch: 100.589us
                   - __MAX_OF_BlockFetch: 136.028us
                   - __MIN_OF_BlockFetch: 72.551us
                 - BlockFetchCount: 64
                   - __MAX_OF_BlockFetchCount: 1
                   - __MIN_OF_BlockFetchCount: 1
                 - BlockSeek: 17.144us
                   - __MAX_OF_BlockSeek: 32.125us
                   - __MIN_OF_BlockSeek: 13.279us
                 - BlockSeekCount: 64
                   - __MAX_OF_BlockSeekCount: 1
                   - __MIN_OF_BlockSeekCount: 1
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
                 - TotalColumnsDataPageCount: 256
                   - __MAX_OF_TotalColumnsDataPageCount: 4
                   - __MIN_OF_TotalColumnsDataPageCount: 4
             - IOTaskWaitTime: 241.875us
               - __MAX_OF_IOTaskWaitTime: 1.031ms
               - __MIN_OF_IOTaskWaitTime: 20.937us
             - MorselsCount: 64
               - __MAX_OF_MorselsCount: 4
               - __MIN_OF_MorselsCount: 4
             - NonPushdownPredicates: 1
             - PeakChunkBufferMemoryUsage: 1.627 MB
             - PeakChunkBufferSize: 2
             - PeakIOTasks: 2
               - __MAX_OF_PeakIOTasks: 4
               - __MIN_OF_PeakIOTasks: 1
             - PeakScanTaskQueueSize: 94
               - __MAX_OF_PeakScanTaskQueueSize: 8
               - __MIN_OF_PeakScanTaskQueueSize: 4
             - PrepareChunkSourceTime: 658.977us
               - __MAX_OF_PrepareChunkSourceTime: 1.108ms
               - __MIN_OF_PrepareChunkSourceTime: 499.174us
             - PushdownAccessPaths: 0
             - PushdownPredicates: 0
             - RawRowsRead: 100.000K (100000)
               - __MAX_OF_RawRowsRead: 1.563K (1563)
               - __MIN_OF_RawRowsRead: 1.562K (1562)
             - ReadPagesNum: 256
               - __MAX_OF_ReadPagesNum: 4
               - __MIN_OF_ReadPagesNum: 4
             - RowsRead: 0
             - RuntimeFilterEvalTime: 0ns
             - RuntimeFilterInputRows: 0
             - RuntimeFilterOutputRows: 0
             - ScanTime: 766.068us
               - __MAX_OF_ScanTime: 1.534ms
               - __MIN_OF_ScanTime: 405.115us
             - SubmitTaskCount: 64
               - __MAX_OF_SubmitTaskCount: 4
               - __MIN_OF_SubmitTaskCount: 4
             - SubmitTaskTime: 653.859us
               - __MAX_OF_SubmitTaskTime: 1.293ms
               - __MIN_OF_SubmitTaskTime: 263.443us
             - TabletCount: 64
             - UncompressedBytesRead: 0.000 B
      Pipeline (id=0):
         - IsGroupExecution: false
         - ActiveTime: 27.223us
           - __MAX_OF_ActiveTime: 39.650us
           - __MIN_OF_ActiveTime: 13.250us
         - BlockByInputEmpty: 0
         - BlockByOutputFull: 0
         - BlockByPrecondition: 0
         - DegreeOfParallelism: 16
         - DriverTotalTime: 80.628us
           - __MAX_OF_DriverTotalTime: 178.650us
           - __MIN_OF_DriverTotalTime: 26.937us
         - PeakDriverQueueSize: 7
           - __MAX_OF_PeakDriverQueueSize: 2
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
             - OperatorTotalTime: 326ns
               - __MAX_OF_OperatorTotalTime: 505ns
               - __MIN_OF_OperatorTotalTime: 218ns
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
             - OperatorTotalTime: 26.911us
               - __MAX_OF_OperatorTotalTime: 38.802us
               - __MIN_OF_OperatorTotalTime: 13.549us
             - OutputChunkBytes: 0.000 B
             - PullChunkNum: 0
             - PullRowNum: 0
             - PullTotalTime: 22.909us
               - __MAX_OF_PullTotalTime: 34.709us
               - __MIN_OF_PullTotalTime: 11.054us
             - PushChunkNum: 0
             - PushRowNum: 0
             - PushTotalTime: 0ns
             - RuntimeFilterNum: 0
             - RuntimeInFilterNum: 0
          UniqueMetrics:
             - CaptureTabletRowsetsTime: 11.307us
               - __MAX_OF_CaptureTabletRowsetsTime: 14.526us
               - __MIN_OF_CaptureTabletRowsetsTime: 8.854us
