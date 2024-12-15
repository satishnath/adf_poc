CREATE TABLE    [metadata].[JobSourceSystemTenant](
    [JobId]                 INT NOT NULL
,   [SourceSystemTenantId]  INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [FK_metadata_JobSourceSystemTenant_JobId_metadata_Job_JobId] FOREIGN KEY ([JobId]) REFERENCES [metadata].[Job]([JobId])
,   CONSTRAINT  [FK_metadata_JobSourceSystemTenant_SourceSystemTenantId_metadata_SourceSystemTenant_SourceSystemTenantId] FOREIGN KEY ([SourceSystemTenantId]) REFERENCES [metadata].[SourceSystemTenant]([SourceSystemTenantId])
,   CONSTRAINT  [PK_metadata_JobSourceSystemTenant] PRIMARY KEY ([JobId], [SourceSystemTenantId])
);