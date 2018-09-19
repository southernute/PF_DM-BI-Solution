



CREATE VIEW [TAB].[vw_DimDepartmentDivision]
AS




SELECT dimD.DepartmentSK
	,D.[Name] AS DepartmentName
	,DIV.[NAME] AS DivisionName
	,DIV.Code AS DivisionCode
	,dimD.DepartmentDesc AS DivisionDesc
	,dimD.DepartmentShortDesc AS DivisionShortDesc
	,dimS.StatusDesc AS DivisionStatusDesc
	,dimD.RecordCurrentFlag
	,dimD.RecordDeletedFlag
	,isnull(dimDT.TreeName, 'FS_DEPARTMENT') AS PSTreeName
	,CASE 
		WHEN dimD.DepartmentSK = 0
			OR dimDT.PSEffDate = dimDmax.CalendarDate
			THEN 'Current'
		WHEN dimDT.PSEffDate IS NULL
			THEN 'Unspecified'
		WHEN dimDT.PSEffDate < dimDmin.CalendarDate
			THEN cast(dimDmin.CalendarDate AS VARCHAR)
		ELSE cast(dimDT.PSEffDate AS VARCHAR)
		END AS PSTreeEffDate
	,CASE 
		WHEN dimD.DepartmentSK = 0
			OR dimDT.PSEffDate = dimDmax.CalendarDate
			THEN dimDmax.DateSK * - 1
		WHEN dimDT.PSEffDate IS NULL
			THEN dimDmax.DateSK + 1
		ELSE cast(convert(VARCHAR, dimDT.PSEffDate, 112) AS INT)
		END AS PSTreeEffDateSortOrder
	,isnull(dimDT.Level10Name, 'Unspecified') AS PSLevel10Name
	,isnull(dimDT.Level10Desc, 'Unspecified') AS PSLevel10Desc
	,isnull(dimDT.Level9Name, 'Unspecified') AS PSLevel9Name
	,isnull(dimDT.Level9Desc, 'Unspecified') AS PSLevel9Desc
	,isnull(dimDT.Level8Name, 'Unspecified') AS PSLevel8Name
	,isnull(dimDT.Level8Desc, 'Unspecified') AS PSLevel8Desc
	,isnull(dimDT.Level7Name, 'Unspecified') AS PSLevel7Name
	,isnull(dimDT.Level7Desc, 'Unspecified') AS PSLevel7Desc
	,isnull(dimDT.Level6Name, 'Unspecified') AS PSLevel6Name
	,isnull(dimDT.Level6Desc, 'Unspecified') AS PSLevel6Desc
	,isnull(dimDT.Level5Name, 'Unspecified') AS PSLevel5Name
	,isnull(dimDT.Level5Desc, 'Unspecified') AS PSLevel5Desc
	,isnull(dimDT.Level4Name, 'Unspecified') AS PSLevel4Name
	,isnull(dimDT.Level4Desc, 'Unspecified') AS PSLevel4Desc
	,isnull(dimDT.Level3Name, 'Unspecified') AS PSLevel3Name
	,isnull(dimDT.Level3Desc, 'Unspecified') AS PSLevel3Desc
	,isnull(dimDT.Level2Name, 'Unspecified') AS PSLevel2Name
	,isnull(dimDT.Level2Desc, 'Unspecified') AS PSLevel2Desc
	,isnull(dimDT.Level1Name, 'Unspecified') AS PSLevel1Name
	,isnull(dimDT.Level1Desc, 'Unspecified') AS PSLevel1Desc
	-- Current Values
	,dimDc.DepartmentDesc AS CurrentDivisionDesc
	,dimDc.DepartmentShortDesc AS CurrentDivisionShortDesc
	,dimSc.StatusDesc AS CurrentDivisionStatusDesc
	-- Formatted Values
	,CASE dimD.DepartmentSK
		WHEN 0
			THEN dimDc.DepartmentDesc
		ELSE CAST(dimD.DepartmentCD AS VARCHAR) + ' - ' + dimDc.DepartmentDesc
		END AS FMTDivisionDesc

FROM [MDS].[mdm].[PF_DIVISION_V1] DIV
  INNER JOIN MDS.mdm.[PF_DEPARTMENT_V1] D
	ON LTRIM(RTRIM(DIV.Code))  =  LTRIM(RTRIM(D.[Division Code_Code]))
INNER JOIN [SUGF_FIN_DM].dm.DIMDepartment dimD  ON LTRIM(RTRIM(DIV.Code)) = dimD.DepartmentCD
INNER JOIN [SUGF_FIN_DM].dm.DIMStatus dimS ON dimS.StatusCD = dimD.DepartmentStatusCD
	AND dimS.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMDepartment dimDc ON dimDc.DepartmentCD = dimD.DepartmentCD
	AND dimDc.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMStatus dimSc ON dimSc.StatusCD = dimDc.DepartmentStatusCD
	AND dimSc.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMDate dimDmin ON dimDmin.CalendarDate = (
		SELECT MIN(CalendarDate)
		FROM [SUGF_FIN_DM].dm.DIMDate
		WHERE DateSK > 0
		)
INNER JOIN [SUGF_FIN_DM].dm.DIMDate dimDmax ON dimDmax.CalendarDate = (
		SELECT MAX(PSEffDate)
		FROM [SUGF_FIN_DM].dm.DIMDepartmentTree
		)
LEFT JOIN [SUGF_FIN_DM].dm.DIMDepartmentTree dimDT ON dimD.DepartmentCD BETWEEN dimDT.DepartmentRangeMin
		AND dimDT.DepartmentRangeMax
		
WHERE D.[Name]  <> 'ALL';