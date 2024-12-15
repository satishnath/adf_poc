CREATE TABLE    [metadata].[SourceSystemTenantSourceSystemEntity](
    [SourceSystemTenantSourceSystemEntityId]    INT IDENTITY(1,1) NOT NULL PRIMARY KEY
,   [SourceSystemTenantId]                      INT NOT NULL
,   [SourceSystemEntityId]                      INT NOT NULL
,   [CheckpointDatetime]                        DATETIME2(7) NULL DEFAULT('1900-01-01')

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_SourceSystemTenantSourceSystemEntity] UNIQUE ([SourceSystemTenantId], [SourceSystemEntityId])
,   CONSTRAINT  [FK_metadata_SourceSystemTenantSourceSystemEntity_SourceSystemTenantId_metadata_SourceSystemTenant_SourceSystemTenantId] FOREIGN KEY ([SourceSystemTenantId]) REFERENCES [metadata].[SourceSystemTenant]([SourceSystemTenantId])
,   CONSTRAINT  [FK_metadata_SourceSystemTenantSourceSystemEntity_SourceSystemEntityId_metadata_SourceSystemEntity_SourceSystemEntityId] FOREIGN KEY ([SourceSystemEntityId]) REFERENCES [metadata].[SourceSystemEntity]([SourceSystemEntityId])
);