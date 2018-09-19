

CREATE VIEW [TAB].[vw_DimSource]

AS

SELECT  [SourceSK]
      ,[SourceCD]
      ,[SourceDesc]
      ,[SourceEffectiveDate]
      ,[SourceStatusCD]
  FROM [SUGF_FIN_DM].[dm].[DIMSource]
  WHERE RecordCurrentFlag = 1;