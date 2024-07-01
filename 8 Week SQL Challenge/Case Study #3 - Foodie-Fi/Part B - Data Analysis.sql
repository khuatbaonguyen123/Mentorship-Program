/* --------------------
   PART B: Data Analysis
   --------------------*/

-- 1. How many customers has Foodie-Fi ever had?
SELECT COUNT(DISTINCT customer_id) AS unique_customer
FROM subscriptions;

-- 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value.
SELECT MONTH(start_date) AS MONTH,
       COUNT(*) AS trial_count
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE p.plan_name = 'trial'
GROUP BY MONTH(start_date);

-- 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name.
SELECT 
	p.plan_name, 
	COUNT(s.customer_id) AS subscription_count_after_2020
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id 
WHERE YEAR(s.start_date) > 2020
GROUP BY p.plan_name;

-- 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
SELECT 
	COUNT(distinct s.customer_id) as churn_customer_count,
	ROUND(100 * COUNT(distinct s.customer_id) / (SELECT COUNT(distinct customer_id) FROM subscriptions), 1) AS churn_percent    
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id 
WHERE p.plan_name = 'churn';

-- 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
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
                 FROM subscriptions), 0) AS churn_percentage
FROM churn_cte
WHERE plan_name = 'churn'
  AND row_num = 2;

-- 6. What is the number and percentage of customer plans after their initial free trial?
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

-- 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
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

-- 8. How many customers have upgraded to an annual plan in 2020?
SELECT COUNT(DISTINCT s.customer_id) AS upgrade_annual_cus_count
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE p.plan_name = 'pro annual'
  AND YEAR(s.start_date) = 2020;

-- 9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
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

-- 10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
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
GROUP BY avg_days_to_upgrade;

-- 11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
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