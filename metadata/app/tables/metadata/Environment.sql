CREATE TABLE    [metadata].[Environment](
    [EnvironmentId]     INT NOT NULL PRIMARY KEY
,   [EnvironmentName]   VARCHAR(32) NOT NULL

,   [InsertedDate]      DATETIME DEFAULT(GETDATE())
,   [InsertedBy]        NVARCHAR(128) NOT NULL
,   [IsActive]          BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_Environment_EnvironmentName]   UNIQUE  ([EnvironmentName])
);