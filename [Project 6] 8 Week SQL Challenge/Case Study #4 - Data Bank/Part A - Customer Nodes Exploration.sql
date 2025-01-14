/* --------------------
   PART A: Customer Nodes Exploration
   --------------------*/

-- 1. How many unique nodes are there on the Data Bank system?
SELECT COUNT(DISTINCT node_id) as unique_nodes
FROM customer_nodes;

-- 2. What is the number of nodes per region?
SELECT r.region_name,
       COUNT(DISTINCT c.node_id) AS node_count
FROM customer_nodes c
JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name;

-- 3. How many customers are allocated to each region?
SELECT r.region_name, 
	   COUNT(c.customer_id) AS customer_count
FROM customer_nodes c
JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name;

-- 4. How many days on average are customers reallocated to a different node?
WITH days_in_node AS
  (SELECT customer_id,
          node_id,
          SUM(DATEDIFF(DAY, start_date, end_date)) AS total_days_in_node
   FROM customer_nodes
   WHERE end_date != '9999-12-31'
   GROUP BY customer_id,
            node_id)
SELECT ROUND(AVG(total_days_in_node), 0) AS avg_reallocate_days
FROM days_in_node;

-- 5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?
WITH node_days AS
  (SELECT c.customer_id,
          r.region_name,
          DATEDIFF(DAY, start_date, end_date) AS days_in_node
   FROM customer_nodes c
   JOIN regions r ON c.region_id = r.region_id
   WHERE c.end_date != '9999-12-31' ),
total_node_days AS
  (SELECT customer_id,
          region_name,
          SUM(days_in_node) AS total_days_in_node
   FROM node_days
   GROUP BY customer_id,
            region_name)

SELECT DISTINCT region_name, 
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_days_in_node) 
		OVER (PARTITION BY region_name) AS median,
	PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_days_in_node) 
		OVER (PARTITION BY region_name) AS percentile_80,
    PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY total_days_in_node) 
		OVER (PARTITION BY region_name) AS percentile_95
FROM total_node_days;