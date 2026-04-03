CREATE TABLE airflow_analysis_tables.salary_to_department_analysis AS
SELECT 
    d.department_name,
    AVG(e.salary) AS avg_salary,
    COUNT(*) AS employee_count
FROM airflow_source_tables.employees e
JOIN airflow_source_tables.departments d 
    ON e.department_id = d.department_id
GROUP BY d.department_name;