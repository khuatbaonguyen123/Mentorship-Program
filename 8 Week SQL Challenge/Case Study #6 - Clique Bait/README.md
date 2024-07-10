# Case Study #6: Clique Bait

<img src="https://user-images.githubusercontent.com/81607668/134615258-d1108e0d-0816-4cd7-a972-d45580f82352.png" alt="Image" width="500" height="520">

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

Please note that all the information regarding the case study has been sourced from the following link: [here](https://8weeksqlchallenge.com/case-study-6/). 

***

## Business Task
Clique Bait is an online seafood store. 

In this case study - you are required to support the founder and CEO Danny’s vision and analyse his dataset and come up with creative solutions to calculate funnel fallout rates for the Clique Bait online store.

## Entity Relationship Diagram

<img width="825" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/0bc8db18-e2a5-4611-a7b8-c2a0373ad664">

**Table: `users`**

<img width="366" alt="image" src="https://user-images.githubusercontent.com/81607668/134623074-7c51d63a-c0a4-41e0-a6fc-257e4ca3997d.png">

**Table: `events`**

<img width="849" alt="image" src="https://user-images.githubusercontent.com/81607668/134623132-dfa2acd3-60c9-4305-9bea-6b39a9403c14.png">

**Table: `event_identifier`**

<img width="273" alt="image" src="https://user-images.githubusercontent.com/81607668/134623311-1ad16fe7-36e3-45b6-9dc6-8114333cf473.png">

**Table: `page_hierarchy`**

<img width="576" alt="image" src="https://user-images.githubusercontent.com/81607668/134623202-3158ca06-6f04-4b67-91f1-e184761e885c.png">

**Table: `campaign_identifier`**

<img width="792" alt="image" src="https://user-images.githubusercontent.com/81607668/134623354-0977d67c-fc61-4e61-90ee-f24a29682a9b.png">

***

## Question and Solution

I'm using MySQL for this Case Study. If you have any questions about my solutions, please feel free to reach out to me.

## 👩🏻‍💻 A. Digital Analysis

**1. How many users are there?**

````sql
SELECT COUNT(DISTINCT user_id) as user_count
FROM users;
````

<img width="104" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/f905d0d0-74b7-401e-a2b3-01c4400ab675">

**2. How many cookies does each user have on average?**

````sql
SELECT ROUND(AVG(cookie_count)) AS avg_cookie_user
FROM
  (SELECT user_id,
          COUNT(cookie_id) AS cookie_count
   FROM users
   GROUP BY user_id) a;
````

<img width="137" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/22126db2-41d1-4e73-b163-6d0976b140d3">

**3. What is the unique number of visits by all users per month?**

````sql
SELECT MONTH(event_time) AS month,
       COUNT(DISTINCT visit_id) AS unique_visit_count
FROM events
GROUP BY MONTH(event_time);
````

<img width="220" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/cd6da533-e97e-4d92-9a9b-b206fb99197b">

**4. What is the number of events for each event type?**

````sql
SELECT event_type,
       COUNT(*) AS event_count
FROM EVENTS
GROUP BY event_type;
````

<img width="220" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/45adcde2-c445-4292-bd07-6fd4e68aee45">

**5. What is the percentage of visits which have a purchase event?**

````sql
SELECT ROUND(COUNT(DISTINCT e.visit_id) * 100 /
               (SELECT COUNT(DISTINCT visit_id)
                FROM events), 2) AS purchase_event_perc
FROM events e
JOIN event_identifier ei ON e.event_type = ei.event_type
WHERE ei.event_name = 'Purchase';
````

<img width="182" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/1ed51f77-b79c-458e-914b-85e9e1feec27">

**6. What is the percentage of visits which view the checkout page but do not have a purchase event?**

````sql
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
````

<img width="200" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/9d1e2e46-dea3-4ad5-b96a-bfcc4ffc38ba">

**7. What are the top 3 pages by number of views?**

````sql
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
````

<img width="280" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/e7dfa7b3-8cd2-491e-9020-00f8b0308385">

**8. What is the number of views and cart adds for each product category?**

````sql
SELECT p.product_category, 
	   SUM(CASE WHEN ei.event_name = 'Page View' THEN 1 ELSE 0 END) AS number_of_view,
       SUM(CASE WHEN ei.event_name = 'Add to Cart' THEN 1 ELSE 0 END) AS number_of_cart_add
FROM events e
JOIN event_identifier ei ON e.event_type = ei.event_type
JOIN page_hierarchy p ON e.page_id = p.page_id
WHERE p.product_category IS NOT NULL
GROUP BY p.product_category;
````

<img width="350" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/3d265f3f-0076-4149-9da4-51081bbf11c3">

**9. What are the top 3 products by purchases?**

````sql
SELECT p.product_id, 
	   SUM(CASE WHEN ei.event_name = 'Purchase' THEN 1 ELSE 0 END) AS purchase_count
FROM events e
JOIN event_identifier ei ON e.event_type = ei.event_type
JOIN page_hierarchy p ON e.page_id = p.page_id
WHERE p.product_id IS NOT NULL
GROUP BY p.product_id
ORDER BY purchase_count DESC
LIMIT 3;
````


***

## 👩🏻‍💻 B. Product Funnel Analysis

Using a single SQL query - create a new output table which has the following details:

1. How many times was each product viewed?
2. How many times was each product added to cart?
3. How many times was each product added to a cart but not purchased (abandoned)?
4. How many times was each product purchased?

**Solution**

```sql
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
```

<kbd><img width="845" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/f4aef885-95d7-437b-9f43-d68707f79c49"></kbd>

***

Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

**Solution**

```sql
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
```

<kbd><img width="661" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/9d7bcec3-dd66-44aa-be40-d526762de3fd"></kbd>

***

Use your 2 new output tables - answer the following questions:

**1. Which product had the most views, cart adds and purchases?**

```sql
SELECT product_id,
	   view_count,
       cart_add_count,
       purchase_count
FROM product_statistics
ORDER BY view_count DESC, cart_add_count DESC, purchase_count DESC;
```

<img width="350" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/0d27f453-cf4c-4291-ac2e-e6a1d77420a5">

**2. Which product was most likely to be abandoned?**

```sql
SELECT product_id,
	   abandon_count
FROM product_statistics
ORDER BY abandon_count DESC
LIMIT 1;
```

<img width="200" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/e7f584da-fcdd-4b02-a969-d3a4e964baea">

**3. Which product had the highest view to purchase percentage?**

```sql
SELECT product_id,
	   ROUND(purchase_count * 100 / view_count, 2) AS view_to_purchase_perc
FROM product_statistics
ORDER BY view_to_purchase_perc DESC
LIMIT 1;
```

<img width="250" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/2e6bde94-ccd0-4db9-92d5-c64e13b0ae6b">

**4. What is the average conversion rate from view to cart add?**

```sql
SELECT ROUND(AVG(cart_add_count / view_count), 2) AS avg_view_to_cart_add_rate
FROM product_statistics;
```

<img width="200" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/b610b2bb-e32b-4d82-8714-02156a35a7af">

**5. What is the average conversion rate from cart add to purchase?**

```sql
SELECT ROUND(AVG(purchase_count / cart_add_count), 2) AS avg_cart_add_to_purchase_rate
FROM product_statistics;
```

<img width="200" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/c32f42c6-2d61-4ae3-a4a6-8aa66502e17f">

***

## 👩🏻‍💻 C. Campaigns Analysis

Generate a table that has 1 single row for every unique visit_id record and has the following columns:
- `user_id`
- `visit_id`
- `visit_start_time`: the earliest event_time for each visit
- `page_views`: count of page views for each visit
- `cart_adds`: count of product cart add events for each visit
- `purchase`: 1/0 flag if a purchase event exists for each visit
- `campaign_name`: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
- `impression`: count of ad impressions for each visit
- `click`: count of ad clicks for each visit
- (Optional column) `cart_products`: a comma separated text value with products added to the cart sorted by the order they were added to the cart (hint: use the sequence_number)
  
**Solution**

```sql
CREATE TEMPORARY TABLE unique_visit AS
SELECT u.user_id, e.visit_id, MIN(e.event_time) AS visit_start_time, 
	SUM(CASE WHEN ei.event_name = 'Page View' THEN 1 ELSE 0 END) AS page_views,
	SUM(CASE WHEN ei.event_name = 'Add to Cart' THEN 1 ELSE 0 END) AS cart_adds,
    SUM(CASE WHEN ei.event_name = 'Purchase' THEN 1 ELSE 0 END) AS purchases,
    c.campaign_name,
    SUM(CASE WHEN ei.event_name = 'Ad Impression' THEN 1 ELSE 0 END) AS impression,
    SUM(CASE WHEN ei.event_name = 'Ad Click' THEN 1 ELSE 0 END) AS click,
    GROUP_CONCAT(CASE WHEN p.product_id IS NOT NULL AND ei.event_name = 'Add to Cart' THEN p.page_name ELSE NULL END, ', ' ORDER BY e.sequence_number) AS products
FROM users u
JOIN events e ON u.cookie_id = e.cookie_id
LEFT JOIN clique_bait.campaign_identifier c ON e.event_time BETWEEN c.start_date AND c.end_date
JOIN event_identifier ei ON e.event_type = ei.event_type
JOIN page_hierarchy p ON e.page_id = p.page_id
GROUP BY u.user_id, e.visit_id, c.campaign_name;
```  

<img width="800" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/74555009-977d-439c-a33d-cce17491ae78">


