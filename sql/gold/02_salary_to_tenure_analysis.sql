CREATE TABLE airflow_analysis_tables.salary_to_tenure_analysis AS
SELECT 
    experience_bucket,
    AVG(salary) AS avg_salary,
    COUNT(*) AS employee_count
FROM (
    SELECT 
        salary,
        CASE 
            WHEN years_of_experience BETWEEN 0 AND 2 THEN '0-2'
            WHEN years_of_experience BETWEEN 3 AND 5 THEN '3-5'
            WHEN years_of_experience BETWEEN 6 AND 8 THEN '6-8'
            WHEN years_of_experience BETWEEN 9 AND 11 THEN '9-11'
            ELSE '12+'
        END AS experience_bucket
    FROM employees
) AS sub
GROUP BY experience_bucket;