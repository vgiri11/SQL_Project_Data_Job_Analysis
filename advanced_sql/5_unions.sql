/**
 * @Author: VictoriaGiri
 * @Date:   2026-06-21 23:32:09
 * @Last Modified by:   VictoriaGiri
 * @Last Modified time: 2026-06-21 23:36:44
 */
-- UNION - combines results from two or more SELECT statements
-- They need to have the same amount of columns, and the data type must match
-- Gets rid of all duplicate rows (unlike UNION ALL), all rows are unique

SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    january_jobs

UNION ALL


SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    february_jobs

UNION ALL


SELECT
    job_title_short,
    company_id,
    job_location
FROM 
    march_jobs


-- UNION ALL - combine the result of two or more SELECT statements
-- again need to have the same amount of columns and the data type must match
-- Returns all rows, even duplicates
-- irl mostly this one used

