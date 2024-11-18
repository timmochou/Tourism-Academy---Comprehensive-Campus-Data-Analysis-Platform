SELECT
  LEFT(date2,4) AS year,
  LEFT(academic_year,4) AS academic_year,
  faculty_id,
  teacher_id,
  faculty_type, 
faculty_status,
  faculty_name_en,
  totalTeachingLoad
  FROM
  [IFTMDW].[dbo].[ods_SCSI_teachingload_ay] T1
  LEFT JOIN
  [IFTMDW].[dbo].[dw_fac_faculty_d] T2
  ON T1.assigned_teacher_id_list = T2.teacher_id