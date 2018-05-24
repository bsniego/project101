--DROP MATERIALIZED VIEW CPRO.DANA_DEPTAREA_MTBL;

--CREATE MATERIALIZED VIEW CPRO.DANA_DEPTAREA_MTBL
AS SELECT  distinct
                A.FFQSI_UNIQUE_ID QSI_UNIQUEID,
                A.FFQSI_FAMILY_ID QSI_FAMILYID,                                       
                A.FFQSI_VERSION QSI_VERSION,
                A.FFQSI_LEVEL QSI_LEVEL,
                a.fbschema,
                A.FFQSI_GROUP_KEY QSI_GROUPKEY,
                --B.QSI_VALUE QSI_GROUPNAME,
                CASE B.QSI_VALUE 
                                WHEN 'Department' THEN 'Dana Departments' 
                                WHEN 'Department(s)' THEN 'Dana Departments' 
                                ELSE B.QSI_VALUE 
                END QSI_GROUPNAME,
                A.FFQSI_CHOICE_KEY QSI_CHOICEKEY,
                C.QSI_VALUE QSI_CHOICENAME

FROM (SELECT * FROM FB_QSI_KEYWORDS_INDEX_QY /*WHERE FBSCHEMA='qsi'*/) A

JOIN QSI_ITEM_ORG_LOOKUP ITEM ON
                A.FFQSI_UNIQUE_ID = ITEM.QSI_UNIQUEID
LEFT JOIN (select distinct qsi_key, qsi_value, qsi_org from QSI_KEYWORD_LOOKUP) B ON
                A.FFQSI_GROUP_KEY = B.QSI_KEY AND ITEM.QSI_ORGKEY = B.QSI_ORG
LEFT JOIN (select distinct qsi_key, qsi_value, qsi_org from QSI_KEYWORD_LOOKUP) C ON
                A.FFQSI_CHOICE_KEY = C.QSI_KEY AND ITEM.QSI_ORGKEY = C.QSI_ORG
                
--Only look for the department qsi_Keywords45449 and area qsi_Keywords17690 keys **plus the stuff Anna added 6-10-2016
WHERE A.FFQSI_GROUP_KEY IN (
                --'qsi_Keywords45449', --QA Dept old
                --'qsi_Keywords87113', --QA Dept new
                --'qsi_Keywords17690', --QA Area
                --'qsi_Keywords6018', -- PRD Dept
                'qsi_Keywords30740')  --TRN Dept

SELECT * FROM DANA_DEPTAREA_MTBL WHERE QSI_CHOICENAME='0405'

SELECT * FROM DANA_JOBI_MAIN WHERE SITE ='76500'

---------------------------------------------------------------------
DROP VIEW CPRO.DANA_CATEGORY;

CREATE OR REPLACE VIEW CPRO.DANA_CATEGORY
AS SELECT   a.qsi_uniqueid, a.qsi_choicename area, substr(a.qsi_choicekey,13) areakey, b. qsi_choicename department, substr(b.qsi_choicekey,13) deptkey
  FROM
    ( SELECT DISTINCT qsi_uniqueid, qsi_choicename, qsi_groupname, QSI_CHOICEKEY
      --FROM qsi_category_lookup_tbl
      FROM Dana_DeptArea_MTBL
      --FROM Dana_DeptArea_MKWREF
      --FROM Dana_DeptArea_KWREF
      WHERE /*qsi_uniqueid = '51324ee1657bc/0'
        AND */ qsi_groupname = 'Dana Areas'
        --AND qsi_uniqueid IN ('4c953f443cd0d/0', '51350333455a2/1', '51893b7dfaf22/0', '51350333455a2/2', '51350333455a2/3', '51324ee1657bc/0', '51550eb203987/1')
    ) a,
    (SELECT DISTINCT qsi_uniqueid, qsi_choicename, qsi_groupname, QSI_CHOICEKEY
      --FROM qsi_category_lookup_tbl
      FROM Dana_DeptArea_MTBL
      --FROM Dana_DeptArea_MKWREF
      --FROM Dana_DeptArea_KWREF
      WHERE /*qsi_uniqueid = '51324ee1657bc/0'
      
        AND */ qsi_groupname IN ('Dana Departments','Department')
        --AND qsi_uniqueid IN ('4c953f443cd0d/0', '51350333455a2/1', '51893b7dfaf22/0', '51350333455a2/2', '51350333455a2/3', '51324ee1657bc/0', '51550eb203987/1')
    ) b
  WHERE a.qsi_uniqueid = b.qsi_uniqueid

