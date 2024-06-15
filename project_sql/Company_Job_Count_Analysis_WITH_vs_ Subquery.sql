-- Direct Query: Count Jobs per Company
SELECT
    company_dim.name,
    COUNT(job_postings_fact.job_id) AS total_job_num
FROM 
    company_dim  
INNER JOIN 
    job_postings_fact ON job_postings_fact.company_id = company_dim.company_id 
GROUP BY
    company_dim.name
ORDER BY
    total_job_num DESC;




-- With command: Create a temporary table to include all companies, even those without advertised jobs

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM
    company_dim
LEFT JOIN 
    company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY 
    total_jobs DESC;
