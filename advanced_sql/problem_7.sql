/**
 * @Author: VictoriaGiri
 * @Date:   2026-05-16 11:36:59
 * @Last Modified by:   VictoriaGiri
 * @Last Modified time: 2026-06-21 23:30:52
 */
/* 
Find the count of the number of remote job postings per skills_dim  
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/

-- First step: Create a CTE that collects the number of job postings per skill. So some JOIN between job_postings_fact table and skills_job_dim table. 
WITH remote_job_skills AS (
    SELECT  
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;