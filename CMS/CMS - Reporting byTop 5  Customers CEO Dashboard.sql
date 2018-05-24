-- CMS Month Reporting Metrics Top 5 Customers
-- Sniegocki 16Mar2016
SELECT DISTINCT 
-- (Sniegocki Feb2013) Some thoughts if Customer is a Parent populate the Parent_Customer_ID with Customer_ID
-- by default in CMS this is set to null if the entry is a Parent
resp.Location_ID, resp.ReportingYear, resp.ReportingMonth, CASE WHEN cust.ParentCustomer_ID IS Null THEN resp.Customer_ID ELSE cust.ParentCustomer_ID END AS Parent_Customer_ID, resp.Customer_ID, cust.Customername,
MAX(CASE Metric_ID WHEN '1' THEN ResponseValue ELSE 0 END) AS Prod_Def_QTY,
MAX(CASE Metric_ID WHEN '5' THEN ResponseValue ELSE 0 END) AS Prod_VOL,
MAX(CASE Metric_ID WHEN '3' THEN ResponseValue ELSE 0 END) AS Prod_Incident_TOTAL,
MAX(CASE Metric_ID WHEN '9' THEN ResponseValue ELSE 0 END) AS Prod_Incident_MAJOR,
MAX(CASE Metric_ID WHEN '2' THEN ResponseValue ELSE 0 END) AS Service_Def_QTY, 
MAX(CASE Metric_ID WHEN '6' THEN ResponseValue ELSE 0 END) AS Service_VOL,
MAX(CASE Metric_ID WHEN '4' THEN ResponseValue ELSE 0 END) AS Service_Incident_TOTAL,
MAX(CASE Metric_ID WHEN '10' THEN ResponseValue ELSE 0 END) AS Service_Incident_MAJOR

FROM (SELECT * FROM dbo.tblResponse WHERE ReportingYear='2015') resp
	--ParentCustomer_ID, CustomerNumber
	--Customer_ID, Customername, ParentCustomer_ID, CustomerNumber
LEFT JOIN (SELECT Customer_ID, Customername, ParentCustomer_ID, CustomerNumber FROM tblCustomer /*WHERE ParentCustomer_ID IN (
	'7',
	'41',
	'42',
	'66',
	'81',
	'102',
	'141',
	'142',
	'150',
	'153',
	'158',
	'160',
	'177',
	'228',
	'229',
	'264',
	'337'
	)*/) cust 
	ON resp.Customer_ID=cust.Customer_ID

WHERE ParentCustomer_ID IN (
	'7',
	'41',
	'42',
	'66',
	'81',
	'102',
	'141',
	'142',
	'150',
	'153',
	'158',
	'160',
	'177',
	'228',
	'229',
	'264',
	'337'
	) OR resp.Customer_ID IN (
	'7',
	'41',
	'42',
	'66',
	'81',
	'102',
	'141',
	'142',
	'150',
	'153',
	'158',
	'160',
	'177',
	'228',
	'229',
	'264',
	'337'
	)

GROUP BY resp.Location_ID, resp.ReportingYear, resp.ReportingMonth, cust.ParentCustomer_ID, resp.Customer_ID, cust.Customername ORDER BY resp.ReportingYear, resp.ReportingMonth, resp.Location_ID, resp.Customer_ID

