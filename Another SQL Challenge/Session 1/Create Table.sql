CREATE DATABASE clothing_store;
GO

USE clothing_store;
GO

CREATE TABLE [color] (
  [id] int PRIMARY KEY,
  [name] varchar(50),
  [extra_fee] decimal(5,2)
)
GO

CREATE TABLE [customer] (
  [id] int PRIMARY KEY,
  [first_name] varchar(50),
  [last_name] varchar(50),
  [favorite_color_id] int
)
GO

CREATE TABLE [category] (
  [id] int PRIMARY KEY,
  [name] varchar(50),
  [parent_id] int
)
GO

CREATE TABLE [clothing] (
  [id] int PRIMARY KEY,
  [name] varchar(50),
  [size] varchar(3),
  [price] decimal(8,2),
  [color_id] int,
  [category_id] int
)
GO

CREATE TABLE [clothing_order] (
  [id] int PRIMARY KEY,
  [customer_id] int,
  [clothing_id] int,
  [items] int,
  [order_date] date
)
GO

ALTER TABLE [customer] ADD FOREIGN KEY ([favorite_color_id]) REFERENCES [color] ([id])
GO

ALTER TABLE [category] ADD FOREIGN KEY ([parent_id]) REFERENCES [category] ([id])
GO

ALTER TABLE [clothing] ADD FOREIGN KEY ([color_id]) REFERENCES [color] ([id])
GO

ALTER TABLE [clothing] ADD FOREIGN KEY ([category_id]) REFERENCES [category] ([id])
GO

ALTER TABLE [clothing_order] ADD FOREIGN KEY ([customer_id]) REFERENCES [customer] ([id])
GO

ALTER TABLE [clothing_order] ADD FOREIGN KEY ([clothing_id]) REFERENCES [clothing] ([id])
GO

-- Inserting data into the color table
INSERT INTO color (id, name, extra_fee)
VALUES
(1, 'Red', 0.5),
(2, 'Blue', 0.75),
(3, 'Green', 0),
(4, 'Yellow', 0.55),
(5, 'Black', 1),
(6, 'White', 0),
(7, 'Pink', 0.8),
(8, 'Purple', 0);

-- Inserting data into the category table
INSERT INTO category (id, name, parent_id)
VALUES
(1, 'Tops', NULL),
(2, 'Bottoms', NULL),
(3, 'Shirts', 1),
(4, 'Pants', 2),
(5, 'Dresses', NULL);

-- Inserting data into the customer table
INSERT INTO customer (id, first_name, last_name, favorite_color_id)
VALUES
(1, 'John', 'Smith', 1),
(2, 'Jane', 'Doe', 2),
(3, 'Michael', 'Johnson', 3),
(4, 'Emily', 'Davis', 4),
(5, 'David', 'Wilson', 5),
(6, 'Emma', 'Brown', 6),
(7, 'James', 'Taylor', 7),
(8, 'Olivia', 'Anderson', 8),
(9, 'Daniel', 'Thomas', 1),
(10, 'Isabella', 'Jackson', 2),
(11, 'Matthew', 'White', 3),
(12, 'Ava', 'Harris', 4),
(13, 'Joshua', 'Martin', 5),
(14, 'Sophia', 'Thompson', 6),
(15, 'Andrew', 'Garcia', 7);

-- Inserting data into the clothing table
INSERT INTO clothing (id, name, size, price, color_id, category_id)
VALUES
(1, 'Vintage T-Shirt', 'S', 12.99, 1, 3),
(2, 'Graphic Tee', 'M', 15.99, 2, 3),
(3, 'Classic Crew Neck', 'L', 11.99, 3, 3),
(4, 'Skinny Jeans', 'S', 45.99, 4, 4),
(5, 'Relaxed Fit Jeans', 'M', 42.99, 5, 4),
(6, 'Denim Overalls', 'L', 55.99, 6, 4),
(7, 'Floral Summer Dress', 'S', 59.99, 7, 5),
(8, 'Evening Gown', 'M', 89.99, 8, 5),
(9, 'Casual Sundress', 'L', 49.99, 1, 5),
(10, 'Woolen Hoodie', 'S', 39.99, 2, 1),
(11, 'Zip-Up Hoodie', 'M', 34.99, 3, 1),
(12, 'Pullover Hoodie', 'L', 32.99, 4, 1),
(13, 'Running Shorts', 'S', 24.99, 5, 2),
(14, 'Cargo Shorts', 'M', 27.99, 6, 2),
(15, 'Chino Shorts', 'L', 29.99, 7, 2);

-- Inserting data into the clothing_order table
INSERT INTO clothing_order (id, customer_id, clothing_id, items, order_date)
VALUES
(1, 1, 1, 2, '2023-01-05'),
(2, 2, 2, 1, '2023-01-10'),
(3, 3, 3, 3, '2023-02-15'),
(4, 4, 4, 1, '2023-02-20'),
(5, 5, 5, 2, '2023-03-01'),
(6, 6, 6, 1, '2023-03-05'),
(7, 7, 7, 1, '2023-04-10'),
(8, 8, 8, 2, '2023-04-15'),
(9, 9, 9, 1, '2023-05-20'),
(10, 10, 10, 3, '2023-06-01'),
(11, 11, 11, 1, '2023-06-05'),
(12, 12, 12, 2, '2023-07-10'),
(13, 13, 13, 1, '2023-07-15'),
(14, 14, 14, 2, '2023-08-20'),
(15, 15, 15, 1, '2023-09-01'),
(16, 1, 1, 1, '2023-09-05'),
(17, 2, 2, 2, '2023-10-10'),
(18, 3, 3, 1, '2023-10-15'),
(19, 4, 4, 2, '2023-11-20'),
(20, 5, 5, 1, '2023-12-01'),
(21, 6, 6, 3, '2023-12-05'),
(22, 7, 7, 1, '2024-01-10'),
(23, 8, 8, 2, '2024-01-15'),
(24, 9, 9, 1, '2024-02-20'),
(25, 10, 10, 2, '2024-03-01'),
(26, 11, 11, 1, '2024-03-05'),
(27, 12, 12, 1, '2024-04-10'),
(28, 13, 13, 2, '2024-04-15'),
(29, 14, 14, 1, '2024-05-20'),
(30, 14, 14, 3, '2024-06-01');


