CREATE TABLE    [metadata].[Job](
    [JobId]         INT NOT NULL PRIMARY KEY
,   [JobName]       VARCHAR(64) NOT NULL
,   [EnvironmentId] INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT      [UQ_metadata_Job_JobName] UNIQUE ([JobName])
,   CONSTRAINT      [FK_metadata_Job_EnvironmentId_metadata_Environment_EnvironmentId] FOREIGN KEY ([EnvironmentId]) REFERENCES [metadata].[Environment]([EnvironmentId])
);