/*-------- Run in the CPRO_Reports Database --------*/
SELECT 
	GDIS.LOCATION_NAME,
	GDIS.COUNTRY,
	GDIS.REGION,
	GDIS.SBU_ABBR,
	GDIS.PRODUCT_GROUP_ABBR,
	GDIS.PRODUCT_GROUP,
	cms.Location_ID,
	cms.ReportingYear,
	cms.ReportingMonth,
	cms.prod_def_qty,
	cms.prod_vol+cms.service_vol total_vol,
	cms.Prod_Incident_TOTAL - cms.Prod_Incident_MAJOR Prod_Incident_Minor,
	cms.Prod_Incident_MAJOR Prod_Incident_Major, 
	cms.Prod_Incident_TOTAL Prod_Incident_Total, 
	cms.Service_Def_QTY Serv_Defect_Qty, 
	cms.Service_VOL Serv_Vol, 
	cms.Service_Incident_TOTAL-Service_Incident_MAJOR Serv_Incident_Minor, 
	cms.Service_Incident_MAJOR Serv_Incident_Major,
	cms.Service_Incident_TOTAL Serv_Incident_Total
	
FROM (SELECT * FROM DANA_CUSTOMER_VALUES) CMS
	JOIN GDIS_LOCATION_EXTRACT GDIS ON 
	cms.location_id = GDIS.GDIS_LOCATION_ID
	
	ORDER BY ReportingYear, ReportingMonth, Location_ID