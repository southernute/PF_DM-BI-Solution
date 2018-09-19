CREATE PROCEDURE [MDS].[RebuildMDSTable]
AS

/**************************************************************************
** DATE: 12/12/2017
** BY: RevGen Partners - Chris Brown
** PURPOSE: Rebuild MDS User DepartmentUnit table for MDS Security
** CHANGE LOG:
			
**************************************************************************/
	
	SET NOCOUNT ON;
	
	IF OBJECT_ID('tempdb..#DIncludes') IS NOT NULL BEGIN DROP TABLE #DIncludes END;
	IF OBJECT_ID('tempdb..#DExcludes') IS NOT NULL BEGIN DROP TABLE #DExcludes END;

	
	SELECT * INTO #DIncludes FROM
	(
		SELECT	DISTINCT
				 U.[ID] AS MDSUserKey 
				,U.[Code] AS UserID
				,U.[LoginName] AS LoginName
				,D.DepartmentSK
				,D.DepartmentCD

		 FROM	 [MDS].[mdm].[PF_User_V1] AS U
				INNER JOIN [MDS].[mdm].[PF_User_by_Division_Unit_V1] AS UBU
					ON U.ID = UBU.[User_ID] 
					AND LTRIM(RTRIM(UBU.[Include or Exclude Department_Code])) = '1'
				INNER JOIN [MDS].[mdm].[PF_DIVISION_V1] DIV
					ON LTRIM(RTRIM(UBU.Division_Code)) = DIV.Code
					OR LTRIM(RTRIM(UBU.[Division_Code])) = '*'
				INNER JOIN [SUGF_FIN_DM].[dm].[DIMDepartment] AS D
					ON LTRIM(RTRIM(DIV.Code)) = D.DepartmentCD 

		WHERE	LTRIM(RTRIM(U.IsEnabled_Code)) = '1'  
		) s3


SELECT * INTO #DExcludes FROM
	(
		SELECT	DISTINCT 
				 U.[ID] AS MDSUserKey 
				,U.[Code] AS UserID
				,U.[LoginName] AS LoginName
				,D.DepartmentSK
				,D.DepartmentCD

		FROM	[MDS].[mdm].[PF_User_V1] AS U
				INNER JOIN [MDS].[mdm].[PF_User_by_Division_Unit_V1] AS UBU
					ON U.ID = UBU.[User_ID] 
					AND LTRIM(RTRIM(UBU.[Include or Exclude Department_Code])) = '0'
				INNER JOIN [MDS].[mdm].[PF_DIVISION_V1] DIV
					ON LTRIM(RTRIM(UBU.Division_Code)) = DIV.Code
					OR LTRIM(RTRIM(UBU.[Division_Code])) = '*'
				INNER JOIN [SUGF_FIN_DM].[dm].[DIMDepartment] AS D
					ON LTRIM(RTRIM(DIV.Code)) = D.DepartmentCD 

		WHERE	LTRIM(RTRIM(U.IsEnabled_Code)) = '1'
	) s4
	


INSERT INTO dm.MDSUserDepartmentUnit 
 
	SELECT	DI.MDSUserKey
			,DI.UserID
			,DI.LoginName
			,DI.DepartmentSK
			,DI.DepartmentCD

	FROM	#DIncludes AS DI
			LEFT JOIN	(
							SELECT	MDSUserKey
									,UserID
									,LoginName
									,DepartmentSK
									,DepartmentCD
							FROM	#DExcludes
						) AS DE 
				ON DI.MDSUserKey = DE.MDSUserKey 
				AND DI.UserID = DE.UserID 
				AND DI.DepartmentSK = DE.DepartmentSK

	WHERE	DE.MDSUserKey IS NULL;