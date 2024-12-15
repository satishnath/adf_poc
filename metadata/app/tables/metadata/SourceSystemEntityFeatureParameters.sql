CREATE TABLE    [metadata].[SourceSystemEntityFeatureParameters](
    [SourceSystemEntityFeatureParameterId]     BIGINT NOT NULL
,   [SourceSystemEntityFeatureId]              BIGINT NOT NULL
,   [Key]                                      VARCHAR(64) NOT NULL
,   [Value]                                    NVARCHAR(1024) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [PK_metadata_SourceSystemEntityFeatureParameters] PRIMARY KEY ([SourceSystemEntityFeatureId], [Key])
,   CONSTRAINT  [FK_metadata_SourceSystemEntityFeatureParameters_SSEFeatureId_metadata_SSEFeature_SSEFeatureId] FOREIGN KEY ([SourceSystemEntityFeatureId]) REFERENCES [metadata].[SourceSystemEntityFeature]([SourceSystemEntityFeatureId])
);