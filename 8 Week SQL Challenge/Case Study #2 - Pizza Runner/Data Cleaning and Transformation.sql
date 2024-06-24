CREATE TEMPORARY TABLE customer_orders_temp AS
SELECT 
  order_id, 
  customer_id, 
  pizza_id, 
  CASE
	  WHEN exclusions LIKE '' OR exclusions LIKE 'null' THEN NULL
	  ELSE exclusions
	  END AS exclusions,
  CASE
	  WHEN extras LIKE '' or extras LIKE 'null' THEN NULL
	  ELSE extras
	  END AS extras,
	order_time
FROM customer_orders;

CREATE TEMPORARY TABLE runner_orders_temp AS
SELECT 
  order_id, 
  runner_id,  
  CASE
	  WHEN pickup_time LIKE 'null' THEN NULL
	  ELSE pickup_time
	  END AS pickup_time,
  CASE
	  WHEN distance LIKE 'null' THEN NULL
	  WHEN distance LIKE '%km' THEN TRIM('km' from distance)
	  ELSE distance 
    END AS distance,
  CASE
	  WHEN duration LIKE 'null' THEN NULL
	  WHEN duration LIKE '%mins' THEN TRIM('mins' from duration)
	  WHEN duration LIKE '%minute' THEN TRIM('minute' from duration)
	  WHEN duration LIKE '%minutes' THEN TRIM('minutes' from duration)
	  ELSE duration
	  END AS duration,
  CASE
	  WHEN cancellation LIKE '' or cancellation LIKE 'null' THEN NULL
	  ELSE cancellation
	  END AS cancellation
FROM pizza_runner.runner_orders;

ALTER TABLE runner_orders_temp
MODIFY pickup_time DATETIME,
MODIFY distance FLOAT,
MODIFY duration INTEGER;

SELECT * FROM runner_orders_temp;


