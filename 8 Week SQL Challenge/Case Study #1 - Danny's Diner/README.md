# 🍜 Case Study #1: Danny's Diner 
<img src="https://user-images.githubusercontent.com/81607668/127727503-9d9e7a25-93cb-4f95-8bd0-20b87cb4b459.png" alt="Image" width="500" height="520">

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

Please note that all the information regarding the case study has been sourced from the following link: [here](https://8weeksqlchallenge.com/case-study-1/). 

***

## Business Task
Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. 

***

## Entity Relationship Diagram

![image](https://user-images.githubusercontent.com/81607668/127271130-dca9aedd-4ca9-4ed8-b6ec-1e1920dca4a8.png)

***

## Question and Solution
I'm using MySQL Server. If you have any questions about my solutions, please feel free to reach out to me. 

**1. What is the total amount each customer spent at the restaurant?**

````sql
SELECT s.customer_id,
       SUM(m.price) AS total_amount_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id; 
````

#### Answer:
| customer_id | total_amount_spent |
| ----------- | -----------        |
| A           | 76                 |
| B           | 74                 |
| C           | 36                 |

- Customer A spent $76.
- Customer B spent $74.
- Customer C spent $36.

***

**2. How many days has each customer visited the restaurant?**

````sql
SELECT customer_id,
       COUNT(distinct(order_date)) AS visit_count
FROM sales
GROUP BY customer_id;
````

#### Answer:
| customer_id | visit_count |
| ----------- | ----------- |
| A           | 4          |
| B           | 6          |
| C           | 2          |

- Customer A visited 4 times.
- Customer B visited 6 times.
- Customer C visited 2 times.

***

**3. What was the first item from the menu purchased by each customer?**

````sql
WITH rank_first_purchased AS
  (SELECT s.customer_id,
          m.product_name,
          DENSE_RANK() OVER (PARTITION BY s.customer_id
                             ORDER BY s.order_date) AS `rank`
   FROM sales s
   JOIN menu m ON s.product_id = m.product_id)

SELECT customer_id,
       product_name AS most_popular_item
FROM rank_first_purchased
WHERE `rank` = 1
GROUP BY customer_id, product_name;
````

#### Answer:
| customer_id | most_popular_item | 
| ----------- | ----------- |
| A           | curry        | 
| A           | sushi        | 
| B           | curry        | 
| C           | ramen        |

- Customer A ordered both curry and sushi on their first day, making them the first items in the order.
- Customer B's first order is curry.
- Customer C's first order is ramen.

***

**4. What is the most purchased item on the menu and how many times was it purchased by all customers?**

````sql
SELECT m.product_name as most_purchased,
       count(*) AS times_purchased
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.product_id,
         m.product_name
HAVING times_purchased =
  (SELECT count(*) AS times_purchased
   FROM sales
   GROUP BY product_id
   ORDER BY times_purchased DESC
   LIMIT 1);
````

#### Answer:
| most_purchased | times_purchased | 
| ----------- | ----------- |
| ramen       | 8 |


- If you're using Microsoft SQL Server, you can use **SELECT TOP 1** instead of that long **HAVING** I have in my solution using MySQL. 

***

**5. Which item was the most popular for each customer?**

````sql
WITH rank_popular AS
  (SELECT s.customer_id,
          m.product_name,
          count(m.product_name) AS order_count,
          DENSE_RANK() OVER (PARTITION BY s.customer_id
                            ORDER BY count(m.product_name) DESC) AS `rank`
   FROM sales s
   JOIN menu m ON s.product_id = m.product_id
   GROUP BY s.customer_id,
            m.product_name)

SELECT customer_id,
       product_name as most_popular,
       order_count
FROM rank_popular
WHERE `rank` = 1;
````

#### Answer:
| customer_id | most_popular | order_count |
| ----------- | ---------- |------------  |
| A           | ramen        |  3   |
| B           | sushi        |  2   |
| B           | curry        |  2   |
| B           | ramen        |  2   |
| C           | ramen        |  3   |

- Customer A's favourite item is ramen.
- Customer B enjoys all items on the menu. 
- Customer C's favourite item is ramen.
***

**6. Which item was purchased first by the customer after they became a member?**

```sql
WITH rank_purchase_after_member AS
  (SELECT s.customer_id,
          mn.product_name,
          DENSE_RANK() OVER (PARTITION BY s.customer_id
                             ORDER BY s.order_date) AS `rank`
   FROM members m
   JOIN sales s ON m.customer_id = s.customer_id
   JOIN menu mn ON s.product_id = mn.product_id
   WHERE s.order_date > m.join_date )

SELECT customer_id,
       product_name AS first_purchased_after_member
FROM rank_purchase_after_member
WHERE `rank` = 1;
```

#### Answer:
| customer_id | first_purchased_after_member |
| ----------- | ---------- |
| A           | ramen        |
| B           | sushi        |

- Customer A's first order after becoming a member is ramen.
- Customer B's first order after becoming a member is sushi.

***

**7. Which item was purchased just before the customer became a member?**

````sql
WITH rank_purchase_before_member AS
  (SELECT s.customer_id,
          mn.product_name,
          DENSE_RANK() OVER (PARTITION BY s.customer_id
                             ORDER BY s.order_date desc) AS `rank`
   FROM members m
   JOIN sales s ON m.customer_id = s.customer_id
   JOIN menu mn ON s.product_id = mn.product_id
   WHERE s.order_date < m.join_date )

SELECT customer_id,
       product_name AS last_purchased_before_member
FROM rank_purchase_before_member
WHERE `rank` = 1;
````

#### Answer:
| customer_id | product_name |
| ----------- | ---------- |
| A           | sushi        |
| A           | curry        |
| B           | sushi        |
- Customer A's last order was sushi and curry.
- Customer B's last order was sushi.

***

**8. What is the total items and amount spent for each member before they became a member?**

```sql
SELECT s.customer_id,
       COUNT(*) AS total_items,
       SUM(mn.price) AS total_amount
FROM members m
JOIN sales s ON m.customer_id = s.customer_id
JOIN menu mn ON s.product_id = mn.product_id
WHERE s.order_date < m.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id;
```

#### Answer:
| customer_id | total_items | total_amount |
| ----------- | ---------- |----------  |
| A           | 2 |  25       |
| B           | 3 |  40       |

Before becoming members,
- Customer A spent $25 on 2 items.
- Customer B spent $40 on 3 items.

***

**9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?**

```sql
WITH points_each_sale AS
  (SELECT s.customer_id,
          CASE
              WHEN m.product_name = 'sushi' THEN 20 * m.price
              ELSE 10 * m.price
          END AS points
   FROM sales s
   JOIN menu m ON s.product_id = m.product_id)
   
SELECT customer_id,
       sum(points) AS total_points
FROM points_each_sale
GROUP BY customer_id;
```

#### Answer:
| customer_id | total_points | 
| ----------- | ---------- |
| A           | 860 |
| B           | 940 |
| C           | 360 |

- Total points for Customer A is $860.
- Total points for Customer B is $940.
- Total points for Customer C is $360.

***

**10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi — how many points do customer A and B have at the end of January?**

**10.1. If we calculate all the points A and B have from the first day they ate at the restaurant:**

```sql
WITH points_each_sale_member AS
  (SELECT s.customer_id,
          s.order_date,
          CASE
              WHEN mn.product_name = 'sushi'
                   OR datediff(s.order_date, m.join_date) BETWEEN 0 AND 6 THEN 20 * mn.price
              ELSE 10 * mn.price
          END AS points
   FROM menu mn
   JOIN sales s ON mn.product_id = s.product_id
   LEFT JOIN members m ON s.customer_id = m.customer_id)
   
SELECT customer_id,
       sum(points) AS total_points
FROM points_each_sale_member
WHERE order_date <= '2021-01-31'
  AND customer_id in ('A', 'B')
GROUP BY customer_id
ORDER BY customer_id;
```

#### Answer:
| customer_id | total_points | 
| ----------- | ---------- |
| A           | 1370 |
| B           | 820 |

- Total points for Customer A is 1,370.
- Total points for Customer B is 820.

**10.2. If we calculate just the points A and B have from the day they became members:**

```sql
WITH points_each_sale_member AS
  (SELECT s.customer_id,
          s.order_date,
          m.join_date,
          CASE
              WHEN mn.product_name = 'sushi'
                   OR datediff(s.order_date, m.join_date) BETWEEN 0 AND 6 THEN 20 * mn.price
              ELSE 10 * mn.price
          END AS points
   FROM menu mn
   JOIN sales s ON mn.product_id = s.product_id
   LEFT JOIN members m ON s.customer_id = m.customer_id)
   
SELECT customer_id,
       sum(points) AS total_points
FROM points_each_sale_member
WHERE order_date BETWEEN join_date AND '2021-01-31'
  AND customer_id in ('A', 'B')
GROUP BY customer_id
ORDER BY customer_id;
```

#### Answer:
| customer_id | total_points | 
| ----------- | ---------- |
| A           | 1020 |
| B           | 320 |

- Total points for Customer A is 1,020 (From the day A became a member).
- Total points for Customer B is 320 (From the day B became a member).

