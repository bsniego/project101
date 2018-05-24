--SELECT Location_ID, ReportingYear, ReportingMonth, Customer_ID, Prod_Def_QTY, Prod_VOL, Prod_Incident_TOTAL, Prod_Incident_MAJOR, Service_Def_QTY, Service_VOL, Service_Incident_TOTAL, Service_Incident_MAJOR
SELECT 
	Location_ID, 
	ReportingYear, 
	ReportingMonth, 
	Sum(Prod_Vol + Service_VOL) 'Total Vol',
	Sum(Prod_Def_QTY) 'Prod Defect Qty', 
	Sum(Prod_VOL) 'Prod Vol',
	Sum(Prod_Incident_TOTAL - Prod_Incident_MAJOR) 'Prod Incident Minor', 
	Sum(Prod_Incident_MAJOR) 'Prod Incident Major', 
	Sum(Prod_Incident_TOTAL) 'Prod Incident Total', 
	Sum(Service_Def_QTY) 'Serv Defect Qty', 
	Sum(Service_VOL) 'Serv Vol', 
	Sum(Service_Incident_TOTAL - Service_Incident_MAJOR) 'Serv Incident Minor', 
	Sum(Service_Incident_MAJOR) 'Serv Incident Major',
	Sum(Service_Incident_TOTAL) 'Serv Incident Total'

FROM dbo.DANA_CUSTOMER_VALUES 
GROUP BY Location_ID, ReportingYear, ReportingMonth
ORDER BY ReportingYear, ReportingMonth, Location_ID
