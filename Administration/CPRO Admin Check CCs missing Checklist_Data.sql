/* bws 18Mar2016 - admin/maint SQL to identify CC's that do not have entries in the Checklist_Data_QY table

This will list all Customer Complaint Requests which do not have entries in the FB_QSI_CHECKLIST_QY table

*/


SELECT 
	ccrq.QSI_UNIQUEID CCRQ_ID,
	ckldata.qsi_uniqueid CKLDATA_ID,
	LENGTH(ckldata.qsi_uniqueid),
	ccrq.QSI_ORGVALUE,
	ccrq.qsi_controlnum,
	ccrq.qsi_credate,
	ccrq.QSI_MODDATE,
	--ccrq.QSI_CREDATE CCDate,
	ckldata.qsi_sectionid, 
	ckldata.qsi_key

FROM QSI_CHECKLIST_DATA CKLDATA
RIGHT JOIN (SELECT qsi_uniqueid, qsi_orgvalue, qsi_controlnum, qsi_credate, QSI_MODDATE FROM QSI_cc_rq) CCRQ ON CCRQ.QSI_UNIQUEID=CKLDATA.qsi_uniqueid
WHERE ckldata.qsi_uniqueid IS NULL
--FROM QSI_CC_RQ CCRQ
--RIGHT JOIN (SELECT qsi_uniqueid, qsi_sectionid, qsi_key FROM QSI_CHECKLIST_DATA) CKLDATA ON CCRQ.QSI_UNIQUEID=CKLDATA.qsi_uniqueid


--SELECT * FROM qsi_cc_rq

--SELECT * FROM QSI_CHECKLIST_DATA

/* show the latest index date */
--select max(fbmoddat) from fb_qsi_checklistmain_qy  

/* show all records update in the past hour */
--select * from fb_qsi_checklistmain_qy where fbmoddat > (sysdate - 1/24)

/* show all records update in the past hour */
--select * from fb_qsi_checklist_choice_qy where fbmoddat > (sysdate - 1/24)
/* show all records update in the past hour */
--select * from fb_qsi_checklistmain_qy where fbmoddat > (sysdate - 1/24)

/* show a specific record in the checklist index */
--select * from fb_qsi_checklistmain_qy where ffqsi_host_family_id='52e17afbe0672'
--select * from qsi_checklist_data where qsi_uniqueid='52e17afbe0672/0'

/*
SELECT 
	ccrq.QSI_UNIQUEID CCRQ_ID,
	ckldata.qsi_uniqueid CKLDATA_ID,
	ccrq.QSI_ORGVALUE,
	ccrq.qsi_controlnum,
	ccrq.QSI_CREDATE CC_CreateDate,
	ckldata.qsi_sectionid, 
	ckldata.qsi_key

FROM QSI_CC_RQ CCRQ
RIGHT JOIN (SELECT qsi_uniqueid, qsi_sectionid, qsi_key FROM QSI_CHECKLIST_DATA) CKLDATA ON CCRQ.QSI_UNIQUEID=CKLDATA.qsi_uniqueid
*/
/*
DROP VIEW CPRO.QSI_CHECKLIST_DATA;

CREATE OR REPLACE VIEW CPRO.QSI_CHECKLIST_DATA
AS SELECT			
	M_QYTBL.FFQSI_HOST_FAMILY_ID || '/' || M_QYTBL.FFQSI_HOST_VERSION QSI_UNIQUEID,			
	M_QYTBL.FFQSI_HOST_FAMILY_ID QSI_FAMILYID,			
	M_QYTBL.FFQSI_HOST_VERSION QSI_VERSION,			
	M_QYTBL.FFQSI_HOST_SECTION_ID QSI_SECTIONID, 			
	M_QYTBL.FFQSI_HOST_LINE_ITEM_KEY QSI_LINEITEM_KEY, 			
	CASE WHEN D_QYTBL.FFQSI_TYPE IN (
		'qsi_checklist_detail_type_oneselectDEG', 
		'qsi_checklist_detail_type_manyselectDEG',
		'qsi_checklist_detail_type_radioDEG', 
		'qsi_checklist_detail_type_checkDEG') 
			THEN 1 				
			ELSE 0 			
	END QSI_ISKEY,
	CASE WHEN D_QYTBL.FFQSI_TYPE IN (
		'qsi_checklist_detail_type_singleuser', 
		'qsi_checklist_detail_type_multipleusers') 
			THEN 1
			ELSE 0
	END QSI_ISUSER, 			
	CASE WHEN D_QYTBL.FFQSI_TYPE IN (
		'qsi_checklist_detail_type_allowance') 
			THEN 1
			ELSE 0
	END QSI_ISROLE,
	M_QYTBL.FFQSI_REPORTING_KEY QSI_KEY,
	CASE D_QYTBL.FFQSI_TYPE	
		WHEN 'qsi_checklist_detail_type_allowance' THEN ffqsi_as_text
		WHEN 'qsi_checklist_detail_type_integer' THEN CAST(D_QYTBL.FFQSI_AS_INT AS VARCHAR(30))
		WHEN 'qsi_checklist_detail_type_decimal' THEN CAST(D_QYTBL.FFQSI_AS_FLOAT AS VARCHAR(30))
		WHEN 'qsi_checklist_detail_type_currency' THEN CAST(D_QYTBL.FFQSI_AS_FLOAT AS VARCHAR(30))
		WHEN 'qsi_checklist_detail_type_shorttext' THEN D_QYTBL.FFQSI_AS_TEXT
		WHEN 'qsi_checklist_detail_type_longtext' THEN D_QYTBL.FFQSI_AS_TEXT
		WHEN 'qsi_checklist_detail_type_paragraph' THEN D_QYTBL.FFQSI_AS_PARAGRAPH
		WHEN 'qsi_content_type_1010' THEN D_QYTBL.FFQSI_AS_PARAGRAPH
		WHEN 'qsi_checklist_detail_type_radioDEG' THEN D_QYTBL.FFQSI_AS_KEY
		WHEN 'qsi_checklist_detail_type_oneselectDEG' THEN D_QYTBL.FFQSI_AS_KEY
		WHEN 'qsi_checklist_detail_type_manyselectDEG' THEN D_QYTBL.FFQSI_AS_KEY
		WHEN 'qsi_checklist_detail_type_checkDEG' THEN D_QYTBL.FFQSI_AS_KEY
		WHEN 'qsi_checklist_detail_type_singleuser' THEN D_QYTBL.FFQSI_AS_PARAGRAPH
		WHEN 'qsi_checklist_detail_type_multipleusers' THEN D_QYTBL.FFQSI_AS_PARAGRAPH
		WHEN 'qsi_checklist_detail_type_date' THEN TO_CHAR(D_QYTBL.FFQSI_AS_DATETIME, 'YYYY-MM-DD')
		WHEN 'qsi_checklist_detail_type_time' THEN TO_CHAR(D_QYTBL.FFQSI_AS_DATETIME, 'HH:MI:SS')
	END QSI_VALUE		

FROM FB_QSI_CHECKLISTMAIN_QY M_QYTBL		
	INNER JOIN FB_QSI_CHECKLIST_DETAIL_QY D_QYTBL 		
		ON M_QYTBL.FBDOCID = D_QYTBL.FFFBDOCIDMAIN		
*/		
		

