CREATE TABLE    [metadata].[ModelEntity](
    [ModelEntityId]         INT NOT NULL PRIMARY KEY
,   [ModelEntityName]       VARCHAR(64) NOT NULL
,   [EnvironmentId]         INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_ModelEntity_ModelEntityId_ModelEntityName] UNIQUE ([ModelEntityId], [ModelEntityName])
,   CONSTRAINT  [FK_metadata_ModelEntity_EnvironmentId_metadata_Environment_EnvironmentId] FOREIGN KEY ([EnvironmentId]) REFERENCES [metadata].[Environment]([EnvironmentId])
);