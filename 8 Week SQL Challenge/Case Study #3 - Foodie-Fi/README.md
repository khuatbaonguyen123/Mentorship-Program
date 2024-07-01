# 🥑 Case Study #3: Foodie-Fi

<img src="https://user-images.githubusercontent.com/81607668/129742132-8e13c136-adf2-49c4-9866-dec6be0d30f0.png" width="500" height="520" alt="image">

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

Please note that all the information regarding the case study has been sourced from the following link: [here](https://8weeksqlchallenge.com/case-study-3/). 

***

## Business Task
Danny and his friends launched a new startup Foodie-Fi and started selling monthly and annual subscriptions, giving their customers unlimited on-demand access to exclusive food videos from around the world.

This case study focuses on using subscription style digital data to answer important business questions on customer journey, payments, and business performances.

## Entity Relationship Diagram

![image](https://user-images.githubusercontent.com/81607668/129744449-37b3229b-80b2-4cce-b8e0-707d7f48dcec.png)

**Table 1: `plans`**

<img width="207" alt="image" src="https://user-images.githubusercontent.com/81607668/135704535-a82fdd2f-036a-443b-b1da-984178166f95.png">

There are 5 customer plans.

- Trial — Customer sign up to an initial 7 day free trial and will automatically continue with the pro monthly subscription plan unless they cancel, downgrade to basic or upgrade to an annual pro plan at any point during the trial.
- Basic plan — Customers have limited access and can only stream their videos and is only available monthly at $9.90.
- Pro plan — Customers have no watch time limits and are able to download videos for offline viewing. Pro plans start at $19.90 a month or $199 for an annual subscription.

When customers cancel their Foodie-Fi service — they will have a Churn plan record with a null price, but their plan will continue until the end of the billing period.

**Table 2: `subscriptions`**

<img width="245" alt="image" src="https://user-images.githubusercontent.com/81607668/135704564-30250dd9-6381-490a-82cf-d15e6290cf3a.png">

Customer subscriptions show the **exact date** where their specific `plan_id` starts.

If customers downgrade from a pro plan or cancel their subscription — the higher plan will remain in place until the period is over — the `start_date` in the subscriptions table will reflect the date that the actual plan changes.

When customers upgrade their account from a basic plan to a pro or annual pro plan — the higher plan will take effect straightaway.

When customers churn, they will keep their access until the end of their current billing period, but the start_date will be technically the day they decided to cancel their service.

***

## Question and Solution

I use Microsoft SQL Server for this Case Study. If you have any questions about my solutions, please feel free to reach out to me.

## 🎞️ A. Customer Journey

Based off the 8 sample customers provided in the sample subscriptions table below, write a brief description about each customer’s onboarding journey.

**Answer:**

```sql
WITH small_group_subscription AS
  (SELECT *
   FROM subscriptions
   WHERE customer_id >= 1
     AND customer_id <= 8)

SELECT sms.customer_id,
       p.plan_name,
       sms.start_date
FROM small_group_subscription sms
JOIN plans p ON sms.plan_id = p.plan_id;
```

<img width="300" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/6a60446c-5ec7-4536-9c10-2694ff7ca66d">

Based on the results above, I have selected three customers to focus on and will now share their onboarding journey.

- Customer 1: This customer initiated their journey by starting the free trial on 1 Aug 2020. After the trial period ended, on 8 Aug 2020, they subscribed to the basic monthly plan.

- Customer 2: Same as customer 1, this customer iniinitiated their journey by starting the free trial on 20 Sep 2020. After the trial ended on 27 Sep 2020, they subscribed for the pro annual plan.

- Customer 4: Same as the other two, this customer commenced their onboarding journey with a free trial on 17 Jan 2020. Once the trial ended, on 24 Jan 2020, they upgraded to the basic monthly plan. However, approximately 3 months later, they decided to end their subscription.

***

## B. Data Analysis Questions

### 1. How many customers has Foodie-Fi ever had?

```sql
SELECT count(DISTINCT customer_id) AS unique_customer
FROM subscriptions;
```

**Answer:**

<img width="180" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/d3998ed7-6e8d-4136-9ae3-944f579e3e81">

### 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

```sql
SELECT month(start_date) AS MONTH,
       count(*) AS trial_count
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE p.plan_name = 'trial'
GROUP BY month(start_date);
```

**Answer:**

<img width="180" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/e6a635ae-1803-4f68-8edd-588a382c4b11">

### 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name.

````sql
SELECT 
  p.plan_name, 
  COUNT(s.customer_id) AS subscription_count_after_2020
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id 
WHERE YEAR(s.start_date) > 2020
GROUP BY p.plan_name;
````

**Answer:**

<img width="280" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/3ccfa07f-b9d6-4bb3-9e91-b0c6d63234e8">


### 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

```sql
SELECT 
	COUNT(distinct s.customer_id) as churn_customer_count,
	ROUND(100 * COUNT(distinct s.customer_id) / (SELECT COUNT(distinct customer_id) FROM subscriptions), 1) AS churn_percent    
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id 
WHERE p.plan_name = 'churn';
```

**Answer:**

<img width="350" alt="image" src="https://user-images.githubusercontent.com/81607668/129840630-adebba8c-9219-4816-bba6-ba8119f298d9.png">


### 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

```sql
WITH churn_cte AS
  (SELECT s.customer_id,
          p.plan_name,
          ROW_NUMBER() OVER(PARTITION BY s.customer_id
                            ORDER BY s.start_date) AS row_num
   FROM subscriptions s
   JOIN plans p ON s.plan_id = p.plan_id)

SELECT COUNT(*) AS churn_customers,
       ROUND (COUNT(*) * 100 /
                (SELECT COUNT(DISTINCT customer_id)
                 FROM subscriptions), 2) AS churn_percentage
FROM churn_cte
WHERE plan_name = 'churn'
  AND row_num = 2;
```

**Answer:**

<img width="280" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/0c5e932c-5a86-4956-a47d-5022c637d6e3">


### 6. What is the number and percentage of customer plans after their initial free trial?

```sql
WITH next_plan_cte AS (
  SELECT s.customer_id,
         p.plan_name,
         ROW_NUMBER() OVER(PARTITION BY s.customer_id
                           ORDER BY s.start_date) AS row_num
  FROM subscriptions s
  JOIN plans p ON s.plan_id = p.plan_id
)

SELECT plan_name, 
       COUNT(*) AS plan_count,
       CAST(ROUND(COUNT(*) * 100.0 / 
                (SELECT COUNT(DISTINCT customer_id)
                 FROM subscriptions), 2) AS DECIMAL(4, 1)) AS plan_percentage
FROM next_plan_cte
WHERE row_num = 2
GROUP BY plan_name;
```

**Answer:**

<img width="350" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/0bad4d48-0f72-4213-a6d8-d544962f7395">


### 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

```sql
WITH rank_cte AS (
  SELECT s.customer_id, 
         p.plan_name, 
         ROW_NUMBER() OVER(PARTITION BY s.customer_id ORDER BY s.start_date DESC) AS row_num
  FROM subscriptions s
  JOIN plans p ON s.plan_id = p.plan_id
  WHERE s.start_date <= '2020-12-31'
)

SELECT plan_name, 
       COUNT(*) AS customer_count, 
       CAST(COUNT(*) * 100.00 / (SELECT COUNT(*) FROM rank_cte WHERE row_num = 1) AS DECIMAL(4, 1)) AS percentage_break
FROM rank_cte 
WHERE row_num = 1
GROUP BY plan_name;
```

**Answer:**

<img width="350" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/54ec3861-cb56-4d1a-be02-761b110b3606">

### 8. How many customers have upgraded to an annual plan in 2020?

```sql
SELECT COUNT(DISTINCT s.customer_id) AS upgrade_annual_cus_count
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE p.plan_name = 'pro annual'
  AND YEAR(s.start_date) = 2020;
```

**Answer:**

<img width="200" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/195157f5-e263-4de0-ac66-75ff8f44cd31">

### 9. How many days on average does it take for a customer to upgrade to an annual plan from the day they join Foodie-Fi?

````sql
WITH trial_plan AS (
  SELECT 
    customer_id, 
    start_date AS trial_date
  FROM subscriptions s
  JOIN plans p ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'trial'
), 
annual_plan AS (
  SELECT 
    customer_id, 
    start_date AS annual_date
  FROM subscriptions s
  JOIN plans p ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'pro annual'
)

SELECT 
  ROUND(
    AVG(
      DATEDIFF(day, trial.trial_date, annual.annual_date)
    ), 0
  ) AS avg_days_to_upgrade
FROM trial_plan AS trial
JOIN annual_plan AS annual
  ON trial.customer_id = annual.customer_id;
````

**Answer:**

<img width="200" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/49412925-a342-4370-b0ea-b161cdfca0c6">

- On average, customers take approximately 105 days from the day they join Foodie-Fi to upgrade to an annual plan.

### 10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

```sql
WITH trial_plan AS (
  SELECT 
    customer_id, 
    start_date AS trial_date
  FROM subscriptions s
  JOIN plans p ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'trial'
), 
annual_plan AS (
  SELECT 
    customer_id, 
    start_date AS annual_date
  FROM subscriptions s
  JOIN plans p ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'pro annual'
),
bins AS (
    SELECT 
        DATEDIFF(day, trial.trial_date, annual.annual_date) AS days_to_upgrade,
        CEILING((DATEDIFF(day, trial.trial_date, annual.annual_date) + 1) / 30.0) AS avg_days_to_upgrade
    FROM trial_plan AS trial
    JOIN annual_plan AS annual
        ON trial.customer_id = annual.customer_id
)
SELECT 
    CONCAT(((avg_days_to_upgrade - 1) * 30), ' - ', (avg_days_to_upgrade * 30), ' days') AS period,
    COUNT(*) AS num_of_customers
FROM bins
GROUP BY avg_days_to_upgrade
ORDER BY avg_days_to_upgrade;
```

**Answer:**

<img width="300" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/e4912b99-0243-4e71-a0fb-7bbfb97491d9">

### 11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

```sql
WITH downgrade_cte AS
  (SELECT s.customer_id,
          p.plan_name,
          LEAD(p.plan_name) OVER(PARTITION BY s.customer_id
                                 ORDER BY s.start_date) AS next_plan_name
   FROM subscriptions s
   JOIN plans p ON s.plan_id = p.plan_id
   WHERE YEAR(s.start_date) = 2020)
SELECT COUNT(DISTINCT customer_id) AS downgrade_pro_basic_monthly
FROM downgrade_cte
WHERE plan_name = 'pro monthly'
  AND next_plan_name = 'basic monthly';
```

**Answer:**

<img width="200" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/06e2fc15-d7a2-4eb6-b198-4125f5ed5af6">

***