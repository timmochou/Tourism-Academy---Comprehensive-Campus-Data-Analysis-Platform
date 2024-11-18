WITH ACADEMIC_YEAR AS (
--串ACADEMIC YEAR 的資料，不用篩選月份，顯示全年的資料
   SELECT
    CONCAT(T2.academic_year,'/',(T2.academic_year+1)) AS year,
    SUM(T1.totalTeachingLoad) / 60 AS num,
    CAST(SUM(T1.totalTeachingLoad) / 3600 AS varchar) + 'h' + CAST((SUM(T1.totalTeachingLoad) / 60) % 60 AS varchar) + 'min' AS hour_min
FROM 
    [dbo].[ods_SCSI_teachingload_ay] T1
LEFT JOIN ( SELECT DISTINCT year,academic_year,month FROM [dbo].[dm_date]  ) AS T2 
ON T1.YEAR = T2.year 
AND  (CASE WHEN T1.MONTH < 10 THEN '0' + CAST(T1.MONTH AS varchar)
         ELSE CAST(T1.MONTH AS varchar) END) = T2.MONTH
WHERE 1=1 
AND T1.assigned_teacher_id_list= (SELECT DISTINCT teacher_id FROM [IFTMDW].[dbo].[dw_fac_teachingload_ay] WHERE faculty_id= '${P_FAC}') 
${if(len(P_AY)=0,"","
  AND T2.academic_year <='"+P_AY+"'
  AND T2.academic_year >='"+P_AY+"'-4
  ")}
GROUP BY 
    T2.academic_year
)
,YEAR AS(
--串ACADEMIC YEAR 的資料，要篩選月份，只顯示該年當月的資料    
    SELECT
    T1.YEAR AS year,
    SUM(T1.totalTeachingLoad) / 60 AS num,
    CAST(SUM(T1.totalTeachingLoad) / 3600 AS varchar) + 'h' + CAST((SUM(T1.totalTeachingLoad) / 60) % 60 AS varchar) + 'min' AS hour_min
FROM 
    [dbo].[ods_SCSI_teachingload_ay] T1
WHERE 1=1 
${if(len(P_YEAR)=0,"","
  AND T1.YEAR <= '"+P_YEAR+"'
  AND T1.YEAR >= '"+P_YEAR+"' - 4
  ")}
--篩選月份，先轉換月份形式，因為一個是數字(1,2)，dm_date裡面的月份是字串：01,02等
${if(len(P_MONTH)=0,"","
  AND (CASE WHEN T1.MONTH < 10 THEN '0' + CAST(T1.MONTH AS varchar)
         ELSE CAST(T1.MONTH AS varchar) END) = '"+P_MONTH+"'"
)}
AND T1.assigned_teacher_id_list IN (SELECT DISTINCT teacher_id FROM [IFTMDW].[dbo].[dw_fac_teachingload_ay] WHERE faculty_id = '${P_FAC}')
GROUP BY T1.YEAR
    )
--最後從BTN_TYPE來決定要用學年還是普通年月
SELECT 
    year, 
    num, 
    hour_min 
FROM ${(IF(BTN_TYPE=='1', "ACADEMIC_YEAR", "YEAR"))}