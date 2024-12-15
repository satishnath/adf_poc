CREATE TABLE    [metadata].[JobRun](
    [JobRunId]      BIGINT IDENTITY(1, 1) NOT NULL PRIMARY KEY
,   [JobId]         INT NOT NULL
,   [JobStatusId]   INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL

,   CONSTRAINT  [FK_metadata_JobRun_JobId_metadata_Job_JobId] FOREIGN KEY ([JobId]) REFERENCES [metadata].[Job]([JobId])
,   CONSTRAINT  [FK_metadata_JobRun_JobStatusId_metadata_JobStatus_JobStatusId] FOREIGN KEY ([JobStatusId]) REFERENCES [metadata].[JobStatus]([JobStatusId])
);

CREATE NONCLUSTERED INDEX   [metadata_JobRun_JobId_InsertedDate]
    ON          [metadata].[JobRun]([JobId], [InsertedDate]) INCLUDE ([JobRunId], [InsertedBy], [JobStatusId])
;