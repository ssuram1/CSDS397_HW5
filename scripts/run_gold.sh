#!/bin/bash

echo "Running gold layer (business insights)..."

#password was removed for security reasons
export MYSQL_PWD=#########

/Users/shravani/anaconda3/bin/mysql -u root -D airflow_analysis_tables < /Users/shravani/airflow/sql/gold/01_salary_by_department.sql
/Users/shravani/anaconda3/bin/mysql -u root -D airflow_analysis_tables < /Users/shravani/airflow/sql/gold/02_salary_to_tenure_analysis.sql
/Users/shravani/anaconda3/bin/mysql -u root -D airflow_analysis_tables < /Users/shravani/airflow/sql/gold/03_performance_by_salary_analysis.sql
/Users/shravani/anaconda3/bin/mysql -u root -D airflow_analysis_tables < /Users/shravani/airflow/sql/gold/04_salary_by_country_analysis.sql
/Users/shravani/anaconda3/bin/mysql -u root -D airflow_analysis_tables < /Users/shravani/airflow/sql/gold/05_sales_performance_analysis.sql
/Users/shravani/anaconda3/bin/mysql -u root -D airflow_analysis_tables < /Users/shravani/airflow/sql/gold/06_support_rating_analysis.sql

echo "Gold layer completed."

