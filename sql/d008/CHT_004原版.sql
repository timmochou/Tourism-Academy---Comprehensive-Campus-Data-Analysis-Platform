SELECT 
  ${if(len(P_AY)=0,"year AS year","CONCAT(academic_year,'/',(academic_year+1)) AS year")}
      ,[totalTeachingLoad]/60 AS num
  FROM [IFTMDW].[dbo].[dw_fac_teachingload_ay]
  WHERE 1=1
  ${if(len(P_FAC)=0, "","AND faculty_id ='"+P_FAC+"'")}
  ${if(len(P_AY)=0,"","
  AND academic_year <='"+P_AY+"'
  AND academic_year >='"+P_AY+"'-4
  ")}
  ${if(len(P_YEAR)=0,"","
  AND year <='"+P_YEAR+"'
  AND year >='"+P_YEAR+"'-4
  ")}
  ORDER BY
  year