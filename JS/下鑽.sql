--PROGRAMMES 下鑽
WITH TL1 AS(
SELECT distinct
	T1.app_id,
	T1.programme,
	academic_year AS year
FROM [dbo].[dw_adm_registration_d] T1
LEFT JOIN dbo.dm_date T2
ON T1.date = T2.date
LEFT JOIN [dbo].[dw_adm_application_d] T3
ON T1.app_id = T3.app_id
WHERE 1=1
${if(len(P_AY) == 0,"","and academic_year > '" +P_AY+ "'-5")} 
${if(len(P_AY) == 0,"","and academic_year <= '" +P_AY+ "'")} 
GROUP BY
academic_year,
T1.programme,
T1.app_id
),
TL2 AS(
SELECT distinct
	T1.app_id,
	T1.programme,
	Year AS year
FROM [dbo].[dw_adm_registration_d] T1
LEFT JOIN dbo.dm_date T2
ON T1.date = T2.date
LEFT JOIN [dbo].[dw_adm_application_d] T3
ON T1.app_id = T3.app_id
WHERE 1=1
${if(len(P_YEAR) == 0,"","and YEAR > '" +P_YEAR+ "'-5")} 
${if(len(P_YEAR) == 0,"","and YEAR <= '" +P_YEAR+ "'")} 
GROUP BY
Year,
T1.programme,
T1.app_id
)
SELECT
	COUNT(app_id) AS num
	,programme,
	year
FROM
${if(BTN_TYPE= "1","TL1","TL2")}
GROUP BY 
programme,
year
ORDER BY year

--------------------------------

--DEGREES 下鑽

WITH TL1 AS(
SELECT distinct
	T1.app_id,
	T1.student_type,
	T1.degree,
	academic_year AS year
FROM [dbo].[dw_adm_registration_d] T1
LEFT JOIN dbo.dm_date T2
ON T1.date = T2.date
LEFT JOIN [dbo].[dw_adm_application_d] T3
ON T1.app_id = T3.app_id
WHERE 1=1
${if(len(P_AY) == 0,"","and academic_year > '" +P_AY+ "'-5")} 
${if(len(P_AY) == 0,"","and academic_year <= '" +P_AY+ "'")} 
),
TL2 AS(
SELECT distinct
	T1.app_id,
	T1.student_type,
	T1.degree,
	Year AS year
FROM [dbo].[dw_adm_registration_d] T1
LEFT JOIN dbo.dm_date T2
ON T1.date = T2.date
LEFT JOIN [dbo].[dw_adm_application_d] T3
ON T1.app_id = T3.app_id
WHERE 1=1
${if(len(P_YEAR) == 0,"","and YEAR > '" +P_YEAR+ "'-5")} 
${if(len(P_YEAR) == 0,"","and YEAR <= '" +P_YEAR+ "'")} 
)
SELECT
	COUNT(app_id) AS num,
	T1.student_type,
	T1.degree,
	year
FROM
${if(BTN_TYPE= "1","TL1","TL2")}
GROUP BY 
student_type,
degree,
year
ORDER BY 
year ASC
