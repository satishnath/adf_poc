MERGE INTO  [metadata].[Environment]    AS  [TRG]
USING   (
    SELECT
        1               AS  [EnvironmentId]
    ,   'DEV'           AS  [EnvironmentName]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   1               AS  [IsActive]

    UNION ALL   SELECT  2,  'UAT',      GETDATE(),  CURRENT_USER,   1
    UNION ALL   SELECT  3,  'PROD',     GETDATE(),  CURRENT_USER,   1
)
                                        AS  [SRC]
ON  [TRG].[EnvironmentId] = [SRC].[EnvironmentId]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[EnvironmentName] =   [SRC].[EnvironmentName]
    ,   [TRG].[IsActive]        =   [SRC].[IsActive]  

WHEN NOT MATCHED BY TARGET
THEN INSERT ([EnvironmentId], [EnvironmentName], [InsertedDate], [InsertedBy], [IsActive])
VALUES ([SRC].[EnvironmentId], [SRC].[EnvironmentName], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[EnvironmentParameters]    AS  [TRG]
USING   (
    SELECT
        1               AS  [EnvironmentId]
    ,   'environment'   AS  [Key]
    ,   'DEV'           AS  [Value]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   1               AS  [IsActive]

UNION ALL   SELECT  2,  'environment',  'UAT',  GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL   SELECT  3,  'environment',  'PROD',  GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
)
                                        AS  [SRC]
ON      [TRG].[EnvironmentId]   = [SRC].[EnvironmentId]
    AND [TRG].[Key]             = [SRC].[Key]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[Value]       =   [SRC].[Value]
    ,   [TRG].[UpdatedBy]   =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate] =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]    =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([EnvironmentId], [Key], [Value], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[EnvironmentId], [SRC].[Key], [SRC].[Value], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[JobStatus]    AS  [TRG]
USING   (
    SELECT
        1               AS  [JobStatusId]
    ,   'In-Progress'   AS  [JobStatusName]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]

UNION ALL   SELECT  2,  'Succeeded',    GETDATE(), CURRENT_USER
UNION ALL   SELECT  3,  'Failed',       GETDATE(), CURRENT_USER
UNION ALL   SELECT  4,  'Cancelled',    GETDATE(), CURRENT_USER
)
                                        AS  [SRC]
ON      [TRG].[JobStatusId]   = [SRC].[JobStatusId]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[JobStatusName]   =   [SRC].[JobStatusName]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([JobStatusId], [JobStatusName], [InsertedDate], [InsertedBy])
VALUES ([SRC].[JobStatusId], [SRC].[JobStatusName], [SRC].[InsertedDate], [SRC].[InsertedBy])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[Job]    AS  [TRG]
USING   (
    SELECT
        1                           AS  [JobId]
    ,   'GCP Bucket File Copy'      AS  [JobName]
    ,   1                           AS  [EnvironmentId]
    ,   GETDATE()                   AS  [InsertedDate]
    ,   CURRENT_USER                AS  [InsertedBy]
    ,   GETDATE()                   AS  [UpdatedDate]
    ,   CURRENT_USER                AS  [UpdatedBy]
    ,   1                           AS  [IsActive]

)
                                        AS  [SRC]
ON      [TRG].[JobId]   = [SRC].[JobId]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[JobName]         =   [SRC].[JobName]
    ,   [TRG].[EnvironmentId]   =   [SRC].[EnvironmentId]
    ,   [TRG].[UpdatedBy]       =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate]     =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]        =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([JobId], [JobName], [EnvironmentId], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[JobId], [SRC].[JobName], [SRC].[EnvironmentId], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO

MERGE INTO  [metadata].[SourceSystem]    AS  [TRG]
USING   (
    SELECT
        1                           AS  [SourceSystemId]
    ,   'GCP Bucket File Copy'      AS  [SourceSystemName]
    ,   1                           AS  [EnvironmentId]
    ,   GETDATE()                   AS  [InsertedDate]
    ,   CURRENT_USER                AS  [InsertedBy]
    ,   GETDATE()                   AS  [UpdatedDate]
    ,   CURRENT_USER                AS  [UpdatedBy]
    ,   1                           AS  [IsActive]

)
                                        AS  [SRC]
ON      [TRG].[SourceSystemId]   = [SRC].[SourceSystemId]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[SourceSystemName]    =   [SRC].[SourceSystemName]
    ,   [TRG].[EnvironmentId]       =   [SRC].[EnvironmentId]
    ,   [TRG].[UpdatedBy]           =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate]         =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]            =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([SourceSystemId], [SourceSystemName], [EnvironmentId], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[SourceSystemId], [SRC].[SourceSystemName], [SRC].[EnvironmentId], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[SourceSystemTenant]    AS  [TRG]
USING   (
    SELECT
        1                           AS  [SourceSystemTenantId]
    ,   'GCP Bucket File Copy'      AS  [SourceSystemTenantName]
    ,   1                           AS  [SourceSystemId]
    ,   GETDATE()                   AS  [InsertedDate]
    ,   CURRENT_USER                AS  [InsertedBy]
    ,   GETDATE()                   AS  [UpdatedDate]
    ,   CURRENT_USER                AS  [UpdatedBy]
    ,   1                           AS  [IsActive]

--UNION ALL SELECT 2, 'Dummy SST2', 1, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
)
                                        AS  [SRC]
ON      [TRG].[SourceSystemTenantId]   = [SRC].[SourceSystemTenantId]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[SourceSystemTenantName]  =   [SRC].[SourceSystemTenantName]
    ,   [TRG].[SourceSystemId]          =   [SRC].[SourceSystemId]
    ,   [TRG].[UpdatedBy]               =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate]             =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]                =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([SourceSystemTenantId], [SourceSystemTenantName], [SourceSystemId], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[SourceSystemTenantId], [SRC].[SourceSystemTenantName], [SRC].[SourceSystemId], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[JobSourceSystemTenant]    AS  [TRG]
USING   (
    SELECT
        1               AS  [JobId]
    ,   1               AS  [SourceSystemTenantId]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   1               AS  [IsActive]

UNION ALL SELECT 1, 2, GETDATE(), CURRENT_USER, 1
)
                                        AS  [SRC]
ON      [TRG].[JobId]                  = [SRC].[JobId]
    AND [TRG].[SourceSystemTenantId]   = [SRC].[SourceSystemTenantId]

/*
WHEN MATCHED
THEN UPDATE
    SET
*/

WHEN NOT MATCHED BY TARGET
THEN INSERT ([JobId], [SourceSystemTenantId], [InsertedDate], [InsertedBy], [IsActive])
VALUES ([SRC].[JobId], [SRC].[SourceSystemTenantId], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[SourceSystemEntity]    AS  [TRG]
USING   (
    SELECT
        1                                       AS  [SourceSystemEntityId]
    ,   'GCP Bucket File Copy - Folder 1'       AS  [SourceSystemEntityName]
    ,   1                                       AS  [SourceSystemId]
    ,   GETDATE()                               AS  [InsertedDate]
    ,   CURRENT_USER                            AS  [InsertedBy]
    ,   GETDATE()                               AS  [UpdatedDate]
    ,   CURRENT_USER                            AS  [UpdatedBy]
    ,   1                                       AS  [IsActive]

UNION ALL SELECT 2, 'GCP Bucket File Copy - Folder 2', 1, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
)
                                        AS  [SRC]
ON      [TRG].[SourceSystemEntityId]   = [SRC].[SourceSystemEntityId]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[SourceSystemEntityName]  =   [SRC].[SourceSystemEntityName]
    ,   [TRG].[SourceSystemId]          =   [SRC].[SourceSystemId]
    ,   [TRG].[UpdatedBy]               =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate]             =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]                =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([SourceSystemEntityId], [SourceSystemEntityName], [SourceSystemId], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[SourceSystemEntityId], [SRC].[SourceSystemEntityName], [SRC].[SourceSystemId], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[SourceSystemEntityParameters]    AS  [TRG]
USING   (
    SELECT
        1               AS  [SourceSystemEntityId]
    ,   'Key'           AS  [Key]
    ,   'Value'         AS  [Value]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   0               AS  [IsActive]

-- GCP Bucket File Copy - Folder 1
UNION ALL SELECT 1, 'SourceGcpBucketName', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 1, 'SourceGcpBucketDirectoryPath', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 1, 'SourceGcpBucketAccessKeyId', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 1, 'SourceGcpBucketSecretAccessKeySecretName', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 1, 'SourceGcpBucketFilePath', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 1, 'Adls2Container', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 1, 'Adls2FileName', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1

-- GCP Bucket File Copy - Folder 2
UNION ALL SELECT 2, 'SourceGcpBucketName', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 2, 'SourceGcpBucketDirectoryPath', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 2, 'SourceGcpBucketAccessKeyId', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 2, 'SourceGcpBucketSecretAccessKeySecretName', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 2, 'SourceGcpBucketFilePath', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 2, 'Adls2Container', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
UNION ALL SELECT 2, 'Adls2FileName', 'PLACEHOLDER', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
)
                                        AS  [SRC]
ON      [TRG].[SourceSystemEntityId]   = [SRC].[SourceSystemEntityId]
    AND [TRG].[Key]                    = [SRC].[Key]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[Value]           =   [SRC].[Value]
    ,   [TRG].[UpdatedBy]       =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate]     =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]        =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([SourceSystemEntityId], [Key], [Value], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[SourceSystemEntityId], [SRC].[Key], [SRC].[Value], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO
