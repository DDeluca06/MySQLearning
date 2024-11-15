### Activity: Creating an E-commerce Database Schema in MySQL

# In this activity, you will design a basic database schema for an e-commerce store. 
# This database will track customers, products, and orders. 

# Follow the steps below to create each table and establish relationships between them.

#### Instructions

-- 1. **Set up a new Database for the E-commerce Store**
--    - Create a new database for the e-commerce store.
--    - Select the new database to use it for the following steps.

CREATE DATABASE commerce;
USE commerce;

-- 2. **Create the Customers Table**
--    - Design a table named `customers` to store customer information. 
--    - Include columns for the customer's unique ID, first name, last name, email, phone number, address, city, state, and zip code.
--    - Add a column to record the customer's registration date with a default value set to the current date and time.
--    - Make sure the `customer_id` is unique and automatically increments for each new customer.
--    - Set `email` to be unique to prevent duplicate entries.

CREATE TABLE customers(
    customerid INT auto_increment unique PRIMARY KEY,
    regdate DATE,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) unique NOT NULL,
    phone VARCHAR(15) unique NOT NULL,
    address VARCHAR(90) unique NOT NULL,
    city VARCHAR(58) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip VARCHAR(9) NOT NULL
);

-- 3. **Create the Products Table**
--    - Design a table named `products` to store product information available in the store.
--    - Include columns for the product’s unique ID, name, description, price, stock quantity, and a date indicating when the product was added to the inventory.
--    - Ensure the `product_id` is unique and automatically increments for each new product.
--    - Set the `price` column to allow values with two decimal places.

CREATE TABLE products(
    productid INT auto_increment UNIQUE PRIMARY KEY NOT NULL,
    productname VARCHAR(20) UNIQUE NOT NULL,
    productdesc TEXT NOT NULL,
    productprice DECIMAL(4,2) NOT NULL,
    productquantity INT NOT NULL,
    productdate DATE NOT NULL
 );

-- 4. **Create the Orders Table**
--    - Design a table named `orders` to store information about each order placed by customers.
--    - Include columns for a unique `order_id`, the `customer_id` (to link to the customer who placed the order), the date the order was placed, order status (e.g., Pending, Shipped, Delivered, or Cancelled), and the total order amount.
--    - Set `order_id` to be unique and automatically increment.
--    - Add a foreign key constraint linking `customer_id` in the `orders` table to the `customer_id` in the `customers` table.
--    - Set a default value for the `order_date` column to the current date and time.

CREATE TABLE orders (
    orderid INT AUTO_INCREMENT PRIMARY KEY,
    customerid INT,
    orderdate DATE NOT NULL DEFAULT (CURRENT_DATE), -- Previous code was "orderdate DATE NOT NULL DEFAULT CURRENT_TIMESTAMP," incorrect Syntax for DEFAULT, and DATE does not like being thrown timestamps, so MySQL freaked out.
    orderstatus ENUM('Pending', 'Shipping', 'Delivered', 'Cancelled') NOT NULL,
    ordertotal DECIMAL(7,2),
    FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

-- 5. **Create the Order Details Table**
--    - Design a table named `order_details` to store details about each product within an order.
--    - Include columns for a unique ID for each order item, `order_id` (to link to the order it belongs to), `product_id` (to link to the purchased product), quantity ordered, and price per product at the time of the order.
--    - Set `order_id` and `product_id` as foreign keys to reference the `orders` and `products` tables, respectively.
--    - Ensure that each order detail has a unique `order_detail_id` that increments automatically

CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_product DECIMAL(7, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(orderid) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(productid) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 6. **Populate the Tables with Sample Data**
--    - Insert sample customer data into the `customers` table.
--    - Insert a few products into the `products` table.
--    - Create a sample order in the `orders` table for one of the customers.
--    - Add items to the `order_details` table for the sample order, referencing the products in the `products` table.

-- NOTE:
-- In an actual environment, we would expand the collum to allow bigger numbers and bigger data entires, more than just double digit items. But in this enviornment, I don't want to reconfigure the entire thing, this will do. Know that I understand this and would otherwise do so in a production world.

INSERT INTO customers (regdate, first_name, last_name, email, phone, address, city, state, zip) 
VALUES
('2023-01-15', 'John', 'Doe', 'john.doe@example.com', '555-1234', '123 Maple St', 'Springfield', 'IL', '62701'),
('2023-02-20', 'Jane', 'Smith', 'jane.smith@example.com', '555-5678', '456 Oak St', 'Greenville', 'TX', '75402'),
('2023-03-10', 'Alice', 'Johnson', 'alice.johnson@example.com', '555-8765', '789 Pine St', 'Fairview', 'CA', '94502');

INSERT INTO products (productname, productdesc, productprice, productquantity, productdate) 
VALUES
('Laptop', '15-inch screen, 16GB RAM', 12.00, 10, '2023-01-01'),
('Smartphone', '128GB storage, 5G capable', 79.99, 20, '2023-01-05'),
('Headphones', 'Noise cancelling, wireless', 19.99, 50, '2023-02-01'),
('Keyboard', 'Mechanical, RGB lighting', 99.99, 30, '2023-03-15');

INSERT INTO orders (customerid, orderdate, orderstatus, ordertotal) 
VALUES
(1, '2023-04-01', 'Pending', 13.98),
(2, '2023-04-05', 'Shipping', 19.99),
(3, '2023-04-10', 'Delivered', 21.98);

INSERT INTO order_details (order_id, product_id, quantity, price_per_product) 
VALUES
(1, 1, 1, 12.00),  -- 1 Laptop
(1, 3, 1, 19.99),   -- 1 Headphones
(2, 4, 2, 99.99),    -- 2 Keyboards
(3, 1, 1, 12.00),  -- 1 Laptop
(3, 2, 1, 79.99);   -- 1 Smartphone

-- 7. **Write Queries to Test Your Database**
--    - Retrieve all orders for a specific customer, showing only the order IDs and dates.
--    - Retrieve all details for a specific order, showing each product’s name, quantity, and price per item.
--    - Write a query to update the stock in the `products` table after an order has been placed.

-- Get Customer #1's order ID and the date
SELECT orderid, orderdate 
FROM orders
WHERE customerid = 1;  -- Replace `1` with the desired customer ID.

-- Get the product name, quantity and price for each prouduct; join them
SELECT p.productname, od.quantity, od.price_per_product
FROM order_details od
JOIN products p ON od.product_id = p.productid
WHERE od.order_id = 1;  -- Replace `1` with the desired order ID.

-- Update the stock
UPDATE products p
JOIN order_details od ON p.productid = od.product_id
SET p.productquantity = p.productquantity - od.quantity
WHERE od.order_id = 1;  -- Replace `1` with the desired order ID.

-- 8. **Consider Enhancements (Optional)**
--    - How might you add a "category" column for products to categorize items in the store?
--    - How would you track shipment dates for orders and delivery addresses if customers have multiple addresses?

-- #### Reflection
-- - How do the tables work together to create a full picture of customers and orders?
--   - A Series of Tubes. It's all a big series of tubes going from one table to another, spewing information and taking information from each end to get to a database that holds information securely and in usable format.
-- - Why are foreign keys essential in linking different tables in a relational database?
--   - Foreign Keys allow tables to communinate between one another, it's a fundamental design allowing for crosscommunication to the nth degree. Storing data means absolutely nothing if you can't talk between those tables and get information in a concise way and have to dig it up yourself. Variables in code achieve the same thing, they're vital for creating programs and databases that people understand.
-- - What challenges did you face in designing this schema?
--   - A lot of challenges, namely with the way MySQL handles its calls and what it wants very specifically. It will not question if you want to wipe the entire database, but it will very much stop you if there's a single character missing or if it doesn't recognize something; it's actually worse than JavaScript, because at least JS will tell you what's wrong and that you're doing something stupid before you run it in VSCode. SQL doesn't do that, you just have to keep running it over and over until it budges. It's annoying.
