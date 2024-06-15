/* Solution of Practice Problem 2 minuts: 2:41*/

SELECT
    company_dim.company_id,
    company_dim.name,
    job_count.total_jobs, --should be created inside the inner joint
    CASE
        WHEN total_jobs < 10 THEN 'small'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS size_categ
FROM
    company_dim
INNER JOIN (
    SELECT
        company_id,
        COUNT(job_id) As total_jobs
    FROM
        job_postings_fact 
    GROUP BY
        company_id
    ) AS job_count
    ON job_count.company_id = company_dim.company_id
ORDER BY 
    total_jobs DESC;


/* Let's break it down:

1. Imagine the table you want as an answer to the request of the practice.

2. Write the column names of the table:
    In this case, we need 4 columns:
    - [company_dim.company_id]
    - [company_dim.name]
    - [job_count.total_jobs]
    - [size_categ]
      We want to categorize the number of jobs posted by each company. Therefore, we use the CASE statement to create the [size_categ] column based on [job_count.total_jobs].

3. To do this, we create a subquery inside the INNER JOIN to generate [job_count], which will provide [job_count.total_jobs] for the first SELECT statement.

4. The required information exists in [job_postings_fact], including company_id and job_id.
    - COUNT(job_id) calculates the total number of jobs posted.
    - GROUP BY company_id groups the job counts by each company, resulting in the number of jobs posted by each company.

5. This number is used in the first SELECT statement as input for the CASE statement to calculate the [size_categ] column.
*/