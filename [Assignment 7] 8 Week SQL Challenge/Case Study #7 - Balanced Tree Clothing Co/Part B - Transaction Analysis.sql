-- 1. How many unique transactions were there?
SELECT COUNT(DISTINCT txn_id) AS unique_txns
FROM sales;

-- 2. What is the average unique products purchased in each transaction?
WITH cte AS
  (SELECT txn_id,
          COUNT(DISTINCT prod_id) AS unique_product_count
   FROM sales
   GROUP BY txn_id)
   
SELECT ROUND(AVG(unique_product_count)) AS avg_unique_product_each_txn
FROM cte;

-- 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
WITH revenue_per_txn AS
(SELECT txn_id, SUM(price * qty * (100 - discount) / 100) AS total_revenue
FROM sales
GROUP BY txn_id)

SELECT 
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_revenue) AS percentile_25,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_revenue) AS percentile_50,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_revenue) AS percentile_75
FROM revenue_per_txn;

-- 4. What is the average discount value per transaction?
WITH cte AS
  (SELECT txn_id,
          SUM(price * qty * discount / 100) AS discount_value
   FROM sales
   GROUP BY txn_id)
   
SELECT ROUND(AVG(discount_value), 2) AS avg_discount
FROM cte;

-- 5. What is the percentage split of all transactions for members vs non-members?
WITH cte AS
  (SELECT member,
          COUNT(DISTINCT txn_id) AS txn_count
   FROM sales
   GROUP BY member)
   
SELECT member,
       ROUND(txn_count * 100 /
               (SELECT SUM(txn_count)
                FROM cte), 2) AS txn_perc
FROM cte;

-- 6. What is the average revenue for member transactions and non-member transactions?
WITH cte AS
  (SELECT member,
          txn_id,
          SUM(price * qty * (100 - discount)) AS revenue
   FROM sales
   GROUP BY member,
            txn_id)
            
SELECT member,
       ROUND(AVG(revenue), 2) AS avg_revenue
FROM cte
GROUP BY member;

