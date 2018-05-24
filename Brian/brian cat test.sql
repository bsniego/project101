--DROP VIEW CPRO.DANA_CATEGORY;

--CREATE OR REPLACE VIEW CPRO.DANA_CATEGORY
AS SELECT   a.qsi_uniqueid, a.qsi_orgkey, a.qsi_choicename area, substr(a.qsi_choicekey,13) areakey, b.qsi_choicename department, substr(b.qsi_choicekey,13) deptkey
  FROM
    ( SELECT DISTINCT qsi_uniqueid, qsi_orgkey, qsi_choicename, qsi_groupname, QSI_CHOICEKEY
      --FROM qsi_category_lookup_tbl
      FROM Dana_DeptArea_MTBL
      --FROM Dana_DeptArea_MKWREF
      --FROM Dana_DeptArea_KWREF
      WHERE /*qsi_uniqueid = '51324ee1657bc/0'
        AND */ qsi_groupname = 'Dana Areas'
        --AND qsi_uniqueid IN ('4c953f443cd0d/0', '51350333455a2/1', '51893b7dfaf22/0', '51350333455a2/2', '51350333455a2/3', '51324ee1657bc/0', '51550eb203987/1')
    ) a,
    (SELECT DISTINCT qsi_uniqueid, qsi_orgkey, qsi_choicename, qsi_groupname, QSI_CHOICEKEY
      --FROM qsi_category_lookup_tbl
      FROM Dana_DeptArea_MTBL
      --FROM Dana_DeptArea_MKWREF
      --FROM Dana_DeptArea_KWREF
      WHERE /*qsi_uniqueid = '51324ee1657bc/0'
      
        AND */ qsi_groupname = 'Dana Departments'
        --AND qsi_uniqueid IN ('4c953f443cd0d/0', '51350333455a2/1', '51893b7dfaf22/0', '51350333455a2/2', '51350333455a2/3', '51324ee1657bc/0', '51550eb203987/1')
    ) b
  WHERE a.qsi_uniqueid = b.qsi_uniqueid


-----------------------------------------------------------------

--DROP MATERIALIZED VIEW CPRO.DANA_DEPTAREA_MTBL;

--CREATE MATERIALIZED VIEW CPRO.DANA_DEPTAREA_MTBL

----------------try doing this like Dana_DEG_Values -----------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

AS SELECT  distinct
    A.FFQSI_UNIQUE_ID QSI_UNIQUEID,
    A.FFQSI_FAMILY_ID QSI_FAMILYID,                                       
    A.FFQSI_VERSION QSI_VERSION,
    ITEM.QSI_ORGKEY,
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

FROM (SELECT FFQSI_UNIQUE_ID, FFQSI_FAMILY_ID, FFQSI_VERSION, FFQSI_LEVEL, FFQSI_GROUP_KEY, FFQSI_CHOICE_KEY  FROM FB_QSI_KEYWORDS_INDEX_QY) A

JOIN QSI_ITEM_ORG_LOOKUP ITEM ON
                A.FFQSI_UNIQUE_ID = ITEM.QSI_UNIQUEID
LEFT outer JOIN (select distinct qsi_key, qsi_value, qsi_org FROM QSI_KEYWORD_LOOKUP) B ON
	A.FFQSI_GROUP_KEY||ITEM.QSI_ORGKEY = B.QSI_KEY||B.QSI_ORG
                --A.FFQSI_GROUP_KEY = B.QSI_KEY AND ITEM.QSI_ORGKEY = B.QSI_ORG
LEFT OUTER JOIN (select distinct qsi_key, qsi_value, qsi_org from QSI_KEYWORD_LOOKUP) C ON
	A.FFQSI_CHOICE_KEY||ITEM.QSI_ORGKEY = C.QSI_KEY||C.QSI_ORG
                --A.FFQSI_CHOICE_KEY = C.QSI_KEY AND ITEM.QSI_ORGKEY = C.QSI_ORG
                
--Only look for the department qsi_Keywords45449 and area qsi_Keywords17690 keys 
WHERE A.FFQSI_GROUP_KEY IN (
                --'qsi_Keywords45449', --QA Dept old
                --'qsi_Keywords87113', --QA Dept new
                'qsi_Keywords17690', --QA Area
                'qsi_Keywords6018') -- PRD Dept
                --'qsi_Keywords30740')  --TRN Dept

/************************New Dept / Area Code from JD Nov */

--SELECT * FROM QSI_KEYWORD_LOOKUP

--------------------------------------------------------------------------------------
    SELECT DISTINCT
    A.FFQSI_UNIQUE_ID QSI_UNIQUEID,
    A.FFQSI_FAMILY_ID QSI_FAMILYID,                                       
    A.FFQSI_VERSION QSI_VERSION,
    ITEM.QSI_ORGKEY,
    A.FFQSI_LEVEL QSI_LEVEL,
    A.FFQSI_GROUP_KEY QSI_GROUPKEY,
    kwd.qsi_level,
    kwd.qsi_groupname,
    kwd.qsi_choicekey,
    kwd.qsi_choicename
    
    FROM (SELECT 
    	FFQSI_UNIQUE_ID, 
    	FFQSI_FAMILY_ID, 
    	FFQSI_VERSION, 
    	FFQSI_LEVEL, 
    	FFQSI_GROUP_KEY, 
    	FFQSI_CHOICE_KEY  
    	FROM FB_QSI_KEYWORDS_INDEX_QY WHERE FFQSI_GROUP_KEY IN ('qsi_Keywords17690','qsi_Keywords6018')) A

	JOIN QSI_ITEM_ORG_LOOKUP ITEM ON
    	A.FFQSI_UNIQUE_ID = ITEM.QSI_UNIQUEID
                
	JOIN (SELECT * FROM QSI_CATEGORY_LOOKUP_TBL) KWD ON
		A.FFQSI_UNIQUE_ID = KWD.QSI_UNIQUEID AND kwd.qsi_groupname IN ('Department(s)','Dana Areas')

--------------------------------------------------------------------------------------

--DROP VIEW CPRO.DANA_DEG_VALUES;

--CREATE OR REPLACE VIEW CPRO.DANA_DEG_VALUES
AS SELECT DISTINCT 
 QSI_UNIQUEID, 
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords11738' THEN QSI_CHOICENAME ELSE NULL END) AS SEVERITY,
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords86474' THEN QSI_CHOICENAME ELSE NULL END) AS REPEATISSUE, 
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords46226' THEN QSI_CHOICENAME ELSE NULL END) AS DISPUTED, 
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords81306' THEN QSI_CHOICENAME ELSE NULL END) AS PARTUSE, 
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords14175' THEN QSI_CHOICENAME ELSE NULL END) AS STOPSHIP,
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords18246' THEN QSI_CHOICENAME ELSE NULL END) AS CARRESP, 
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords48106' THEN QSI_CHOICENAME ELSE NULL END) AS SOURCEOFCAR, 
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords45449' THEN QSI_CHOICENAME ELSE NULL END) AS RESPDEPT,
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords28880' THEN QSI_CHOICENAME ELSE NULL END) AS PROCESSNAME,
MAX(CASE QSI_GROUPKEY WHEN 'qsi_Keywords29740' THEN QSI_CHOICENAME ELSE NULL END) AS PRODGRPPROBCODE

FROM (SELECT * FROM QSI_CATEGORY_LOOKUP_TBL)

GROUP BY QSI_UNIQUEID


