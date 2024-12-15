MERGE INTO  [metadata].[Environment]    AS  [TRG]
USING   (
    SELECT 1
)
                                        AS  [SRC]
ON  [TRG].[KEY] = [SRC].[KEY]

WHEN MATCHED
THEN UPDATE
    SET
        [TRG].[VALUE]   =   [SRC].[VALUE]

WHEN NOT MATCHED BY TARGET
THEN INSERT ([KEY], [VALUE])
VALUES ()

WHEN NOT MATCHED BY SOURCE
THEN DELETE
;GO