-- 2. Select the main distance and the number of runners that run the given distance (runners_number).
-- Display only those rows where the number of runners is greater than 3.
SELECT main_distance, 
	   COUNT(*) AS runners_number
FROM runner
GROUP BY main_distance
HAVING runners_number > 3;

-- 3. Display the event name and the number of club members that take part in this event (call this column runner_count).
-- Note that there may be events in which no club members participate.
-- For these events, the runner_count should equal 0.

-- The COUNT function will return 0 if the value is NULL
SELECT e.name AS event_name, 
       COUNT(re.runner_id) AS runner_count
FROM event e
LEFT JOIN runner_event re ON e.id = re.event_id
GROUP BY e.name;

-- 3. Display the distance and the number of runners there are for the following age categories: under 20, 20–29, 30–39, 40–49, and over 50.
-- Use the following column aliases: under_20, age_20_29, age_30_39, age_40_49, and over_50.
SELECT 
    main_distance,
    SUM(CASE WHEN age < 20 THEN 1 ELSE 0 END) AS under_20,
    SUM(CASE WHEN age BETWEEN 20 AND 29 THEN 1 ELSE 0 END) AS age_20_29,
    SUM(CASE WHEN age BETWEEN 30 AND 39 THEN 1 ELSE 0 END) AS age_30_39,
    SUM(CASE WHEN age BETWEEN 40 AND 49 THEN 1 ELSE 0 END) AS age_40_49,
    SUM(CASE WHEN age >= 50 THEN 1 ELSE 0 END) AS over_50
FROM runner
GROUP BY main_distance;
