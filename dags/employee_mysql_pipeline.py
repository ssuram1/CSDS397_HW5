from datetime import datetime, timedelta
from airflow import DAG
from airflow.providers.standard.operators.bash import BashOperator

default_args = {
    'owner': 'shravani',
    'retries': 2,
    'retry_delay': timedelta(minutes=5)
}

with DAG(
    dag_id='employee_mysql_pipeline',
    default_args=default_args,
    description='MySQL pipeline: staging + gold layers',
    start_date=datetime(2025, 1, 1),
    template_searchpath=["/Users/shravani/airflow/scripts"],
    schedule='@daily',
    catchup=False
) as dag:

    staging_task = BashOperator(
        task_id='run_staging_sql',
        bash_command='run_staging.sh'
    )

    gold_task = BashOperator(
        task_id='run_gold_sql',
        bash_command='run_gold.sh'
    )

    staging_task >> gold_task