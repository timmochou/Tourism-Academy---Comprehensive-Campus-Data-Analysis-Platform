WITH ACADEMIC_YEAR AS (
SELECT
type,
(SUM(minutediff)/60) AS minutediff,
CAST(SUM(T1.minutediff) / 3600 AS varchar) + 'h' + CAST((SUM(T1.minutediff) / 60) % 60 AS varchar) + 'min' AS hour_min
FROM
dbo.dw_fac_teachingload_distribution T1
LEFT JOIN
dbo.dw_fac_faculty_d T2
ON T1.teacher_id = T2.teacher_id
LEFT JOIN ( SELECT DISTINCT year,academic_year,month FROM [dbo].[dm_date]  ) AS T3 
ON T1.YEAR = T3.year 
AND  (CASE WHEN T1.MONTH < 10 THEN '0' + CAST(T1.MONTH AS varchar)
         ELSE CAST(T1.MONTH AS varchar) END) = T3.MONTH
WHERE 1=1 
${if(len(P_FAC)=0,""," AND faculty_id='"+P_FAC+"'")}
${if(len(P_AY)=0,""," AND T3.academic_year='"+P_AY+"'")}
GROUP BY type)
, YEAR AS(
SELECT
type,
(SUM(minutediff)/60) AS minutediff,
CAST(SUM(T1.minutediff) / 3600 AS varchar) + 'h' + CAST((SUM(T1.minutediff) / 60) % 60 AS varchar) + 'min' AS hour_min
FROM
dbo.dw_fac_teachingload_distribution T1
LEFT JOIN
dbo.dw_fac_faculty_d T2
ON T1.teacher_id = T2.teacher_id
LEFT JOIN ( SELECT DISTINCT year,academic_year,month FROM [dbo].[dm_date]  ) AS T3 
ON T1.YEAR = T3.year 
AND  (CASE WHEN T1.MONTH < 10 THEN '0' + CAST(T1.MONTH AS varchar)
         ELSE CAST(T1.MONTH AS varchar) END) = T3.MONTH
WHERE 1=1 
${if(len(P_FAC)=0,""," AND faculty_id='"+P_FAC+"'")}
${if(len(P_YEAR)=0,""," AND T3.year='"+P_YEAR+"'")}
${if(len(P_MONTH)=0,""," AND T3.MONTH='"+P_MONTH+"'")}
GROUP BY type
)
SELECT 
    type, 
    minutediff, 
    hour_min 
FROM ${(IF(BTN_TYPE=='1', "ACADEMIC_YEAR", "YEAR"))}