

CREATE PROCEDURE [scd].[DimDivision]

AS

/**************************************************************************
** DATE: 12/12/2017
** BY: RevGen Partners - Chris Brown
** PURPOSE: Create Division hierarchy based on spreadsheet from Leah
** CHANGE LOG: 01/23/2018   - CB Updated query to pull in only TRENT data.
			
**************************************************************************/
	
SET NOCOUNT ON;

SELECT DISTINCT CAST(DepartmentCD AS NVARCHAR(10)) AS Code,
CAST(DepartmentDesc AS NVARCHAR(100)) AS [Name]
FROM [SUGF_FIN_DM].[dm].[FACTJournalLine] JL
INNER JOIN [SUGF_FIN_DM].dm.DIMDepartment dimDe ON
		dimDe.DepartmentSK = JL.DepartmentSK
        AND dimDe.RecordCurrentFlag = 1
WHERE JL.BusinessUnitSK = 34;