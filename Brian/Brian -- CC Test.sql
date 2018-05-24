SELECT * FROM QSI_CM_ALL WHERE QSI_RQUID='5331e383651c8/0'

SELECT * FROM QSI_CM_RQ WHERE QSI_RQUID='5331e383651c8/0'

SELECT * FROM QSI_CM_RS WHERE QSI_RQUID='5331e383651c8/0'
/*--------------------------------------------------------------------------------------------------*/
SELECT 
	rq.qsi_uniqueid,
	rq.qsi_orgvalue,
	rq.qsi_title, --This is what will show across the top of the report and be used to select
	rs.QSI_UNIQUEID,
	rs.QSI_TITLE,
	chkqy.FFQSI_HOST_SECTION_ID,
	chkqy.FFQSI_REPORTING_KEY



	FROM (SELECT * FROM QSI_CM_RQ WHERE QSI_RQUID='5331e383651c8/0') rq
		JOIN QSI_CM_RS rs ON
		rq.qsi_uniqueid = rs.QSI_PROGENUID
		-- join rs to the checklists '5331e5a88b649/0','5331f574283d6/0','53320eeed4060/0'
		JOIN (SELECT * FROM FB_QSI_CHECKLISTmain_QY WHERE FBSCHEMA='qsi_item' ORDER BY FBDOCID) chkqy ON --fbschema was used to remove section names
			rs.QSI_UNIQUEID = chkqy.ffqsi_host_family_id || '/' ||  chkqy.ffqsi_host_version
			
			--SELECT * FROM FB_QSI_CHECKLISTmain_QY WHERE ffqsi_host_family_id='5331e5a88b649'
		

/*--------------------------------------------------------------------------------------------------*/