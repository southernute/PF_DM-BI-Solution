

CREATE PROCEDURE [scd].[DimDepartment]

AS

/**************************************************************************
** DATE: 12/12/2017
** BY: RevGen Partners - Chris Brown
** PURPOSE: Create Department hierarchy based on spreadsheet from Leah
** CHANGE LOG: 01/23/2018   - CB Updated query to pull in only TRENT data and added "Other" department per Ian's request
				02/01/2018  - CB Updated query to include new list of Departments.  Leaving "Other" department in for now to help with QA.  Per Leah, we should remove it.
**************************************************************************/
	
	SET NOCOUNT ON;

	

SELECT DISTINCT CAST([NAME] AS NVARCHAR(100)) AS [NAME], CAST(CODE AS NVARCHAR(10)) AS CODE,
CAST(CODE AS NVARCHAR(10))AS DivisionCode
FROM
(SELECT CASE WHEN DepartmentCD in ('21900') 
			THEN 'Casino'
			WHEN DepartmentCD in ('11400','11405','11410','11420') 
			THEN 'Community Center'
			WHEN DepartmentCD IN ('10800')
			THEN 'Const and Prj Mgmt'
			WHEN DepartmentCD IN ('12900','12905','12910','12920','12925','12930')
			THEN 'Culture'
			WHEN DepartmentCD in ('11820') 
			THEN 'Election Committee'
			WHEN DepartmentCD IN ('10600','10605','10610','10615','10620','10630','11455','12915')
			THEN 'Executive Office'
			WHEN DepartmentCD IN ('11500','11505','11510','11515','11520','11525')
			THEN 'Facilities and Prop'
			WHEN DepartmentCD IN ('10200','10290','11000','11005','11010','11015','11016','11020','12800','12885')
			THEN 'Finance'
			WHEN DepartmentCD IN ('10635','11300','11320')
			THEN 'Higher Ed'
			WHEN DepartmentCD IN ('10640','11100','11105','11110','11115')
			THEN 'HR Department'
			WHEN DepartmentCD IN ('11700','11705','11710','11715','11720','11725','11730','11735','11736','11740','11745','11750','11755','11760','11765','11770')
			THEN 'Justice and Reg'
			WHEN DepartmentCD IN ('10500')
			THEN 'Legal Services'
			WHEN DepartmentCD IN ('16000')
			THEN 'Museum'
			WHEN DepartmentCD IN ('10735','10900','10905','10910','10915','10920','10925','10930','10935','10940')
			THEN 'Natural Resources'
			WHEN DepartmentCD IN ('11900','11905','11910')
			THEN 'Private Education'
			WHEN DepartmentCD IN ('10400','10405','10410')
			THEN 'Public Ed and Admin'
			WHEN DepartmentCD IN ('10100','10110')
			THEN 'Tribal Council'
			WHEN DepartmentCD IN ('10300')
			THEN 'Tribal Court'
			WHEN DepartmentCD IN ('10725','15900')
			THEN 'Tribal Housing'
			WHEN DepartmentCD IN ('11800','11805','11810','11815')
			THEN 'Tribal Information Svcs'
			WHEN DepartmentCD IN ('10700','10705','10710','10720','10730','10740')
			THEN 'Tribal Services'
			WHEN DepartmentCD in ('16100','16105','16110','16115','16120','16125','16130','16135','16140','16145','16150','16155') 
			THEN 'KSUT'
			WHEN DepartmentCD in ('12500','12600','12605','12610','12615','12616','12617','12620','12625','12630','12635','12640','12645','12650') 
			THEN 'Tribal Health'
			ELSE 'Other'
			END AS Name
			,DepartmentCD AS Code
	
FROM [SUGF_FIN_DM].[dm].[FACTJournalLine] JL
INNER JOIN [SUGF_FIN_DM].dm.DIMDepartment dimDe ON
		dimDe.DepartmentSK = JL.DepartmentSK
        AND dimDe.RecordCurrentFlag = 1
WHERE JL.BusinessUnitSK = 34

)A
--WHERE [NAME] <> 'Other'
;