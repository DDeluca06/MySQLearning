### Activity: Joining Tables in an E-commerce Database

 # In this activity, you’ll learn how to use SQL JOIN operations to retrieve data across multiple tables in an e-commerce database. 
 # You’ll use the `customers`, `orders`, `products`, and `order_details` tables you created in the previous activity to explore relationships in the 
 # database and practice extracting combined information from multiple tables.

#### Instructions

-- 1. **Retrieve Customer Order Details**
--    - Write a query to join the `customers` and `orders` tables to list all orders placed by each customer.
--    - Include columns for `customer_id`, `first_name`, `last_name`, `order_id`, and `order_date`.
--    - Filter the results to show only orders with a status of "Delivered."

-- This should give us Alice Johnson.
SELECT 
    customers.customerid,
    customers.first_name,
    customers.last_name,
    orders.orderid,
    orders.orderdate,
    orders.orderstatus
FROM customers
JOIN orders ON customers.customerid = orders.customerid
WHERE orders.orderstatus = 'Delivered'; 


-- 2. **Get Detailed Order Items for a Specific Order**
--    - Choose one order by `order_id` and write a query to retrieve detailed information about each product in that order.
--    - Join the `orders`, `order_details`, and `products` tables.
--    - Include columns for `order_id`, `product_id`, `name` (product name), `quantity`, and `price`.
--    - Sort the results by `product_id` in ascending order.

-- Keyboard, $99.99
SELECT 
    orders.orderid,
    products.productid,
    products.productname,
    order_details.quantity,
    order_details.price_per_product
FROM orders
JOIN order_details ON orders.orderid = orderdetails.order_id
JOIN products ON orderdetails.product_id = products.productid
WHERE orders.orderid = 2  
ORDER BY products.productid ASC;


-- 3. **List Orders with Customer Information**
--    - Write a query to join the `orders` and `customers` tables to list all orders along with the customer's name and contact information.
--    - Include columns for `order_id`, `order_date`, `status`, `first_name`, `last_name`, and `email`.
--    - Filter to show only orders with a `Pending` status.

-- John Doe
SELECT 
    orders.orderid,
    orders.orderdate,
    orders.orderstatuss,
    customers.first_name,
    customers.last_name,
    customers.email
FROM orders
JOIN customers ON orders.customerid = customers.customerid
WHERE orders.orderstatus = 'Pending';


-- Adding more fake data; 3 pieces is far too little
INSERT INTO customers (regdate, first_name, last_name, email, phone, address, city, state, zip) 
VALUES
('2023-02-20', 'Bob', 'Brown', 'bob.brown@example.com', '555-2345', '101 Birch St', 'Lakeside', 'NY', '11542'),
('2023-03-05', 'Charlie', 'Davis', 'charlie.davis@example.com', '555-3456', '102 Cedar St', 'Hillview', 'FL', '33101'),
('2023-03-15', 'Diana', 'Miller', 'diana.miller@example.com', '555-4567', '103 Elm St', 'Mountainview', 'CO', '80202'),
('2023-03-30', 'Eve', 'Clark', 'eve.clark@example.com', '555-5678', '104 Fir St', 'Baytown', 'WA', '98004'),
('2023-04-10', 'Frank', 'Wilson', 'frank.wilson@example.com', '555-6789', '105 Oak Ave', 'Riverdale', 'AZ', '85001'),
('2023-04-20', 'Grace', 'Martinez', 'grace.martinez@example.com', '555-7890', '106 Maple Ave', 'Forestview', 'OR', '97001'),
('2023-05-01', 'Hank', 'Lopez', 'hank.lopez@example.com', '555-8901', '107 Poplar Rd', 'Meadowbrook', 'PA', '19104'),
('2023-05-10', 'Ivy', 'Taylor', 'ivy.taylor@example.com', '555-9012', '108 Spruce Rd', 'Bridgeport', 'CT', '06601'),
('2023-05-15', 'Jack', 'Anderson', 'jack.anderson@example.com', '555-0123', '109 Pine Blvd', 'Shoreline', 'WA', '98133'),
('2023-05-20', 'Kara', 'Thomas', 'kara.thomas@example.com', '555-3450', '110 Birch Blvd', 'Cedarburg', 'WI', '53012'),
('2023-05-25', 'Liam', 'Moore', 'liam.moore@example.com', '555-6780', '111 Cherry Blvd', 'Mapleton', 'VA', '22001'),
('2023-05-30', 'Mia', 'Hall', 'mia.hall@example.com', '555-9100', '112 Willow St', 'Brookside', 'NV', '89005');

INSERT INTO products (productname, productdesc, productprice, productquantity, productdate) 
VALUES
('Mouse', 'Wireless, ergonomic', 49.99, 40, '2023-03-01'),
('Monitor', '27-inch 4K UHD', 349.99, 15, '2023-03-10'),
('Tablet', '10-inch display, 64GB storage', 499.99, 20, '2023-03-20'),
('Camera', 'DSLR, 24MP', 899.99, 10, '2023-03-25'),
('Speaker', 'Bluetooth, portable', 129.99, 35, '2023-04-01'),
('Smartwatch', 'Fitness tracking, GPS', 199.99, 30, '2023-04-10'),
('Router', 'WiFi 6, dual-band', 179.99, 25, '2023-04-15'),
('External SSD', '1TB, USB-C', 149.99, 20, '2023-04-20'),
('Gaming Console', 'Next-gen console', 499.99, 15, '2023-05-01'),
('Drone', '4K camera, GPS', 799.99, 10, '2023-05-10'),
('E-Reader', '6-inch display, 8GB', 129.99, 30, '2023-05-15');


INSERT INTO orders (customerid, orderdate, orderstatus, ordertotal) 
VALUES
(1, '2023-06-01', 'Pending', 1199.98),
(2, '2023-06-02', 'Delivered', 249.99),
(3, '2023-06-03', 'Shipping', 499.98),
(4, '2023-06-04', 'Cancelled', 199.99),
(5, '2023-06-05', 'Pending', 1749.97),
(1, '2023-06-06', 'Delivered', 999.99),
(2, '2023-06-07', 'Pending', 349.98),
(3, '2023-06-08', 'Delivered', 649.99),
(4, '2023-06-09', 'Pending', 1049.97),
(5, '2023-06-10', 'Delivered', 449.99);

INSERT INTO order_details (order_id, product_id, quantity, price_per_product) 
VALUES
(1, 1, 1, 1200.00),  
(2, 3, 1, 249.99),   
(3, 2, 2, 249.99),   
(4, 4, 2, 99.99),    
(5, 1, 1, 1200.00),  
(5, 5, 3, 149.99),   
(6, 2, 1, 799.99),   
(7, 3, 2, 199.99),   
(8, 5, 1, 149.99),   
(9, 4, 3, 99.99),    
(10, 1, 1, 1200.00); 


-- 4. **Calculate Total Sales per Customer**
--    - Use a join between `orders`, `order_details`, and `customers` to calculate the total sales amount for each customer.
--    - Include columns for `customer_id`, `first_name`, `last_name`, and `total_sales`.
--    - Use the `SUM()` function to calculate the total sales amount for each customer based on the order details.

SELECT 
    customers.customerid, 
    customers.first_name, 
    customers.last_name, 
    SUM(order_details.price_per_product * order_details.quantity) AS total_sales
FROM 
    customers
INNER JOIN 
    orders ON customers.customerid = orders.customerid
INNER JOIN 
    order_details ON orders.orderid = order_details.order_id
GROUP BY 
    customers.customerid, customers.first_name, customers.last_name;


-- 5. **Find Products Ordered by Multiple Customers**
--    - Write a query to find products that have been ordered by more than one customer.
--    - Join the `order_details` and `products` tables and use a grouping function to identify products with multiple distinct `customer_id`s.
--    - Include columns for `product_id`, `name`, and the count of distinct `customer_id`s.

-- Trying to figure out aliases while I'm cracking this out, so far so good; sorry for the switchup!
SELECT 
    p.productid,
    p.productname,
    COUNT(DISTINCT o.customerid) AS distinct_customer_count
FROM 
    products p
INNER JOIN 
    order_details od ON p.productid = od.product_id
INNER JOIN 
    orders o ON od.order_id = o.orderid
GROUP BY 
    p.productid, p.productname
HAVING 
    COUNT(DISTINCT o.customerid) > 1;


-- 6. **Display All Product Sales with Quantities and Customers**
--    - Write a query to display each product that has been sold, along with the quantity sold and the customer who purchased it.
--    - Use joins to combine the `products`, `order_details`, `orders`, and `customers` tables.
--    - Include columns for `product_id`, `name`, `quantity`, `customer_id`, and `first_name`.
--    - Sort by `product_id` and `customer_id` in ascending order.

SELECT
    p.productid,
    p.productname,
    od.quantity,
    c.customerid,
    c.first_name,
    c.last_name
FROM
    products p
INNER JOIN
    order_details od ON p.productid = od.product_id
INNER JOIN
    orders o ON od.order_id = o.orderid
INNER JOIN
    customers c ON o.customerid = c.customerid
ORDER BY
    product_id, customer_id ASC


-- 7. **Bonus: Complex Join with Aggregation**
--    - Write a query to find each customer's total number of orders and the total amount spent.
--    - Use joins and aggregation functions to include columns for `customer_id`, `first_name`, `last_name`, `total_orders`, and `total_amount_spent`.
--    - Sort by `total_amount_spent` in descending order to see the highest-spending customers at the top.

-- #### Reflection Questions
-- After completing the joins, reflect on the following:
-- - How does joining tables help you get a fuller picture of customer orders and product information?
    -- Not by very much, admittedly. I feel like I spent a lot of time staring at w3schools too much for there to be any kind of lasting information that sticks. I need more time to figure it out, which will most likely be independent.
-- - Which joins were most challenging to understand? Why?
    -- I mostly ended up defaulting to inner joins, they seemed to do the job pretty well regardless of what I threw at them. I don't think I experimened much with other joins.
-- - How could joining tables and using aggregations be useful for reporting in an e-commerce application?
    -- Getting exact $$$ amounts per customer and getting product data individually, it allows a seller to see which product is the biggest and what should be shelved. Very useful data.
