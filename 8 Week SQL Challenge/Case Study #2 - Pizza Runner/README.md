# 🍕 Case Study #2 Pizza Runner

<img src="https://user-images.githubusercontent.com/81607668/127271856-3c0d5b4a-baab-472c-9e24-3c1e3c3359b2.png" alt="Image" width="500" height="520">

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- Solution
  - [A. Pizza Metrics](#a-pizza-metrics)
  - [B. Runner and Customer Experience](#b-runner-and-customer-experience)
  - [C. Ingredient Optimisation](#c-ingredient-optimisation)
  - [D. Pricing and Ratings](#d-pricing-and-ratings)

***

## Business Task
Danny is expanding his new Pizza Empire and at the same time, he wants to Uberize it, so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers. 

## Entity Relationship Diagram

![Pizza Runner](https://github.com/katiehuangx/8-Week-SQL-Challenge/assets/81607668/78099a4e-4d0e-421f-a560-b72e4321f530)



## Solution
I use MySQL for Part A and Part B, and Microsoft SQL Server for Part C and Part D, so you may notice the difference. If you have any questions about my solutions, please feel free to reach out to me.
## A. Pizza Metrics

### 1. How many pizzas were ordered?

````sql
SELECT COUNT(pizza_id) AS pizza_order_count
FROM customer_orders_temp;
````


### 2. How many unique customer orders were made?

````sql
SELECT COUNT(DISTINCT order_id) AS unique_order_count
FROM customer_orders_temp;
````


### 3. How many successful orders were delivered by each runner?

````sql
SELECT runner_id,
       COUNT(order_id) AS successful_order_count
FROM runner_orders_temp
WHERE cancellation IS NULL
GROUP BY runner_id;
````


### 4. How many of each type of pizza was delivered?

````sql
SELECT p.pizza_name,
       COUNT(c.pizza_id) AS successful_pizza_deliver_count
FROM pizza_names p
JOIN customer_orders_temp c ON p.pizza_id = c.pizza_id
JOIN runner_orders_temp r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY p.pizza_name;
````


### 5. How many Vegetarian and Meatlovers were ordered by each customer?**

````sql
SELECT c.customer_id,
       p.pizza_name,
       COUNT(p.pizza_name) AS order_count
FROM pizza_names p
JOIN customer_orders_temp c ON p.pizza_id = c.pizza_id
GROUP BY c.customer_id,
         p.pizza_name
ORDER BY c.customer_id;
````

### 6. What was the maximum number of pizzas delivered in a single order?

````sql
SELECT COUNT(pizza_id) AS max_pizza_per_order
FROM customer_orders_temp
GROUP BY order_id
ORDER BY max_pizza_per_order DESC
LIMIT 1;
````

### 7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

````sql
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
````


### 8. How many pizzas were delivered that had both exclusions and extras?

````sql
SELECT count(pizza_id) AS pizza_exclusion_extra_count
FROM customer_orders_temp AS c
JOIN runner_orders_temp AS r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
  AND c.exclusions IS NOT NULL
  AND c.extras IS NOT NULL;
````


### 9. What was the total volume of pizzas ordered for each hour of the day?

````sql
SELECT 
  EXTRACT(HOUR FROM order_time) AS hour_of_day, 
  COUNT(order_id) AS pizza_count
FROM customer_orders_temp
GROUP BY EXTRACT(HOUR FROM order_time);
````

### 10. What was the volume of orders for each day of the week?

````sql
SELECT 
  DATE_FORMAT(DATE_ADD(order_time, INTERVAL 2 DAY), '%W') AS day_of_week, 
  COUNT(order_id) AS total_pizzas_ordered
FROM customer_orders
GROUP BY DATE_FORMAT(DATE_ADD(order_time, INTERVAL 2 DAY), '%W');
````


***

## B. Runner and Customer Experience

### 1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

````sql
SELECT 
  FLOOR((TO_DAYS(registration_date) - TO_DAYS(DATE_FORMAT(registration_date, '%Y-01-01'))) / 7) + 1 AS registration_week,
  COUNT(runner_id) AS runner_signup
FROM runners
GROUP BY registration_week;
````

### 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

````sql
SELECT r.runner_id,
       ROUND(AVG(TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time)), 2) AS avg_minutes
FROM customer_orders_temp c
JOIN runner_orders_temp r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY r.runner_id;
````

### 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

````sql
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
````

### 4. What was the average distance travelled for each customer?

````sql
SELECT c.customer_id,
       round(avg(r.distance), 2) AS avg_distance
FROM customer_orders_temp c
JOIN runner_orders_temp r ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id;
````


### 5. What was the difference between the longest and shortest delivery times for all orders?

````sql
SELECT MAX(duration) - MIN(duration) AS delivery_time_difference
FROM runner_orders_temp
WHERE cancellation IS NULL;
````



### 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

````sql
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
````

Trends noticed:
- Runner 1's average speed is from 37.5 to 60 and not really depends on the number of pizzas ordered. 
- Runner 2's average speed is from 35.1 to 93.6, the fluctutation rate is nearly 300% and worth the attention.
- Runner 3's average speed is 40, which seems normal. But since he/she/they has just 1 delivery, it's hard to draw any conclusion.

### 7. What is the successful delivery percentage for each runner?

### 7.1. Using CTE:
````sql
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
````

### 7.2. Using Subqueries:
````sql
SELECT 
  runner_id, 
  ROUND(100 * SUM(
    CASE WHEN distance > 0 THEN 1
    ELSE 0 END) / COUNT(*)) AS success_perc
FROM runner_orders_temp
WHERE cancellation IS NULL
GROUP BY runner_id;
````

***

## C. Ingredient Optimisation

### 1. What are the standard ingredients for each pizza?

````sql
WITH toppings AS
  (SELECT pr.pizza_id,
          pt.topping_name
   FROM pizza_recipes pr CROSS apply string_split(pr.toppings, ',') AS topping_split
   INNER JOIN pizza_toppings pt ON topping_split.value = pt.topping_id)

SELECT pizza_id,
       STRING_AGG(topping_name, ', ') AS toppings
FROM toppings
GROUP BY pizza_id;
````

### 2. What was the most commonly added extra?

```sql
WITH Toppings AS (
    SELECT
      value AS topping_id
    FROM #customer_orders_temp
    CROSS APPLY STRING_SPLIT(extras, ',')
	WHERE extras IS NOT NULL
)

SELECT TOP 1	
  t.topping_id, 
  pt.topping_name, 
  COUNT(t.topping_id) AS added_times
from Toppings t 
INNER JOIN pizza_toppings pt ON t.topping_id = pt.topping_id
GROUP BY t.topping_id, pt.topping_name
ORDER BY added_times DESC;
```

### 3. What was the most common exclusion?

```sql
WITH Toppings AS (
    SELECT
      value AS topping_id
    FROM #customer_orders_temp
    CROSS APPLY STRING_SPLIT(exclusions, ',')
	WHERE exclusions IS NOT NULL
)

SELECT TOP 1	
  t.topping_id, 
  pt.topping_name, 
  COUNT(t.topping_id) AS excluded_times
from Toppings t 
INNER JOIN pizza_toppings pt ON t.topping_id = pt.topping_id
GROUP BY t.topping_id, pt.topping_name
ORDER BY excluded_times DESC;
```


### 4. Generate an order item for each record in the customers_orders table in the format of one of the following:
- Meat Lovers
- Meat Lovers - Exclude Beef
- Meat Lovers - Extra Bacon
- Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

```sql
WITH topping_cte AS (
    SELECT 
        co.order_id,
        co.customer_id,
        co.pizza_id,
        exclusions_toppings.topping_names AS exclusions,
        extras_toppings.topping_names AS extras
    FROM 
        #customer_orders_temp AS co
    OUTER APPLY (
        SELECT 
            STRING_AGG(pt.topping_name, ', ') AS topping_names
        FROM 
            STRING_SPLIT(co.exclusions, ',') AS es
        LEFT JOIN 
            pizza_toppings AS pt ON es.value = pt.topping_id
    ) AS exclusions_toppings
    OUTER APPLY (
        SELECT 
            STRING_AGG(pt.topping_name, ', ') AS topping_names
        FROM 
            STRING_SPLIT(co.extras, ',') AS ex
        LEFT JOIN 
            pizza_toppings AS pt ON ex.value = pt.topping_id
    ) AS extras_toppings
)

SELECT 
    tc.order_id, 
    tc.customer_id, 
    CASE 
        WHEN tc.exclusions IS NULL AND tc.extras IS NULL THEN pn.pizza_name
        WHEN tc.exclusions IS NOT NULL AND tc.extras IS NULL THEN CONCAT(pn.pizza_name, ' - Exclude ', tc.exclusions)
        WHEN tc.exclusions IS NULL AND tc.extras IS NOT NULL THEN CONCAT(pn.pizza_name, ' - Extra ', tc.extras)
        ELSE CONCAT(pn.pizza_name, ' - Exclude ', tc.exclusions, ' - Extra ', tc.extras)
    END AS pizza_info
FROM 
    topping_cte tc
LEFT JOIN 
    pizza_names pn ON tc.pizza_id = pn.pizza_id;
```

***

## D. Pricing and Ratings

### 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

````sql
SELECT 
SUM(CASE
		WHEN p.pizza_name = 'Meatlovers' THEN 12
		ELSE 10
	END) AS total_money_made
FROM #customer_orders_temp c
JOIN #runner_orders_temp r ON c.order_id = r.order_id
JOIN pizza_names p ON c.pizza_id = p.pizza_id
WHERE r.cancellation IS NULL;

````

### 2. What if there was an additional $1 charge for any pizza extras?
- Add cheese is $1 extra

````sql
SELECT 
	SUM(
		CASE
            WHEN p.pizza_name = 'Meatlovers' THEN 12
            ELSE 10
        END
	) + 
	SUM(CASE
            WHEN (extras IS NOT NULL AND extras != '') THEN (LEN(extras) - LEN(REPLACE(extras, ',', '')) + 1)
            ELSE 0
         END) AS total_money_made
FROM #customer_orders_temp c
JOIN #runner_orders_temp r ON c.order_id = r.order_id
JOIN pizza_names p ON c.pizza_id = p.pizza_id
WHERE r.cancellation IS NULL;

````

### 3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

````sql
CREATE TABLE customer_runner_ratings (
    rating_id INT,
    order_id INT,
    customer_id INT,
    runner_id INT,
    rating INT,
    comment VARCHAR(255),
    rating_date DATETIME
 )

INSERT INTO customer_runner_ratings (rating_id, order_id, customer_id, runner_id, rating, comment, rating_date)
VALUES 
    (1, 1, 101, 1, 5, 'Exceptional delivery time, very pleased!', '2020-02-01 18:30:00'),
    (2, 2, 101, 1, 4, 'Nice runner, delivery was slightly delayed.', '2020-02-01 19:30:00'),
    (3, 3, 102, 1, 5, 'Top-notch service, definitely recommend!', '2020-02-03 00:30:00'),
    (4, 4, 103, 2, 3, 'Food arrived cold, but the runner was friendly.', '2020-02-04 14:30:00'),
    (5, 5, 104, 3, 5, 'Quick and efficient, very satisfied!', '2020-02-08 21:30:00'),
    (6, 7, 105, 2, 4, 'Great communication, timely delivery.', '2020-02-08 22:00:00'),
    (7, 8, 102, 2, 5, 'Outstanding service, will order again!', '2020-02-10 00:45:00'),
    (9,10, 104, 1, 4, 'Good service, but missed an extra item.', '2020-02-11 19:30:00');
````

### 4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
- customer_id
- order_id
- runner_id
- rating
- order_time
- pickup_time
- Time between order and pickup
- Delivery duration
- Average speed
- Total number of pizzas

````sql
SELECT
    c.customer_id,
    c.order_id,
    r.runner_id,
    cr.rating,
    c.order_time,
    r.pickup_time,
    DATEDIFF(MINUTE, c.order_time, r.pickup_time) AS time_between_order_pickup,
    r.duration AS delivery_duration, 
    ROUND((r.distance / TRY_CAST(r.duration AS FLOAT))* 60, 2) AS average_speed,
    COUNT(c.order_id) AS total_number_of_pizzas 
FROM #customer_orders_temp c
JOIN #runner_orders_temp r ON c.order_id = r.order_id
JOIN customer_runner_ratings cr ON c.order_id = cr.order_id
WHERE r.cancellation IS NULL
GROUP BY
    c.customer_id, c.order_id, r.runner_id, cr.rating, c.order_time, r.pickup_time, r.distance, r.duration
ORDER BY c.order_id;
````

### 5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

````sql
SELECT c.order_id,
       SUM(CASE
               WHEN p.pizza_name = 'Meatlovers' THEN 12
               ELSE 10
           END) - (r.distance * 0.3) AS money_left
FROM #customer_orders_temp c
JOIN #runner_orders_temp r ON c.order_id = r.order_id
JOIN pizza_names p ON c.pizza_id = p.pizza_id
WHERE r.cancellation IS NULL
GROUP BY c.order_id, r.distance;
````

***
