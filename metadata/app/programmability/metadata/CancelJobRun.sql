CREATE OR ALTER PROCEDURE   [metadata].[CancelJobRun]
(
    @JobRunId       BIGINT
,   @CancelledBy    NVARCHAR(64)    =   NULL
)
AS
BEGIN
    IF  NOT EXISTS (SELECT 1 FROM [metadata].[JobRun] WHERE [JobRunId] = @JobRunId)
        RAISERROR(15600, -1, -1, '[metadata].[CancelJobRun] :: Given Job Run Id doesn''t exist')

    UPDATE  [metadata].[JobRun]
    SET
            [JobStatusId]   =   4   -- [metadata].[JobStatus] / Cancelled
    OUTPUT
            [INSERTED].[JobRunId]
        ,   [INSERTED].[JobStatusId]    AS  [NewJobStatusId]
        ,   [DELETED].[JobStatusId]     AS  [OldJobStatusId]
    WHERE
        [JobRunId]  =   @JobRunId
END;
GO