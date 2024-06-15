-- Direct Query: List Companies Offering Jobs with No Degree Requirement
SELECT
    company_dim.name,
    company_dim.company_id,
    job_no_degree_mention
FROM 
    company_dim
INNER JOIN 
    job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
WHERE 
    job_no_degree_mention = TRUE
ORDER BY 
    company_id ASC;


-- Subquery: List Company Names Offering Jobs with No Degree Requirement
SELECT 
    name AS company_name
FROM 
    company_dim
WHERE 
    company_id IN (
        SELECT 
            company_id
        FROM 
            job_postings_fact
        WHERE 
            job_no_degree_mention = TRUE
    );



-- Common Table Expression (CTE): List Companies Offering Jobs with No Degree Requirement
WITH company_name1 AS (
    SELECT
        DISTINCT company_dim.name AS name,
        company_dim.company_id
    FROM 
        company_dim
    INNER JOIN 
        job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
    WHERE 
        job_no_degree_mention = TRUE
)
SELECT 
    name
FROM 
    company_name1
ORDER BY 
    company_id ASC;
