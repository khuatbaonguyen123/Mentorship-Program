/* --------------------
   PART A: Customer Journey
   --------------------*/
-- Here is the SQL query (JOIN) needed for the explanation for Part A. The explanation's detail is in the README.md file.


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