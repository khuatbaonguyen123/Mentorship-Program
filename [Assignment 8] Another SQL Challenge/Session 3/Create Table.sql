CREATE DATABASE customer_order;

USE customer_order;

CREATE TABLE `customers` (
  `customer_id` int PRIMARY KEY,
  `email` varchar(255),
  `full_name` varchar(255),
  `address` varchar(255),
  `city` varchar(100),
  `region` varchar(100),
  `postal_code` varchar(20),
  `country` varchar(100),
  `phone` varchar(20),
  `registration_date` date,
  `channel_id` int,
  `first_order_id` int,
  `first_order_date` date,
  `last_order_id` int,
  `last_order_date` date
);

CREATE TABLE `orders` (
  `order_id` int PRIMARY KEY,
  `customer_id` int,
  `order_date` date,
  `total_amount` decimal(10,2),
  `ship_name` varchar(255),
  `ship_address` varchar(255),
  `ship_city` varchar(100),
  `ship_region` varchar(100),
  `ship_postalcode` varchar(20),
  `ship_country` varchar(100),
  `shipped_date` date
);

CREATE TABLE `products` (
  `product_id` int PRIMARY KEY,
  `product_name` varchar(255),
  `category_id` int,
  `unit_price` decimal(10,2),
  `discontinued` boolean
);

CREATE TABLE `categories` (
  `category_id` int PRIMARY KEY,
  `category_name` varchar(100),
  `description` text
);

CREATE TABLE `order_items` (
  `order_id` int,
  `product_id` int,
  `unit_price` decimal(10,2),
  `quantity` int,
  `discount` decimal(3,2),
  PRIMARY KEY (`order_id`, `product_id`)
);

CREATE TABLE `channels` (
  `id` int PRIMARY KEY,
  `channel_name` varchar(255)
);

ALTER TABLE `customers` ADD FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`);

ALTER TABLE `customers` ADD FOREIGN KEY (`first_order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `customers` ADD FOREIGN KEY (`last_order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

ALTER TABLE `products` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

DELIMITER //

CREATE TRIGGER update_customer_orders
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE first_order INT;
    DECLARE last_order INT;
    DECLARE first_order_date DATE;
    DECLARE last_order_date DATE;

    -- Find the first order for the customer
    SELECT MIN(order_id), MIN(order_date) INTO first_order, first_order_date 
    FROM orders WHERE customer_id = NEW.customer_id;

    -- Find the last order for the customer
    SELECT MAX(order_id), MAX(order_date) INTO last_order, last_order_date
    FROM orders WHERE customer_id = NEW.customer_id;

    -- Update the customers table with the first and last order info
    UPDATE customers
    SET first_order_id = first_order,
        first_order_date = first_order_date,
        last_order_id = last_order,
        last_order_date = last_order_date
    WHERE customer_id = NEW.customer_id;
END //

DELIMITER ;

-- Insert statements for channels
INSERT INTO channels (id, channel_name) VALUES 
(1, 'Online'),
(2, 'In-Store'),
(3, 'Mobile App'),
(4, 'Partner'),
(5, 'Social Media');

-- Insert statements for categories
INSERT INTO categories (category_id, category_name, description) VALUES 
(1, 'Electronics', 'Devices and gadgets'),
(2, 'Books', 'Various genres of books'),
(3, 'Clothing', 'Men\'s and women\'s clothing');

-- Insert statements for products
INSERT INTO products (product_id, product_name, category_id, unit_price, discontinued) VALUES 
(1, 'Smartphone', 1, 699.99, FALSE),
(2, 'Laptop', 1, 999.99, FALSE),
(3, 'Fiction Book', 2, 19.99, FALSE),
(4, 'Non-fiction Book', 2, 29.99, FALSE),
(5, 'T-Shirt', 3, 14.99, FALSE),
(6, 'Jeans', 3, 49.99, FALSE);

-- Insert statements for customers (without first_order_id and last_order_id)
INSERT INTO customers (customer_id, email, full_name, address, city, region, postal_code, country, phone, registration_date, channel_id) VALUES 
(1, 'john.doe@example.com', 'John Doe', '123 Elm St', 'Springfield', 'IL', '62701', 'USA', '555-1234', '2023-01-10', 1),
(2, 'jane.smith@example.com', 'Jane Smith', '456 Oak St', 'Lincoln', 'NE', '68501', 'USA', '555-5678', '2023-02-20', 2),
(3, 'bob.johnson@example.com', 'Bob Johnson', '789 Pine St', 'Dallas', 'TX', '75201', 'USA', '555-8765', '2023-03-15', 3);

-- Insert statements for orders
INSERT INTO orders (order_id, customer_id, order_date, total_amount, ship_name, ship_address, ship_city, ship_region, ship_postalcode, ship_country, shipped_date) VALUES 
(1, 1, '2024-01-15', 150.75, 'John Doe', '123 Elm St', 'Springfield', 'IL', '62701', 'USA', '2024-01-17'),
(2, 2, '2024-02-20', 250.50, 'Jane Smith', '456 Oak St', 'Lincoln', 'NE', '68501', 'USA', '2024-02-22'),
(3, 3, '2024-03-25', 99.99, 'Bob Johnson', '789 Pine St', 'Dallas', 'TX', '75201', 'USA', '2024-03-27'),
(4, 1, '2024-04-10', 175.20, 'John Doe', '123 Elm St', 'Springfield', 'IL', '62701', 'USA', '2024-04-12'),
(5, 2, '2024-05-15', 300.00, 'Jane Smith', '456 Oak St', 'Lincoln', 'NE', '68501', 'USA', '2024-05-17'),
(6, 3, '2024-06-20', 50.50, 'Bob Johnson', '789 Pine St', 'Dallas', 'TX', '75201', 'USA', '2024-06-22'),
(7, 1, '2024-07-10', 200.00, 'John Doe', '123 Elm St', 'Springfield', 'IL', '62701', 'USA', '2024-07-12');

-- Insert statements for order_items
INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount) VALUES 
(1, 1, 699.99, 1, 0.00),
(1, 3, 19.99, 2, 0.05),
(2, 2, 999.99, 1, 0.00),
(2, 5, 14.99, 3, 0.10),
(3, 4, 29.99, 1, 0.00),
(3, 2, 999.99, 1, 0.05),
(4, 1, 699.99, 1, 0.00),
(4, 5, 14.99, 2, 0.10),
(5, 3, 19.99, 1, 0.00),
(6, 4, 29.99, 3, 0.00),
(7, 2, 999.99, 1, 0.00),
(7, 4, 29.99, 2, 0.05);
