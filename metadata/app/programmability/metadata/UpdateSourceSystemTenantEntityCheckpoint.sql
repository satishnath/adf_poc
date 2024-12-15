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