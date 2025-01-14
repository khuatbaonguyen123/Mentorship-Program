/* --------------------
   PART C: Ingredient Optimisation
   --------------------*/
   
-- 1. What are the standard ingredients for each pizza?
WITH toppings AS
  (SELECT pr.pizza_id,
          pt.topping_name
   FROM pizza_recipes pr CROSS apply string_split(pr.toppings, ',') AS topping_split
   INNER JOIN pizza_toppings pt ON topping_split.value = pt.topping_id)

SELECT pizza_id,
       STRING_AGG(topping_name, ', ') AS toppings
FROM toppings
GROUP BY pizza_id;

-- 2. What was the most commonly added extra?
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

-- 3. What was the most common exclusion?
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

/* --------------------
   4. Generate an order item for each record in the customers_orders table in the format of one of the following:
	Meat Lovers
	Meat Lovers - Exclude Beef
	Meat Lovers - Extra Bacon
	Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
   --------------------*/
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



