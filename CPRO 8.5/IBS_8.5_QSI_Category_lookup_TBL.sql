--DROP TABLE CPRO_STG.QSI_CATEGORY_LOOKUP_TBL CASCADE CONSTRAINTS;

--CREATE TABLE CPRO_STG.QSI_CATEGORY_LOOKUP_TBL
	(
	QSI_UNIQUEID   VARCHAR2 (156),
	QSI_FAMILYID   VARCHAR2 (128),
	QSI_VERSION    VARCHAR2 (20),
	QSI_GROUPKEY   VARCHAR2 (160),
	QSI_GROUPNAME  VARCHAR2 (200),
	QSI_CHOICEKEY  VARCHAR2 (160),
	QSI_CHOICENAME VARCHAR2 (200),
	QSI_KEY        VARCHAR2 (652),
	QSI_VALUE      VARCHAR2 (824),
	QSI_VALUES     VARCHAR2 (616)
	)
	TABLESPACE STG_APPDATA
	LOGGING
	NOCACHE
	STORAGE (BUFFER_POOL DEFAULT);

