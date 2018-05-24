--bsniegocki 10 Feb 2014 8.52 view created for 8.14
--DROP VIEW CPRO_STG.QSI_CLB_ALL;

--CREATE OR REPLACE VIEW DANA_QSI_CLB_ALL
--AS 
SELECT			
	QYTBL.FFQSI_UNIQUE_ID QSI_UNIQUEID,			
	QYTBL.FFFAMILYID QSI_FAMILYID,	
	QYTBL.FFVERSION QSI_VERSION,			
	QYTBL.FBSCHEMA QSI_FBSCHEMA,			
	QYTBL.FFQSI_SCHEMA QSI_DCLASSKEY,			
	QYTBL.FFFORMALIAS QSI_DTYPEKEY,			
	QYTBL.FFORGANIZATION QSI_ORGKEY,			
	QYTBL.FFQSI_ORGANIZATION_NAME QSI_ORGVALUE,			
	--QYTBL.FFQSI_SPECIAL_ORIGINATION QSI_SPECIAL_ORGKEY,  
	'' QSI_SPECIAL_ORGKEY,			
	QYTBL.FFDATECREATED QSI_CREDATE,			
	QYTBL.FFDATEMODIFIED QSI_MODDATE,			
	QYTBL.FFDATEREQUESTED QSI_REQDATE,			
	QYTBL.FFQSI_ACCEPTED_TIMESTAMP QSI_ACCDATE,			
	QYTBL.FFQSI_APPROVED_TIMESTAMP QSI_APPDATE,			
	QYTBL.FFQSI_DUE_DATE QSI_DUEDATE,			
	QYTBL.FFQSI_CLOSED_DATE QSI_CLOSEDATE,			
	QYTBL.FFQSI_EFF_REV_DUE_DATE QSI_EFREVDATE,			
	CASE QYTBL.FFQSI_IS_EFF_REV_PENDING				
		WHEN 1 THEN 'Yes'				
		ELSE 'No'			
	END QSI_EFREVPENDING,			
	CASE QYTBL.FFQSI_IS_REQUESTED				
		WHEN 1 THEN 'Yes'				
		ELSE 'No'			
	END QSI_IS_REQUESTED,			
	CASE QYTBL.FFQSI_IS_ACCEPTED				
		WHEN 1 THEN 'Yes'				
		ELSE 'No'			
	END QSI_IS_ACCEPTED,			
	CASE QYTBL.FFQSI_IS_CLOSED				
		WHEN 1 THEN 'Yes'				
		ELSE 'No'			
	END QSI_IS_CLOSED,			
	CASE QYTBL.FFQSI_IS_HISTORICAL				
		WHEN 1 THEN 'Yes'				
		ELSE 'No'			
	END QSI_IS_HISTORICAL,			
	QYTBL.FFCONTROLNUMBER QSI_CONTROLNUM,			
	QYTBL.FFTITLE QSI_TITLE,			
	QYTBL.FFQSI_FORMATTED_IDENTITY QSI_IDENTITY,			
	QYTBL.FFDLCS QSI_STATUSKEY,			
	QYTBL.FFSTATUS QSI_STATUS,			
	QYTBL.FFQSI_STATUS_WITH_CUSTOM QSI_CUSTOM_STATUS,			
	CASE QYTBL.FFQSI_PRIORITY_CODE				
		WHEN NULL THEN ''				
		ELSE SUBSTR(QYTBL.FFQSI_PRIORITY_CODE,18,30)			
	END QSI_PRIORITY,			
	QYTBL.FFDOCUMENTMANAGER QSI_DOCMANGER,			
	QYTBL.FFQSI_EXPEDITER QSI_DOCEXPEDITER,			
	QYTBL.FFREQUESTER QSI_DOCREQUESTER,			
	QYTBL.FFLASTACTOR QSI_LASTACTOR,			
	CASE QYTBL.FFPROCESSTYPE				
		WHEN NULL THEN ''				
		WHEN 'qsi_rq_automatic_...' THEN 'qsi_rq_automatic_acceptance'				
		WHEN 'qsi_rq_acceptance...' THEN 'qsi_rq_acceptance_by_expediter'				
		WHEN 'qsi_rq_direct_to_...' THEN 'qsi_rq_direct_to_approval'			
	END QSI_PROCESSTYPE,			
	QYTBL.FFQSI_INCIDENT_DATE QSI_INCIDENT_DATE,			
	QYTBL.FFQSI_INCIDENT_PERSON_DN QSI_INCIDENT_PERSON,			
	QYTBL.FFQSI_SOURCE QSI_SOURCE,			
	QYTBL.FFQSI_BASIC_PROBLEM_CODE QSI_BASIC_PROBLEM,			
	QYTBL.FFQSI_RESP_ROOT_CAUSE QSI_ROOT_CAUSE,			
	QYTBL.FFQSI_KIND_OF_RESPONSE QSI_KIND,			
	QYTBL.FFQSI_RESP_TOTAL_MINUTES QSI_MINUTES,			
	QYTBL.FFQSI_COST1 QSI_COST1,			
	QYTBL.FFQSI_COST2 QSI_COST2,			
	QYTBL.FFQSI_COST3 QSI_COST3,			
	QYTBL.FFQSI_SPECIAL_ACTION_DESIGN QSI_SPECIAL_ACTION,			
	QYTBL.FFQSI_MONTH_CREATED QSI_MONTH_CREATED,			
	QYTBL.FFQSI_MONTH_COMPLETED QSI_MONTH_COMPLETED,			
	QYTBL.FFQSI_MONTH_CLOSED QSI_MONTH_CLOSED,			
	QYTBL.FFQSI_QUARTER_CREATED QSI_QUARTER_CREATED,			
	QYTBL.FFQSI_QUARTER_COMPLETED QSI_QUARTER_COMPLETED,			
	QYTBL.FFQSI_QUARTER_CLOSED QSI_QUARTER_CLOSED,			
	QYTBL.FFQSI_CYCLE_TIME QSI_CYCLE_TIME,			
	QYTBL.FFQSI_DOWN_TIME QSI_DOWN_TIME,			
	MTBL.FBBASEURL ||'/'|| MTBL.FBFORM || '.xsp?action=openDocument' || '&' ||'database=qsi_' ||SUBSTR(QYTBL.FFQSI_SCHEMA,7,10)|| '&' || 'id=' || MTBL.FBDOCID QSI_URL,			QYTBL.FFQSI_PROGENITOR_UNIQUEID QSI_PROGENUID,			
	QYTBL.FFQSI_RQ_UNIQUEID QSI_RQUID,			
	QYTBL.FFQSI_EXT_UNIQUE_ID QSI_EXTUID,			
	--QYTBL.FFQSI_VASSALHOST_UNIQUE_ID QSI_VASSAL_HUID
	'' QSI_VASSAL_HUID		
	
	FROM FB_QSI_CLB_QY QYTBL INNER JOIN FB_QSI_CLB MTBL ON MTBL.FBDOCID = QYTBL.FBDOCID		
	WHERE QYTBL.FBROWID = 0 AND QYTBL.FFORGANIZATION IS NOT NULL AND QYTBL.FBSCHEMA != 'qsi_deleted'	

