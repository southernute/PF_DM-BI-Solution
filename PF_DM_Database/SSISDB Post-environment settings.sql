USE SSISDB;
GO


/**************************************************************************************************

	DEPLOY SSIS - ASSOCIATE ENVIRONMENT WITH PROJECT
	Written By Chris Brown
	01/10/2018

	*** MUST BE RUN AFTER PROJECT HAS BEEN DEPLOYED TO SERVER ***

**************************************************************************************************/

--CONFIGURING THE PF PROJECT ETL
Declare @reference_id bigint
EXEC [SSISDB].[catalog].[create_environment_reference] @environment_name=N'Permanent Fund Server Settings', @reference_id=@reference_id OUTPUT, @project_name=N'PF_DM_ETL', @folder_name=N'PF', @reference_type=R
--Select @reference_id

GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'ETLStage_ServerName', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'ETLStage_ServerName'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'ETLUtility_ServerName', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'ETLUtility_ServerName'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'MDS_AdminUserID', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'MDS_AdminUserID'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'MDS_InitialCatalog', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'MDS_InitialCatalog'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'MDS_ModelName', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'MDS_ModelName'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'MDS_ServerName', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'MDS_ServerName'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'MDS_VersionName', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'MDS_VersionName'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'PF_DMTabularModel_ServerName', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'PF_DMTabular_ServerName'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'PF_DM_ServerName', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'PF_DM_ServerName'
GO
EXEC [SSISDB].[catalog].[set_object_parameter_value] @object_type=20, @parameter_name=N'SUGF_FIN_DM_ServerName', @object_name=N'PF_DM_ETL', @folder_name=N'PF', @project_name=N'PF_DM_ETL', @value_type=R, @parameter_value=N'SUGF_FIN_DM_ServerName'
GO

GO


--SETTING PF FOLDER PERMISSIONS TO THE Southernute\bimartproxy

EXEC [SSISDB].[catalog].[grant_permission] @object_type=1, @object_id=5, @principal_id=10, @permission_type=1
GO

EXEC [SSISDB].[catalog].[grant_permission] @object_type=1, @object_id=5, @principal_id=10, @permission_type=2
GO

EXEC [SSISDB].[catalog].[grant_permission] @object_type=1, @object_id=5, @principal_id=10, @permission_type=4
GO

EXEC [SSISDB].[catalog].[grant_permission] @object_type=1, @object_id=5, @principal_id=10, @permission_type=100
GO

EXEC [SSISDB].[catalog].[grant_permission] @object_type=1, @object_id=5, @principal_id=10, @permission_type=102
GO

EXEC [SSISDB].[catalog].[grant_permission] @object_type=1, @object_id=5, @principal_id=10, @permission_type=103
GO

EXEC [SSISDB].[catalog].[grant_permission] @object_type=1, @object_id=5, @principal_id=10, @permission_type=101
GO

EXEC [SSISDB].[catalog].[grant_permission] @object_type=1, @object_id=5, @principal_id=10, @permission_type=104
GO

