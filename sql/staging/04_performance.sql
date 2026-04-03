INSERT IGNORE INTO airflow_source_tables.performance (
    employee_id,
    performance_rating,
    total_sales,
    support_rating
)
SELECT
    sc.`employee id`,
    sc.`performance rating`,
    sc.`total sales`,
    sc.`support rating`
FROM staging_cleaned.employee_data_clean sc
JOIN airflow_source_tables.employees e
    ON sc.`employee id` = e.employee_id;