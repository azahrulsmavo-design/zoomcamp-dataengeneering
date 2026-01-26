-- Question 3: Count trips <= 1 mile
SELECT COUNT(*) 
FROM green_taxi_trips 
WHERE lpep_pickup_datetime >= '2025-11-01' AND lpep_pickup_datetime < '2025-12-01'
AND trip_distance <= 1;

-- Question 4: Day with longest trip
SELECT lpep_pickup_datetime::DATE AS pickup_day, MAX(trip_distance) as max_dist
FROM green_taxi_trips
WHERE trip_distance < 100
AND lpep_pickup_datetime >= '2025-11-01' AND lpep_pickup_datetime < '2025-12-01'
GROUP BY pickup_day
ORDER BY max_dist DESC
LIMIT 1;

-- Question 5: Biggest pickup zone
SELECT z."Zone", SUM(t.total_amount) as total
FROM green_taxi_trips t
JOIN zones z ON t."PULocationID" = z."LocationID"
WHERE t.lpep_pickup_datetime::DATE = '2025-11-18'
GROUP BY z."Zone"
ORDER BY total DESC
LIMIT 1;

-- Question 6: Largest tip
SELECT z_do."Zone", MAX(t.tip_amount) as max_tip
FROM green_taxi_trips t
JOIN zones z_pu ON t."PULocationID" = z_pu."LocationID"
JOIN zones z_do ON t."DOLocationID" = z_do."LocationID"
WHERE z_pu."Zone" = 'East Harlem North'
AND t.lpep_pickup_datetime >= '2025-11-01' AND t.lpep_pickup_datetime < '2025-12-01'
GROUP BY z_do."Zone"
ORDER BY max_tip DESC
LIMIT 1;
