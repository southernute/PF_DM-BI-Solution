


CREATE VIEW [TAB].[vw_DIMFund]
AS



SELECT - 1 AS FundSK
	,'TCGF' AS FundCD
	,'Total Combined Growth Fund' AS FundDesc
	,'Total Combined Growth Fund' AS FundShortDesc
	,'Active' AS FundStatusDesc
	,1 AS RecordCurrentFlag
	,0 AS RecordDeletedFlag
	-- PS Tree
	,'FS_FUND' AS PSTreeName
	,'Current' AS PSTreeEffDate
	,(
		SELECT cast(convert(VARCHAR, max(PSEffDate), 112) AS INT) * - 1
		FROM [SUGF_FIN_DM].dm.DIMFundTree
		) AS PSTreeEffDateSortOrder
	,'Total Combined Growth Fund' AS PSLevel10Name
	,'Total Combined Growth Fund' AS PSLevel10Desc
	,'Total Combined Growth Fund' AS PSLevel9Name
	,'Total Combined Growth Fund' AS PSLevel9Desc
	,'Total Combined Growth Fund' AS PSLevel8Name
	,'Total Combined Growth Fund' AS PSLevel8Desc
	,'Total Combined Growth Fund' AS PSLevel7Name
	,'Total Combined Growth Fund' AS PSLevel7Desc
	,'Total Combined Growth Fund' AS PSLevel6Name
	,'Total Combined Growth Fund' AS PSLevel6Desc
	,'Total Combined Growth Fund' AS PSLevel5Name
	,'Total Combined Growth Fund' AS PSLevel5Desc
	,'Total Combined Growth Fund' AS PSLevel4Name
	,'Total Combined Growth Fund' AS PSLevel4Desc
	,'Total Combined Growth Fund' AS PSLevel3Name
	,'Total Combined Growth Fund' AS PSLevel3Desc
	,'Total Combined Growth Fund' AS PSLevel2Name
	,'Total Combined Growth Fund' AS PSLevel2Desc
	,'Total Combined Growth Fund' AS PSLevel1Name
	,'Total Combined Growth Fund' AS PSLevel1Desc
	-- Entity
	,'Total Combined Growth Fund' AS ValueCreatedEntityName
	,'Total Combined Growth Fund' AS BUEntityName
	,'Total Combined Growth Fund' AS EntityNameGroup2
	,2001 AS EntityYearEstablished
	-- Current Values
	,'Total Combined Growth Fund' AS currentFundDesc
	,'Total Combined Growth Fund' AS currentFundShortDesc
	,'Active' AS currentFundStatusDesc
	-- Formatted Values
	,'TCGF' AS fmtFundCd
	,'Total Combined Growth Fund' AS fmtFundDesc

UNION

SELECT dimF.FundSK
	,dimF.FundCD
	,dimF.FundDesc
	,dimF.FundShortDesc
	,dimS.StatusDesc AS FundStatusDesc
	,dimF.RecordCurrentFlag
	,dimF.RecordDeletedFlag
	-- PS Tree
	,isnull(dimFT.TreeName, 'FS_FUND') AS PSTreeName
	,CASE 
		WHEN dimF.FundSK = 0
			OR dimFT.PSEffDate = dimDmax.CalendarDate
			THEN 'Current'
		WHEN dimFT.PSEffDate IS NULL
			THEN 'Unspecified'
		WHEN dimFT.PSEffDate < dimDmin.CalendarDate
			THEN cast(dimDmin.CalendarDate AS VARCHAR)
		ELSE cast(dimFT.PSEffDate AS VARCHAR)
		END AS PSTreeEffDate
	,CASE 
		WHEN dimF.FundSK = 0
			OR dimFT.PSEffDate = dimDmax.CalendarDate
			THEN dimDmax.DateSK * - 1
		WHEN dimFT.PSEffDate IS NULL
			THEN dimDmax.DateSK + 1
		ELSE cast(convert(VARCHAR, dimFT.PSEffDate, 112) AS INT)
		END AS PSTreeEffDateSortOrder
	,isnull(dimFT.Level10Name, 'Unspecified') AS PSLevel10Name
	,isnull(dimFT.Level10Desc, 'Unspecified') AS PSLevel10Desc
	,isnull(dimFT.Level9Name, 'Unspecified') AS PSLevel9Name
	,isnull(dimFT.Level9Desc, 'Unspecified') AS PSLevel9Desc
	,isnull(dimFT.Level8Name, 'Unspecified') AS PSLevel8Name
	,isnull(dimFT.Level8Desc, 'Unspecified') AS PSLevel8Desc
	,isnull(dimFT.Level7Name, 'Unspecified') AS PSLevel7Name
	,isnull(dimFT.Level7Desc, 'Unspecified') AS PSLevel7Desc
	,isnull(dimFT.Level6Name, 'Unspecified') AS PSLevel6Name
	,isnull(dimFT.Level6Desc, 'Unspecified') AS PSLevel6Desc
	,isnull(dimFT.Level5Name, 'Unspecified') AS PSLevel5Name
	,isnull(dimFT.Level5Desc, 'Unspecified') AS PSLevel5Desc
	,isnull(dimFT.Level4Name, 'Unspecified') AS PSLevel4Name
	,isnull(dimFT.Level4Desc, 'Unspecified') AS PSLevel4Desc
	,isnull(dimFT.Level3Name, 'Unspecified') AS PSLevel3Name
	,isnull(dimFT.Level3Desc, 'Unspecified') AS PSLevel3Desc
	,isnull(dimFT.Level2Name, 'Unspecified') AS PSLevel2Name
	,isnull(dimFT.Level2Desc, 'Unspecified') AS PSLevel2Desc
	,isnull(dimFT.Level1Name, 'Unspecified') AS PSLevel1Name
	,isnull(dimFT.Level1Desc, 'Unspecified') AS PSLevel1Desc
	-- Entity
	,CASE 
		WHEN dimFT.Level6Name = 'AKA01'
			THEN 'AKA'
		WHEN dimFT.level6Name = 'ALTEN1'
			THEN 'Alternative Energy'
		WHEN dimFT.level6Name IN (
				'RE_NATIONAL'
				,'RE_REGIONAL'
				,'GFPRP_ELIM'
				)
			THEN 'GF Properties'
		WHEN dimFT.Level6Name = 'PVTEQ'
			THEN 'Private Equity'
		WHEN dimFT.Level6Name = 'RED CEDAR'
			THEN 'Red Cedar'
		WHEN dimFT.Level6Name IN (
				'RDWIL'
				,'REDWILLOWDBA'
				,'REDWILLOWELIM'
				,'RED_WILLOW'
				)
			THEN 'Red Willow'
		ELSE 'Unspecified'
		END AS ValueCreatedEntityName
	,CASE 
		WHEN dimFT.Level6Name = 'AKA01'
			THEN 'AKA'
		WHEN dimFT.Level6Name = 'ELIM1'
			THEN 'ELIM1'
		WHEN dimFT.Level6Name = 'ELIM_GASB_TO_FASB'
			THEN 'ELIM2'
		WHEN dimFT.Level6Name IN (
				'OTHER_ROLLUP'
				,'ELIM_FASB'
				,'PNTHR_CLOSE'
				,'CM_ROLLUP'
				)
			THEN 'GF OTHER'
		WHEN dimFT.Level6Name = 'PVTEQ'
			THEN 'GF PRIVATE EQUITY'
		WHEN dimFT.level6Name IN (
				'RE_NATIONAL'
				,'RE_REGIONAL'
				,'GFPRP_ELIM'
				)
			THEN 'GF PROPERTIES'
		WHEN dimFT.Level6Name = 'PNTHR'
			THEN 'PANTHER'
		WHEN dimFT.Level6Name = 'RED CEDAR'
			THEN 'RED CEDAR'
		WHEN dimFT.Level6Name IN (
				'RDWIL'
				,'RED_WILLOW'
				)
			THEN 'RED WILLOW'
		WHEN dimFT.Level6Name = 'ALTEN1'
			THEN 'SU ALT ENERGY'
		ELSE 'Unspecified'
		END AS BUCEntityName
	,CASE 
		WHEN dimFT.Level6Name = 'AKA01'
			THEN 'AKA'
		WHEN dimFT.level6Name = 'ALTEN1'
			THEN 'Alternative Energy'
		WHEN dimFT.level6Name IN (
				'RE_NATIONAL'
				,'RE_REGIONAL'
				,'GFPRP_ELIM'
				)
			THEN 'GF Properties'
		WHEN dimFT.Level6Name = 'PVTEQ'
			THEN 'Private Equity'
		WHEN dimFT.Level6Name = 'RED CEDAR'
			THEN 'Red Cedar'
		WHEN dimFT.Level6Name IN (
				'RDWIL'
				,'REDWILLOWDBA'
				,'REDWILLOWELIM'
				,'RED_WILLOW'
				)
			THEN 'Red Willow'
		WHEN dimFT.Level6Name = 'PNTHR'
			THEN 'Panther'
		ELSE 'Unspecified'
		END AS EntityNameGroup2
	,CASE 
		WHEN dimFT.Level6Name = 'AKA01'
			THEN 2003
		WHEN dimFT.level6Name = 'ALTEN1'
			THEN 2008
		WHEN dimFT.level6Name IN (
				'RE_NATIONAL'
				,'RE_REGIONAL'
				,'GFPRP_ELIM'
				)
			THEN 2001
		WHEN dimFT.Level6Name = 'PVTEQ'
			THEN 2003
		WHEN dimFT.Level6Name = 'RED CEDAR'
			THEN 1994
		WHEN dimFT.Level6Name IN (
				'RDWIL'
				,'REDWILLOWDBA'
				,'REDWILLOWELIM'
				,'RED_WILLOW'
				)
			THEN 1992
		ELSE NULL
		END AS EntityYearEstablished
	-- Current Values
	,dimFc.FundDesc AS currentFundDesc
	,dimFc.FundShortDesc AS currentFundShortDesc
	,dimSc.StatusDesc AS currentFundStatusDesc
	-- Formatted Values
	,CASE dimF.FundSK
		WHEN 0
			THEN 'Unspecified'
		ELSE dimF.FundCD
		END AS fmtFundCd
	,CASE dimF.FundSK
		WHEN 0
			THEN dimFc.FundDesc
		ELSE cast(dimF.FundCD AS VARCHAR) + ' - ' + dimFc.FundDesc
		END AS fmtFundDesc
FROM [SUGF_FIN_DM].dm.DIMFund dimF
INNER JOIN [SUGF_FIN_DM].dm.DIMStatus dimS ON dimS.StatusCD = dimF.FundStatusCD
	AND dimS.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMDate dimDmin ON dimDmin.CalendarDate = (
		SELECT min(CalendarDate)
		FROM [SUGF_FIN_DM].dm.DIMDate
		WHERE DateSK > 0
		)
INNER JOIN [SUGF_FIN_DM].dm.DIMDate dimDmax ON dimDmax.CalendarDate = (
		SELECT max(PSEffDate)
		FROM [SUGF_FIN_DM].dm.DIMFundTree
		)
-- Current Values
INNER JOIN [SUGF_FIN_DM].dm.DIMFund dimFc ON dimFc.FundCD = dimF.FundCD
	AND dimFc.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMStatus dimSc ON dimSc.StatusCD = dimFc.FundStatusCD
	AND dimSc.RecordCurrentFlag = 1
LEFT JOIN [SUGF_FIN_DM].dm.DIMFundTree dimFT ON dimF.FundCD BETWEEN dimFT.FundRangeMin
		AND dimFT.FundRangeMax;