CREATE OR ALTER PROCEDURE   [metadata].[AddJobRunLog]
(
    @JobRunId       BIGINT
,   @LogBy          NVARCHAR(64)        =   NULL
,   @LogType        VARCHAR(64)
,   @LogValue       NVARCHAR(MAX)
)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [metadata].[JobRun] WHERE [JobRunId] = @JobRunId)
        RAISERROR(15600, -1, -1, '[metadata].[AddJobRunLog] :: Given Job Run doesn''t exist')

    INSERT INTO     [metadata].[JobRunLog]
    (
            [JobRunId]
        ,   [LogType]
        ,   [LogValue]
        ,   [InsertedDate]
        ,   [InsertedBy]   
    )
    OUTPUT
            [INSERTED].[JobRunId]
        ,   [INSERTED].[LogType]
        ,   CONCAT(LEFT([INSERTED].[LogValue], 25), '...')  AS  [LogValue]
        ,   [INSERTED].[InsertedDate]
        ,   [INSERTED].[InsertedBy]
    VALUES
    (
            @JobRunId
        ,   @LogType
        ,   @LogValue
        ,   GETDATE()
        ,   COALESCE(@LogBy, CURRENT_USER)
    )
END;
GO
