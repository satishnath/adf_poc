CREATE TABLE    [metadata].[SourceSystemEntity](
    [SourceSystemEntityId]      INT NOT NULL PRIMARY KEY
,   [SourceSystemEntityName]    VARCHAR(32) NOT NULL
,   [SourceSystemId]            INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_SourceSystemEntity_SourceSystemEntityName_SourceSystemId] UNIQUE ([SourceSystemEntityName], [SourceSystemId])
,   CONSTRAINT  [FK_metadata_SourceSystemEntity_SourceSystemId_metadata_SourceSystem_SourceSystemId] FOREIGN KEY ([SourceSystemId]) REFERENCES [metadata].[SourceSystem]([SourceSystemId])
);