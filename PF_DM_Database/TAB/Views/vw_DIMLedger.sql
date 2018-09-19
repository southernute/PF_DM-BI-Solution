


CREATE VIEW [TAB].[vw_DIMLedger]
AS

SELECT dimL.LedgerSK
	,dimL.LedgerName
	,dimL.LedgerGroupCD
	,dimLG.LedgerGroupName
	,dimL.RecordCurrentFlag
	,dimL.RecordDeletedFlag
	-- Current Values
	,dimLc.LedgerName AS currentLedgerName
	,dimLc.LedgerGroupCD AS currentLedgerGroupCD
	,dimLGc.LedgerGroupName AS currentLedgerGroupName

FROM [SUGF_FIN_DM].dm.DIMLedger dimL
INNER JOIN [SUGF_FIN_DM].dm.DIMLedgerGroup dimLG ON dimLG.LedgerGroupCD = dimL.LedgerGroupCD
	AND dimLG.RecordCurrentFlag = 1
-- Current Values
INNER JOIN [SUGF_FIN_DM].dm.DIMLedger dimLc ON dimLc.LedgerSK = dimL.LedgerSK
	AND dimLc.RecordCurrentFlag = 1
INNER JOIN [SUGF_FIN_DM].dm.DIMLedgerGroup dimLGc ON dimLGc.LedgerGroupCD = dimLc.LedgerGroupCD
	AND dimLGc.RecordCurrentFlag = 1;