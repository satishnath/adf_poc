CREATE TABLE    [metadata].[JobStatus](
    [JobStatusId]   INT NOT NULL PRIMARY KEY
,   [JobStatusName] VARCHAR(32) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL   
);