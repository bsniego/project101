--DROP VIEW CPRO.DANA_JOBIETR_MINSTATUS;

--CREATE OR REPLACE VIEW CPRO.DANA_JOBIETR_MINSTATUS
--AS 
SELECT   TQ_ID, QDQY_FFCONTROLNUMBER, ffqsi_name, TQQY_ffcontrolnumber,
    fftitle, FFORGANIZATION, FFSTATUS, MAX(PreMinStatus) PreMinStatus
  FROM
    (SELECT   TQQY.FBDOCID TQ_id, QDQY.FFCONTROLNUMBER QDQY_FFCONTROLNUMBER, TQQY.ffqsi_name,
        TQQY.ffcontrolnumber TQQY_ffcontrolnumber, TQQY.fftitle, TQQY.FFORGANIZATION, TQQY.FFSTATUS
        ,
        DECODE(TRQY.FFSTATUS, 'New', 1, 'Scheduled', 1,'Not Completed', 1, 'Completed - Ineffective', 1, 'Completed', 2,
        'Completed - Effective', 3, 'Waived', 3, 0) PreMinStatus
      FROM
        (SELECT   FFQSI_UNIQUE_ID, FFCONTROLNUMBER
          FROM FB_QSI_QD_QY
          WHERE fbrowid=0
            AND FFSTATUS='Approved - Released'
            AND FFORGANIZATION='10714'
        ) QDQY
      JOIN FB_QSI_TQ_QY TQQY
      ON QDQY.FFQSI_UNIQUE_ID = TQQY.FFQSI_PROGENITOR_UNIQUEID
        AND TQQY.FFSTATUS NOT IN ('Superseded','Expired','Archived')
      JOIN FB_QSI_TQ_QY TQRQY
      ON TQQY.FFCONTROLNUMBER =TQRQY.FFCONTROLNUMBER
        AND TQQY.FFORGANIZATION=TQRQY.FFORGANIZATION
        AND TQQY.FFQSI_PROGENITOR_UNIQUEID=TQRQY.FFQSI_QD_FAMILY_ID||'/'||TQRQY.FFQSI_QD_VERSION
        --AND TQQY.FFSTATUS NOT IN ('Superseded','Expired','Archived')
      JOIN FB_QSI_TR_QY TRQY
      ON TQRQY.FFQSI_CD_DC_FAMILY_ID=TRQY.FFQSI_PROGENITOR_FAMILY_ID
      --ON TQRQY.FFQSI_DOCUMENT_FAMILY_ID=TRQY.FFQSI_DOCUMENT_FAMILY_ID
        AND TQRQY.FFCONTROLNUMBER=TRQY.FFCONTROLNUMBER
        --AND TRQY.FFSTATUS NOT IN ('Superseded','Obsolete','Expired','Archived')
    )
  GROUP BY TQ_ID, QDQY_FFCONTROLNUMBER, ffqsi_name, TQQY_ffcontrolnumber,
    fftitle, FFORGANIZATION, FFSTATUS
  ORDER BY FFORGANIZATION, FFTITLE, ffqsi_name

