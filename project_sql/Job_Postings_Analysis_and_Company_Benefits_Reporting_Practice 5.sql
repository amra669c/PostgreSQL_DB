-- Summarize Job Titles, Job Counts, and Average Salaries
SELECT 
    job_title_short AS job_title,
    COUNT(job_id) AS Number_of_Jobs,
    ROUND(AVG(salary_year_avg), 2) AS Salary_Year,
    ROUND(AVG(salary_hour_avg), 2) AS Salary_hour
FROM
    job_postings_fact
GROUP BY
    job_title_short;




-- Count Advertised Jobs by Month for the Year 2023
SELECT 
    COUNT(job_id) AS advertised_jobs,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
FROM    
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY
    month
ORDER BY
    COUNT(job_id) DESC;




-- List Company Names Offering Health Insurance for Jobs Posted Between March and July
SELECT
   company_name
FROM
    job_postings_fact
WHERE
    job_health_insurance = TRUE
    AND EXTRACT(MONTH FROM job_posted_date) BETWEEN 3 AND 7;


    

-- List Company Names and Posting Months Offering Health Insurance for Jobs Posted Between April and June
SELECT
   company_dim.name,
   EXTRACT(MONTH FROM job_posted_date) AS Month
FROM
    job_postings_fact
INNER JOIN 
    company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_health_insurance = TRUE
    AND EXTRACT(MONTH FROM job_posted_date) BETWEEN 4 AND 6;
