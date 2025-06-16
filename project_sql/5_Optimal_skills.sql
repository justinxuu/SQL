WITH skills_demand as (
SELECT
    skills_dim.skill_id as skill_id,
    skills_dim.skills as skill,
    count(skills_job_dim.job_id) as demand_count
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_postings_fact.job_title_short = 'Data Analyst' AND
job_postings_fact.salary_year_avg IS NOT NULL AND
job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
),

average_salary as (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    round(AVG(job_postings_fact.salary_year_avg),2) as avgsalary
from job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where
    job_postings_fact.job_title_short = 'Data Analyst' AND 
    job_postings_fact.salary_year_avg IS NOT NULL 
GROUP BY 
    skills_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skill,
    demand_count,
    avgsalary
from skills_demand inner JOIN average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE demand_count >10
ORDER BY avgsalary DESC, demand_count desc
limit 25



