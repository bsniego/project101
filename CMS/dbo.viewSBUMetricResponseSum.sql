--IF OBJECT_ID ('dbo.viewSBUMetricResponseSum') IS NOT NULL
--	DROP VIEW dbo.viewSBUMetricResponseSum
--GO

CREATE VIEW dbo.viewSBUMetricResponseSum
AS
SELECT DISTINCT 
                      dbo.tblResponse.ResponseValue, dbo.tblResponse.Metric_ID, GDIS.dbo.GDIS_LOCATION_DETAIL.SBU_ID, GDIS.dbo.GDIS_LOCATION_DETAIL.SBU, 
                      GDIS.dbo.GDIS_LOCATION_DETAIL.SBU_ABBREVIATION, dbo.tblResponse.ReportingMonth, dbo.tblResponse.ReportingYear, 
                      dbo.tblUserLocRel.System_ID, dbo.tblResponse.EntryDate, dbo.tblResponse.Customer_ID
FROM         dbo.tblUserLocRel INNER JOIN
                      GDIS.dbo.GDIS_LOCATION_DETAIL ON dbo.tblUserLocRel.Location_ID = GDIS.dbo.GDIS_LOCATION_DETAIL.LOCATION_ID INNER JOIN
                      dbo.tblResponse ON dbo.tblUserLocRel.Location_ID = dbo.tblResponse.Location_ID
WHERE     (dbo.tblResponse.Customer_ID <> 287)
GROUP BY dbo.tblResponse.Metric_ID, GDIS.dbo.GDIS_LOCATION_DETAIL.SBU_ID, GDIS.dbo.GDIS_LOCATION_DETAIL.SBU, 
                      GDIS.dbo.GDIS_LOCATION_DETAIL.SBU_ABBREVIATION, dbo.tblResponse.ReportingMonth, dbo.tblResponse.ReportingYear, 
                      dbo.tblUserLocRel.System_ID, dbo.tblResponse.ResponseValue, dbo.tblResponse.EntryDate, dbo.tblResponse.Customer_ID

GO

