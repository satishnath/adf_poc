CREATE OR ALTER PROCEDURE   [metadata].[GetTransformationConfig]
(
    @JobName            VARCHAR(64)     =   NULL
,   @EnvironmentName    VARCHAR(32)     =   NULL
)
AS
BEGIN

    IF  @JobName IS NULL
        RAISERROR(15600, -1, -1, '[metadata].[GetTransformationConfig]')

    IF  @EnvironmentName IS NULL
        RAISERROR(15600, -1, -1, '[metadata].[GetTransformationConfig]')

    SELECT
            [E].[EnvironmentId]
        ,   [E].[EnvironmentName]
        ,   [J].[JobId]
        ,   [J].[JobName]
        ,   [SS].[SourceSystemId]
        ,   [SS].[SourceSystemName]
        ,   [SST].[SourceSystemTenantId]
        ,   [SST].[SourceSystemTenantName]
        ,   [SSE].[SourceSystemEntityId]
        ,   [SSE].[SourceSystemEntityName]
        ,   [ME].[ModelEntityId]
        ,   [ME].[ModelEntityName]
        ,   [MEP].[ModelEntityParametersJson]
    FROM        [metadata].[Job]                                AS  [J]

    INNER JOIN  [metadata].[Environment]                        AS  [E]
        ON          [J].[IsActive]                  =   1
            AND     [E].[IsActive]                  =   1
            AND     UPPER([E].[EnvironmentName])    =   UPPER(@EnvironmentName)
            AND     [J].[EnvironmentId]             =   [E].[EnvironmentId]

    INNER JOIN  [metadata].[JobSourceSystemTenant]              AS  [JSST]
        ON          [J].[IsActive]                  =   1
            AND     [JSST].[IsActive]               =   1
            AND     UPPER([J].[JobName])            =   UPPER(@JobName)
            AND     [JSST].[JobId]                  =   [J].[JobId]

    INNER JOIN  [metadata].[SourceSystemTenant]                 AS  [SST]
        ON          [SST].[IsActive]                =   1
            AND     [JSST].[IsActive]               =   1
            AND     [SST].[SourceSystemTenantId]    =   [JSST].[SourceSystemTenantId]

    INNER JOIN  [metadata].[SourceSystem]                       AS  [SS]
        ON          [SS].[IsActive]                 =   1
            AND     [SST].[IsActive]                =   1
            AND     [SS].[SourceSystemId]           =   [SST].[SourceSystemId]

    INNER JOIN  [metadata].[SourceSystemEntity]                 AS  [SSE]
        ON          [SSE].[IsActive]                =   1
            AND     [SS].[IsActive]                 =   1
            AND     [SSE].[SourceSystemId]          =   [SS].[SourceSystemId]

    INNER JOIN  [metadata].[SourceSystemTenantSourceSystemEntity]   AS  [SST_SSE]
        ON          [SST_SSE].[IsActive]                =   1
            AND     [SST_SSE].[SourceSystemTenantId]    =   [SST].[SourceSystemTenantId]
            AND     [SST_SSE].[SourceSystemEntityId]    =   [SSE].[SourceSystemEntityId]

    INNER JOIN  [metadata].[SourceSystemEntityModelEntity]      AS  [SSE_ME]
        ON          [SSE_ME].[IsActive]             =   1
            AND     [SSE_ME].[SourceSystemEntityId] =   [SSE].[SourceSystemEntityId]

    INNER JOIN  [metadata].[ModelEntity]                        AS  [ME]
        ON          [ME].[IsActive]                 =   1
            AND     [SSE_ME].[IsActive]             =   1
            AND     [E].[IsActive]                  =   1
            AND     [ME].[ModelEntityId]            =   [SSE_ME].[ModelEntityId]
            AND     [ME].[EnvironmentId]            =   [E].[EnvironmentId]

    INNER JOIN  (
        SELECT
                [_MEP].[ModelEntityId]
            ,   '{' + STRING_AGG( '"' + [_MEP].[Key] + '":"' + STRING_ESCAPE([_MEP].[Value], 'json') + '"', ',') + '}'      AS  [ModelEntityParametersJson]
        FROM        [metadata].[ModelEntityParameters]              AS  [_MEP]

        GROUP BY    [_MEP].[ModelEntityId]
    )                                                           AS  [MEP]
        ON          [MEP].[ModelEntityId]   =   [ME].[ModelEntityId]
END;
GO