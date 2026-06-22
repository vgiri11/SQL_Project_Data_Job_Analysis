/**
 * @Author: VictoriaGiri
 * @Date:   2026-05-15 22:40:17
 * @Last Modified by:   VictoriaGiri
 * @Last Modified time: 2026-06-21 22:47:46
 */
-- We want to create separate tables with all the postings of Jan, Feb and Mar each.
SELECT *
FROM job_postings_fact
LIMIT 10;

-- Filter out the January postings.
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- Create tables.
CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- Double Check work.
SELECT job_posted_date
FROM march_jobs;

-- CASE Expression
SELECT 
    job_title_short,
    job_location
FROM job_postings_fact;

-- We want to group the location into 'Remote' for 'Anywhere', 'New York, NY as 'Local' and all others as 'Onsite'
SELECT 
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;

SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;