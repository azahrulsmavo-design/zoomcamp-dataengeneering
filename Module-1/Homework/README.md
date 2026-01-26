# Module 1 Homework Solutions

## Question 1. Understanding Docker images

**Answer: 25.3**

**Explanation:**
Verified by running the `python:3.13` image and checking the pip version:
```bash
docker run --rm --entrypoint bash python:3.13 -c "pip --version"
```
Output:
(Pending output)

## Question 2. Understanding Docker networking and docker-compose

**Answer: db:5432**

**Explanation:**
In Docker Compose, services within the same network can verify/communicate with each other using the service name or container name as the hostname.
- **Hostname**: The service name is `db`, and the container name is explicitly set to `postgres`. So both `db` and `postgres` are valid hostnames for the internal network.
- **Port**: The internal port for the Postgres container is `5432` (standard Postgres port). The mapping `5433:5432` exposes the internal port 5432 to the host machine's port 5433. However, other containers in the same network (like `pgadmin`) communicate directly via the internal port.

Therefore, `pgadmin` should connect to the database using `db:5432` or `postgres:5432`.
The option `db:5432` is one of the correct choices.

## Question 3. Counting short trips

**Answer: 8007**

**Explanation:**
Query to count trips with distance <= 1 mile within the specified date range:
```sql
SELECT COUNT(*) 
FROM green_taxi_trips 
WHERE lpep_pickup_datetime >= '2025-11-01' AND lpep_pickup_datetime < '2025-12-01'
AND trip_distance <= 1;
```
Result: `8007`

## Question 4. Longest trip for each day

**Answer: 2025-11-14**

**Explanation:**
Query to find the day with the longest trip distance (filtering out likely outliers > 100 miles):
```sql
SELECT lpep_pickup_datetime::DATE AS pickup_day, MAX(trip_distance) as max_dist
FROM green_taxi_trips
WHERE trip_distance < 100
AND lpep_pickup_datetime >= '2025-11-01' AND lpep_pickup_datetime < '2025-12-01'
GROUP BY pickup_day
ORDER BY max_dist DESC
LIMIT 1;
```
Result: `2025-11-14` (Distance: 88.03)

## Question 5. Biggest pickup zone

**Answer: East Harlem North**

**Explanation:**
Query to sum total amount by pickup zone for 2025-11-18:
```sql
SELECT z."Zone", SUM(t.total_amount) as total
FROM green_taxi_trips t
JOIN zones z ON t."PULocationID" = z."LocationID"
WHERE t.lpep_pickup_datetime::DATE = '2025-11-18'
GROUP BY z."Zone"
ORDER BY total DESC
LIMIT 1;
```
Result: `East Harlem North` (Total: 9281.92)

## Question 6. Largest tip

**Answer: Yorkville West**

**Explanation:**
Query to find the dropoff zone with the largest single tip from "East Harlem North":
```sql
SELECT z_do."Zone", MAX(t.tip_amount) as max_tip
FROM green_taxi_trips t
JOIN zones z_pu ON t."PULocationID" = z_pu."LocationID"
JOIN zones z_do ON t."DOLocationID" = z_do."LocationID"
WHERE z_pu."Zone" = 'East Harlem North'
AND t.lpep_pickup_datetime >= '2025-11-01' AND t.lpep_pickup_datetime < '2025-12-01'
GROUP BY z_do."Zone"
ORDER BY max_tip DESC
LIMIT 1;
```
Result: `Yorkville West` (Max Tip: 81.89)

## Question 7. Terraform Workflow

**Answer: terraform init, terraform apply -auto-approve, terraform destroy**

**Explanation:**
1.  **Downloading provider plugins and setting up backend**: This is handled by `terraform init`. It initializes the working directory containing Terraform configuration files.
2.  **Generating proposed changes and auto-executing the plan**: `terraform apply` generates a plan and executes it. The `-auto-approve` flag skips the interactive approval step, allowing it to execute immediately (auto-execute).
3.  **Remove all resources managed by terraform**: `terraform destroy` parses the state file and removes all resources created by the configuration.

## Submitting the solutions
*   Form for submitting: https://courses.datatalks.club/de-zoomcamp-2026/homework/hw1
