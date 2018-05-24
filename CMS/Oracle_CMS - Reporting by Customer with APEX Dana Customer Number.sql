-- CMS Month Reporting Metrics
-- Sniegocki 06Nov2012
SELECT DISTINCT 
-- (Sniegocki Feb2013) Some thoughts if Customer is a Parent populate the Parent_Customer_ID with Customer_ID
-- by default in CMS this is set to null if the entry is a Parent
resp.Location_ID, resp.ReportingYear, resp.ReportingMonth, CASE WHEN to_char (cust.Parent_Customer_ID) IS Null THEN resp.Customer_ID ELSE to_char (cust.Parent_Customer_ID) END AS Parent_Customer_ID, resp.Customer_ID, cust.Customer_Number,
MAX(CASE Metric_ID WHEN '1' THEN ResponseValue ELSE '0' END) AS Prod_Def_QTY,
MAX(CASE Metric_ID WHEN '5' THEN ResponseValue ELSE '0' END) AS Prod_VOL,
MAX(CASE Metric_ID WHEN '3' THEN ResponseValue ELSE '0' END) AS Prod_Incident_TOTAL,
MAX(CASE Metric_ID WHEN '9' THEN ResponseValue ELSE '0' END) AS Prod_Incident_MAJOR,
MAX(CASE Metric_ID WHEN '2' THEN ResponseValue ELSE '0' END) AS Service_Def_QTY, 
MAX(CASE Metric_ID WHEN '6' THEN ResponseValue ELSE '0' END) AS Service_VOL,
MAX(CASE Metric_ID WHEN '4' THEN ResponseValue ELSE '0' END) AS Service_Incident_TOTAL,
MAX(CASE Metric_ID WHEN '10' THEN ResponseValue ELSE '0' END) AS Service_Incident_MAJOR

FROM CMS_DEFECT_INCIDENT resp
LEFT OUTER JOIN CMS_Customer cust ON resp.Customer_ID=cust.Customer_ID

GROUP BY resp.Location_ID, resp.ReportingYear, resp.ReportingMonth, cust.Parent_Customer_ID, resp.Customer_ID, cust.Customer_Number ORDER BY resp.ReportingYear, resp.ReportingMonth, resp.Location_ID, resp.Customer_ID

