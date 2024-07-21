-- We will be using some temporary tables for this session (For reuse purpose)

-- Each interest_id and the number of months it has been present in our dataset
CREATE TEMPORARY TABLE interest_month AS
SELECT interest_id,
       COUNT(DISTINCT month_year) AS total_months
FROM interest_metrics
GROUP BY interest_id;

-- Each total_months metric and the number of interest_ids that have been present for for that duration
CREATE TEMPORARY TABLE month_interest AS
SELECT total_months,
       COUNT(*) AS interest_count
FROM interest_month
GROUP BY total_months;

-- Use the temporary tables in the final query
SELECT total_months,
       interest_count,
       SUM(interest_count) OVER(
                                 ORDER BY total_months DESC) AS cumulative_sum,
       ROUND(SUM(interest_count) OVER (
                                  ORDER BY total_months DESC) * 100 / SUM(interest_count) OVER(), 2) AS cumulative_percentage
FROM month_interest;

-- 1. Which interests have been present in all month_year dates in our dataset?
WITH max_cte AS
  (SELECT MAX(total_months) AS max_total_months
   FROM month_interest)
   
SELECT im.interest_id,
       im.total_months
FROM interest_month im
JOIN max_cte m ON im.total_months = m.max_total_months;

-- 2. Using this same total_months measure - calculate the cumulative percentage of all records starting at 14 months - which total_months value passes the 90% cumulative percentage value?
SELECT total_months,
       interest_count,
       SUM(interest_count) OVER(
                                 ORDER BY total_months DESC) AS cumulative_sum,
       ROUND(SUM(interest_count) OVER (
                                  ORDER BY total_months DESC) * 100 / SUM(interest_count) OVER(), 2) AS cumulative_percentage
FROM month_interest;

-- 3. If we were to remove all interest_id values which are lower than the total_months value we found in the previous question - how many total data points would we be removing?
WITH cumulative_percentage AS
  (SELECT total_months,
          interest_count,
          SUM(interest_count) OVER(
                                   ORDER BY total_months DESC) AS cumulative_sum,
          ROUND(SUM(interest_count) OVER (
                                          ORDER BY total_months DESC) * 100 / SUM(interest_count) OVER(), 2) AS cumulative_percentage
   FROM month_interest)
   
SELECT SUM(interest_count) AS data_points_removed
FROM cumulative_percentage
WHERE cumulative_percentage > 90;

-- 4. Does this decision make sense to remove these data points from a business perspective? 
-- Use an example where there are all 14 months present to a removed interest example for your arguments - think about what it means to have less months present from a segment perspective.
-- I think the decision makes sense since these interests are less valuable and don't represent constant needs of customers. We can remove these interests 
-- and keep the segmets more targeted and focused to the most popular interests and customers' needs.



-- 5. After removing these interests - how many unique interests are there for each month?