--DROP VIEW CPRO_REPORTS.DANA_CUSTOMER_VALUES;

--CREATE OR REPLACE VIEW DANA_CUSTOMER_VALUES
AS 
SELECT DISTINCT 

cms.Location_ID, ReportingYear, ReportingMonth, cms.customernumber cpro_cust_no, cms.Customer_ID, cust.CUSTOMER_NAME,cust.PARENT_CUSTOMER_ID,nvl(parent.CUSTOMER_NAME,cust.CUSTOMER_NAME) Parent_Name,
MAX(CASE Metric_ID WHEN '1' THEN ResponseValue ELSE '0' END) AS Prod_Def_QTY,
MAX(CASE Metric_ID WHEN '5' THEN ResponseValue ELSE '0' END) AS Prod_VOL,
MAX(CASE Metric_ID WHEN '3' THEN ResponseValue ELSE '0' END) AS Prod_Incident_TOTAL,
MAX(CASE Metric_ID WHEN '9' THEN ResponseValue ELSE '0' END) AS Prod_Incident_MAJOR,
MAX(CASE Metric_ID WHEN '2' THEN ResponseValue ELSE '0' END) AS Service_Def_QTY, 
MAX(CASE Metric_ID WHEN '6' THEN ResponseValue ELSE '0' END) AS Service_VOL,
MAX(CASE Metric_ID WHEN '4' THEN ResponseValue ELSE '0' END) AS Service_Incident_TOTAL,
MAX(CASE Metric_ID WHEN '10' THEN ResponseValue ELSE '0' END) AS Service_Incident_MAJOR

FROM (SELECT * FROM CMS_DEFECT_INCIDENT /*WHERE CUSTOMER_ID IN ('392','393','416','83')*/)  cms
Left Outer Join cms_customer cust on
cms.Customer_ID = cust.customer_id
Left Outer Join cms_customer parent on
parent.Customer_ID = cust.parent_customer_id

GROUP BY cms.Location_ID, ReportingYear, ReportingMonth, cms.customernumber, cms.Customer_ID,cust.CUSTOMER_NAME,cust.PARENT_CUSTOMER_ID,parent.CUSTOMER_NAME