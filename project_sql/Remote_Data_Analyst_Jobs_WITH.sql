-- Subquery to find the top 5 skills for remote Data Analyst jobs



CREATE TABLE remote_job_skills_table AS
WITH remote_job_skills AS (
    -- Subquery to find the top 5 skills for remote Data Analyst jobs
    SELECT
        skills_dim.skill_id,
        skills_dim.skills AS skill_name,
        COUNT(job_postings_fact.job_id) AS count -- Added alias for the count column
    FROM
        skills_dim
    INNER JOIN skills_job_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        job_work_from_home = TRUE AND
        job_title_short = 'Data Analyst'
    GROUP BY
        skills_dim.skills,
        skills_dim.skill_id
    ORDER BY
        count DESC -- Orders the results by the count of job postings in descending order
    LIMIT
        5 -- Limits the results to the top 5 skills
)
-- Creates a new table using the results of the subquery
SELECT *
FROM remote_job_skills_table;

-- Drops the table created earlier
DROP TABLE remote_job_skills_table;
