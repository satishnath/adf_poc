CREATE OR ALTER PROCEDURE   [metadata].[GetEnvironmentConfig]
(
    @EnvironmentName    VARCHAR(32) =   NULL
)
AS
BEGIN

    IF  @EnvironmentName IS NULL
        RAISERROR(15600, -1, -1, '[metadata].[GetEnvironmentConfig]')

    SELECT
            [E].[EnvironmentId]
        ,   [E].[EnvironmentName]
        ,   [EP].[EnvironmentParametersJson]
    FROM    [metadata].[Environment]                AS  [E]

    INNER JOIN  (
        SELECT
                [_EP].[EnvironmentId]
            ,   '{' + STRING_AGG( '"' + [_EP].[Key] + '":"' + STRING_ESCAPE([_EP].[Value], 'json') + '"', ',') + '}'    AS  [EnvironmentParametersJson]
        FROM    [metadata].[EnvironmentParameters]  AS  [_EP]
        WHERE   [_EP].[IsActive] = 1
        GROUP BY    [_EP].[EnvironmentId]
    )												AS	[EP]
        ON      [E].[IsActive]          =   1
            AND [E].[EnvironmentName]   =   @EnvironmentName
            AND [EP].[EnvironmentId]    =   [E].[EnvironmentId]
END;
GO