



CREATE VIEW [TAB].[vw_FACTLedger]
AS


SELECT BusinessUnitSK
	,LedgerSK
	,AccountSK
	,FundSK
	,DepartmentSK
	,ProjectSK
	,AccountingDateSK
	,PostedBaseAmt
	,PostedTranAmt
	,PostedTotalAmt
	,PSModifiedDate
	,CASE rtrim(ltrim(PSScenario))
		WHEN ''
			THEN 'Unspecified'
		ELSE isnull(cast(PSScenario AS VARCHAR(15)), 'Unspecified')
		END AS PSScenario
	,CASE rtrim(ltrim(Chartfield1))
		WHEN ''
			THEN 'Unspecified'
		ELSE isnull(cast(Chartfield1 AS VARCHAR(15)), 'Unspecified')
		END AS Chartfield1
	,CASE rtrim(ltrim(Chartfield2))
		WHEN ''
			THEN 'Unspecified'
		ELSE isnull(cast(Chartfield2 AS VARCHAR(15)), 'Unspecified')
		END AS Chartfield2
	,CASE rtrim(ltrim(Chartfield3))
		WHEN ''
			THEN 'Unspecified'
		ELSE isnull(cast(Chartfield3 AS VARCHAR(15)), 'Unspecified')
		END AS Chartfield3
	,DataAsOfDate = (SELECT MAX(DTTM_STAMP_SEC) FROM [ETLStage].[SUGF_FIN].[PS_LEDGER])

FROM [SUGF_FIN_DM].dm.FACTLedger
WHERE RecordDeletedFlag = 0
	AND BusinessUnitSK = 34;