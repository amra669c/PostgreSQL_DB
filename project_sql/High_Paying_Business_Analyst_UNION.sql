

-- Extracting High-Paying Business Analyst Jobs for Q1

-- Selecting relevant columns from the combined dataset of Q1 job postings
SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE, -- Casting job_posted_date to DATE type
    salary_year_avg
FROM (
    -- Combining job postings from January, February, and March using UNION ALL
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings -- Aliasing the combined result set as quarter1_job_postings
WHERE
    salary_year_avg > 70000 AND -- Filtering for jobs with an average annual salary greater than $70,000
    job_title_short = 'Business Analyst' -- Filtering for job title 'Business Analyst'
ORDER BY
    salary_year_avg DESC; -- Ordering the results by salary in descending order
