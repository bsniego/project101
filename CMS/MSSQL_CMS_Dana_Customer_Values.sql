IF OBJECT_ID ('dbo.DANA_CUSTOMER_VALUES') IS NOT NULL
	DROP VIEW dbo.DANA_CUSTOMER_VALUES
GO

CREATE VIEW dbo.DANA_CUSTOMER_VALUES
AS
SELECT DISTINCT 
Location_ID, ReportingYear, ReportingMonth, Customer_ID,
MAX(CASE Metric_ID WHEN '1' THEN ResponseValue ELSE 0 END) AS Prod_Def_QTY,
MAX(CASE Metric_ID WHEN '5' THEN ResponseValue ELSE 0 END) AS Prod_VOL,
MAX(CASE Metric_ID WHEN '3' THEN ResponseValue ELSE 0 END) AS Prod_Incident_TOTAL,
MAX(CASE Metric_ID WHEN '9' THEN ResponseValue ELSE 0 END) AS Prod_Incident_MAJOR,
MAX(CASE Metric_ID WHEN '2' THEN ResponseValue ELSE 0 END) AS Service_Def_QTY, 
MAX(CASE Metric_ID WHEN '6' THEN ResponseValue ELSE 0 END) AS Service_VOL,
MAX(CASE Metric_ID WHEN '4' THEN ResponseValue ELSE 0 END) AS Service_Incident_TOTAL,
MAX(CASE Metric_ID WHEN '10' THEN ResponseValue ELSE 0 END) AS Service_Incident_MAJOR

FROM dbo.tblResponse

GROUP BY Location_ID, ReportingYear, ReportingMonth, Customer_ID
GO

