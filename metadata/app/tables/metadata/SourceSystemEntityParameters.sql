CREATE TABLE    [metadata].[SourceSystemEntityParameters](
    [SourceSystemEntityId]              INT NOT NULL
,   [Key]                               VARCHAR(64) NOT NULL
,   [Value]                             NVARCHAR(1024) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [PK_metadata_SourceSystemEntityParameters] PRIMARY KEY ([SourceSystemEntityId], [Key])
,   CONSTRAINT  [FK_metadata_SourceSystemEntityParameters_SourceSystemEntityId_metadata_SourceSystemEntity_SourceSystemEntityId] FOREIGN KEY ([SourceSystemEntityId]) REFERENCES [metadata].[SourceSystemEntity]([SourceSystemEntityId])
);