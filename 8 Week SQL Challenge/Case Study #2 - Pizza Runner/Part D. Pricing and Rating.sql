/* --------------------
   PART D: Pricing and Ratings
   --------------------*/

-- 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
SELECT 
SUM(CASE
		WHEN p.pizza_name = 'Meatlovers' THEN 12
		ELSE 10
	END) AS total_money_made
FROM #customer_orders_temp c
JOIN #runner_orders_temp r ON c.order_id = r.order_id
JOIN pizza_names p ON c.pizza_id = p.pizza_id
WHERE r.cancellation IS NULL;

-- 2. What if there was an additional $1 charge for any pizza extras? 
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

-- 3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, 
-- how would you design an additional table for this new dataset - 
-- generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
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

-- 4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
-- customer_id
-- order_id
-- runner_id
-- rating
-- order_time
-- pickup_time
-- Time between order and pickup
-- Delivery duration
-- Average speed
-- Total number of pizzas

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

-- 5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - 
-- how much money does Pizza Runner have left over after these deliveries?
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