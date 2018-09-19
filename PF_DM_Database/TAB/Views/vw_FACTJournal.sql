

CREATE VIEW [TAB].[vw_FACTJournal]
AS



SELECT factJH.BusinessUnitSK
	,dimL.LedgerSK
	,factJH.JournalHeaderSK
	,factJH.SourceSK
	,factJH.JournalStatusSK
	,factJH.AccountingDateSK
	,factJH.JournalDateSK
	,factJH.PostedDateSK
	,factJL.AccountSK
	,factJL.FundSK
	,factJL.DepartmentSK
	,factJL.ProjectSK
	,factJL.JournalID
	,factJL.UnpostSeqNum
	,factJL.JournalLine
	,factJL.JournalLineDesc
	,factJH.JournalHeaderDesc
	,factJL.Chartfield1
	,factJL.Chartfield2
	,factJL.Chartfield3
	,factJL.MonetaryAmt

FROM [SUGF_FIN_DM].dm.FACTJournalLine factJL
INNER JOIN [SUGF_FIN_DM].dm.FACTJournalHeader factJH ON factJH.JournalHeaderSK = factJL.JournalHeaderSK
INNER JOIN [SUGF_FIN_DM].dm.DIMLedgerGroup dimJG ON dimJG.LedgerGroupSK = factJH.LedgerGroupSK
INNER JOIN [SUGF_FIN_DM].dm.DIMLedger dimL ON dimJG.LedgerGroupName = dimL.LedgerName
	OR dimJG.LedgerGroupName = 'Budget'
	AND dimL.LedgerName = 'Amended'
	OR dimJG.LedgerGroupName = 'Other'
	AND dimL.LedgerName = 'Unspecified'
WHERE factJH.BusinessUnitSK = 34;