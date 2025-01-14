/* --------------------
   PART A: Data Cleansing Steps
   --------------------*/

-- Create and insert data into the temporary table in one go
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

/* --------------------
   PART B: Data Exploration
   --------------------*/

ALTER TABLE #clean_weekly_sales
ALTER COLUMN sales BIGINT;


-- 1. What day of the week is used for each week_date value?
SELECT DISTINCT week_date,
    DATENAME(weekday, week_date) AS week_day
FROM #clean_weekly_sales;

-- 2. What range of week numbers are missing from the dataset?
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

-- 3. How many total transactions were there for each year in the dataset?
SELECT calendar_year AS year, 
       SUM(transactions) as transaction_count
FROM #clean_weekly_sales
GROUP BY calendar_year;

-- 4. What is the total sales for each region for each month?
SELECT region, month_number, 
	   SUM(sales) as total_sales
FROM #clean_weekly_sales
GROUP BY region, month_number
ORDER BY region;

-- 5. What is the total count of transactions for each platform
SELECT platform, 
	   SUM(transactions) as transaction_count
FROM #clean_weekly_sales
GROUP BY platform;

-- 6. What is the percentage of sales for Retail vs Shopify for each month?
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

-- 7. What is the percentage of sales by demographic for each year in the dataset?

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

-- 8. Which age_band and demographic values contribute the most to Retail sales?

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

-- 9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
SELECT 
  calendar_year, 
  platform, 
  ROUND(AVG(avg_transaction), 0) AS avg_transaction_row, 
  SUM(sales) / SUM(transactions) AS avg_transaction_group
FROM #clean_weekly_sales
GROUP BY calendar_year, platform;

/* --------------------
   PART C: Before & After Analysis
   --------------------*/

-- 1. What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?
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

-- 2. What about the entire 12 weeks before and after?
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
