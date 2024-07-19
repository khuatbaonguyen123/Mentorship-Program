/*
Generate a table that has 1 single row for every unique visit_id record and has the following columns:
1. user_id
2. visit_id
3. visit_start_time: the earliest event_time for each visit
4. page_views: count of page views for each visit
5. cart_adds: count of product cart add events for each visit
6. purchase: 1/0 flag if a purchase event exists for each visit
7. campaign_name: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
8. impression: count of ad impressions for each visit
9. click: count of ad clicks for each visit
10. (Optional column) cart_products: a comma separated text value with products added to the cart sorted by the order they were added to the cart (hint: use the sequence_number)
*/

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