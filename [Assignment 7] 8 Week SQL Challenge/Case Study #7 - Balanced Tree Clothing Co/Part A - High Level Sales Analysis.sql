-- 1. What was the total quantity sold for all products?
SELECT SUM(qty) AS total_quantity_sold
FROM sales;

-- 2. What is the total generated revenue for all products before discounts?
SELECT SUM(price) AS revenue_before_discount
FROM sales;

-- 3. What was the total discount amount for all products?
SELECT ROUND(SUM(price * qty * discount / 100), 2) AS total_discount_amount
FROM sales;
