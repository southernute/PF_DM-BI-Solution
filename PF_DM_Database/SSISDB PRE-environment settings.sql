
USE SSISDB;
GO
/**************************************************************************************************

	DEPLOY SSIS - CREATE ENVIRONMENTS
	Written By Chris Brown
	01/10/2018

**************************************************************************************************/


--CREATE THE ENVIRONMENT

EXEC [SSISDB].[catalog].[create_environment] @environment_name=N'Permanent Fund Server Settings', @environment_description=N'', @folder_name=N'PF'

GO



--ADD ENVIRONMENT VARAIBLES

DECLARE @var sql_variant = N'SUD-DB-DEV1\SQL2016BIDEV'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'ETLStage_ServerName', @sensitive=False, @description=N'Name of the server used to connect to the ETLStage database.', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'SUD-DB-DEV1\SQL2016BIDEV'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'ETLUtility_ServerName', @sensitive=False, @description=N'Name of the server used to connect to the ETLUtility database.', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'SOUTHERNUTE\cbrown'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'MDS_AdminUserID', @sensitive=False, @description=N'MDS Administrator User ID that can be used to run the validation of MDS data loaded from Permanent Fund data mart', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'MDS'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'MDS_InitialCatalog', @sensitive=False, @description=N'Initial Catalog for the MDS database on the Server specified', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'Permanent Fund'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'MDS_ModelName', @sensitive=False, @description=N'MDS ModelName for the Permanent Fund application', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'SUD-DB-DEV1\SQL2016BIDEV'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'MDS_ServerName', @sensitive=False, @description=N'Server name for the MDS database', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'VERSION_1'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'MDS_VersionName', @sensitive=False, @description=N'MDS VersionName for the Permanent Fund application', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'SUD-SASS-DEV1\BITabularDev'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'PF_DMTabular_ServerName', @sensitive=False, @description=N'SSAS Tabular Model ServerName.', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'SUD-DB-DEV1\SQL2016BIDEV'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'PF_DM_ServerName', @sensitive=False, @description=N'Name of the server used to connect to the PF_DM database.', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO
DECLARE @var sql_variant = N'SUD-DB-DEV1\SQL2016BIDEV'
EXEC [SSISDB].[catalog].[create_environment_variable] @variable_name=N'SUGF_FIN_DM_ServerName', @sensitive=False, @description=N'Server name for the Finance Data Mart database', @environment_name=N'Permanent Fund Server Settings', @folder_name=N'PF', @value=@var, @data_type=N'String'
GO

GO


GO
