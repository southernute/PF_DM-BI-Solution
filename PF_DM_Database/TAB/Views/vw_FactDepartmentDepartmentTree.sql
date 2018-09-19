



CREATE VIEW [TAB].[vw_FactDepartmentDepartmentTree]
AS


SELECT
	DepartmentSK
	, PSTreeName
	, PSTreeEffDate

FROM
	[TAB].[vw_DimDepartmentDivision];