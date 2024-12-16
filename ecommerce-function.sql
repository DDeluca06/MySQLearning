### Activity: Using Aggregate and Built-in Functions in MySQL for an E-commerce Database

# In this activity, you will explore and use MySQL aggregate functions and other built-in functions to gain insights from the data in an e-commerce database. You’ll work with the `customers`, `orders`, `products`, and `order_details` tables you created previously to calculate totals, averages, and other useful information.
# By completing this activity, you’ll gain experience using MySQL aggregate functions and other built-in functions, helping you develop useful reports and summaries for an e-commerce database.
#### Instructions

/* 1. **Calculate Average Order Value**
   - Write a query to calculate the average value of all orders.
   - Use the `AVG()` function on the total amount of each order.
   - Include columns for `order_id` and the average value (as `average_order_value`). */
SELECT orderid, ROUND(AVG(ordertotal)) AS average_order_value
FROM orders
GROUP BY orderid;

/* 2. **Count Orders by Status**
   - Write a query to count the number of orders in each status (Pending, Shipped, Delivered, and Cancelled).
   - Use the `COUNT()` function with the `GROUP BY` clause to group by `status`.
   - Include columns for `status` and the count of orders (as `order_count`). */
SELECT orderstatus, COUNT(orderid) AS order_count
FROM orders
GROUP BY orderstatus;

/* 3. **Find Highest and Lowest Priced Products**
   - Write two queries:
     - One to find the highest priced product in the `products` table.
     - One to find the lowest priced product.
   - Use the `MAX()` and `MIN()` functions on the `price` column to get the highest and lowest prices, respectively.
   - Include columns for `product_id`, `name`, and `price`. */
### MAX query
SELECT productid, productname, MAX(productprice) AS highest_price
FROM products
GROUP BY productid, productname
ORDER BY highest_price DESC

### MIN query
SELECT productid, productname, MIN(productprice) AS lowest_price
FROM products
GROUP BY productid, productname
ORDER BY lowest_price ASC

/* 4. **Calculate Total Quantity Sold per Product**
   - Write a query to calculate the total quantity sold for each product.
   - Use the `SUM()` function to add up quantities in the `order_details` table.
   - Join the `products` table to include `product_id` and `name` columns in your results.
   - Use `GROUP BY` to group results by `product_id`. */
SELECT p.productid, p.productname, SUM(order_details.quantity) AS total_quantity_sold
FROM products p
JOIN order_details order_details ON p.productid = order_details.product_id
GROUP BY p.productid, p.productname;

/* 5. **Calculate Total Sales Revenue per Day**
   - Write a query to calculate the total revenue generated each day.
   - Use `SUM()` to calculate the total order amount, and group by the date the orders were placed.
   - Use the `DATE()` function to extract just the date part from `order_date`.
   - Include columns for `order_date` (as just the date) and `total_revenue`. */
SELECT DATE(orderdate) AS order_date, SUM(ordertotal) AS total_revenue
FROM orders
GROUP BY DATE(orderdate);

/* 6. **List Customers with Total Amount Spent**
   - Write a query to find the total amount spent by each customer across all orders.
   - Use `SUM()` on the `price` and `quantity` columns in `order_details` to calculate total spending.
   - Join with `customers` to include each customer’s `customer_id`, `first_name`, and `last_name`.
   - Group results by `customer_id`. */
SELECT customers.customerid, 
       customers.first_name, 
       customers.last_name, 
       COALESCE(SUM(order_details.price_per_product * order_details.quantity), 0) AS total_amount_spent
FROM customers
LEFT JOIN orders ON customers.customerid = orders.customerid
LEFT JOIN order_details ON orders.orderid = order_details.order_id
GROUP BY customers.customerid, customers.first_name, customers.last_name
ORDER BY total_amount_spent DESC;

/* 7. **Calculate Average Order Quantity per Product**
   - Write a query to find the average quantity ordered per product.
   - Use the `AVG()` function on the `quantity` in the `order_details` table.
   - Include columns for `product_id`, `name`, and the average quantity (as `avg_quantity`).
   - Group by `product_id` to calculate the average per product. */
SELECT productid, productname, AVG(quantity) AS avg_quantit
FROM products
JOIN order_details ON products.productid = order_details.product_id
GROUP BY productid, productname;


/* 8. **Bonus: Find Top 5 Customers by Total Spending**
   - Write a query to find the top 5 customers who have spent the most in total.
   - Use `SUM()` on the `price * quantity` in `order_details` to calculate each customer’s total spending.
   - Join with `customers` to include `customer_id`, `first_name`, and `last_name`.
   - Order by total spending in descending order and limit the results to the top 5 customers. */

#### Reflection Questions
/* Once you’ve completed the queries, consider the following:
- How do aggregate functions like `SUM()` and `AVG()` help you gain insights into the data?
  -- By creating averages and sums of data, you can understand trends and patterns within your tables and show more data to the user as well as having a deeper dive into what you have and what your userbase desires.
- What insights could you gather from combining multiple functions (e.g., `SUM()` and `DATE()`)?
  -- With these two aggregation functions, you could get a sum of order totals for a specific date, or a list of dates with each order total per date.
- Why might limiting results (e.g., to the top 5) be useful in reporting for an e-commerce store? */
 -- Sometimes you don't need all 13,000 orders. Sometimes I just need the last 300, massive amounts of data is distracting and a waste of time to process and scroll through.
