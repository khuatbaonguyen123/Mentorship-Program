## Case Study #4: Data Bank

<img src="https://user-images.githubusercontent.com/81607668/130343294-a8dcceb7-b6c3-4006-8ad2-fab2f6905258.png" alt="Image" width="500" height="520">

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

Please note that all the information regarding the case study has been sourced from the following link: [here](https://8weeksqlchallenge.com/case-study-4/). 

***

## Business Task
Danny launched a new initiative, Data Bank which runs **banking activities** and also acts as the world’s most secure distributed **data storage platform**!

Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. 

The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.

This case study is all about calculating metrics, growth and helping the business analyse their data in a smart way to better forecast and plan for their future developments!

## Entity Relationship Diagram

<img width="631" alt="image" src="https://user-images.githubusercontent.com/81607668/130343339-8c9ff915-c88c-4942-9175-9999da78542c.png">

**Table 1: `regions`**

This regions table contains the `region_id` and their respective `region_name` values.

<img width="176" alt="image" src="https://user-images.githubusercontent.com/81607668/130551759-28cb434f-5cae-4832-a35f-0e2ce14c8811.png">

**Table 2: `customer_nodes`**

Customers are randomly distributed across the nodes according to their region. This random distribution changes frequently to reduce the risk of hackers getting into Data Bank’s system and stealing customer’s money and data!

<img width="412" alt="image" src="https://user-images.githubusercontent.com/81607668/130551806-90a22446-4133-45b5-927c-b5dd918f1fa5.png">

**Table 3: Customer Transactions**

This table stores all customer deposits, withdrawals and purchases made using their Data Bank debit card.

<img width="343" alt="image" src="https://user-images.githubusercontent.com/81607668/130551879-2d6dfc1f-bb74-4ef0-aed6-42c831281760.png">

***

## Question and Solution

I'm using Microsoft SQL Server. If you have any questions about my solutions, please feel free to reach out to me.

## 🏦 A. Customer Nodes Exploration

**1. How many unique nodes are there on the Data Bank system?**

````sql
SELECT COUNT(DISTINCT node_id) as unique_nodes
FROM customer_nodes;
````

**Answer:**

|unique_nodes|
|:----|
|5|

***

**2. What is the number of nodes per region?**

````sql
SELECT r.region_name,
       COUNT(DISTINCT c.node_id) AS node_count
FROM customer_nodes c
JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name;
````

**Answer:**

|region_name|node_count|
|:----|:----|
|Africa|5|
|America|5|
|Asia|5|
|Australia|5|
|Europe|5|

***

**3. How many customers are allocated to each region?**

````sql
SELECT r.region_name, 
	   COUNT(c.customer_id) AS customer_count
FROM customer_nodes c
JOIN regions r ON c.region_id = r.region_id
GROUP BY r.region_name;
````

**Answer:**

|region_name|customer_count|
|:----|:----|
|Africa|714|
|America|735|
|Asia|665|
|Australia|770|
|Europe|616|

***

**4. How many days on average are customers reallocated to a different node?**

````sql
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
````

**Answer:**

|avg_reallocate_days|
|:----|
|23|

***

**5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?**

````sql
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
````

**Answer:**

<img width="300" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/e70dcf38-f802-4092-bd0b-29964ac27b08">


***

## 🏦 B. Customer Transactions

**1. What is the unique count and total amount for each transaction type?**

````sql
SELECT txn_type,
       COUNT(*) AS unique_count,
       SUM(txn_amount) AS total_amount
FROM customer_transactions
GROUP BY txn_type;
````

**Answer:**

|txn_type|unique_count|total_amount|
|:----|:----|:----|
|purchase|1617|806537|
|deposit|2671|1359168|
|withdrawal|1580|793003|

***

**2. What is the average total historical deposit counts and amounts for all customers?**

````sql
WITH deposits AS (
  SELECT 
    customer_id, 
    COUNT(customer_id) AS txn_count, 
    AVG(txn_amount) AS avg_amount
  FROM customer_transactions
  WHERE txn_type = 'deposit'
  GROUP BY customer_id
)

SELECT 
  ROUND(AVG(txn_count), 0) AS avg_deposit_count, 
  ROUND(AVG(avg_amount), 0) AS avg_deposit_amt
FROM deposits;
````
**Answer:**

|avg_deposit_count|avg_deposit_amt|
|:----|:----|
|5|509|

***

**3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?**

````sql
WITH monthly_transactions AS (
  SELECT 
    customer_id, 
    DATEPART(month, txn_date) AS mth,
    SUM(CASE WHEN txn_type = 'deposit' THEN 0 ELSE 1 END) AS deposit_count,
    SUM(CASE WHEN txn_type = 'purchase' THEN 0 ELSE 1 END) AS purchase_count,
    SUM(CASE WHEN txn_type = 'withdrawal' THEN 1 ELSE 0 END) AS withdrawal_count
  FROM customer_transactions
  GROUP BY customer_id, DATEPART(month, txn_date)
)

SELECT
  mth,
  COUNT(DISTINCT customer_id) AS customer_count
FROM monthly_transactions
WHERE deposit_count > 1 
  AND (purchase_count >= 1 OR withdrawal_count >= 1)
GROUP BY mth
ORDER BY mth;
````

**Answer:**

|mth|customer_count|
|:----|:----|
|1|170|
|2|277|
|3|292|
|4|103|

***

**4. What is the closing balance for each customer at the end of the month? Also show the change in balance each month in the same table output.**

```sql
WITH monthly_balances AS (
  SELECT 
    customer_id, 
    MONTH(txn_date) AS month, 
    SUM(CASE 
      		WHEN txn_type = 'withdrawal' OR txn_type = 'purchase' THEN -txn_amount
      		ELSE txn_amount 
        END) AS monthly_balance
  FROM customer_transactions
  GROUP BY customer_id, MONTH(txn_date)
),

cumulative_balances AS (
  SELECT 
    customer_id, 
    month, 
    SUM(monthly_balance) OVER (PARTITION BY customer_id ORDER BY month) AS closing_balance
  FROM monthly_balances
)

SELECT 
  customer_id, 
  month, 
  COALESCE(closing_balance, 0) AS closing_balance,
  COALESCE(closing_balance - LAG(closing_balance, 1) OVER (PARTITION BY customer_id ORDER BY month), 0) AS change_in_balance
FROM cumulative_balances
ORDER BY customer_id, month;
```

