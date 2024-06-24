/* --------------------
   Case Study Questions
   --------------------*/

-- 1. How many pizzas were ordered?
SELECT COUNT(pizza_id) AS pizza_order_count
FROM customer_orders_temp;

-- 2. How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) AS unique_order_count
FROM customer_orders_temp;

-- 3. How many successful orders were delivered by each runner?
SELECT runner_id,
       COUNT(order_id) AS successful_order_count
FROM runner_orders_temp
WHERE cancellation IS NULL
GROUP BY runner_id;

-- 4. How many of each type of pizza was delivered?

-- 4.1. Successfully delivered (no cancellation)
SELECT p.pizza_name,
       COUNT(c.pizza_id) AS successful_pizza_deliver_count
FROM pizza_names p
JOIN customer_orders_temp c ON p.pizza_id = c.pizza_id
JOIN runner_orders_temp r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY p.pizza_name;

-- 4.2. Delivered (A runner is assigned - both cancellation and no cancellation)
SELECT p.pizza_name,
       COUNT(c.pizza_id) AS pizza_deliver_count
FROM pizza_names p
JOIN customer_orders_temp c ON p.pizza_id = c.pizza_id
JOIN runner_orders_temp r ON c.order_id = r.order_id
GROUP BY p.pizza_name;

-- 5. How many Vegetarian and Meatlovers were ordered by each customer?
SELECT c.customer_id,
       p.pizza_name,
       COUNT(p.pizza_name) AS order_count
FROM pizza_names p
JOIN customer_orders_temp c ON p.pizza_id = c.pizza_id
GROUP BY c.customer_id,
         p.pizza_name
ORDER BY c.customer_id;

-- 6. What was the maximum number of pizzas delivered in a single order?
SELECT count(pizza_id) AS max_pizza_per_order
FROM customer_orders_temp
GROUP BY order_id
ORDER BY max_pizza_per_order DESC
LIMIT 1;

-- 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT 
  c.customer_id,
  SUM(
    CASE WHEN c.exclusions IS NOT NULL OR c.extras IS NOT NULL THEN 1
    ELSE 0
    END) AS at_least_1_change,
  SUM(
    CASE WHEN c.exclusions IS NULL AND c.extras IS NULL THEN 1 
    ELSE 0
    END) AS no_change
FROM customer_orders_temp AS c
JOIN runner_orders_temp AS r
  ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id;

-- 8. How many pizzas were delivered that had both exclusions and extras?
SELECT count(pizza_id) AS pizza_exclusion_extra_count
FROM customer_orders_temp AS c
JOIN runner_orders_temp AS r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
  AND c.exclusions IS NOT NULL
  AND c.extras IS NOT NULL;

-- 9. What was the total volume of pizzas ordered for each hour of the day?
SELECT 
  EXTRACT(HOUR FROM order_time) AS hour_of_day, 
  COUNT(order_id) AS pizza_count
FROM customer_orders_temp
GROUP BY EXTRACT(HOUR FROM order_time);

-- 10. What was the volume of orders for each day of the week?
SELECT 
  DATE_FORMAT(DATE_ADD(order_time, INTERVAL 2 DAY), '%W') AS day_of_week, 
  COUNT(order_id) AS total_pizzas_ordered
FROM customer_orders
GROUP BY DATE_FORMAT(DATE_ADD(order_time, INTERVAL 2 DAY), '%W');
