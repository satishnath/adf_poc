CREATE OR ALTER PROCEDURE   [metadata].[StartJobRun]
(
    @JobName        VARCHAR(64)
,   @StartedBy      NVARCHAR(64)        =   NULL
)
AS
BEGIN
    DECLARE @JobId INT = (SELECT [JobId] FROM [metadata].[Job] WHERE [JobName] = @JobName)

    IF  NOT EXISTS (SELECT @JobId)
        RAISERROR(15600, -1, -1, '[metadata].[StartJobRun] :: JobId of given JobName not found')

    INSERT INTO [metadata].[JobRun]
    (
            [JobId]
        ,   [JobStatusId]
        ,   [InsertedDate]
        ,   [InsertedBy]
    )
    OUTPUT
            [INSERTED].[JobRunId]
        ,   [INSERTED].[InsertedDate]
        ,   [INSERTED].[InsertedBy]
    VALUES
    (
            @JobId
        ,   1   -- [metadata].[JobStatus] / In-Progress
        ,   GETDATE()
        ,   COALESCE(@StartedBy, CURRENT_USER)
    )
END;
GO