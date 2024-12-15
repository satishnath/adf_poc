CREATE TABLE    [metadata].[JobRunLog](
    [JobRunLogId]   BIGINT IDENTITY(1, 1) NOT NULL PRIMARY KEY
,   [JobRunId]      BIGINT NOT NULL
,   [LogType]       VARCHAR(64) NOT NULL
,   [LogValue]      NVARCHAR(MAX) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL

,   CONSTRAINT  [FK_metadata_JobRunLog_JobRunId_metadata_JobRun_JobRunId] FOREIGN KEY ([JobRunId]) REFERENCES [metadata].[JobRun]([JobRunId])
);

CREATE NONCLUSTERED INDEX   [metadata_JobRunLog_JobRunId_LogType_LogValue]
    ON          [metadata].[JobRunLog] ([JobRunId]) INCLUDE ([LogType], [LogValue])
;