--DROP VIEW CPRO.DANA_JOBI_MAIN;

--CREATE OR REPLACE VIEW CPRO.DANA_JOBI_MAIN
AS SELECT 
  --bws 12-June-2015 Created for JOBi Shop Floor Documentation Interface
  -- the following 2 views need to be created to support this query
  -- Dana_Category  (This provided the multi-level Department / Area structure)
  -- Dana_Doc_All (This provides the URL Document Link)
  --bws 2 Jul 2015 Added a where to only look at doc's with attachments that are assigned departments
  --bws 6 Jul 2015 View Dana_JOBI_Main created
  --bws 16Feb2016 Added filers to Join Statements, removed Dana_Doc_All requirement
  --bws 01Apr2016 Added - WHERE nvl(ATTIDX."Line_Item_Heading",'legacy') != 'Master Document Library'

  QYTBL.FBDocID || cat.deptkey || cat.areakey || a.rowid "RumbaORM_Code",
  QYTBL.FBDocID,
  QYTBL.FFFamilyID,
  QYTBL.FFVERSION,
  QYTBL.FFQSI_UNIQUE_ID,
  QYTBL.FFFormLabel,
  QYTBL.FFORGANIZATION Site,
  ORGIDX.QSI_VALUE "Facility_Name",
  QYTBL.FFControlNumber "Doc_Number", 
  QYTBL.FFTitle Title, 
  QYTBL.FFStatus Status,
  
  MTBL.FBBASEURL ||'/'|| MTBL.FBFORM || '.xsp?action=openDocument' || '&' || 'id=' || MTBL.FBDOCID QSI_URL,
  cat.department "Department",
  cat.AREA "Area",

  CASE nvl(ATTIDX."Line_Item_Heading",'null')
  	WHEN 'null' THEN
		CASE substr(a.FBNAME,1,3) 
  			WHEN '01_' THEN '01 Setup Instruction'
  			WHEN '02_' THEN '02 Work Instruction'
  			WHEN '03_' THEN '03 Standardized Work'
  			WHEN '04_' THEN '04 Packaging Plan'
  			WHEN '05_' THEN '05 Visual Aids'
  			WHEN '06_' THEN '06 Safety & Environmental'
  			WHEN '07_' THEN '07 Additional Records'
  			WHEN '08_' THEN '08 Part Profile'
  			ELSE '10 Job Instructions'
  		END
  	ELSE 
  		CASE ATTIDX."Line_Item_Heading" 
  			WHEN 'Setup Instructions' THEN '01 Setup Instruction'
  			WHEN 'Work Instructions' THEN '02 Work Instruction'
  			WHEN 'Standardized Work' THEN '03 Standardized Work'
  			WHEN 'Packaging Plan' THEN '04 Packaging Plan'
  			WHEN 'Visual Aids' THEN '05 Visual Aids'
  			WHEN 'Safety & Environmental Information/ Información...' THEN '00 Safety & Environmental'
  			WHEN 'Additional Records/ Registros adicionales/ Regi...' THEN '07 Additional Records'
  			WHEN 'Product Profile Image' THEN '08 Part Profile'
  			WHEN 'Process Sheets and Specifications' THEN '09 Process Sheets & Specs'
  			ELSE '10 Job Instructions'
  		END
  END AS "FBSECTION",
ATTIDX."Line_Item_Heading" linehead,
  a.FBName "File_Name",

  CASE nvl(ATTIDX."Attachment_Label",'null')
  	WHEN 'null' THEN substr(a.FBNAME,instr(a.FBName,'_')+1,instr(a.FBName,'.',-1)-instr(a.FBName,'_')-1)
  	ELSE ATTIDX."Attachment_Label"
  END AS "FBLABEL",
  
  a.FBDESCR Description,
  ATTIDX.ATTACHMENTSEQ,
  a.FBTYPE "File_Type",
  a.FBLENGTH "Size",
  a.FBFile "Blob"

    FROM (SELECT * FROM FB_QSI_QY WHERE FFFORMLABEL IN 'Work Instruction ' AND FFSTATUS='Approved - Released' AND FBROWID=0/* AND FFORGANIZATION ='88900'*/) QYTBL 

/* Get the URL of the document */
	JOIN FB_QSI MTBL ON 
		MTBL.FBDOCID = QYTBL.FBDOCID and QYTBL.FBROWID = 0 AND QYTBL.FFORGANIZATION IS NOT NULL AND QYTBL.FBSCHEMA != 'qsi_deleted'
	JOIN (SELECT FBDOCID, FBNAME, FBDESCR, FBLENGTH, FBTYPE, FBFILE From FB_QSI_AF WHERE FBNAME IS NOT NULL) A ON 
    	QYTBL.FBDOCID = A.FBDOCID 	
  	LEFT OUTER JOIN (SELECT host_docid, "Attachment_Label", "Line_Item_Heading", AttachmentSEQ, "Attachment_File_Name" FROM DANA_JOBI_ATTACHMENTIDX /*WHERE "Line_Item_Heading" <> 'Master Document Library'*/) ATTIDX ON
  		ATTIDX.HOST_DOCID = QYTBL.FFQSI_UNIQUE_ID AND ATTIDX."Attachment_File_Name" = a.FBName
	JOIN QSI_ORG_LOOKUP ORGIDX ON
	ORGIDX.QSI_KEY = QYTBL.FFORGANIZATION
  	JOIN (SELECT * FROM DANA_CATEGORY WHERE DEPARTMENT IS NOT NULL AND AREA IS NOT NULL) CAT ON  
  		CAT.QSI_UNIQUEID  = QYTBL.FFQSI_UNIQUE_ID

    --AND QYTBL.FFORGANIZATION IN ('99066','88900','10594', '10400') --Rayong Axle, St Clair, Rayong Gear, Wuxi)
    --AND QYTBL.FFORGANIZATION ='99066' --Rayong Axle
    --AND QYTBL.FFORGANIZATION ='88900' --St Clair
    --AND QYTBL.FFORGANIZATION ='10594' --Rayong Gear
    
    WHERE nvl(ATTIDX."Line_Item_Heading",'legacy') != 'Master Document Library'

  ORDER BY QYTBL.FFORGANIZATION, QYTBL.FFControlNumber, ATTIDX.ATTACHMENTSEQ --substr(a.FBNAME,1,2)

