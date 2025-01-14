## 🌲 Case Study #7: Balanced Tree

<img src="https://github.com/katiehuangx/8-Week-SQL-Challenge/assets/81607668/8ada3c0c-e90a-47a7-9a5c-8ffd6ee3eef8" alt="Image" width="500" height="520">

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

Please note that all the information regarding the case study has been sourced from the following link: [here](https://8weeksqlchallenge.com/case-study-7/). 

***

## Business Task

Balanced Tree Clothing Company prides themselves on providing an optimised range of clothing and lifestyle wear for the modern adventurer!

Danny, the CEO of this trendy fashion company has asked you to assist the team’s merchandising teams **analyse their sales performance and generate a basic financial report** to share with the wider business.

## Entity Relationship Diagram

<img width="932" alt="image" src="https://github.com/katiehuangx/8-Week-SQL-Challenge/assets/81607668/2ce4df84-2b05-4fe9-a50c-47c903b392d5">

**Table 1: `product_details`**

|product_id|price|product_name|category_id|segment_id|style_id|category_name|segment_name|style_name|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|c4a632|13|Navy Oversized Jeans - Womens|1|3|7|Womens|Jeans|Navy Oversized|
|e83aa3|32|Black Straight Jeans - Womens|1|3|8|Womens|Jeans|Black Straight|
|e31d39|10|Cream Relaxed Jeans - Womens|1|3|9|Womens|Jeans|Cream Relaxed|
|d5e9a6|23|Khaki Suit Jacket - Womens|1|4|10|Womens|Jacket|Khaki Suit|
|72f5d4|19|Indigo Rain Jacket - Womens|1|4|11|Womens|Jacket|Indigo Rain|
|9ec847|54|Grey Fashion Jacket - Womens|1|4|12|Womens|Jacket|Grey Fashion|
|5d267b|40|White Tee Shirt - Mens|2|5|13|Mens|Shirt|White Tee|
|c8d436|10|Teal Button Up Shirt - Mens|2|5|14|Mens|Shirt|Teal Button Up|
|2a2353|57|Blue Polo Shirt - Mens|2|5|15|Mens|Shirt|Blue Polo|
|f084eb|36|Navy Solid Socks - Mens|2|6|16|Mens|Socks|Navy Solid|


**Table 2: `sales`**

|prod_id|qty|price|discount|member|txn_id|start_txn_time|
|:----|:----|:----|:----|:----|:----|:----|
|c4a632|4|13|17|true|54f307|2021-02-13T01:59:43.296Z|
|5d267b|4|40|17|true|54f307|2021-02-13T01:59:43.296Z|
|b9a74d|4|17|17|true|54f307|2021-02-13T01:59:43.296Z|
|2feb6b|2|29|17|true|54f307|2021-02-13T01:59:43.296Z|
|c4a632|5|13|21|true|26cc98|2021-01-19T01:39:00.345Z|
|e31d39|2|10|21|true|26cc98|2021-01-19T01:39:00.345Z|
|72f5d4|3|19|21|true|26cc98|2021-01-19T01:39:00.345Z|
|2a2353|3|57|21|true|26cc98|2021-01-19T01:39:00.345Z|
|f084eb|3|36|21|true|26cc98|2021-01-19T01:39:00.345Z|
|c4a632|1|13|21|false|ef648d|2021-01-27T02:18:17.164Z|

**Table 3: `product_hierarchy`**

|id|parent_id|level_text|level_name|
|:----|:----|:----|:----|
|1|null|Womens|Category|
|2|null|Mens|Category|
|3|1|Jeans|Segment|
|4|1|Jacket|Segment|
|5|2|Shirt|Segment|
|6|2|Socks|Segment|
|7|3|Navy Oversized|Style|
|8|3|Black Straight|Style|
|9|3|Cream Relaxed|Style|
|10|4|Khaki Suit|Style|

**Table 4: `product_prices`**

|id|product_id|price|
|:----|:----|:----|
|7|c4a632|13|
|8|e83aa3|32|
|9|e31d39|10|
|10|d5e9a6|23|
|11|72f5d4|19|
|12|9ec847|54|
|13|5d267b|40|
|14|c8d436|10|
|15|2a2353|57|
|16|f084eb|36|

***

## Question and Solution

I'm using MySQL for this Case Study. If you have any questions about my solutions, please feel free to reach out to me.

## 📈 A. High Level Sales Analysis

**1. What was the total quantity sold for all products?**

```sql
SELECT SUM(qty) AS total_quantity_sold
FROM sales;
```

**Answer:**

|total_quantity_sold|
|:----|
|45216|

***

**2. What is the total generated revenue for all products before discounts?**

```sql
SELECT SUM(price) AS revenue_before_discount
FROM sales;
```

**Answer:**

|revenue_before_discount|
|:----|
|429290|

***

**3. What was the total discount amount for all products?**

```sql
SELECT ROUND(SUM(price * qty * discount / 100), 2) AS total_discount_amount
FROM sales;
```

**Answer:**

|total_discount_amount|
|:----|
|156229.14|


***

## 🧾 B. Transaction Analysis

**1. How many unique transactions were there?**

```sql
SELECT COUNT(DISTINCT txn_id) AS unique_txns
FROM sales;
```

**Answer:**

|unique_txns|
|:----|
|2500|

***

**2. What is the average unique products purchased in each transaction?**

```sql
WITH cte AS
  (SELECT txn_id,
          COUNT(DISTINCT prod_id) AS unique_product_count
   FROM sales
   GROUP BY txn_id)
   
SELECT ROUND(AVG(unique_product_count)) AS avg_unique_product_each_txn
FROM cte;
```

**Answer:**

|avg_unique_product_each_txn|
|:----|
|6|

***

**3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?**

```sql
WITH revenue_per_txn AS
(SELECT txn_id, SUM(price * qty * (100 - discount) / 100) AS total_revenue
FROM sales
GROUP BY txn_id)

SELECT 
	PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_revenue) AS percentile_25,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_revenue) AS percentile_50,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_revenue) AS percentile_75
FROM revenue_per_txn;
```

**Answer:**

|percentile_25|percentile_50|percentile_75|
|:----|:----|:----|
|375.75|509.5|647|

***

**4. What is the average discount value per transaction?**

```sql
WITH cte AS
  (SELECT txn_id,
          SUM(price * qty * discount / 100) AS discount_value
   FROM sales
   GROUP BY txn_id)

SELECT ROUND(AVG(discount_value), 2) AS avg_discount
FROM cte;
```

**Answer:**

|avg_discount|
|:----|
|62.49|

**5. What is the percentage split of all transactions for members vs non-members?**

```sql
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
```

**Answer:**

|member|txn_perc|
|:----|:----|
|0|39.80|
|1|60.20|

***

**6. What is the average revenue for member transactions and non-member transactions?**

```sql
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
```

**Answer:**

The average revenue per transaction for members is only $1.23 higher compared to non-members.

|member|avg_revenue|
|:----|:----|
|1|45413.70|
|0|45200.78|

***

## 👚 C. Product Analysis

**1. What are the top 3 products by total revenue before discount?**

```sql
SELECT s.prod_id,
       p.product_name,
       SUM(s.price * s.qty) AS revenue_before_discount
FROM sales s
JOIN product_details p ON s.prod_id = p.product_id
GROUP BY s.prod_id,
         p.product_name
ORDER BY revenue_before_discount DESC
LIMIT 3;
```

**Answer:**

|prod_id|product_name|revenue_before_discount|
|:----|:----|:----|
|2a2353|Blue Polo Shirt - Mens|217683|
|9ec847|Grey Fashion Jacket - Womens|209304|
|5d267b|White Tee Shirt - Mens|152000|

***

**2. What is the total quantity, revenue and discount for each segment?**

```sql
SELECT p.segment_id,
       p.segment_name,
       SUM(s.qty) AS quantity,
       ROUND(SUM(s.qty * s.price * (100 - s.discount) / 100), 2) AS revenue,
       ROUND(SUM(s.discount * s.price / 100), 2) AS discount
FROM sales s
JOIN product_details p ON s.prod_id = p.product_id
GROUP BY p.segment_id,
         p.segment_name;
```

**Answer:**

| segment_id | segment_name | quantity | revenue   | discount |
|------------|--------------|----------|-----------|----------|
| 3          | Jeans        | 11349    | 183006.03 | 8393.08  |
| 5          | Shirt        | 11265    | 356548.73 | 16560.31 |
| 6          | Socks        | 11217    | 270963.56 | 12495.31 |
| 4          | Jacket       | 11385    | 322705.54 | 14647.64 |




***

**3. What is the top selling product for each segment?**

```sql
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
```

**Answer:**

| segment_id | segment_name | product_id | product_name                  | quantity |
|------------|--------------|------------|-------------------------------|----------|
| 3          | Jeans        | c4a632     | Navy Oversized Jeans - Womens | 3856     |
| 4          | Jacket       | 9ec847     | Grey Fashion Jacket - Womens  | 3876     |
| 5          | Shirt        | 2a2353     | Blue Polo Shirt - Mens        | 3819     |
| 6          | Socks        | f084eb     | Navy Solid Socks - Mens       | 3792     |


***

**4. What is the total quantity, revenue and discount for each category?**

```sql
SELECT p.category_id, 
	   p.category_name, 
       SUM(s.qty) AS quantity,
       ROUND(SUM(s.qty * s.price * (100 - s.discount) / 100), 2) AS revenue,
       ROUND(SUM(s.discount * s.price / 100), 2) AS discount
FROM sales s
JOIN product_details p ON s.prod_id = p.product_id 
GROUP BY p.category_id,
         p.category_name;
```

**Answer:**

| category_id | category_name | quantity | revenue   | discount  |
|-------------|---------------|----------|-----------|-----------|
| 1           | Womens        | 22734    | 505711.57 | 23040.72  |
| 2           | Mens          | 22482    | 627512.29 | 29055.62  |


***

**5. What is the top selling product for each category?**

```sql
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
```

**Answer:**

| category_id | category_name | product_id | product_name                  | quantity |
|-------------|---------------|------------|-------------------------------|----------|
| 1           | Womens        | 9ec847     | Grey Fashion Jacket - Womens  | 3876     |
| 2           | Mens          | 2a2353     | Blue Polo Shirt - Mens        | 3819     |


***

**6. What is the percentage split of revenue by product for each segment?**

```sql
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
```

**Answer:**

| segment_id | segment_name | product_id | product_name                                 | revenue_percentage |
|------------|--------------|------------|----------------------------------------------|--------------------|
| 3          | Jeans        | c4a632     | Navy Oversized Jeans - Womens               | 24.04              |
| 5          | Shirt        | 5d267b     | White Tee Shirt - Mens                      | 37.48              |
| 6          | Socks        | b9a74d     | White Striped Socks - Mens                  | 20.20              |
| 6          | Socks        | 2feb6b     | Pink Fluro Polkadot Socks - Mens            | 35.57              |
| 3          | Jeans        | e31d39     | Cream Relaxed Jeans - Womens                | 17.82              |
| 4          | Jacket       | 72f5d4     | Indigo Rain Jacket - Womens                 | 19.44              |
| 5          | Shirt        | 2a2353     | Blue Polo Shirt - Mens                      | 53.53              |
| 6          | Socks        | f084eb     | Navy Solid Socks - Mens                     | 44.24              |
| 3          | Jeans        | e83aa3     | Black Straight Jeans - Womens               | 58.14              |
| 4          | Jacket       | d5e9a6     | Khaki Suit Jacket - Womens                  | 23.57              |
| 4          | Jacket       | 9ec847     | Grey Fashion Jacket - Womens                | 56.99              |
| 5          | Shirt        | c8d436     | Teal Button Up Shirt - Mens                 | 8.99               |


***

**7. What is the percentage split of revenue by segment for each category?**

```sql
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
```

**Answer:**

| category_id | category_name | segment_id | segment_name | revenue_percentage |
|-------------|---------------|------------|--------------|--------------------|
| 1           | Womens        | 3          | Jeans        | 36.19              |
| 2           | Mens          | 5          | Shirt        | 56.82              |
| 2           | Mens          | 6          | Socks        | 43.18              |
| 1           | Womens        | 4          | Jacket       | 63.81              |


***

**8. What is the percentage split of total revenue by category?**

```sql
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
```

**Answer:**

| category_id | category_name | revenue_percentage |
|-------------|---------------|--------------------|
| 1           | Womens        | 44.63              |
| 2           | Mens          | 55.37              |


***

**9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)**

```sql
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
```

**Answer:**

| product_id | product_name                        | penetration |
|------------|-------------------------------------|-------------|
| 2a2353     | Blue Polo Shirt - Mens              | 0.51        |
| 2feb6b     | Pink Fluro Polkadot Socks - Mens    | 0.50        |
| 5d267b     | White Tee Shirt - Mens              | 0.51        |
| 72f5d4     | Indigo Rain Jacket - Womens         | 0.50        |
| 9ec847     | Grey Fashion Jacket - Womens        | 0.51        |
| b9a74d     | White Striped Socks - Mens          | 0.50        |
| c4a632     | Navy Oversized Jeans - Womens       | 0.51        |
| c8d436     | Teal Button Up Shirt - Mens         | 0.50        |
| d5e9a6     | Khaki Suit Jacket - Womens          | 0.50        |
| e31d39     | Cream Relaxed Jeans - Womens        | 0.50        |
| e83aa3     | Black Straight Jeans - Womens       | 0.50        |
| f084eb     | Navy Solid Socks - Mens             | 0.51        |


***

**10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?**

```sql
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
```

**Answer:**

| prod_1                        | prod_2                      | prod_3                       | times_bought_together |
|-------------------------------|-----------------------------|------------------------------|-----------------------|
| Grey Fashion Jacket - Womens | Teal Button Up Shirt - Mens | White Tee Shirt - Mens       | 352                   |


