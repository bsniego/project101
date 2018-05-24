--DROP VIEW CPRO.DANA_JOBIETR_MAIN;

--CREATE OR REPLACE VIEW CPRO.DANA_JOBIETR_MAIN
AS SELECT  

	QD_ALL.QSI_FAMILYID || QD_Cat.deptkey || QD_Cat.areakey || TQ_QY.FBDOCID RumbaORM_Code,
	tq_qy.ffqsi_progenitor_uniqueid,
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
	
	FROM (SELECT * FROM FB_QSI_TQ_QY WHERE FBROWID=0 /*AND FFQSI_PROGENITOR_UNIQUEID='534db5f5653f7/1'*/) TQ_QY
	
	LEFT OUTER JOIN (Select * FROM DANA_TP_ALL) TP_QY ON
  		TQ_QY.FFCONTROLNUMBER = TP_QY.QSI_CONTROLNUM
  	
  	LEFT OUTER JOIN (Select * FROM FB_QSI_TP_AF) TP_AF ON -- get employee photo
    	TP_QY.QSI_FBDOCID = TP_AF.FBDOCID
    	
    LEFT OUTER JOIN (Select * FROM DANA_JOBIETR_MINSTATUS) TQ_STAT ON 
    	TQ_QY.FBDOCID = TQ_STAT.TQ_ID
  	
	JOIN (Select * FROM DANA_QD_ALL) QD_ALL ON
		TQ_QY.FFQSI_PROGENITOR_UNIQUEID = QD_ALL.QSI_UNIQUEID
		
	INNER JOIN (Select * FROM DANA_CATEGORY) QD_CAT ON -- test using the inner join to remove null areas/departments
		QD_ALL.QSI_UNIQUEID = QD_CAT.QSI_UNIQUEID
		
	WHERE TP_QY.QSI_STATUS='Current'
	AND TQ_QY.FFStatus='Active'
	AND QD_ALL.QSI_ORGKEY='76200' 
	
--	SELECT * FROM DANA_TP_ALL
--	SELECT * FROM FB_QSI_TQ_QY
-------------------------------------------------------------------------------------
/*
SELECT * FROM DANA_DEPTAREA_MTBL WHERE QSI_UNIQUEID='534f204a8c07a/0'

-------------------------------------------------------------------------------------

--DROP MATERIALIZED VIEW CPRO.DANA_DEPTAREA_MTBL;

--CREATE MATERIALIZED VIEW CPRO.DANA_DEPTAREA_MTBL
AS SELECT  distinct
                A.FFQSI_UNIQUE_ID QSI_UNIQUEID,
                A.FFQSI_FAMILY_ID QSI_FAMILYID,                                       
                A.FFQSI_VERSION QSI_VERSION,
                A.FFQSI_LEVEL QSI_LEVEL,
                A.FFQSI_GROUP_KEY QSI_GROUPKEY,
                --B.QSI_VALUE QSI_GROUPNAME,
                CASE B.QSI_VALUE 
                                WHEN 'Department' THEN 'Dana Departments' 
                                WHEN 'Department(s)' THEN 'Dana Departments' 
                                ELSE B.QSI_VALUE 
                END QSI_GROUPNAME,
                A.FFQSI_CHOICE_KEY QSI_CHOICEKEY,
                C.QSI_VALUE QSI_CHOICENAME

FROM FB_QSI_KEYWORDS_INDEX_QY A

JOIN QSI_ITEM_ORG_LOOKUP ITEM ON
                A.FFQSI_UNIQUE_ID = ITEM.QSI_UNIQUEID
LEFT JOIN (select distinct qsi_key, qsi_value, qsi_org from QSI_KEYWORD_LOOKUP) B ON
                A.FFQSI_GROUP_KEY = B.QSI_KEY AND ITEM.QSI_ORGKEY = B.QSI_ORG
LEFT JOIN (select distinct qsi_key, qsi_value, qsi_org from QSI_KEYWORD_LOOKUP) C ON
                A.FFQSI_CHOICE_KEY = C.QSI_KEY AND ITEM.QSI_ORGKEY = C.QSI_ORG
                
--Only look for the department qsi_Keywords45449 and area qsi_Keywords17690 keys **plus the stuff Anna added 6-10-2016
WHERE A.FFQSI_GROUP_KEY IN (
                'qsi_Keywords45449', --QA Dept old
                'qsi_Keywords87113', --QA Dept new
                'qsi_Keywords17690', --QA Area
                'qsi_Keywords6018', -- PRD Dept
                'qsi_Keywords30740')  --TRN Dept
                --AND QSI_UNIQUEID='534f204a8c07a/0'
                --AND QSI_UNIQUEID='534db5f5653f7/1'
                AND QSI_UNIQUEID='534f1f95e6a90/0'

