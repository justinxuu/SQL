SELECT
    skills_dim.skills,
    round(AVG(job_postings_fact.salary_year_avg),2) as avgsalary
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where
    job_postings_fact.job_title_short = 'Data Analyst' AND 
    job_postings_fact.salary_year_avg IS NOT NULL 
GROUP BY 
    skills_dim.skills
ORDER BY avgsalary DESC
