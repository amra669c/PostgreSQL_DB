SELECT
    *
FROM (
    SELECT
    job_title_short,
    job_location,
    CASE
       WHEN job_location ='Anywhere' THEN 'Remote'
       WHEN job_location = 'New York, NY' THEN 'Local'
       ELSE 'Onsite'
    END AS location_category
    FROM job_postings_fact
)
WHERE location_category = 'Remote' OR location_category = 'Local';




SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
       WHEN job_location ='Anywhere' THEN 'Remote'
       WHEN job_location = 'New York, NY' THEN 'Local'
       ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
GROUP BY
    location_category;



SELECT
    job_title_short,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > 600000 THEN 'High_standard'
        WHEN salary_year_avg BETWEEN 200000 AND 600000 THEN 'Acceptable standard'
        ELSE'Low_standard'
    END AS payment_standard
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;




SELECT
    COUNT(*)

From (
        SELECT
            job_title_short,
            salary_year_avg,
            CASE
                WHEN salary_year_avg > 600000 THEN 'High_standard'
                WHEN salary_year_avg BETWEEN 200000 AND 600000 THEN 'Acceptable standard'
                ELSE'Low_standard'
            END AS payment_standard
        FROM 
             job_postings_fact
        WHERE
             job_title_short = 'Data Analyst'
             AND salary_year_avg IS NOT NULL
        ORDER BY
             salary_year_avg DESC
    ) AS payment
WHERE payment_standard = 'Acceptable standard';


SELECT
    SUM(CASE
        WHEN salary_year_avg BETWEEN 200000 AND 600000 THEN 1
        ELSE 0
    END) AS acceptable_standard_count
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst';




SELECT
    COUNT(CASE
        WHEN salary_year_avg BETWEEN 200000 AND 600000 THEN 1
    END) AS acceptable_standard_count
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'


