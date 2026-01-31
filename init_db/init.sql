-- Create the Kestra database (ny_taxi is created by POSTGRES_DB env)
CREATE DATABASE kestra;
GRANT ALL PRIVILEGES ON DATABASE kestra TO postgres;
