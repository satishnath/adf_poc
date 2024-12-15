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