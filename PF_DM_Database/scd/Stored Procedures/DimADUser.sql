


CREATE PROCEDURE [scd].[DimADUser]

AS

/**************************************************************************
** DATE: 12/12/2017
** BY: RevGen Partners - Chris Brown
** PURPOSE: Create AD User for MDS security
** CHANGE LOG:
			
**************************************************************************/
SET NOCOUNT ON;

SELECT	DISTINCT 
		CAST(LoginID AS NVARCHAR(250)) AS Code
		,CAST(Name + ' (' + Domain + ')' AS NVARCHAR(250)) AS Name
		,CAST(SamAccountName AS NVARCHAR(250)) AS LoginName
		,CAST(IsEnabled AS NCHAR(1)) AS IsEnabled
FROM	SUGF_FIN_DM.dm.DIMADUser
WHERE	ADUserSK <> 0
		AND RecordCurrentFlag = 1;