--DROP VIEW CPRO_STG.QSI_PR_MAIN;

--CREATE OR REPLACE VIEW CPRO_STG.QSI_PR_MAIN
--AS 
SELECT			
	QYTBL.FFQSI_UNIQUE_ID QSI_UNIQUEID,			
	QYTBL.FFFAMILYID QSI_FAMILYID,			
	QYTBL.FFVERSION QSI_VERSION,			
	QYTBL.FFQSI_REFERENCE_ID_NUMBER QSI_REFID,			
	QYTBL.FBSCHEMA QSI_FBSCHEMA,			
	QYTBL.FFQSI_SCHEMA QSI_DCLASSKEY,			
	QYTBL.FFFORMALIAS QSI_DTYPEKEY,			
	QYTBL.FFORGANIZATION QSI_ORGKEY,			
	QYTBL.FFQSI_ORGANIZATION_NAME QSI_ORGVALUE,			
	QYTBL.FFDATECREATED QSI_CREDATE,			
	QYTBL.FFDATEMODIFIED QSI_MODDATE,			
	QYTBL.FFDATEREQUESTED QSI_REQDATE,			
	QYTBL.FFDATERELEASED QSI_RELDATE,			
	QYTBL.FFDATEAPPROVEDTIMESTAMP QSI_APPDATE,			
	QYTBL.FFCONTROLNUMBER QSI_CONTROLNUM,			
	QYTBL.FFTITLE QSI_TITLE,			
	QYTBL.FFQSI_FORMATTED_IDENTITY QSI_IDENTITY,			
	QYTBL.FFDLCS QSI_STATUSKEY,			
	QYTBL.FFSTATUS QSI_STATUS,			
	QYTBL.FFDOCUMENTMANAGER QSI_DOCMANAGER,			
	QYTBL.FFREQUESTER QSI_DOCREQUESTER,			
	QYTBL.FFAUTHOR QSI_DOCAUTHOR,			
	QYTBL.FFLASTACTOR QSI_LASTACTOR,			
	MDTBL.FFQSI_REFERENCE_ID_NUMBER QSI_REFNUM,			
	MDTBL.FFQSI_ORDER_NUMBER QSI_ORDERNUM,			
	MDTBL.FFQSI_LOT_NUMBER QSI_LOTNUM,			
	MDTBL.FFQSI_LOT_SIZE QSI_LOTSIZE,			
	MDTBL.FFQSI_SAMPLE_SIZE QSI_SMPLSIZE,			
	MDTBL.FFQSI_UNITS QSI_UNITS,			
	MDTBL.FFQSI_COST QSI_COST,			
	MDTBL.FFQSI_DATE QSI_DATE,			
	MDTBL.FFQSI_DATE_CONVERTED QSI_DATECONV,			
	MDTBL.FFQSI_DISPLAY_NAME QSI_NAME,			
	MDTBL.FFQSI_DISTINGUISHED_NAME QSI_DN,			
	MDTBL.FFQSI_FULL_NAME QSI_CN,			
	MDTBL.FFQSI_ADDITIONAL_TEXT1 QSI_TEXT1,			
	MDTBL.FFQSI_ADDITIONAL_TEXT2 QSI_TEXT2,			
	MDTBL.FFQSI_ADDITIONAL_TEXT3 QSI_TEXT3,			
	MDTBL.FFQSI_ADDITIONAL_TEXT4 QSI_TEXT4,			
	MDTBL.FFQSI_ADDITIONAL_TEXT5 QSI_TEXT5,			
	MDTBL.FFQSI_ADDITIONAL_TEXT6 QSI_TEXT6,			
	MDTBL.FFQSI_ADDITIONAL_TEXT7 QSI_TEXT7,			
	MDTBL.FFQSI_ADDITIONAL_TEXT8 QSI_TEXT8,			
	MDTBL.FFQSI_ADDITIONAL_TEXT9 QSI_TEXT9,			
	MDTBL.FFQSI_ADDITIONAL_TEXT10 QSI_TEXT10,			
	MDTBL.FFQSI_ADDITIONAL_TEXT11 QSI_TEXT11,			
	MDTBL.FFQSI_ADDITIONAL_TEXT12 QSI_TEXT12,	 		
	MDTBL.FFQSI_DESCRIPTION1 QSI_DESC1,			
	MDTBL.FFQSI_DESCRIPTION2 QSI_DESC2		
FROM FB_QSI_PR_QY QYTBL		
LEFT JOIN FB_QSI_MASTER_DATA_INDEX_QY MDTBL	ON	QYTBL.FFQSI_UNIQUE_ID = MDTBL.FFQSI_SOURCE_UNIQUE_ID AND MDTBL.FFQSI_SEQUENCE_NUMBER = -1		
WHERE QYTBL.FBROWID = 0 AND	QYTBL.FBSCHEMA != 'qsi_deleted' AND	QYTBL.FFORGANIZATION  IS NOT NULL