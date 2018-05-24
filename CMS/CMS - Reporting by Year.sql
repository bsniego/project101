SELECT 
	Response_ID,
	ReportingDate,
	ReportingMonth,
	ReportingYear,
	EntryDate,
	ResponseValue,
	ResponseComment,
	Customer_ID,
	WebUser_ID,
	Location_ID,
	Division_ID,
	ProductGroup_ID,
	SBU_ID,
	Metric_ID,
	RollupLevel_ID,
	MetricOrg_ID,
	RollupMetric_ID,
	EnterCalc_ID,
	Unit_ID,
	QuarterofOccur,
	AreasofConcern,
	ActionPlan,
	TargetDate,
	CompDate,
	Disputed,
	SupplierCode_ID,
	System_ID
FROM dbo.tblResponse WHERE ReportingYear='2011' AND Location_ID='99209' ORDER by 'ReportingMonth'
