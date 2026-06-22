/**
 * @Author: VictoriaGiri
 * @Date:   2026-05-15 18:38:29
 * @Last Modified by:   VictoriaGiri
 * @Last Modified time: 2026-05-15 18:55:42
 */
SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

-- :: DATE
-- used for casting, can be used to convert different data types

SELECT '2023-02-19';    
SELECT '2023-02-19'::DATE; 
SELECT  
    '2023-02-19'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL;


SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date 
FROM    
    job_postings_fact;

-- First AT TIME ZONE adds time zone information to the timestamp (that until now has no timezone info)
-- so first one says, this time is in UTC
-- second AT TIME ZONE transfers it to the time zone we want to have the data in, in this case EST
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM    
    job_postings_fact
LIMIT 5;

-- EXTRACT: gets a field (e.h. year, month, day) from a date/time value
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM    
    job_postings_fact
LIMIT 5;

SELECT  
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM   
    job_postings_fact
WHERE   
    job_title_short = 'Data Analyst'
GROUP BY    
    month
ORDER BY
    job_posted_count DESC;