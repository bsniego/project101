--SELECT Location_ID, ReportingYear, ReportingMonth, Customer_ID, Prod_Def_QTY, Prod_VOL, Prod_Incident_TOTAL, Prod_Incident_MAJOR, Service_Def_QTY, Service_VOL, Service_Incident_TOTAL, Service_Incident_MAJOR
SELECT 
	Location_ID, 
	ReportingYear, 
	ReportingMonth, 
	Sum(Prod_Vol + Service_VOL) 'Total Vol',
	Sum(Prod_Def_QTY + Service_Def_QTY) 'Total Defect Qty',
	Sum(Prod_Incident_TOTAL + Service_Incident_TOTAL) 'Total Incident Total', 
	round(((Sum(Prod_Def_QTY + Service_Def_QTY)) / (Sum(Prod_Vol + Service_VOL)+.00001) * 1000000),1) PPM,
	round(((Sum(Prod_Incident_TOTAL + Service_Incident_TOTAL)) / (Sum(Prod_Vol + Service_VOL)+.0001) * 1000000),1) IPM,
	'  CMS Ref Data ->' "Reference Data",	
	Sum(Prod_VOL) 'Prod Vol',	
	Sum(Prod_Def_QTY) 'Prod Defect Qty', 
	Sum(Prod_Incident_TOTAL) 'Prod Incident Total', 
	Sum(Prod_Incident_MAJOR) 'Prod Incident Major', 
	Sum(Prod_Incident_TOTAL - Prod_Incident_MAJOR) 'Prod Incident Minor', 


	Sum(Service_VOL) 'Serv Vol', 
	Sum(Service_Def_QTY) 'Serv Defect Qty', 
	Sum(Service_Incident_TOTAL) 'Serv Incident Total',
		Sum(Service_Incident_MAJOR) 'Serv Incident Major',
	Sum(Service_Incident_TOTAL - Service_Incident_MAJOR) 'Serv Incident Minor'


FROM dbo.DANA_CUSTOMER_VALUES WHERE ReportingYear='2016' AND ReportingMonth='1'

--FROM dbo.DANA_CUSTOMER_VALUES WHERE Location_ID IN ('10042','10088','10118','10384','10400','10412','10461','19000','19002','19007','25400','25402','25403','25405','25406','58002','59000','88714','88716','88721','88726','88900','89043','99013') AND ReportingYear='2016'
GROUP BY Location_ID, ReportingYear, ReportingMonth
ORDER BY ReportingYear, ReportingMonth, Location_ID
