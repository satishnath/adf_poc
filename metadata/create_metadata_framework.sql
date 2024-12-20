CREATE SCHEMA [metadata]
GO

CREATE TABLE    [metadata].[Environment](
    [EnvironmentId]     INT NOT NULL PRIMARY KEY
,   [EnvironmentName]   VARCHAR(32) NOT NULL

,   [InsertedDate]      DATETIME DEFAULT(GETDATE())
,   [InsertedBy]        NVARCHAR(128) NOT NULL
,   [IsActive]          BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_Environment_EnvironmentName]   UNIQUE  ([EnvironmentName])
);

CREATE TABLE    [metadata].[EnvironmentParameters](
    [EnvironmentId]     INT NOT NULL
,   [Key]               VARCHAR(32) NOT NULL
,   [Value]             NVARCHAR(1024) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [PK_metadata_EnvironmentParameters] PRIMARY KEY ([EnvironmentId], [Key])
);

CREATE TABLE    [metadata].[JobStatus](
    [JobStatusId]   INT NOT NULL PRIMARY KEY
,   [JobStatusName] VARCHAR(32) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL   
);

CREATE TABLE    [metadata].[Job](
    [JobId]         INT NOT NULL PRIMARY KEY
,   [JobName]       VARCHAR(64) NOT NULL
,   [EnvironmentId] INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT      [UQ_metadata_Job_JobName] UNIQUE ([JobName])
,   CONSTRAINT      [FK_metadata_Job_EnvironmentId_metadata_Environment_EnvironmentId] FOREIGN KEY ([EnvironmentId]) REFERENCES [metadata].[Environment]([EnvironmentId])
);

CREATE TABLE    [metadata].[JobRun](
    [JobRunId]      BIGINT IDENTITY(1, 1) NOT NULL PRIMARY KEY
,   [JobId]         INT NOT NULL
,   [JobStatusId]   INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL

,   CONSTRAINT  [FK_metadata_JobRun_JobId_metadata_Job_JobId] FOREIGN KEY ([JobId]) REFERENCES [metadata].[Job]([JobId])
,   CONSTRAINT  [FK_metadata_JobRun_JobStatusId_metadata_JobStatus_JobStatusId] FOREIGN KEY ([JobStatusId]) REFERENCES [metadata].[JobStatus]([JobStatusId])
);

CREATE NONCLUSTERED INDEX   [metadata_JobRun_JobId_InsertedDate]
    ON          [metadata].[JobRun]([JobId], [InsertedDate]) INCLUDE ([JobRunId], [InsertedBy], [JobStatusId])
;

CREATE TABLE    [metadata].[JobRunLog](
    [JobRunLogId]   BIGINT IDENTITY(1, 1) NOT NULL PRIMARY KEY
,   [JobRunId]      BIGINT NOT NULL
,   [LogType]       VARCHAR(64) NOT NULL
,   [LogValue]      NVARCHAR(MAX) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL

,   CONSTRAINT  [FK_metadata_JobRunLog_JobRunId_metadata_JobRun_JobRunId] FOREIGN KEY ([JobRunId]) REFERENCES [metadata].[JobRun]([JobRunId])
);

CREATE NONCLUSTERED INDEX   [metadata_JobRunLog_JobRunId_LogType_LogValue]
    ON          [metadata].[JobRunLog] ([JobRunId]) INCLUDE ([LogType], [LogValue])
;

CREATE TABLE    [metadata].[SourceSystem](
    [SourceSystemId]    INT NOT NULL PRIMARY KEY
,   [SourceSystemName]  VARCHAR(64) NOT NULL
,   [EnvironmentId]     INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [FK_metadata_SourceSystem_EnvironmentId_metadata_Environment_EnvironmentId] FOREIGN KEY ([EnvironmentId]) REFERENCES [metadata].[Environment]([EnvironmentId])
,   CONSTRAINT  [UQ_metadata_SourceSystem_SourceSystemName] UNIQUE ([SourceSystemName])
);

CREATE TABLE    [metadata].[SourceSystemEntity](
    [SourceSystemEntityId]      INT NOT NULL PRIMARY KEY
,   [SourceSystemEntityName]    VARCHAR(32) NOT NULL
,   [SourceSystemId]            INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_SourceSystemEntity_SourceSystemEntityName_SourceSystemId] UNIQUE ([SourceSystemEntityName], [SourceSystemId])
,   CONSTRAINT  [FK_metadata_SourceSystemEntity_SourceSystemId_metadata_SourceSystem_SourceSystemId] FOREIGN KEY ([SourceSystemId]) REFERENCES [metadata].[SourceSystem]([SourceSystemId])
);

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

CREATE TABLE    [metadata].[SourceSystemTenant](
    [SourceSystemTenantId]      INT NOT NULL PRIMARY KEY
,   [SourceSystemTenantName]    VARCHAR(64) NOT NULL
,   [SourceSystemId]            INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [FK_metadata_SourceSystemTenant_SourceSystemId_metadata_SourceSystem_SourceSystemId] FOREIGN KEY ([SourceSystemId]) REFERENCES [metadata].[SourceSystem]([SourceSystemId])
,   CONSTRAINT  [UQ_metadata_SourceSystemTenant_SourceSystemTenantName] UNIQUE ([SourceSystemTenantName])
);

CREATE TABLE    [metadata].[SourceSystemTenantSourceSystemEntity](
    [SourceSystemTenantSourceSystemEntityId]    INT IDENTITY(1,1) NOT NULL PRIMARY KEY
,   [SourceSystemTenantId]                      INT NOT NULL
,   [SourceSystemEntityId]                      INT NOT NULL
,   [CheckpointDatetime]                        DATETIME2(7) NULL DEFAULT('1900-01-01')

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [UQ_metadata_SourceSystemTenantSourceSystemEntity] UNIQUE ([SourceSystemTenantId], [SourceSystemEntityId])
,   CONSTRAINT  [FK_metadata_SourceSystemTenantSourceSystemEntity_SourceSystemTenantId_metadata_SourceSystemTenant_SourceSystemTenantId] FOREIGN KEY ([SourceSystemTenantId]) REFERENCES [metadata].[SourceSystemTenant]([SourceSystemTenantId])
,   CONSTRAINT  [FK_metadata_SourceSystemTenantSourceSystemEntity_SourceSystemEntityId_metadata_SourceSystemEntity_SourceSystemEntityId] FOREIGN KEY ([SourceSystemEntityId]) REFERENCES [metadata].[SourceSystemEntity]([SourceSystemEntityId])
);

CREATE TABLE    [metadata].[JobSourceSystemTenant](
    [JobId]                 INT NOT NULL
,   [SourceSystemTenantId]  INT NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [FK_metadata_JobSourceSystemTenant_JobId_metadata_Job_JobId] FOREIGN KEY ([JobId]) REFERENCES [metadata].[Job]([JobId])
,   CONSTRAINT  [FK_metadata_JobSourceSystemTenant_SourceSystemTenantId_metadata_SourceSystemTenant_SourceSystemTenantId] FOREIGN KEY ([SourceSystemTenantId]) REFERENCES [metadata].[SourceSystemTenant]([SourceSystemTenantId])
,   CONSTRAINT  [PK_metadata_JobSourceSystemTenant] PRIMARY KEY ([JobId], [SourceSystemTenantId])
);

CREATE TABLE    [metadata].[SourceSystemTenantSourceSystemEntityParameterOverride](
    [SourceSystemTenantSourceSystemEntityParameterOverrideId]   BIGINT NOT NULL
,   [SourceSystemEntityId]                                      INT NOT NULL
,   [SourceSystemTenantSourceSystemEntityId]                    INT NOT NULL
,   [Key]                                                       VARCHAR(64) NOT NULL
,   [Value]                                                     NVARCHAR(1024) NOT NULL

,   [InsertedDate]  DATETIME DEFAULT(GETDATE())
,   [InsertedBy]    NVARCHAR(128) NOT NULL
,   [UpdatedDate]   DATETIME DEFAULT (GETDATE())
,   [UpdatedBy]     NVARCHAR(128) NOT NULL
,   [IsActive]      BIT NOT NULL DEFAULT(1)

,   CONSTRAINT  [PK_metadata_SourceSystemTenantSourceSystemEntityParameterOverride] PRIMARY KEY ([SourceSystemTenantSourceSystemEntityId], [SourceSystemEntityId], [Key])
,   CONSTRAINT  [FK_metadata_SSTSSEParameterOverride_SSTSSEId_metadata_SSTSSE_SSTSSEId] FOREIGN KEY ([SourceSystemTenantSourceSystemEntityId]) REFERENCES [metadata].[SourceSystemTenantSourceSystemEntity]([SourceSystemTenantSourceSystemEntityId])
,   CONSTRAINT  [FK_metadata_SSEParameters_SourceSystemEntityId_metadata_SourceSystemEntity_SourceSystemEntityId] FOREIGN KEY ([SourceSystemEntityId]) REFERENCES [metadata].[SourceSystemEntity]([SourceSystemEntityId])
);

CREATE OR ALTER VIEW     [metadata].[LastJobRun]
AS
    SELECT
        [JR].[JobRunId]
    ,   [JR].[JobId]
    ,   [J].[JobName]
    ,   [JR].[InsertedDate]
    ,   [JR].[InsertedBy]
    FROM    [metadata].[JobRun]     AS  [JR]

    INNER JOIN  (
        SELECT
            MAX([JobRunId]) AS  [JobRunId]
        FROM    [metadata].[JobRun]
        GROUP BY    [JobId]
    )                               AS  [MOST_RECENT_JOB_RUN]
        ON  [JR].[JobRunId] = [MOST_RECENT_JOB_RUN].[JobRunId]

    INNER JOIN  [metadata].[Job]    AS  [J]
        ON          [J].[JobId] = [JR].[JobId]
GO

CREATE OR ALTER PROCEDURE   [metadata].[AddJobRunLog]
(
    @JobRunId       BIGINT
,   @LogBy          NVARCHAR(64)        =   NULL
,   @LogType        VARCHAR(64)
,   @LogValue       NVARCHAR(MAX)
)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [metadata].[JobRun] WHERE [JobRunId] = @JobRunId)
        RAISERROR(15600, -1, -1, '[metadata].[AddJobRunLog] :: Given Job Run doesn''t exist')

    INSERT INTO     [metadata].[JobRunLog]
    (
            [JobRunId]
        ,   [LogType]
        ,   [LogValue]
        ,   [InsertedDate]
        ,   [InsertedBy]   
    )
    OUTPUT
            [INSERTED].[JobRunId]
        ,   [INSERTED].[LogType]
        ,   CONCAT(LEFT([INSERTED].[LogValue], 25), '...')  AS  [LogValue]
        ,   [INSERTED].[InsertedDate]
        ,   [INSERTED].[InsertedBy]
    VALUES
    (
            @JobRunId
        ,   @LogType
        ,   @LogValue
        ,   GETDATE()
        ,   COALESCE(@LogBy, CURRENT_USER)
    )
END;
GO

CREATE OR ALTER PROCEDURE   [metadata].[CancelJobRun]
(
    @JobRunId       BIGINT
,   @CancelledBy    NVARCHAR(64)    =   NULL
)
AS
BEGIN
    IF  NOT EXISTS (SELECT 1 FROM [metadata].[JobRun] WHERE [JobRunId] = @JobRunId)
        RAISERROR(15600, -1, -1, '[metadata].[CancelJobRun] :: Given Job Run Id doesn''t exist')

    UPDATE  [metadata].[JobRun]
    SET
            [JobStatusId]   =   4   -- [metadata].[JobStatus] / Cancelled
    OUTPUT
            [INSERTED].[JobRunId]
        ,   [INSERTED].[JobStatusId]    AS  [NewJobStatusId]
        ,   [DELETED].[JobStatusId]     AS  [OldJobStatusId]
    WHERE
        [JobRunId]  =   @JobRunId
END;
GO

CREATE OR ALTER PROCEDURE   [metadata].[CompleteJobRun]
(
    @JobRunId       BIGINT
,   @CompletedBy    NVARCHAR(64)    =   NULL
,   @JobStatusId    INT
)
AS
BEGIN
    IF  NOT EXISTS (SELECT 1 FROM [metadata].[JobRun] WHERE [JobRunId] = @JobRunId)
        RAISERROR(15600, -1, -1, '[metadata].[CompleteJobRun] :: Given Job Run doesn''t exist')

    IF  NOT EXISTS (SELECT 1 FROM [metadata].[JobStatus] WHERE [JobStatusId] = @JobStatusId)
        RAISERROR(15600, -1, -1, '[metadata].[CompleteJobRun] :: Given Job Status doesn''t exist')

    UPDATE  [metadata].[JobRun]
    SET
            [JobStatusId]   =   @JobStatusId
    OUTPUT
            [INSERTED].[JobRunId]
        ,   [INSERTED].[JobStatusId]    AS  [NewJobStatusId]
        ,   [DELETED].[JobStatusId]     AS  [OldJobStatusId]
    WHERE
        [JobRunId]  =   @JobRunId
END;
GO

CREATE OR ALTER PROCEDURE   [metadata].[GetEnvironmentConfig]
(
    @EnvironmentName    VARCHAR(32) =   NULL
)
AS
BEGIN

    IF  @EnvironmentName IS NULL
        RAISERROR(15600, -1, -1, '[metadata].[GetEnvironmentConfig]')

    SELECT
            [E].[EnvironmentId]
        ,   [E].[EnvironmentName]
        ,   [EP].[EnvironmentParametersJson]
    FROM    [metadata].[Environment]                AS  [E]

    INNER JOIN  (
        SELECT
                [_EP].[EnvironmentId]
            ,   '{' + STRING_AGG( '"' + [_EP].[Key] + '":"' + STRING_ESCAPE([_EP].[Value], 'json') + '"', ',') + '}'    AS  [EnvironmentParametersJson]
        FROM    [metadata].[EnvironmentParameters]  AS  [_EP]
        WHERE   [_EP].[IsActive] = 1
        GROUP BY    [_EP].[EnvironmentId]
    )												AS	[EP]
        ON      [E].[IsActive]          =   1
            AND [E].[EnvironmentName]   =   @EnvironmentName
            AND [EP].[EnvironmentId]    =   [E].[EnvironmentId]
END;
GO
CREATE OR ALTER PROCEDURE   [metadata].[GetExtractedFiles]
(
    @JobRunId           BIGINT
,   @ExtractionLogType  VARCHAR(64)     =   'DataExtraction'
)
AS
BEGIN
    IF  NOT EXISTS (SELECT 1 FROM [metadata].[JobRun] WHERE [JobRunId] = @JobRunId)
        RAISERROR(15600, -1, -1, '[metadata].[GetExtractedFiles] :: Given Job Run doesn''t exist')

    SELECT
        *
    FROM    [metadata].[JobRunLog]      AS  [JRL]

    WHERE   [JRL].[JobRunId]    =   @JobRunId
        AND [JRL].[LogType]     =   @ExtractionLogType
END;
GO

CREATE OR ALTER PROCEDURE   [metadata].[GetJobConfig]
(
    @JobName            VARCHAR(64)     =   NULL
,   @EnvironmentName    VARCHAR(32)     =   NULL
)
AS
BEGIN

    IF  @JobName IS NULL
        RAISERROR(15600, -1, -1, '[metadata].[GetJobConfig] :: @JobName is null')

    IF  @EnvironmentName IS NULL
        RAISERROR(15600, -1, -1, '[metadata].[GetJobConfig] :: @EnvironmentName is null')

    SELECT
        [ENV].[EnvironmentId]
    ,   [ENV].[EnvironmentName]
    ,   [J].[JobId]
    ,   [J].[JobName]
    ,   [SS].[SourceSystemId]
    ,   [SS].[SourceSystemName]
    ,   [SST].[SourceSystemTenantId]
    ,   [SST].[SourceSystemTenantName]
    ,   [SSE].[SourceSystemEntityId]
    ,   [SSE].[SourceSystemEntityName]
    ,   [SSEP].[SourceSystemEntityParametersJson]
    ,   FORMAT(
            COALESCE([SSTSSE].[CheckpointDatetime], '1900-01-01 00:00:00.0000000')
        ,   'yyyy-MM-dd HH:mm:ss.fffffff'
        )                                           AS  [CheckpointDatetime]
    FROM    [metadata].[Job]                                AS  [J]

    INNER JOIN  [metadata].[Environment]                    AS  [ENV]
        ON          [J].[IsActive]                  = 1
            AND     [ENV].[IsActive]                = 1
            AND     UPPER([ENV].[EnvironmentName])  = UPPER(@EnvironmentName)
            AND     [J].[EnvironmentId]             = [ENV].[EnvironmentId]

    INNER JOIN  [metadata].[JobSourceSystemTenant]          AS  [JSST]
        ON          [J].[IsActive]      = 1
            AND     [JSST].[IsActive]   = 1
            AND     [J].[JobName]       = @JobName
            AND     [JSST].[JobId]      = [J].[JobId]

    INNER JOIN  [metadata].[SourceSystemTenant]             AS  [SST]
        ON          [SST].[IsActive]                = 1
            AND     [JSST].[IsActive]               = 1
            AND     [SST].[SourceSystemTenantId]    = [JSST].[SourceSystemTenantId]

    INNER JOIN  [metadata].[SourceSystemTenantSourceSystemEntity]   AS  [SSTSSE]
        ON          [SST].[IsActive]                = 1
            AND     [SSTSSE].[IsActive]             = 1
            AND     [SST].[SourceSystemTenantId]    = [SSTSSE].[SourceSystemTenantId]
            
    INNER JOIN  [metadata].[SourceSystemEntity]             AS  [SSE]
        ON          [SSE].[IsActive]                = 1
            AND     [SSTSSE].[IsActive]             = 1
            AND     [SSE].[SourceSystemEntityId]    = [SSTSSE].[SourceSystemEntityId]

    INNER JOIN  [metadata].[SourceSystem]                   AS  [SS]
        ON          [SS].[IsActive]         = 1
            AND     [SSE].[IsActive]        = 1
            AND     [SS].[SourceSystemId]   = [SSE].[SourceSystemId]

    
    INNER JOIN  (
        SELECT
            [_SSEP].[SourceSystemEntityId]
        ,   '{' + STRING_AGG( '"' + [_SSEP].[Key] + '":"' + STRING_ESCAPE([_SSEP].[Value], 'json') + '"', ',' ) + '}'   AS [SourceSystemEntityParametersJson]
        FROM        [metadata].[SourceSystemEntityParameters]   AS  [_SSEP]

        GROUP BY    [_SSEP].[SourceSystemEntityId]
    )                                                       AS  [SSEP]
        ON          [SSEP].[SourceSystemEntityId]   = [SSE].[SourceSystemEntityId]
  
END;
GO

CREATE OR ALTER PROCEDURE   [metadata].[GetLoadedFiles]
(
    @JobRunId           BIGINT
,   @ExtractionLogType  VARCHAR(64)     =   'DataLoad'
)
AS
BEGIN
    IF  NOT EXISTS (SELECT 1 FROM [metadata].[JobRun] WHERE [JobRunId] = @JobRunId)
        RAISERROR(15600, -1, -1, '[metadata].[GetExtractedFiles] :: Given Job Run doesn''t exist')

    SELECT
        *
    FROM    [metadata].[JobRunLog]      AS  [JRL]

    WHERE   [JRL].[JobRunId]    =   @JobRunId
        AND [JRL].[LogType]     =   @ExtractionLogType
END;
GO

CREATE OR ALTER PROCEDURE   [metadata].[StartJobRun]
(
    @JobName        VARCHAR(64)
,   @StartedBy      NVARCHAR(64)        =   NULL
)
AS
BEGIN
    DECLARE @JobId INT = (SELECT [JobId] FROM [metadata].[Job] WHERE [JobName] = @JobName)

    IF  NOT EXISTS (SELECT @JobId)
        RAISERROR(15600, -1, -1, '[metadata].[StartJobRun] :: JobId of given JobName not found')

    INSERT INTO [metadata].[JobRun]
    (
            [JobId]
        ,   [JobStatusId]
        ,   [InsertedDate]
        ,   [InsertedBy]
    )
    OUTPUT
            [INSERTED].[JobRunId]
        ,   [INSERTED].[InsertedDate]
        ,   [INSERTED].[InsertedBy]
    VALUES
    (
            @JobId
        ,   1   -- [metadata].[JobStatus] / In-Progress
        ,   GETDATE()
        ,   COALESCE(@StartedBy, CURRENT_USER)
    )
END;
GO

CREATE OR ALTER PROCEDURE   [metadata].[UpdateSourceSystemTenantEntityCheckpoint]
(
    @SourceSystemEntityId       INT
,   @SourceSystemTenantId       INT
,   @NewCheckpointDatetime      VARCHAR(32)
)
AS
BEGIN
    IF  NOT EXISTS (SELECT 1 FROM [metadata].[SourceSystemTenantSourceSystemEntity] WHERE [SourceSystemEntityId] = @SourceSystemEntityId AND [SourceSystemTenantId] = @SourceSystemTenantId)
        RAISERROR(15600, -1, 1, '[metadata].[UpdateSourceSystemTenantEntityCheckpoint] :: Given SourceSystemEntityId & SourceSystemTenantId combination doesn''t exist')

    DECLARE @_NC DATETIME2 = TRY_CAST(@NewCheckpointDatetime AS DATETIME2)
    IF @_NC IS NULL
        RAISERROR(15600, -1, 2, '[metadata].[UpdateSourceSystemTenantEntityCheckpoint] :: Given NewCheckpointDatetime cannot be cast to DATETIME2')

    IF  EXISTS (SELECT 1 FROM [metadata].[SourceSystemTenantSourceSystemEntity] WHERE [SourceSystemEntityId] = @SourceSystemEntityId AND [SourceSystemTenantId] = @SourceSystemTenantId AND [CheckpointDatetime] > @_NC)
        RAISERROR(15600, -1, 3, '[metadata].[UpdateSourceSystemTenantEntityCheckpoint] :: Given NewCheckpointDatetime cannot be set before the previous checkpoint')

    UPDATE  [metadata].[SourceSystemTenantSourceSystemEntity]
        SET     [CheckpointDatetime]    =   @_NC
    WHERE   [SourceSystemTenantId]  =   @SourceSystemTenantId
        AND [SourceSystemEntityId]  =   @SourceSystemEntityId

    -- Return 0 for success
    SELECT 0
END;
GO