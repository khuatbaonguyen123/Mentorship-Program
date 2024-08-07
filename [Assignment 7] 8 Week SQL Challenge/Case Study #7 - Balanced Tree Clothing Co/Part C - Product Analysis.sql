-- 1. What are the top 3 products by total revenue before discount?
SELECT s.prod_id,
       p.product_name,
       SUM(s.price * s.qty) AS revenue_before_discount
FROM sales s
JOIN product_details p ON s.prod_id = p.product_id
GROUP BY s.prod_id,
         p.product_name
ORDER BY revenue_before_discount DESC
LIMIT 3;

-- 2. What is the total quantity, revenue and discount for each segment?
SELECT p.segment_id,
       p.segment_name,
       SUM(s.qty) AS quantity,
       ROUND(SUM(s.qty * s.price * (100 - s.discount) / 100), 2) AS revenue,
       ROUND(SUM(s.discount * s.price / 100), 2) AS discount
FROM sales s
JOIN product_details p ON s.prod_id = p.product_id
GROUP BY p.segment_id,
         p.segment_name;

-- 3. What is the top selling product for each segment?
WITH rank_cte AS
  (SELECT p.segment_id,
          p.segment_name,
          p.product_id,
          p.product_name,
          SUM(s.qty) AS quantity,
          DENSE_RANK() OVER(PARTITION BY p.segment_id
                            ORDER BY SUM(s.qty) DESC) AS prod_rank
   FROM sales s
   JOIN product_details p ON s.prod_id = p.product_id
   GROUP BY p.segment_id,
            p.segment_name,
            p.product_id,
            p.product_name)
            
SELECT segment_id,
       segment_name,
       product_id,
       product_name,
       quantity
FROM rank_cte
WHERE prod_rank = 1;

-- 4. What is the total quantity, revenue and discount for each category?
SELECT p.category_id, 
	   p.category_name, 
       SUM(s.qty) AS quantity,
       ROUND(SUM(s.qty * s.price * (100 - s.discount) / 100), 2) AS revenue,
       ROUND(SUM(s.discount * s.price / 100), 2) AS discount
FROM sales s
JOIN product_details p ON s.prod_id = p.product_id 
GROUP BY p.category_id,
         p.category_name;

-- 5. What is the top selling product for each category?
WITH rank_cte AS
  (SELECT p.category_id,
          p.category_name,
          p.product_id,
          p.product_name,
          SUM(s.qty) AS quantity,
          DENSE_RANK() OVER(PARTITION BY p.category_id
                            ORDER BY SUM(s.qty) DESC) AS prod_rank
   FROM sales s
   JOIN product_details p ON s.prod_id = p.product_id
   GROUP BY p.category_id,
            p.category_name,
            p.product_id,
            p.product_name)
            
SELECT category_id,
       category_name,
       product_id,
       product_name,
       quantity
FROM rank_cte
WHERE prod_rank = 1;

-- 6. What is the percentage split of revenue by product for each segment?
WITH segment_product_revenue AS (
    SELECT 
        p.segment_id, 
        p.segment_name, 
        p.product_id, 
        p.product_name, 
        SUM(s.qty * s.price * (100 - s.discount) / 100) AS revenue
    FROM 
        sales s
    JOIN 
        product_details p ON s.prod_id = p.product_id
    GROUP BY 
        p.segment_id, 
        p.segment_name, 
        p.product_id, 
        p.product_name
),
segment_total_revenue AS (
    SELECT 
        p.segment_id, 
        SUM(s.qty * s.price * (100 - s.discount) / 100) AS total_revenue
    FROM 
        sales s
    JOIN 
        product_details p ON s.prod_id = p.product_id
    GROUP BY 
        p.segment_id
)
SELECT 
    spr.segment_id, 
    spr.segment_name, 
    spr.product_id, 
    spr.product_name, 
    ROUND(spr.revenue * 100 / str.total_revenue, 2) AS revenue_percentage
FROM 
    segment_product_revenue spr
JOIN
    segment_total_revenue str ON spr.segment_id = str.segment_id;

-- 7. What is the percentage split of revenue by segment for each category?
WITH segment_revenue AS (
    SELECT 
        p.category_id, 
        p.category_name,
        p.segment_id, 
        p.segment_name,
        SUM(s.qty * s.price * (100 - s.discount) / 100) AS segment_revenue
    FROM 
        sales s
    JOIN 
        product_details p ON s.prod_id = p.product_id
    GROUP BY 
        p.category_id, 
        p.category_name,
        p.segment_id, 
        p.segment_name
),
category_total_revenue AS (
    SELECT 
        p.category_id, 
        SUM(s.qty * s.price * (100 - s.discount) / 100) AS total_category_revenue
    FROM 
        sales s
    JOIN 
        product_details p ON s.prod_id = p.product_id
    GROUP BY 
        p.category_id
)
SELECT 
    sr.category_id,
    sr.category_name,
    sr.segment_id,
    sr.segment_name,
    (sr.segment_revenue / ctr.total_category_revenue) * 100 AS revenue_percentage
FROM 
    segment_revenue sr
JOIN
    category_total_revenue ctr ON sr.category_id = ctr.category_id;

-- 8. What is the percentage split of total revenue by category?
WITH category_revenue AS
  (SELECT p.category_id,
          p.category_name,
          SUM(s.qty * s.price * (100 - s.discount) / 100) AS revenue
   FROM sales s
   JOIN product_details p ON s.prod_id = p.product_id
   GROUP BY p.category_id,
            p.category_name)
            
SELECT category_id,
       category_name,
       ROUND(revenue * 100 /
               (SELECT SUM(revenue)
                FROM category_revenue), 2) AS revenue_percentage
FROM category_revenue;

-- 9. What is the total transaction “penetration” for each product? 
-- (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
WITH prod_txn AS
  (SELECT p.product_id,
          p.product_name,
          COUNT(DISTINCT s.txn_id) AS txn_count
   FROM sales s
   JOIN product_details p ON s.prod_id = p.product_id
   GROUP BY p.product_id,
            p.product_name)
            
SELECT product_id,
       product_name,
       ROUND(txn_count /
               (SELECT COUNT(DISTINCT txn_id)
                FROM sales), 2) AS penetration
FROM prod_txn;

-- 10. What is the most common combination of at least 1 quantity of any 3 products in a single transaction?
WITH products AS
  (SELECT txn_id,
          product_name
   FROM sales s
   JOIN product_details p ON s.prod_id = p.product_id)
   
SELECT p.product_name AS prod_1,
       p1.product_name AS prod_2,
       p2.product_name AS prod_3,
       COUNT(*) AS times_bought_together
FROM products p
JOIN products p1 ON p.txn_id = p1.txn_id
AND p.product_name != p1.product_name
AND p.product_name < p1.product_name
JOIN products p2 ON p1.txn_id = p2.txn_id
AND p1.product_name != p2.product_name
AND p1.product_name < p2.product_name
GROUP BY p.product_name,
         p1.product_name,
         p2.product_name
ORDER BY times_bought_together DESC
LIMIT 1;