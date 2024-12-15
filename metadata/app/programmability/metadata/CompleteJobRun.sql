CREATE OR ALTER PROCEDURE   [metadata].[CompleteJobRun]
(
    @JobRunId       BIGINT
,   @CompletedBy    NVARCHAR(64)    =   NULL
,   @JobStatusId    INT
)
AS
BEGIN
    IF  NOT EXISTS (SELECT 1 FROM [metadata].[JobRun] WHERE [JobRunId] = @JobRunId)
        RAISERROR(15600, -1, -1, '[metadata].[CompleteJobRun] :: Given Job Run doesn''t exist')

    IF  NOT EXISTS (SELECT 1 FROM [metadata].[JobStatus] WHERE [JobStatusId] = @JobStatusId)
        RAISERROR(15600, -1, -1, '[metadata].[CompleteJobRun] :: Given Job Status doesn''t exist')

    UPDATE  [metadata].[JobRun]
    SET
            [JobStatusId]   =   @JobStatusId
    OUTPUT
            [INSERTED].[JobRunId]
        ,   [INSERTED].[JobStatusId]    AS  [NewJobStatusId]
        ,   [DELETED].[JobStatusId]     AS  [OldJobStatusId]
    WHERE
        [JobRunId]  =   @JobRunId
END;
GO