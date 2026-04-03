INSERT IGNORE INTO airflow_source_tables.employees (
    employee_id,
    full_name,
    age,
    date_of_joining,
    years_of_experience,
    salary,
    department_id,
    country_id
)
SELECT 
    sc.`employee id`,
    sc.name,
    sc.age,
    sc.`date of joining`,
    sc.`years of experience`,
    sc.salary,
    d.department_id,
    c.country_id
FROM staging_cleaned.employee_data_clean sc
JOIN airflow_source_tables.departments d 
    ON sc.department = d.department_name
JOIN airflow_source_tables.countries c 
    ON sc.country = c.country_name;