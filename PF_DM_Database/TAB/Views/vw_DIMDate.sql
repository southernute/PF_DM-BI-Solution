

CREATE VIEW [TAB].[vw_DIMDate]
AS

SELECT dimD.DateSK
	,dimD.CalendarDate
	,dimD.DayOfWeekNum
	,dimD.DayOfWeekName
	,dimD.DayOfMonthNum
	,CASE 
		WHEN dimD.DateSK = 0
			THEN - 1
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 0
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 998
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 999
		ELSE dimD.WeekOfYearNum
		END AS WeekOfYearNum
	,CASE 
		WHEN dimD.DateSK = 0
			THEN - 1
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 0
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 998
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 999
		ELSE dimD.MonthOfYearNum
		END AS MonthOfYearNum
	,dimD.MonthOfYearName
	,CASE 
		WHEN dimD.DateSK = 0
			THEN - 1
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 0
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 998
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 999
		ELSE dimD.QuarterOfYearNum
		END AS QuarterOfYearNum
	,CASE 
		WHEN dimD.DayOfWeekName IN (
				'SOY Beginning Balances'
				,'EOY Adjustments'
				,'EOY Closing'
				)
			THEN left(dimD.DateSK, 4) - 1
		ELSE dimD.YearNum
		END AS YearNum
	,CASE 
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 0
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 998
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 999
		ELSE dimD.FiscalPeriodNum
		END AS FiscalPeriodNum
	,CASE 
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 0
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 998
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 999
		ELSE dimD.FiscalQuarterNum
		END AS FiscalQuarterNum
	,CASE 
		WHEN dimD.DayOfWeekName IN (
				'SOY Beginning Balances'
				,'EOY Adjustments'
				,'EOY Closing'
				)
			THEN left(dimD.DateSK, 4)
		ELSE dimD.FiscalYearNum
		END AS FiscalYearNum
	-- Period Close Status
	,dimD.MonthEndFlag
	,dimD.QuarterEndFlag
	,dimD.CalendarYearEndFlag
	,dimD.MonthEndFlag AS FiscalPeriodEndFlag
	,CASE 
		WHEN dimD.CalendarDate = (
				SELECT max(dimD2.CalendarDate)
				FROM [SUGF_FIN_DM].dm.DIMDate dimD2
				WHERE dimD2.FiscalYearNum = dimD.FiscalYearNum
					AND dimD2.FiscalQuarterNum = dimD.FiscalQuarterNum
				)
			THEN 1
		ELSE 0
		END AS FiscalQuarterEndFlag
	,FiscalYearEndFlag
	,isnull(mds.PeriodCloseStatusDesc, 'Unspecified') AS DateCloseStatusDesc
	,isnull(mds.PeriodCloseStatusDesc, 'Unspecified') AS PeriodCloseStatusDesc
	,isnull(mds.QuarterCloseStatusDesc, 'Unspecified') AS QuarterCloseStatusDesc
	,isnull(mds.YearCloseStatusDesc, 'Unspecified') AS YearCloseStatusDesc
	-- FMT
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE cast(dimD.CalendarDate AS VARCHAR)
		END AS DateFmt
	,CASE dimD.MonthEndFlag
		WHEN 1
			THEN 'EOM Date'
		ELSE 'non-EOM Date'
		END AS MonthEndFlagFmt
	-- Calendar FMT
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE 'W' + cast(dimD.WeekOfYearNum AS VARCHAR)
		END AS CalendarWeekFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE 'W' + cast(dimD.WeekOfYearNum AS VARCHAR) + ' ' + cast(dimD.YearNum AS VARCHAR)
		END AS CalendarWeekYearFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE left(dimD.MonthOfYearName, 3) + ' ' + cast(dimD.YearNum AS VARCHAR)
		END AS CalendarMonthYearFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE 'Q' + cast(dimD.QuarterOfYearNum AS VARCHAR)
		END AS CalendarQuarterFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE 'Q' + cast(dimD.QuarterOfYearNum AS VARCHAR) + ' ' + cast(dimD.YearNum AS VARCHAR)
		END AS CalendarQuarterYearFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName IN (
				'SOY Beginning Balances'
				,'EOY Adjustments'
				,'EOY Closing'
				)
			THEN cast(left(dimD.DateSK, 4) - 1 AS VARCHAR)
		ELSE cast(dimD.YearNum AS VARCHAR)
		END AS CalendarYearFmt
	-- Fiscal FMT
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE 'FP' + cast(dimD.FiscalPeriodNum AS VARCHAR)
		END AS FiscalPeriodFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE 'FP' + cast(dimD.FiscalPeriodNum AS VARCHAR) + ' FY' + cast(dimD.FiscalYearNum AS VARCHAR)
		END AS FiscalPeriodYearFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE 'FQ' + cast(dimD.FiscalQuarterNum AS VARCHAR)
		END AS FiscalQuarterFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		WHEN dimD.DayOfWeekName = 'SOY Beginning Balances'
			THEN 'SOY Beginning Balance'
		WHEN dimD.DayOfWeekName = 'EOY Adjustments'
			THEN 'EOY Adjustment'
		WHEN dimD.DayOfWeekName = 'EOY Closing'
			THEN 'EOY Closing'
		ELSE 'FQ' + cast(dimD.FiscalQuarterNum AS VARCHAR) + ' FY' + cast(dimD.FiscalYearNum AS VARCHAR)
		END AS FiscalQuarterYearFmt
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 'Unspecified'
		ELSE 'FY' + cast(dimD.FiscalYearNum AS VARCHAR)
		END AS FiscalYearFmt
	-- Display Order
	,dimD.DateSK AS DateDisplayOrder
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 0
		WHEN dimD.FiscalPeriodNum = 0
			THEN - 1
		WHEN dimD.FiscalPeriodNum IN (
				998
				,999
				)
			THEN dimD.FiscalPeriodNum
		ELSE dimD.WeekOfYearNum
		END AS calendarWeekDisplayOrder
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 0
		WHEN dimD.FiscalPeriodNum = 0
			THEN - 1
		WHEN dimD.FiscalPeriodNum IN (
				998
				,999
				)
			THEN dimD.FiscalPeriodNum
		ELSE dimD.MonthOfYearNum
		END AS calendarMonthDisplayOrder
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 0
		WHEN dimD.FiscalPeriodNum = 0
			THEN - 1
		WHEN dimD.FiscalPeriodNum IN (
				998
				,999
				)
			THEN dimD.FiscalPeriodNum
		ELSE dimD.QuarterOfYearNum
		END AS calendarQuarterDisplayOrder
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 0
		WHEN dimD.FiscalPeriodNum = 0
			THEN - 1
		ELSE dimD.FiscalPeriodNum
		END AS FiscalPeriodDisplayOrder
	,CASE 
		WHEN dimD.DateSK = 0
			THEN 0
		WHEN dimD.FiscalPeriodNum = 0
			THEN - 1
		WHEN dimD.FiscalPeriodNum IN (
				998
				,999
				)
			THEN dimD.FiscalPeriodNum
		ELSE dimD.FiscalQuarterNum
		END AS FiscalQuarterDisplayOrder
	,day(EOMONTH(calendarDate)) AS MonthDays
FROM [SUGF_FIN_DM].dm.DIMDate dimD
LEFT OUTER JOIN (
	SELECT mds.FiscalYearNum
		,mds.FiscalPeriodNum
		,mds.[Close Status_Name] AS PeriodCloseStatusDesc
		,CASE 
			WHEN mds.FiscalPeriodNum IN (
					0
					,998
					,999
					)
				THEN mds.[Close Status_Name]
			WHEN mds.FiscalPeriodNum <= 3
				THEN mdsQ1.[Close Status_Name]
			WHEN mds.FiscalPeriodNum <= 6
				THEN mdsQ2.[Close Status_Name]
			WHEN mds.FiscalPeriodNum <= 9
				THEN mdsQ3.[Close Status_Name]
			ELSE mdsQ4.[Close Status_Name]
			END AS QuarterCloseStatusDesc
		,isnull(mdsQ4.[Close Status_Name], mds.[Close Status_Name]) AS YearCloseStatusDesc
	FROM [SUGF_FIN_DM].dm.MDSFiscalPeriodCloseStatus mds
	LEFT OUTER JOIN [SUGF_FIN_DM].dm.MDSFiscalPeriodCloseStatus mdsQ1 ON mdsQ1.FiscalYearNum = mds.FiscalYearNum
		AND mdsQ1.FiscalPeriodNum = 3
	LEFT OUTER JOIN [SUGF_FIN_DM].dm.MDSFiscalPeriodCloseStatus mdsQ2 ON mdsQ2.FiscalYearNum = mds.FiscalYearNum
		AND mdsQ2.FiscalPeriodNum = 6
	LEFT OUTER JOIN [SUGF_FIN_DM].dm.MDSFiscalPeriodCloseStatus mdsQ3 ON mdsQ3.FiscalYearNum = mds.FiscalYearNum
		AND mdsQ3.FiscalPeriodNum = 9
	LEFT OUTER JOIN [SUGF_FIN_DM].dm.MDSFiscalPeriodCloseStatus mdsQ4 ON mdsQ4.FiscalYearNum = mds.FiscalYearNum
		AND mdsQ4.FiscalPeriodNum = 12
	) mds ON mds.FiscalYearNum = dimD.FiscalYearNum
	AND mds.FiscalPeriodNum = dimD.FiscalPeriodNum;