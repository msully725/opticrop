from google.cloud import bigquery
import pandas as pd
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

def generate_smooth_weather_data(num_records):
    start_temp = 20.0
    temp_variation = 2.0

    data = {
        'location': [fake.city() for _ in range(num_records)],
        'date': [(datetime.now() - timedelta(days=i)).strftime('%Y-%m-%d') for i in range(num_records)],
        'temperature': []
    }

    current_temp = start_temp
    for _ in range(num_records):
        current_temp += random.uniform(-temp_variation, temp_variation)
        data['temperature'].append(round(current_temp, 2))

    return pd.DataFrame(data)

num_records = 1000  # Adjust as needed
weather_data = generate_smooth_weather_data(num_records)

# Specify your GCP project and dataset
project_id = 'your_project_id'
dataset_id = 'your_dataset_id'
table_id = 'weather_data'

# Load data into BigQuery
client = bigquery.Client(project=project_id)
job_config = bigquery.LoadJobConfig(schema=[
    bigquery.SchemaField("location", "STRING"),
    bigquery.SchemaField("date", "DATE"),
    bigquery.SchemaField("temperature", "FLOAT64"),
])

job = client.load_table_from_dataframe(
    weather_data, f"{project_id}.{dataset_id}.{table_id}", job_config=job_config
)

job.result()  # Wait for the job to complete