CREATE TABLE airflow_analysis_tables.performance_by_salary_analysis AS
SELECT 
    p.performance_rating,
    AVG(e.salary) AS avg_salary,
    COUNT(*) AS employee_count
FROM airflow_source_tables.employees e
JOIN airflow_source_tables.performance p 
    ON e.employee_id = p.employee_id
GROUP BY p.performance_rating
ORDER BY p.performance_rating;
