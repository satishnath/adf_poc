CREATE TABLE    [metadata].[FeatureGroup](
    [FeatureGroupId]    INT NOT NULL PRIMARY KEY
,   [FeatureGroupName]  VARCHAR(64) NOT NULL
,   [FeatureAreaId]     INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_FeatureGroup_FeatureGroupName_FeatureAreaId] UNIQUE ([FeatureGroupName], [FeatureAreaId])
,   CONSTRAINT  [FK_metadata_FeatureGroup_FeatureAreaId_metadata_FeatureArea_FeatureAreaId] FOREIGN KEY ([FeatureAreaId]) REFERENCES [metadata].[FeatureArea]([FeatureAreaId])
);