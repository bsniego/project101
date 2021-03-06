SELECT facility.product_group_abbr business_unit,
    cms_data.location_id,
    facility.facility,
    cms_data.base_data,
    cms_data.year_3 AS "2016", --"2013",
    cms_data.year_2 AS "2017", --"2014",
   cms_data.year_1 AS "2018", --"2015",
    cms_data.year_current AS "YTD", --YTD,
    cms_data.month_12 "Feb-17", --Jul_2015,
    cms_data.month_11 "Mar-17", --Aug_2015,
    cms_data.month_10 "Apr-17", --Sep_2015,
    cms_data.month_9 "May-17", --Oct_2015,
    cms_data.month_8 "Jun-17", --Nov_2015,
    cms_data.month_7 "Jul-17", --Dec_2015,
    cms_data.month_6 "Aug-17", --Jan_2016,
    cms_data.month_5 "Sep-17", --Feb_2016,
    cms_data.month_4 "Oct-17", --Mar_2016,
    cms_data.month_3 "Nov-17", --Apr_2016,
    cms_data.month_2 "Dec-17", --May_2016,
    cms_data.month_1 AS "Jan-18" --Jun_2016
  FROM
    (SELECT   location_id,
        base_data,
        SUM(year_3) year_3,
        SUM(year_2) year_2,
        SUM(year_1) year_1,
        SUM(year_current) year_current,
        SUM(month_12) month_12,
        SUM(month_11) month_11,
        SUM(month_10) month_10,
        SUM(month_9) month_9,
        SUM(month_8) month_8,
        SUM(month_7) month_7,
        SUM(month_6) month_6,
        SUM(month_5) month_5,
        SUM(month_4) month_4,
        SUM(month_3) month_3,
        SUM(month_2) month_2,
        SUM(month_1) month_1
      FROM
        (SELECT   location_id,
            base_data,
            DECODE(base_year, TO_CHAR(ADD_MONTHS(SYSDATE, -36), 'yyyy'), qty, NULL) year_3,
            DECODE(base_year, TO_CHAR(ADD_MONTHS(SYSDATE, -24), 'yyyy'), qty, NULL) year_2,
            DECODE(base_year, TO_CHAR(ADD_MONTHS(SYSDATE, -12), 'yyyy'), qty, NULL) year_1,
            DECODE(base_year, TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'yyyy'), qty, NULL) year_current,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -12), 'MON-yy')), qty, NULL) month_12,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -11), 'MON-yy')), qty, NULL) month_11,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -10), 'MON-yy')), qty, NULL) month_10,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -9), 'MON-yy')), qty, NULL) month_9,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -8), 'MON-yy')), qty, NULL) month_8,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -7), 'MON-yy')), qty, NULL) month_7,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -6), 'MON-yy')), qty, NULL) month_6,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -5), 'MON-yy')), qty, NULL) month_5,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'MON-yy')), qty, NULL) month_4,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -3), 'MON-yy')), qty, NULL) month_3,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'MON-yy')), qty, NULL) month_2,
            DECODE(report_date, to_date('01-' || TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'MON-yy')), qty, NULL) month_1
          FROM
            (SELECT   location_id,
                report_date,
                base_data,
                qty,
                TO_CHAR(report_date, 'YYYY') base_year
              FROM
                (SELECT   location_id,
                    report_date,
                    base_data,
                    qty
                  FROM
                    (SELECT   *
                      FROM
                        (SELECT   Location_ID,
                            report_date,
                            Prod_Vol,
                            Serv_Vol,
                            Prod_Vol + SerV_VOL Total_Vol,
                            Prod_Defect_Qty,
                            Serv_Defect_Qty,
                            Prod_Defect_Qty + Serv_Defect_Qty Total_Defect,
                            Prod_Incident_TOTAL, 
                            Prod_Incident_MAJOR,
                            Prod_Incident_TOTAL - Prod_Incident_MAJOR Prod_Incident_Minor,
                            Serv_Incident_Major,
                            Serv_Incident_Total,
                            Serv_Incident_TOTAL - Serv_Incident_MAJOR Serv_Incident_Minor,
                            PROD_INCIDENT_TOTAL + SERV_INCIDENT_TOTAL TOTAL_INCIDENT,
                            Prod_Incident_MAJOR + Serv_Incident_Major TOTAL_INCIDENT_MAJOR
                          FROM
                            (SELECT   location_id,
                                report_date,
                                NVL(prod_defect_qty, 0) prod_defect_qty ,
                                NVL( prod_vol, 0) prod_vol,
                                NVL(prod_incident_major, 0) prod_incident_major ,
                                NVL( serv_defect_qty, 0) serv_defect_qty,
                                NVL( serv_vol, 0) serv_vol,
                                NVL ( prod_incident_total, 0) prod_incident_total,
                                NVL(serv_incident_total, 0) serv_incident_total,
                                NVL( serv_incident_major, 0) serv_incident_major
                              FROM
                                (SELECT   Location_ID,
                                    to_date(ReportingYear|| ReportingMonth , 'YYYYMM') report_date,
                                    ResponseValue,
                                    Metric_ID
                                  FROM cms_defect_incident WHERE CUSTOMER_ID NOT IN ('287')
                                ) pivot (SUM(to_number(ResponseValue)) FOR Metric_ID IN ( '1'
                                Prod_Defect_Qty, '5' Prod_VOL , '3' Prod_Incident_TOTAL, '9'
                                Prod_Incident_MAJOR, '2' Serv_Defect_Qty, '6' Serv_Vol, '4'
                                Serv_Incident_Total, '10' Serv_Incident_Major)))
                        ) unpivot (QTY FOR base_data IN ("TOTAL_INCIDENT", "TOTAL_DEFECT",
                        "TOTAL_VOL", "TOTAL_INCIDENT_MAJOR"))))))
      GROUP BY location_id,
        base_data) cms_data,
    (SELECT   gdis_Location_Id,
         location_name Facility,
        PRODUCT_GROUP_ABBR
      FROM gdis_location_extract
) facility
  WHERE cms_data.location_id = facility.gdis_location_id
  order by 1, 3, 4
