CREATE TABLE    [metadata].[Feature](
    [FeatureId]         INT NOT NULL PRIMARY KEY
,   [FeatureName]       VARCHAR(128) NOT NULL
,   [FeatureGroupId]    INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_Feature_FeatureName_FeatureGroupId] UNIQUE ([FeatureName], [FeatureGroupId])
,   CONSTRAINT  [FK_metadata_Feature_FeatureGroupId_metadata_FeatureGroup_FeatureGroupId] FOREIGN KEY ([FeatureGroupId]) REFERENCES [metadata].[FeatureGroup]([FeatureGroupId])
);