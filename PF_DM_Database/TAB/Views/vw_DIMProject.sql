


CREATE VIEW [TAB].[vw_DIMProject]
AS



SELECT DISTINCT dimP.ProjectSK
	,dimP.ProjectID
	,dimP.ProjectDesc
	,dimP.BusinessUnitID
	,dimBU.BusinessUnitShortDesc
	,dimP.RecordCurrentFlag
	,dimP.RecordDeletedFlag
	-- Current Values
	,dimPc.ProjectDesc AS currentProjectDesc
	,dimPc.BusinessUnitID AS currentBusinessUnitID
	,dimBUc.BusinessUnitShortDesc AS currentBusinessUnitShortDesc
	-- Formatted Values
	,CASE 
		WHEN dimPd.ProjectSK IS NULL
			THEN dimPc.ProjectDesc
		ELSE dimPd.ProjectDesc + ' (' + dimPc.BusinessUnitID + ')'
		END AS fmtProjectDesc

FROM [SUGF_FIN_DM].dm.DIMProject dimP
INNER JOIN [SUGF_FIN_DM].dm.DIMBusinessUnit dimBU ON dimBU.BusinessUnitID = dimP.BusinessUnitID
	AND dimBU.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMProject dimPc ON dimPc.ProjectSK = dimP.ProjectSK
	AND dimPc.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMBusinessUnit dimBUc ON dimBUc.BusinessUnitID = dimPc.BusinessUnitID
	AND dimBUc.RecordCurrentFlag = 1
LEFT OUTER JOIN [SUGF_FIN_DM].dm.DIMProject dimPd ON dimPd.ProjectDesc = dimP.ProjectDesc
	AND dimPd.BusinessUnitID <> dimP.BusinessUnitID;