/**
 * @Author: VictoriaGiri
 * @Date:   2026-05-15 23:48:48
 * @Last Modified by:   VictoriaGiri
 * @Last Modified time: 2026-06-21 23:27:27
 */
-- Subqueries are queries within queries:
SELECT *
FROM ( -- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- SubQuery ends here
-- Gave us the table with all January postings like before as a result. 

-- CTEs: Common Table Expressions: Define temporary result set that you can reference.
-- Can reference within SELECT, INSERT, UPDATE or DELETE statement
-- Defined with WITH
WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTHS FROM job_posted_date) = 1
) -- CTE definition ends here

SELECT *
FROM january_jobs;

-- Subqueries: can be used in clauses like SELECT, FROM, WHERE, HAVING
-- Executed first, then results are passed to outer query. Used when you want to perform calculation before the main query can complete its calculation.
SELECT  
        company_id,
        job_no_degree_mention
FROM
        job_postings_fact
WHERE
        job_no_degree_mention = true;
-- This returns all company IDs for that have job postings with no degree mentioned. 
-- But: We don't have company names.
-- We can now turn this into a subquery and use it to filter through the company_dim table:

SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT  
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY 
        company_id
);

-- CTEs:
-- Temporary result set that can be referenced within SELECT, INSERT, UPDATE, DELETE statements.
-- Exists only during the execution of a query
-- Defined query that can be referenced in the main query or other CTEs
-- WITH used to define CTE at the beginning of a query

-- Want to find the companies with the most job openings. 
-- Return the total number of jobs with the company name
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM    
        job_postings_fact
    GROUP BY 
        company_id
) -- No semicolon here.

-- Now need to connect the temporary table with the company_dim table to get the names.
-- We will use a LEFT JOIN with company_dim as A table. So in case there are companies in the company_dim table that do not have job postings, they still show up, but with a zero. We'll use job_postings_fact as B table.
SELECT 
    name as company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
