CREATE TABLE    [metadata].[SourceSystemEntityModelEntity](
    [ModelEntityId]         INT NOT NULL
,   [SourceSystemEntityId]  INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [PK_metadata_SourceSystemEntityModelEntity] PRIMARY KEY ([SourceSystemEntityId], [ModelEntityId])
);