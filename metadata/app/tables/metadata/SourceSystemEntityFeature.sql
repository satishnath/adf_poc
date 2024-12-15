CREATE TABLE    [metadata].[SourceSystemEntityFeature](
    [SourceSystemEntityFeatureId]   BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY
,   [SourceSystemEntityId]          INT NOT NULL
,   [FeatureId]                     INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_SourceSystemEntityFeature] UNIQUE ([SourceSystemEntityId], [FeatureId])
,   CONSTRAINT  [FK_metadata_SourceSystemEntityFeature_SourceSystemEntityId_metadata_SourceSystemEntity_SourceSystemEntityId] FOREIGN KEY ([SourceSystemEntityId]) REFERENCES [metadata].[SourceSystemEntity]([SourceSystemEntityId])
,   CONSTRAINT  [FK_metadata_SourceSystemEntityFeature_FeatureId_metadata_Feature_FeatureId] FOREIGN KEY ([FeatureId]) REFERENCES [metadata].[Feature]([FeatureId])
);