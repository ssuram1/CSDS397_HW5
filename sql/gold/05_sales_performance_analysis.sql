CREATE TABLE airflow_analysis_tables.sales_performance_analysis AS
SELECT 
    sales_bucket,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    AVG(total_sales) AS avg_sales,
    AVG(sales_to_salary_ratio) AS avg_sales_to_salary_ratio
FROM (
    SELECT 
        e.salary,
        p.total_sales,
        (p.total_sales / NULLIF(e.salary, 0)) AS sales_to_salary_ratio,
        CASE 
            WHEN p.total_sales < 50000 THEN 'Low Sales'
            WHEN p.total_sales BETWEEN 50000 AND 100000 THEN 'Medium Sales'
            ELSE 'High Sales'
        END AS sales_bucket
    FROM airflow_source_tables.employees e
    JOIN airflow_source_tables.performance p 
        ON e.employee_id = p.employee_id
    JOIN airflow_source_tables.departments d 
        ON e.department_id = d.department_id
    WHERE d.department_name = 'Sales'
) sub
GROUP BY sales_bucket;