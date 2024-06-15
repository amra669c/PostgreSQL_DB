-- First query: Calculate the number of job postings for each skill and get the top 5 most demanded skills
SELECT
    skills_job_dim.skill_id,
    COUNT(skills_dim.skills) as skill_count   
FROM 
    skills_job_dim
INNER JOIN job_postings_fact
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
GROUP BY
    skills_job_dim.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5;

-- Second query: Retrieve the names of the top 5 most demanded skills
SELECT 
    skills
FROM 
    skills_dim
WHERE
    skill_id IN (
        SELECT
            skills_job_dim.skill_id   
        FROM 
            skills_job_dim
        INNER JOIN job_postings_fact
            ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim
            ON skills_dim.skill_id = skills_job_dim.skill_id
        GROUP BY
            skills_job_dim.skill_id
        ORDER BY 
            COUNT(skills_dim.skills) DESC
        LIMIT 5
    );

-- Third query: Another approach to retrieve the names of the top 5 most demanded skills
SELECT
    skills_dim.skills
FROM
    skills_dim
WHERE
    skills_dim.skill_id IN (
        SELECT
            skills_job_dim.skill_id
        FROM 
            skills_job_dim
        INNER JOIN 
            job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN 
            skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
        GROUP BY
            skills_job_dim.skill_id
        ORDER BY 
            COUNT(skills_dim.skills) DESC
        LIMIT 5
    );

-- Fourth query: Combine the above steps into one query to get skill names and their counts directly
SELECT
    skills_dim.skills,        -- skill name column
    skill_counts.skill_count  -- number of jobs demanding the skill which must be created in later part of the code
FROM
    skills_dim                 -- from skills_dim because you can find the name of the skills there
INNER JOIN (    -- now it's time to create the skill_counts inside INNER JOIN 
                -- the skills_count should have two columns: one for skill_id, one for skill_count
    SELECT 
       skills_job_dim.skill_id,
       COUNT(skills_job_dim.job_id) AS skill_count
    FROM
        skills_job_dim
    INNER JOIN job_postings_fact -- for calculating the skill-count we need to relate (by inner join) the skills_dim to job_postings_fact
        ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY -- to group the COUNT function by skill_id
        skill_id
    ORDER BY
        skill_count DESC
    LIMIT 5 
) AS skill_counts
    ON skill_counts.skill_id = skills_dim.skill_id
ORDER BY
    skill_count DESC;
