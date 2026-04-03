CREATE TABLE airflow_analysis_tables.support_rating_analysis AS
SELECT 
    p.support_rating,
    AVG(e.salary) AS avg_salary,
    COUNT(*) AS employee_count
FROM airflow_source_tables.employees e
JOIN airflow_source_tables.performance p 
    ON e.employee_id = p.employee_id
JOIN airflow_source_tables.departments d 
    ON e.department_id = d.department_id
WHERE d.department_name = 'Support'
GROUP BY p.support_rating
ORDER BY p.support_rating;