-- 1. How many users are there?
SELECT COUNT(DISTINCT user_id) as user_count
FROM users;

-- 2. How many cookies does each user have on average?
SELECT ROUND(AVG(cookie_count)) AS avg_cookie_user
FROM
  (SELECT user_id,
          COUNT(cookie_id) AS cookie_count
   FROM users
   GROUP BY user_id) a;

-- 3. What is the unique number of visits by all users per month?
SELECT MONTH(event_time) AS month,
       COUNT(DISTINCT visit_id) AS unique_visit_count
FROM events
GROUP BY MONTH(event_time);

-- 4. What is the number of events for each event type?
SELECT event_type,
       COUNT(*) AS event_count
FROM EVENTS
GROUP BY event_type;

-- 5. What is the percentage of visits which have a purchase event?
SELECT ROUND(COUNT(DISTINCT e.visit_id) * 100 /
               (SELECT COUNT(DISTINCT visit_id)
                FROM events), 2) AS purchase_event_perc
FROM events e
JOIN event_identifier ei ON e.event_type = ei.event_type
WHERE ei.event_name = 'Purchase';

-- 6. What is the percentage of visits which view the checkout page but do not have a purchase event?
WITH cte AS
  (SELECT e.visit_id,
          SUM(CASE
                  WHEN p.page_name = 'Checkout' THEN 1
                  ELSE 0
              END) AS checkout_view_count,
          SUM(CASE
                  WHEN ei.event_name = 'Purchase' THEN 1
                  ELSE 0
              END) AS purchase_event_count
   FROM events e
   JOIN event_identifier ei ON e.event_type = ei.event_type
   JOIN page_hierarchy p ON e.page_id = p.page_id
   GROUP BY e.visit_id)
   
SELECT ROUND(COUNT(*) * 100 /
               (SELECT COUNT(*)
                FROM cte), 2) AS checkout_not_purchase_perc
FROM cte
WHERE checkout_view_count > 0
  AND purchase_event_count = 0;

-- 7. What are the top 3 pages by number of views?
SELECT e.page_id,
       p.page_name,
       COUNT(e.visit_id) AS view_count
FROM EVENTS e
JOIN event_identifier ei ON e.event_type = ei.event_type
JOIN page_hierarchy p ON e.page_id = p.page_id
WHERE ei.event_name = 'Page View'
GROUP BY e.page_id,
         p.page_name
ORDER BY view_count DESC
LIMIT 3;

-- 8. What is the number of views and cart adds for each product category?
SELECT p.product_category, 
	   SUM(CASE WHEN ei.event_name = 'Page View' THEN 1 ELSE 0 END) AS number_of_view,
       SUM(CASE WHEN ei.event_name = 'Add to Cart' THEN 1 ELSE 0 END) AS number_of_cart_add
FROM events e
JOIN event_identifier ei ON e.event_type = ei.event_type
JOIN page_hierarchy p ON e.page_id = p.page_id
WHERE p.product_category IS NOT NULL
GROUP BY p.product_category;

-- 9. What are the top 3 products by purchases?
SELECT p.product_id, 
	   SUM(CASE WHEN ei.event_name = 'Purchase' THEN 1 ELSE 0 END) AS purchase_count
FROM events e
JOIN event_identifier ei ON e.event_type = ei.event_type
JOIN page_hierarchy p ON e.page_id = p.page_id
WHERE p.product_id IS NOT NULL
GROUP BY p.product_id
ORDER BY purchase_count DESC
LIMIT 3;


