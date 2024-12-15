CREATE TABLE    [metadata].[SourceSystemTenant](
    [SourceSystemTenantId]      INT NOT NULL PRIMARY KEY
,   [SourceSystemTenantName]    VARCHAR(64) NOT NULL
,   [SourceSystemId]            INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [FK_metadata_SourceSystemTenant_SourceSystemId_metadata_SourceSystem_SourceSystemId] FOREIGN KEY ([SourceSystemId]) REFERENCES [metadata].[SourceSystem]([SourceSystemId])
,   CONSTRAINT  [UQ_metadata_SourceSystemTenant_SourceSystemTenantName] UNIQUE ([SourceSystemTenantName])
);