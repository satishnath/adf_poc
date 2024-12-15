CREATE OR ALTER PROCEDURE   [metadata].[GetJobConfig]
(
    @JobName            VARCHAR(64)     =   NULL
,   @EnvironmentName    VARCHAR(32)     =   NULL
)
AS
BEGIN

    IF  @JobName IS NULL
        RAISERROR(15600, -1, -1, '[metadata].[GetJobConfig] :: @JobName is null')

    IF  @EnvironmentName IS NULL
        RAISERROR(15600, -1, -1, '[metadata].[GetJobConfig] :: @EnvironmentName is null')

    SELECT
        [ENV].[EnvironmentId]
    ,   [ENV].[EnvironmentName]
    ,   [J].[JobId]
    ,   [J].[JobName]
    ,   [SS].[SourceSystemId]
    ,   [SS].[SourceSystemName]
    ,   [SST].[SourceSystemTenantId]
    ,   [SST].[SourceSystemTenantName]
    ,   [SSE].[SourceSystemEntityId]
    ,   [SSE].[SourceSystemEntityName]
    ,   [SSEP].[SourceSystemEntityParametersJson]
    ,   FORMAT(
            COALESCE([SSTSSE].[CheckpointDatetime], '1900-01-01 00:00:00.0000000')
        ,   'yyyy-MM-dd HH:mm:ss.fffffff'
        )                                           AS  [CheckpointDatetime]
    FROM    [metadata].[Job]                                AS  [J]

    INNER JOIN  [metadata].[Environment]                    AS  [ENV]
        ON          [J].[IsActive]                  = 1
            AND     [ENV].[IsActive]                = 1
            AND     UPPER([ENV].[EnvironmentName])  = UPPER(@EnvironmentName)
            AND     [J].[EnvironmentId]             = [ENV].[EnvironmentId]

    INNER JOIN  [metadata].[JobSourceSystemTenant]          AS  [JSST]
        ON          [J].[IsActive]      = 1
            AND     [JSST].[IsActive]   = 1
            AND     [J].[JobName]       = @JobName
            AND     [JSST].[JobId]      = [J].[JobId]

    INNER JOIN  [metadata].[SourceSystemTenant]             AS  [SST]
        ON          [SST].[IsActive]                = 1
            AND     [JSST].[IsActive]               = 1
            AND     [SST].[SourceSystemTenantId]    = [JSST].[SourceSystemTenantId]

    INNER JOIN  [metadata].[SourceSystemTenantSourceSystemEntity]   AS  [SSTSSE]
        ON          [SST].[IsActive]                = 1
            AND     [SSTSSE].[IsActive]             = 1
            AND     [SST].[SourceSystemTenantId]    = [SSTSSE].[SourceSystemTenantId]
            
    INNER JOIN  [metadata].[SourceSystemEntity]             AS  [SSE]
        ON          [SSE].[IsActive]                = 1
            AND     [SSTSSE].[IsActive]             = 1
            AND     [SSE].[SourceSystemEntityId]    = [SSTSSE].[SourceSystemEntityId]

    INNER JOIN  [metadata].[SourceSystem]                   AS  [SS]
        ON          [SS].[IsActive]         = 1
            AND     [SSE].[IsActive]        = 1
            AND     [SS].[SourceSystemId]   = [SSE].[SourceSystemId]

    
    INNER JOIN  (
        SELECT
            [_SSEP].[SourceSystemEntityId]
        ,   '{' + STRING_AGG( '"' + [_SSEP].[Key] + '":"' + STRING_ESCAPE([_SSEP].[Value], 'json') + '"', ',' ) + '}'   AS [SourceSystemEntityParametersJson]
        FROM        [metadata].[SourceSystemEntityParameters]   AS  [_SSEP]

        GROUP BY    [_SSEP].[SourceSystemEntityId]
    )                                                       AS  [SSEP]
        ON          [SSEP].[SourceSystemEntityId]   = [SSE].[SourceSystemEntityId]
  
END;
GO