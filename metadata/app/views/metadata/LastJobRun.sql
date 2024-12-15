CREATE OR ALTER VIEW     [metadata].[LastJobRun]
AS
    SELECT
        [JR].[JobRunId]
    ,   [JR].[JobId]
    ,   [J].[JobName]
    ,   [JR].[InsertedDate]
    ,   [JR].[InsertedBy]
    FROM    [metadata].[JobRun]     AS  [JR]

    INNER JOIN  (
        SELECT
            MAX([JobRunId]) AS  [JobRunId]
        FROM    [metadata].[JobRun]
        GROUP BY    [JobId]
    )                               AS  [MOST_RECENT_JOB_RUN]
        ON  [JR].[JobRunId] = [MOST_RECENT_JOB_RUN].[JobRunId]

    INNER JOIN  [metadata].[Job]    AS  [J]
        ON          [J].[JobId] = [JR].[JobId]
GO