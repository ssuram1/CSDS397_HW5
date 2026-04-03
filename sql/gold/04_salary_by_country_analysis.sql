CREATE TABLE airflow_analysis_tables.salary_by_country_analysis AS
SELECT 
    c.country_name,
    AVG(e.salary) AS avg_salary,
    COUNT(*) AS employee_count
FROM airflow_source_tables.employees e
JOIN airflow_source_tables.countries c 
    ON e.country_id = c.country_id
GROUP BY c.country_name;

