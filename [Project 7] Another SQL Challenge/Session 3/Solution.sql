-- 1. List the Top 3 Most Expensive Orders
SELECT order_id, 
	   total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 3;

-- 2. Compute Deltas Between Consecutive Orders
WITH ranked_orders AS (
  SELECT 
    order_id,
    customer_id,
    total_amount,
    order_date,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_value
  FROM orders
)
SELECT
  order_id,
  customer_id,
  total_amount,
  previous_value,
  total_amount - previous_value AS delta
FROM ranked_orders;

-- 3. Compute the Running Total of Purchases per Customer
SELECT c.customer_id,
       c.full_name,
       o.order_date,
       o.total_amount,
       SUM(o.total_amount) OVER (PARTITION BY c.customer_id
                                 ORDER BY o.order_date) AS running_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
