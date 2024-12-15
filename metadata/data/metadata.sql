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
        1               AS  [JobId]
    ,   'Dummy Job'     AS  [JobName]
    ,   1               AS  [EnvironmentId]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   1               AS  [IsActive]

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
        1               AS  [SourceSystemId]
    ,   'Dummy SS'      AS  [SourceSystemName]
    ,   1               AS  [EnvironmentId]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   1               AS  [IsActive]

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
        1               AS  [SourceSystemTenantId]
    ,   'Dummy SST'     AS  [SourceSystemTenantName]
    ,   1               AS  [SourceSystemId]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   1               AS  [IsActive]

UNION ALL SELECT 2, 'Dummy SST2', 1, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
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
        1               AS  [SourceSystemEntityId]
    ,   'Dummy SSE'     AS  [SourceSystemEntityName]
    ,   1               AS  [SourceSystemId]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   1               AS  [IsActive]

UNION ALL SELECT 2, 'Dummy SSE2', 1, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
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
    ,   1               AS  [IsActive]

UNION ALL SELECT 1, 'Key2', 'Value', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
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


MERGE INTO  [metadata].[ModelEntity]    AS  [TRG]
USING   (
    SELECT
        1               AS  [ModelEntityId]
    ,   'ModelName'     AS  [ModelEntityName]
    ,   2               AS  [EnvironmentId]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   1               AS  [IsActive]

UNION ALL SELECT 1, 'ModelName2', 2, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
)
                                        AS  [SRC]
ON      [TRG].[ModelEntityId]   = [SRC].[ModelEntityId]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[ModelEntityName]     =   [SRC].[ModelEntityName]
    ,   [TRG].[EnvironmentId]       =   [SRC].[EnvironmentId]
    ,   [TRG].[UpdatedBy]           =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate]         =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]            =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([ModelEntityId], [ModelEntityName], [EnvironmentId], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[ModelEntityId], [SRC].[ModelEntityName], [SRC].[EnvironmentId], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[ModelEntityParameters]    AS  [TRG]
USING   (
    SELECT
        1               AS  [ModelEntityId]
    ,   'Key'           AS  [Key]
    ,   'Value'         AS  [Value]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   1               AS  [IsActive]

UNION ALL SELECT 1, 'Key2', 'Value', GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
)
                                        AS  [SRC]
ON      [TRG].[ModelEntityId]   = [SRC].[ModelEntityId]
    AND [TRG].[Key]             = [SRC].[Key]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[Value]           =   [SRC].[Value]
    ,   [TRG].[UpdatedBy]       =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate]     =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]        =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([ModelEntityId], [Key], [Value], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[ModelEntityId], [SRC].[Key], [SRC].[Value], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO


MERGE INTO  [metadata].[SourceSystemEntityModelEntity]    AS  [TRG]
USING   (
    SELECT
        1               AS  [ModelEntityId]
    ,   1               AS  [SourceSystemEntityId]
    ,   GETDATE()       AS  [InsertedDate]
    ,   CURRENT_USER    AS  [InsertedBy]
    ,   GETDATE()       AS  [UpdatedDate]
    ,   CURRENT_USER    AS  [UpdatedBy]
    ,   1               AS  [IsActive]

UNION ALL SELECT 2, 2, GETDATE(), CURRENT_USER, GETDATE(), CURRENT_USER, 1
)
                                        AS  [SRC]
ON      [TRG].[ModelEntityId]           = [SRC].[ModelEntityId]
    AND [TRG].[SourceSystemEntityId]    = [SRC].[SourceSystemEntityId]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[UpdatedBy]       =   [SRC].[UpdatedBy]
    ,   [TRG].[UpdatedDate]     =   [SRC].[UpdatedDate]
    ,   [TRG].[IsActive]        =   [SRC].[IsActive]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([ModelEntityId], [SourceSystemEntityId], [InsertedDate], [InsertedBy], [UpdatedDate], [UpdatedBy], [IsActive])
VALUES ([SRC].[ModelEntityId], [SRC].[SourceSystemEntityId], [SRC].[InsertedDate], [SRC].[InsertedBy], [SRC].[UpdatedDate], [SRC].[UpdatedBy], [SRC].[IsActive])

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO