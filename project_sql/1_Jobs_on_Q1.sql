CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- Create table for February
CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- Create table for March
CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT * FROM march_jobs;