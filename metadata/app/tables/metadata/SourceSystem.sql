CREATE TABLE    [metadata].[SourceSystem](
    [SourceSystemId]    INT NOT NULL PRIMARY KEY
,   [SourceSystemName]  VARCHAR(64) NOT NULL
,   [EnvironmentId]     INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [FK_metadata_SourceSystem_EnvironmentId_metadata_Environment_EnvironmentId] FOREIGN KEY ([EnvironmentId]) REFERENCES [metadata].[Environment]([EnvironmentId])
,   CONSTRAINT  [UQ_metadata_SourceSystem_SourceSystemName] UNIQUE ([SourceSystemName])
);