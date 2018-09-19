


CREATE VIEW [TAB].[vw_DIMBusinessUnit]
AS


SELECT
	dimBU.BusinessUnitSK
	, dimBU.BusinessUnitID
	, dimBU.BusinessUnitDesc
	, dimBU.BusinessUnitShortDesc
	, dimBU.BusinessUnitGroupDesc
	, dimBU.RecordCurrentFlag
	, dimBU.RecordDeletedFlag
	-- Current Values
	, dimBUc.BusinessUnitDesc as currentBusinessUnitDesc
	, dimBUc.BusinessUnitShortDesc as currentBusinessUnitShortDesc
	, dimBUc.BusinessUnitGroupDesc as currentBusinessUnitGroupDesc
FROM
	[SUGF_FIN_DM].dm.DIMBusinessUnit dimBU
	INNER JOIN [SUGF_FIN_DM].dm.DIMBusinessUnit dimBUc on
		dimBUc.BusinessUnitSK = dimBU.BusinessUnitSK
		AND dimBUc.RecordCurrentFlag = 1

	WHERE dimBU.BusinessUnitID = 'TRENT';