import os
import pandas as pd
from sqlalchemy import create_engine
from time import time

def ingest_data():
    # Database connection parameters
    user = 'postgres'
    password = 'postgres'
    host = 'db'
    port = '5432'
    db = 'ny_taxi'
    
    table_name_trips = 'green_taxi_trips'
    table_name_zones = 'zones'
    
    parquet_file = 'green_tripdata_2025-11.parquet'
    csv_file = 'taxi_zone_lookup.csv'

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    
    print("Ingesting Green Taxi Data...")
    try:
        df = pd.read_parquet(parquet_file)
        print(f"Read {len(df)} rows from {parquet_file}")
        
        # Create table and insert data
        df.head(0).to_sql(name=table_name_trips, con=engine, if_exists='replace')
        
        t_start = time()
        df.to_sql(name=table_name_trips, con=engine, if_exists='append', chunksize=100000)
        t_end = time()
        
        print(f"Inserted into {table_name_trips} in {t_end - t_start:.3f} seconds")
    except Exception as e:
        print(f"Error ingesting taxi data: {e}")

    print("Ingesting Zones Data...")
    try:
        df_zones = pd.read_csv(csv_file)
        print(f"Read {len(df_zones)} rows from {csv_file}")
        
        df_zones.to_sql(name=table_name_zones, con=engine, if_exists='replace')
        print(f"Inserted into {table_name_zones}")
    except Exception as e:
        print(f"Error ingesting zones data: {e}")

if __name__ == '__main__':
    ingest_data()
