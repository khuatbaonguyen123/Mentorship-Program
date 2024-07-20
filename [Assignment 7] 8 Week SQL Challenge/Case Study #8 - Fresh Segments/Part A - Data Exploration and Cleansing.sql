-- 1. Update the interest_metrics table by modifying the month_year column to be a date data type with the start of the month
ALTER TABLE interest_metrics
MODIFY COLUMN month_year VARCHAR(10);

UPDATE interest_metrics
SET month_year = STR_TO_DATE(CONCAT('01-', month_year), '%d-%m-%Y');

ALTER TABLE interest_metrics
MODIFY COLUMN month_year DATE;

-- 2. What is the count of records in the interest_metrics for each month_year value sorted in chronological order (earliest to latest) with the null values appearing first?
SELECT month_year, COUNT(*)
FROM interest_metrics
GROUP BY month_year;

-- 3. What should we do with these null values in the interest_metrics?
-- The other columns are not meaningful when the interest_id is null
DELETE FROM interest_metrics
WHERE interest_id IS NULL;

-- 4. How many interest_id values exist in the interest_metrics table but not in the interest_map table? What about the other way around?
SELECT 
  COUNT(DISTINCT map_id) AS map_id_count,
  COUNT(DISTINCT interest_id) AS metrics_id_count,
  SUM(CASE WHEN map_id IS NULL THEN 1 ELSE 0 END) AS not_in_metric,
  SUM(CASE WHEN interest_id IS NULL THEN 1 ELSE 0 END) AS not_in_map
FROM (
  SELECT 
    map.id AS map_id, 
    metrics.interest_id
  FROM interest_map map
  LEFT JOIN interest_metrics metrics
    ON metrics.interest_id = map.id
  
  UNION
  
  SELECT 
    map.id AS map_id, 
    metrics.interest_id
  FROM interest_metrics metrics
  LEFT JOIN interest_map map
    ON metrics.interest_id = map.id
) AS combined;

-- 5. Summarize the id values in the interest_map by its total record count in this table.
SELECT COUNT(*) AS map_id_count
FROM interest_map;

-- 6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where interest_id = 21246 in your joined output 
-- and include all columns from fresh_segments.interest_metrics and all columns from fresh_segments.interest_map except from the id column.
SELECT *
FROM interest_map map
INNER JOIN interest_metrics metrics ON metrics.interest_id = map.id
WHERE metrics.interest_id = 21246
  AND metrics._month IS NOT NULL;

-- 7. Are there any records in your joined table where the month_year value is before the created_at value from the fresh_segments.interest_map table? Do you think these values are valid and why?
SELECT metrics.interest_id,
       metrics.month_year,
       map.created_at,
       map.last_modified
FROM interest_map map
INNER JOIN interest_metrics metrics ON metrics.interest_id = map.id
WHERE metrics.month_year < map.created_at;

