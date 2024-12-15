CREATE TABLE    [metadata].[SourceSystemTenantSourceSystemEntityParameterOverride](
    [SourceSystemTenantSourceSystemEntityParameterOverrideId]   BIGINT NOT NULL
,   [SourceSystemEntityId]                                      INT NOT NULL
,   [SourceSystemTenantSourceSystemEntityId]                    INT NOT NULL
,   [Key]                                                       VARCHAR(64) NOT NULL
,   [Value]                                                     NVARCHAR(1024) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [PK_metadata_SourceSystemTenantSourceSystemEntityParameterOverride] PRIMARY KEY ([SourceSystemTenantSourceSystemEntityId], [SourceSystemEntityId], [Key])
,   CONSTRAINT  [FK_metadata_SSTSSEParameterOverride_SSTSSEId_metadata_SSTSSE_SSTSSEId] FOREIGN KEY ([SourceSystemTenantSourceSystemEntityId]) REFERENCES [metadata].[SourceSystemTenantSourceSystemEntity]([SourceSystemTenantSourceSystemEntityId])
,   CONSTRAINT  [FK_metadata_SSEParameters_SourceSystemEntityId_metadata_SourceSystemEntity_SourceSystemEntityId] FOREIGN KEY ([SourceSystemEntityId]) REFERENCES [metadata].[SourceSystemEntity]([SourceSystemEntityId])
);