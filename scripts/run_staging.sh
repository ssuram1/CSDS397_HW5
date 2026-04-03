#!/bin/bash

echo "Running staging layer..."

#password was removed for security reasons
export MYSQL_PWD=##########

/Users/shravani/anaconda3/bin/mysql -u root -D airflow_source_tables < /Users/shravani/airflow/sql/staging/01_departments.sql
/Users/shravani/anaconda3/bin/mysql -u root -D airflow_source_tables < /Users/shravani/airflow/sql/staging/02_countries.sql
/Users/shravani/anaconda3/bin/mysql -u root -D airflow_source_tables < /Users/shravani/airflow/sql/staging/03_employees.sql
/Users/shravani/anaconda3/bin/mysql -u root -D airflow_source_tables < /Users/shravani/airflow/sql/staging/04_performance.sql

echo "Staging layer completed."
