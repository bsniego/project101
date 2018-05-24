SELECT  

	QD_ALL.QSI_FAMILYID || QD_Cat.deptkey || QD_Cat.areakey || TQ_QY.FBDOCID RumbaORM_Code,
	QD_ALL.QSI_ORGKEY site,
	QD_CAT.DEPARTMENT department,
	QD_CAT.AREA area,
	TQ_QY.FFQSI_NAME name,
	nvl(TQ_QY.FFQSI_SUPERVISOR_CN,'n/a') supervisor,
	TP_QY.QSI_URL TP_URL,
	QD_ALL.QSI_URL TQ_URL,
	QD_ALL.QSI_TITLE qualificaion,
	TQ_STAT.PREMINSTATUS qual_level,
	TP_AF.FBTYPE file_type,
  	TP_AF.FBFILE
	
	FROM (SELECT * FROM FB_QSI_TQ_QY WHERE FBROWID=0 and fb_qsi_tq_qy.fforganization='10594' and fb_qsi_tq_qy.ffqsi_name like 'But%') TQ_QY
	
	LEFT OUTER JOIN DANA_TP_ALL TP_QY ON
  		TQ_QY.FFCONTROLNUMBER = TP_QY.QSI_CONTROLNUM
  	
  	LEFT OUTER JOIN FB_QSI_TP_AF TP_AF ON 
    	TP_QY.QSI_FBDOCID = TP_AF.FBDOCID
    	
    LEFT OUTER JOIN DANA_JOBIETR_MINSTATUS TQ_STAT ON 
    	TQ_QY.FBDOCID = TQ_STAT.TQ_ID
  	
	JOIN DANA_QD_ALL QD_ALL ON
		TQ_QY.FFQSI_PROGENITOR_UNIQUEID = QD_ALL.QSI_UNIQUEID
		
	LEFT OUTER JOIN (Select * from DANA_CATEGORY where area='RPC-04') QD_CAT ON
		QD_ALL.QSI_UNIQUEID = QD_CAT.QSI_UNIQUEID
		
	WHERE TP_QY.QSI_STATUS='Current'
	AND TQ_QY.FFStatus='Active'