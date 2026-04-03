INSERT IGNORE INTO airflow_source_tables.countries (country_name)
SELECT DISTINCT country
FROM staging_cleaned.employee_data_clean;