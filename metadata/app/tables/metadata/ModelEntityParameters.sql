CREATE TABLE    [metadata].[ModelEntityParameters](
    [ModelEntityId]     INT NOT NULL
,   [Key]               VARCHAR(64) NOT NULL
,   [Value]             NVARCHAR(1024) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [PK_metadata_ModelEntityParameters] PRIMARY KEY ([ModelEntityId], [Key])
);