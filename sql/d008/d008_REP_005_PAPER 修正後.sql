WITH t0 AS 
(
    SELECT 
        login_id, 
        teacher_id, 
        faculty_id
    FROM dbo.dw_fac_faculty_d
    WHERE 1=1
    ${if(len(P_FAC)=0, "", "AND faculty_id = '" + P_FAC + "'")}
),
ACADEMIC_YEAR AS (
    SELECT 
        ta.*,
        LEFT(date_issued, 4) AS year,
        SUBSTRING(date_issued, 6, 2) AS month
    FROM dbo.dw_api_publication_type_d ta 
    INNER JOIN t0 ON ta.teacher_id = t0.login_id
    LEFT JOIN (SELECT DISTINCT year, academic_year, month FROM [dbo].[dm_date]) AS T3 
    ON LEFT(date_issued, 4) = T3.YEAR
    AND SUBSTRING(date_issued, 6, 2) = T3.MONTH
    WHERE 1=1 
    ${if(len(P_AY)=0, "", "
      AND T3.academic_year = '" + P_AY + "'
    ")}
    
),
YEAR AS (
    SELECT 
        ta.*,
        LEFT(date_issued, 4) AS year,
        SUBSTRING(date_issued, 6, 2) AS month
    FROM dbo.dw_api_publication_type_d ta 
    INNER JOIN t0 ON ta.teacher_id = t0.login_id
    LEFT JOIN (SELECT DISTINCT year, academic_year, month FROM [dbo].[dm_date]) AS T3 
    ON LEFT(date_issued, 4) = T3.year 
    AND SUBSTRING(date_issued, 6, 2) = T3.MONTH
    WHERE 1=1 
    ${if(len(P_YEAR)=0, "", "
      AND T3.year = '" + P_YEAR + "'
    ")}
    ${if(len(P_MONTH)=0, "", "
      AND T3.month = '" + P_MONTH + "'
    ")}
    
)
SELECT 
    *
FROM ${(IF(BTN_TYPE='1', "ACADEMIC_YEAR", "YEAR"))}
ORDER BY year , month ASC 