CREATE TABLE    [metadata].[FeatureArea](
    [FeatureAreaId]     INT NOT NULL PRIMARY KEY
,   [FeatureAreaName]   VARCHAR(64) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_FeatureArea_FeatureAreaName] UNIQUE ([FeatureAreaName])
);