/* --------------------
   PART B: Runner and Customer Experience
   --------------------*/
   
-- 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT 
  FLOOR((TO_DAYS(registration_date) - TO_DAYS(DATE_FORMAT(registration_date, '%Y-01-01'))) / 7) + 1 AS registration_week,
  COUNT(runner_id) AS runner_signup
FROM runners
GROUP BY registration_week;

-- 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT r.runner_id,
       ROUND(AVG(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)), 2) AS avg_minutes
FROM customer_orders_temp c
JOIN runner_orders_temp r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY r.runner_id;

-- 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
WITH prep_time_cte AS
  (SELECT c.order_id,
          COUNT(pizza_id) AS pizza_order,
          TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time) AS time_prepared
   FROM customer_orders_temp c
   JOIN runner_orders_temp r ON c.order_id = r.order_id
   WHERE r.cancellation IS NULL
   GROUP BY c.order_id,
            c.order_time,
            r.pickup_time)
		
SELECT pizza_order,
       round(avg(time_prepared)) AS avg_time_prepared
FROM prep_time_cte
GROUP BY pizza_order;

-- 4. What was the average distance travelled for each customer?
SELECT c.customer_id,
       round(avg(r.distance), 2) AS avg_distance
FROM customer_orders_temp c
JOIN runner_orders_temp r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id;

-- 5. What was the difference between the longest and shortest delivery times for all orders?
SELECT max(duration) - min(duration) AS delivery_time_difference
FROM runner_orders_temp
WHERE cancellation IS NULL;

-- 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT r.runner_id,
       c.order_id,
       count(c.pizza_id) AS pizza_count,
       round(r.distance * 60 / r.duration, 2) AS avg_speed_km_h
FROM customer_orders_temp c
JOIN runner_orders_temp r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY r.runner_id,
         c.order_id,
         r.distance,
         r.duration;

/* --------------------
Trends notice:
1. Runner 1's average speed is from 37.5 to 60 and not really depends on the number of pizzas ordered. 
2. Runner 2's average speed is from 35.1 to 93.6, the fluctutation rate is nearly 300% and worth the attention.
3. Runner 3's average speed is 40, which seems normal. But since he/she/they has just 1 delivery, it's hard to draw any conclusion.
   --------------------*/

-- 7. What is the successful delivery percentage for each runner?
-- Assumption: Successful delivery to evaluate a runner's performance will be calculated based on deliveries with a distance greater than 0. 
-- It is not fair to evaluate performance using order cancellations, as they are out of the runners' control.

-- 7.1. Using CTE:
WITH successful_delivery_runner AS
  (SELECT runner_id,
          CASE
              WHEN distance > 0 THEN 1
              ELSE 0
          END AS is_successful_delivery
   FROM runner_orders_temp
   WHERE cancellation IS NULL)
   
SELECT runner_id,
       ROUND((SUM(is_successful_delivery) / COUNT(is_successful_delivery)) * 100) AS success_perc
FROM successful_delivery_runner
GROUP BY runner_id;

-- 7.2. Using subqueries:
SELECT 
  runner_id, 
  ROUND(100 * SUM(
    CASE WHEN distance > 0 THEN 1
    ELSE 0 END) / COUNT(*)) AS success_perc
FROM runner_orders_temp
WHERE cancellation IS NULL
GROUP BY runner_id;
