

CREATE VIEW [TAB].[vw_DIMAccount]
AS



SELECT dimA.AccountSK
	,dimA.AccountNum
	,dimA.AccountDesc
	,dimA.AccountShortDesc
	,dimA.AccountTypeDesc
	,dimA.AccountTypeShortDesc
	,dimS.StatusDesc AS accountStatusDesc
	-- PS Tree
	,isnull(dimAT.TreeName, 'FS_ACCOUNT') AS PSTreeName
	,CASE 
		WHEN dimA.AccountSK = 0
			OR dimAT.PSEffDate = dimDmax.CalendarDate
			THEN 'Current'
		WHEN dimAT.PSEffDate IS NULL
			THEN 'Unspecified'
		WHEN dimAT.PSEffDate < dimDmin.CalendarDate
			THEN cast(dimDmin.CalendarDate AS VARCHAR)
		ELSE cast(dimAT.PSEffDate AS VARCHAR)
		END AS PSTreeEffDate
	,CASE 
		WHEN dimA.AccountSK = 0
			OR dimAT.PSEffDate = dimDmax.CalendarDate
			THEN dimDmax.DateSK * - 1
		WHEN dimAT.PSEffDate IS NULL
			THEN dimDmax.DateSK + 1
		ELSE cast(convert(VARCHAR, dimAT.PSEffDate, 112) AS INT)
		END AS PSTreeEffDateSortOrder
	,isnull(dimAT.Level10Name, 'Unspecified') AS PSLevel10Name
	,isnull(dimAT.Level10Desc, 'Unspecified') AS PSLevel10Desc
	,isnull(dimAT.Level9Name, 'Unspecified') AS PSLevel9Name
	,isnull(dimAT.Level9Desc, 'Unspecified') AS PSLevel9Desc
	,isnull(dimAT.Level8Name, 'Unspecified') AS PSLevel8Name
	,isnull(dimAT.Level8Desc, 'Unspecified') AS PSLevel8Desc
	,isnull(dimAT.Level7Name, 'Unspecified') AS PSLevel7Name
	,isnull(dimAT.Level7Desc, 'Unspecified') AS PSLevel7Desc
	,isnull(dimAT.Level6Name, 'Unspecified') AS PSLevel6Name
	,isnull(dimAT.Level6Desc, 'Unspecified') AS PSLevel6Desc
	,isnull(dimAT.Level5Name, 'Unspecified') AS PSLevel5Name
	,isnull(dimAT.Level5Desc, 'Unspecified') AS PSLevel5Desc
	,isnull(dimAT.Level4Name, 'Unspecified') AS PSLevel4Name
	,isnull(dimAT.Level4Desc, 'Unspecified') AS PSLevel4Desc
	,isnull(dimAT.Level3Name, 'Unspecified') AS PSLevel3Name
	,isnull(dimAT.Level3Desc, 'Unspecified') AS PSLevel3Desc
	,isnull(dimAT.Level2Name, 'Unspecified') AS PSLevel2Name
	,isnull(dimAT.Level2Desc, 'Unspecified') AS PSLevel2Desc
	,isnull(dimAT.Level1Name, 'Unspecified') AS PSLevel1Name
	,isnull(dimAT.Level1Desc, 'Unspecified') AS PSLevel1Desc
	,dimA.RecordCurrentFlag
	,dimA.RecordDeletedFlag
	---- Current Values
	,CASE 
		WHEN EXISTS (
				SELECT TOP 1 dimA2.AccountSK
				FROM [SUGF_FIN_DM].dm.DIMAccount dimA2
				WHERE dimA2.AccountDesc = dimA.AccountDesc
					AND dimA2.AccountTypeDesc <> dimA.AccountTypeDesc
				)
			THEN dimAc.AccountDesc + ' (' + dimAc.AccountTypeDesc + ')'
		ELSE dimAc.AccountDesc
		END AS currentAccountDesc
	,dimAc.AccountShortDesc AS currentAccountShortDesc
	,dimAc.AccountTypeDesc AS currentAccountTypeDesc
	,dimAc.AccountTypeShortDesc AS currentAccountTypeShortDesc
	,dimSc.StatusDesc AS currentAccountStatusDesc
	-- Formatted Values
	,CASE dimA.AccountSK
		WHEN 0
			THEN dimAc.AccountDesc
		ELSE cast(dimA.AccountNum AS VARCHAR) + ' - ' + dimAc.AccountDesc
		END AS fmtAccountDesc

FROM [SUGF_FIN_DM].dm.DIMAccount dimA
INNER JOIN [SUGF_FIN_DM].dm.DIMStatus dimS ON dimS.StatusCD = dimA.AccountStatusCD
	AND dimS.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMAccount dimAc ON dimAc.AccountNum = dimA.AccountNum
	AND dimAc.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMStatus dimSc ON dimSc.StatusCD = dimAc.AccountStatusCD
	AND dimSc.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMDate dimD ON dimD.CalendarDate = (
		SELECT min(CalendarDate)
		FROM [SUGF_FIN_DM].dm.DIMDate
		WHERE DateSK > 0
		)
INNER JOIN [SUGF_FIN_DM].dm.DIMDate dimDmin ON dimDmin.CalendarDate = (
		SELECT min(CalendarDate)
		FROM [SUGF_FIN_DM].dm.DIMDate
		WHERE DateSK > 0
		)
INNER JOIN [SUGF_FIN_DM].dm.DIMDate dimDmax ON dimDmax.CalendarDate = (
		SELECT max(PSEffDate)
		FROM [SUGF_FIN_DM].dm.DIMAccountTree
		)
LEFT OUTER JOIN [SUGF_FIN_DM].dm.DIMAccountTree dimAT ON dimA.AccountNum BETWEEN dimAT.AccountRangeMin
		AND dimAT.AccountRangeMax;