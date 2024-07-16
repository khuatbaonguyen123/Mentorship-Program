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
-- 5. What is the percentage split of all transactions for members vs non-members?
-- 6. What is the average revenue for member transactions and non-member transactions?
