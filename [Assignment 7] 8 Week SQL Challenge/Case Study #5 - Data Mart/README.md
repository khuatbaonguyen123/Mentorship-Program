# Case Study #5: Data Mart

<img src="https://user-images.githubusercontent.com/81607668/131437982-fc087a4c-0b77-4714-907b-54e0420e7166.png" alt="Image" width="500" height="520">

## 📚 Table of Contents
- [Business Task](#business-task)
- [Entity Relationship Diagram](#entity-relationship-diagram)
- [Question and Solution](#question-and-solution)

Please note that all the information regarding the case study has been sourced from the following link: [here](https://8weeksqlchallenge.com/case-study-5/). 

***

## Business Task
Data Mart is an online supermarket that specialises in fresh produce.

In June 2020, large scale supply changes were made at Data Mart. All Data Mart products now use sustainable packaging methods in every single step from the farm all the way to the customer.

Danny needs your help to analyse and quantify the impact of this change on the sales performance for Data Mart and it’s separate business areas.

The key business question to answer are the following:
- What was the quantifiable impact of the changes introduced in June 2020?
- Which platform, region, segment and customer types were the most impacted by this change?
- What can we do about future introduction of similar sustainability updates to the business to minimise impact on sales?

## Entity Relationship Diagram

For this case study there is only a single table: `data_mart.weekly_sales`

<img width="287" alt="image" src="https://user-images.githubusercontent.com/81607668/131438278-45e6a4e8-7cf5-468a-937b-2c306a792782.png">

Here are some further details about the dataset:

1. Data Mart has international operations using a multi-region strategy.
2. Data Mart has both, a retail and online `platform` in the form of a Shopify store front to serve their customers.
3. Customer `segment` and `customer_type` data relates to personal age and demographics information that is shared with Data Mart.
4. `transactions` is the count of unique purchases made through Data Mart and `sales` is the actual dollar amount of purchases.

Each record in the dataset is related to a specific aggregated slice of the underlying sales data rolled up into a `week_date` value which represents the start of the sales week.

10 random rows are shown in the table output below from `data_mart.weekly_sales`.

<img width="649" alt="image" src="https://user-images.githubusercontent.com/81607668/131438417-1e21efa3-9924-490f-9bff-3c28cce41a37.png">

***

## Question and Solution

I'm using Microsoft SQL Server for this Case Study. If you have any questions about my solution, please feel free to reach out to me.

## 🧼 A. Data Cleansing Steps

In a single query, perform the following operations and generate a new table in the `data_mart` schema named `clean_weekly_sales`:
- Convert the `week_date` to a `DATE` format
- Add a `week_number` as the second column for each `week_date` value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc
- Add a `month_number` with the calendar month for each `week_date` value as the 3rd column
- Add a `calendar_year` column as the 4th column containing either 2018, 2019 or 2020 values
- Add a new column called `age_band` after the original segment column using the following mapping on the number inside the segment value
  
<img width="166" alt="image" src="https://user-images.githubusercontent.com/81607668/131438667-3b7f3da5-cabc-436d-a352-2022841fc6a2.png">
  
- Add a new `demographic` column using the following mapping for the first letter in the `segment` values:  

| segment | demographic | 
| ------- | ----------- |
| C | Couples |
| F | Families |

- Ensure all `null` string values with an "unknown" string value in the original `segment` column as well as the new `age_band` and `demographic` columns
- Generate a new `avg_transaction` column as the sales value divided by transactions rounded to 2 decimal places for each record

**Answer:**

````sql
SELECT
    CONVERT(DATE, week_date, 3) AS week_date,
    DATEPART(week, CONVERT(DATE, week_date, 3)) AS week_number,
    DATEPART(month, CONVERT(DATE, week_date, 3)) AS month_number,
    DATEPART(year, CONVERT(DATE, week_date, 3)) AS calendar_year,
    region, 
    platform, 
    segment,
    CASE 
        WHEN RIGHT(segment, 1) = '1' THEN 'Young Adults'
        WHEN RIGHT(segment, 1) = '2' THEN 'Middle Aged'
        WHEN RIGHT(segment, 1) IN ('3', '4') THEN 'Retirees'
        ELSE 'unknown' 
    END AS age_band,
    CASE 
        WHEN LEFT(segment, 1) = 'C' THEN 'Couples'
        WHEN LEFT(segment, 1) = 'F' THEN 'Families'
        ELSE 'unknown' 
    END AS demographic,
    transactions,
	CAST(ROUND(sales * 1.00 / transactions, 2) AS DECIMAL(18, 2)) AS avg_transaction,
    sales
INTO #clean_weekly_sales
FROM weekly_sales;
````

<img width="1148" alt="image" src="https://user-images.githubusercontent.com/81607668/131474035-528e0af6-d848-427b-bbd9-73956a775f86.png">

***

## 🛍 B. Data Exploration

**1. What day of the week is used for each week_date value?**

````sql
SELECT DISTINCT week_date,
    DATENAME(weekday, week_date) AS week_day
FROM #clean_weekly_sales;
````

**Answer:**

_Please note that I'm just showing a part of the result set._

<img width="200" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/9c484071-922a-41c9-9463-7741ee4e7b96">



**2. What range of week numbers are missing from the dataset?**

````sql
WITH week_number AS (
    SELECT 1 AS week_number
    UNION ALL
    SELECT week_number + 1
    FROM week_number
    WHERE week_number < 52
)

SELECT 
    wn.week_number
FROM week_number wn
LEFT JOIN #clean_weekly_sales ws ON wn.week_number = ws.week_number
WHERE ws.week_number IS NULL;
````

**Answer:**

_Please note that I'm just showing a part of the result set._

|week_number|
|:----|
|1|
|2|
|3|
|37|
|41|

- The dataset is missing a total of 28 `week_number` records.

**3. How many total transactions were there for each year in the dataset?**

````sql
SELECT calendar_year AS year, 
       SUM(transactions) as transaction_count
FROM #clean_weekly_sales
GROUP BY calendar_year;
````

**Answer:**

|year|total_transactions|
|:----|:----|
|2018|346406460|
|2019|365639285|
|2020|375813651|

**4. What is the total sales for each region for each month?**

````sql
SELECT region, month_number, 
	   SUM(sales) as total_sales
FROM #clean_weekly_sales
GROUP BY region, month_number
ORDER BY region;

````

**Answer:**

_Please note that I'm just showing a part of the result set._

<img width="250" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/c7c9d8c0-60c7-42bd-97c1-16afdf12f9e5">


**5. What is the total count of transactions for each platform?**

````sql
SELECT platform, 
	   SUM(transactions) as transaction_count
FROM #clean_weekly_sales
GROUP BY platform;
````

**Answer:**

|platform|transaction_count|
|:----|:----|
|Retail|1081934227|
|Shopify|5925169|

**6. What is the percentage of sales for Retail vs Shopify for each month?**

````sql
WITH monthly_transactions AS (
  SELECT 
    calendar_year, 
    month_number, 
    platform, 
    SUM(sales) AS monthly_sales
  FROM #clean_weekly_sales
  GROUP BY calendar_year, month_number, platform
)
SELECT 
  calendar_year, 
  month_number, 
  CAST(ROUND(100.00 * SUM(CASE WHEN platform = 'Retail' THEN monthly_sales ELSE NULL END) / SUM(monthly_sales), 2) AS DECIMAL(5, 2)) AS retail_percent,
  CAST(ROUND(100.00 * SUM(CASE WHEN platform = 'Shopify'THEN monthly_sales ELSE NULL END) / SUM(monthly_sales), 2) AS DECIMAL(5, 2)) AS shopify_percent
FROM monthly_transactions
GROUP BY calendar_year, month_number;
````

**Answer:**

<img width="380" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/52fc8123-d3fd-4b3a-8893-dc87f3ced1e1">


**7. What is the percentage of sales by demographic for each year in the dataset?**

````sql
SELECT b.calendar_year,
       a.region,
       CAST(ROUND((100.00 * a.sale_region / b.total_sale), 2) AS DECIMAL(5, 2)) AS perc_sale_region
FROM
  (SELECT calendar_year,
          region,
          SUM(sales) AS sale_region
   FROM #clean_weekly_sales
   GROUP BY calendar_year,
            region) a
JOIN
  (SELECT calendar_year,
          SUM(sales) AS total_sale
   FROM #clean_weekly_sales
   GROUP BY calendar_year) b ON a.calendar_year = b.calendar_year;
````

**Answer:**

_Please note that I'm just showing a part of the result set._

<img width="300" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/7d2f4908-077b-461d-8d3a-88b327956f75">


**8. Which age_band and demographic values contribute the most to Retail sales?**

````sql
SELECT a.platform,
       a.age_band,
       b.region
FROM
  (SELECT TOP 1 platform,
              age_band,
              SUM(sales) AS sale_contribute_age_band
   FROM #clean_weekly_sales
   WHERE platform = 'Retail'
   GROUP BY platform,
            age_band
   ORDER BY sale_contribute_age_band DESC) a
JOIN
  (SELECT TOP 1 platform,
              region,
              SUM(sales) AS sale_contribute_region
   FROM #clean_weekly_sales
   WHERE platform = 'Retail'
   GROUP BY platform,
            region
   ORDER BY sale_contribute_region DESC) b ON a.platform = b.platform;
````

**Answer:**

|platform|age_band|region|
|:----|:----|:----|
|Retail|unknown|OCEANIA|


**9. Can we use the `avg_transaction` column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?**

````sql
SELECT 
  calendar_year, 
  platform, 
  ROUND(AVG(avg_transaction), 0) AS avg_transaction_row, 
  SUM(sales) / SUM(transactions) AS avg_transaction_group
FROM #clean_weekly_sales
GROUP BY calendar_year, platform;
````

**Answer:**

|calendar_year|platform|avg_transaction_row|avg_transaction_group|
|:----|:----|:----|:----|
|2018|Retail|43|36|
|2018|Shopify|188|192|
|2019|Retail|42|36|
|2019|Shopify|178|183|
|2020|Retail|41|36|
|2020|Shopify|175|179|

***

## 🧼 C. Before & After Analysis

This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.

Taking the `week_date` value of `2020-06-15` as the baseline week where the Data Mart sustainable packaging changes came into effect. We would include all `week_date` values for `2020-06-15` as the start of the period after the change and the previous week_date values would be before.

Using this analysis approach - answer the following questions:

**1. What is the total sales for the 4 weeks before and after `2020-06-15`? What is the growth or reduction rate in actual values and percentage of sales?**

````sql
WITH before_after_changes AS (
	SELECT 
        SUM(CASE WHEN week_number BETWEEN 21 AND 24 AND calendar_year = 2020 THEN sales ELSE 0 END) AS total_sales_before,
        SUM(CASE WHEN week_number BETWEEN 25 AND 28 AND calendar_year = 2020 THEN sales ELSE 0 END) AS total_sales_after
    FROM #clean_weekly_sales
)
SELECT 
  total_sales_before,
  total_sales_after,
  total_sales_after - total_sales_before AS sales_variance, 
  CAST(ROUND(100.00 * (total_sales_after - total_sales_before) / total_sales_before, 2) AS DECIMAL(5, 2)) AS variance_percent
FROM before_after_changes;

````

**Answer:**

<img width="450" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/c55aeddb-ac44-4f12-9792-9b375de70a37">

***

**2. What about the entire 12 weeks before and after?**

````sql
WITH before_after_changes AS (
	SELECT 
        SUM(CASE WHEN week_number BETWEEN 13 AND 24 AND calendar_year = 2020 THEN sales ELSE 0 END) AS total_sales_before,
        SUM(CASE WHEN week_number BETWEEN 25 AND 37 AND calendar_year = 2020 THEN sales ELSE 0 END) AS total_sales_after
    FROM #clean_weekly_sales
)
SELECT 
  total_sales_before,
  total_sales_after,
  total_sales_after - total_sales_before AS sales_variance, 
  CAST(ROUND(100.00 * (total_sales_after - total_sales_before) / total_sales_before, 2) AS DECIMAL(5, 2)) AS variance_percent
FROM before_after_changes;
````

**Answer:**

<img width="450" alt="image" src="https://github.com/khuatbaonguyen123/Mentorship-Program/assets/124229814/ef446c0a-abc5-4b94-a338-a74d13ab098b">


