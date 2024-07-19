/*
Using a single SQL query - create a new output table which has the following details:

1. How many times was each product viewed?
2. How many times was each product added to cart?
3. How many times was each product added to a cart but not purchased (abandoned)?
4. How many times was each product purchased?
*/

CREATE TEMPORARY TABLE product_statistics AS
WITH purchase_events AS (
    SELECT DISTINCT visit_id
    FROM events
    WHERE event_type = 3
)
SELECT 
    ph.product_id,
    SUM(CASE WHEN e.event_type = 1 THEN 1 ELSE 0 END) AS view_count,
    SUM(CASE WHEN e.event_type = 2 THEN 1 ELSE 0 END) AS cart_add_count,
    SUM(CASE WHEN e.event_type = 2 AND pe.visit_id IS NOT NULL THEN 1 ELSE 0 END) AS purchase_count,
    SUM(CASE WHEN e.event_type = 2 AND pe.visit_id IS NULL THEN 1 ELSE 0 END) AS abandon_count
FROM events e
JOIN page_hierarchy ph ON e.page_id = ph.page_id
LEFT JOIN purchase_events pe ON e.visit_id = pe.visit_id
WHERE ph.product_id IS NOT NULL
GROUP BY ph.product_id;

-- Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.
CREATE TEMPORARY TABLE product_category AS
SELECT p.product_category, 
	SUM(ps.view_count) AS view_count,
    SUM(ps.cart_add_count) AS cart_add_count,
    SUM(ps.abandon_count) AS abandon_count,
    SUM(ps.purchase_count) AS purchase_count
FROM 
	product_statistics ps 
JOIN 
	page_hierarchy p on ps.product_id = p.product_id
GROUP BY p.product_category;

-- 1. Which product had the most views, cart adds, and purchases?
SELECT product_id,
	   view_count,
       cart_add_count,
       purchase_count
FROM product_statistics
ORDER BY view_count DESC, cart_add_count DESC, purchase_count DESC;

-- 2. Which product was most likely to be abandoned?
SELECT product_id,
	   abandon_count
FROM product_statistics
ORDER BY abandon_count DESC
LIMIT 1;

-- 3. Which product had the highest view to purchase percentage?
SELECT product_id,
	   ROUND(purchase_count * 100 / view_count, 2) AS view_to_purchase_perc
FROM product_statistics
ORDER BY view_to_purchase_perc DESC
LIMIT 1;

-- 4. What is the average conversion rate from view to cart add?
SELECT ROUND(AVG(cart_add_count / view_count), 2) AS avg_view_to_cart_add_rate
FROM product_statistics;

-- 5. What is the average conversion rate from cart add to purchase?
SELECT ROUND(AVG(purchase_count / cart_add_count), 2) AS avg_cart_add_to_purchase_rate
FROM product_statistics;