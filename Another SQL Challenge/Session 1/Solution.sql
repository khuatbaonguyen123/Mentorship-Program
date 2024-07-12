/*
2. List All Clothing Items
Display the name of clothing items (name the column clothes), their color (name the column color), 
and the last name and first name of the customer(s) who bought this apparel in their favorite color. Sort rows according to color, in ascending order.
*/

SELECT DISTINCT cus.first_name,
                cus.last_name,
                cl.name AS clothes,
                c.name AS color
FROM clothing_order co
JOIN customer cus ON co.customer_id = cus.id
JOIN clothing cl ON co.clothing_id = cl.id
JOIN color c ON cl.color_id = c.id
WHERE cl.color_id = cus.favorite_color_id;

/*
3. Get All Non-Buying Customers
Select the last name and first name of customers and the name of their favorite color for customers with no purchases.
*/

SELECT cu.last_name,
       cu.first_name,
       cl.name AS favorite_color
FROM customer cu
LEFT JOIN clothing_order co ON cu.id = co.customer_id
JOIN color cl ON cu.favorite_color_id = cl.id
WHERE co.id IS NULL;

/*
4. Select All Main Categories and Their Subcategories
Select the name of the main categories (which have a NULL in the parent_id column) and the name of their direct subcategory (if one exists). 
Name the first column category and the second column subcategory.
*/

SELECT c1.name AS category,
       STRING_AGG(c2.name, ', ') AS subcategory
FROM category c1
LEFT JOIN category c2 ON c1.id = c2.parent_id
WHERE c1.parent_id IS NULL
GROUP BY c1.name;