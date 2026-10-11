-- =====================================
-- WEEK 1 SQL ASSIGNMENT
-- Lab Solutions (SQLite3)
-- =====================================

-- LAB 1: SELECT

-- LAB 2: WHERE

-- LAB 3: BETWEEN

-- LAB 4: DISTINCT

-- LAB 5: ORDER BY and LIMIT

-- LAB 6: LIKE

-- LAB 7: IS NULL

-- LAB 8: INSERT

-- LAB 9: UPDATE

-- LAB 10: DELETE

-- LAB 11: Aggregate Functions

-- LAB 12: GROUP BY and HAVING

-- LAB 13: INNER JOIN

-- LAB 14: LEFT JOIN

-- LAB 15: Multi-table JOIN and Aggregation

-- LAB 16: Final Business Report
-- =========================================================
-- WEEK 1 SQL ASSIGNMENT
-- SQLite3 - All 16 Lab Solutions
-- =========================================================
--
-- Database: week1_assignment.db
-- Topics: SELECT, WHERE, JOIN, GROUP BY, CRUD, Aggregation
--
-- Note:
-- Labs 8, 9, and 10 document changes already performed.
-- The database file contains the final state of the data.
-- =========================================================


-- =========================================================
-- LAB 1: SELECT ALL ORDERS
-- =========================================================

-- Display all columns and rows from the orders table.

SELECT *
FROM orders;


-- =========================================================
-- LAB 2: SELECT SPECIFIC COLUMNS WITH WHERE
-- =========================================================

-- Find orders where the quantity is greater than 2.

SELECT order_id,
       customer_id,
       quantity,
       order_date
FROM orders
WHERE quantity > 2;


-- =========================================================
-- LAB 3: IN AND BETWEEN
-- =========================================================

-- Question A:
-- Find orders placed by customers 1, 2, or 3.

SELECT order_id,
       customer_id,
       order_date
FROM orders
WHERE customer_id IN (1, 2, 3);


-- Question B:
-- Find orders placed between July and December 2022.

SELECT order_id,
       order_date
FROM orders
WHERE order_date BETWEEN '2022-07-01'
                     AND '2022-12-31';


-- =========================================================
-- LAB 4: DISTINCT
-- =========================================================

-- Display unique customer cities.

SELECT DISTINCT city
FROM customers;


-- =========================================================
-- LAB 5: ORDER BY AND LIMIT
-- =========================================================

-- Find the 5 most recent orders.

SELECT order_id,
       customer_id,
       order_date
FROM orders
ORDER BY order_date DESC
LIMIT 5;


-- =========================================================
-- LAB 6: LIKE
-- =========================================================

-- Find products containing USB in their names.

SELECT product_id,
       product_name
FROM products
WHERE product_name LIKE '%USB%';


-- =========================================================
-- LAB 7: IS NULL AND IS NOT NULL
-- =========================================================

-- Question A:
-- Find customers whose city is missing.

SELECT customer_id,
       customer_name,
       city
FROM customers
WHERE city IS NULL;


-- Question B:
-- Count customers whose city is not missing.

SELECT COUNT(*) AS non_null_city_count
FROM customers
WHERE city IS NOT NULL;


-- =========================================================
-- LAB 8: INSERT
-- =========================================================

-- Add a new order.
-- This INSERT has already been executed in our database.

INSERT INTO orders (
    order_id,
    customer_id,
    product_id,
    quantity,
    unit_price,
    order_date,
    status
)
VALUES (
    1100,
    3,
    106,
    1,
    7999,
    '2023-01-05',
    'pending'
);


-- Verify the inserted order.

SELECT *
FROM orders
WHERE order_id = 1100;


-- =========================================================
-- LAB 9: UPDATE
-- =========================================================

-- Question:
-- Change order 1006 from pending to delivered.

-- Check the order before updating.

SELECT order_id,
       status
FROM orders
WHERE order_id = 1006;


-- Update the order status.
-- This UPDATE has already been executed.

UPDATE orders
SET status = 'delivered'
WHERE order_id = 1006;


-- Verify the updated status.

SELECT order_id,
       status
FROM orders
WHERE order_id = 1006;


-- =========================================================
-- LAB 10: DELETE
-- =========================================================

-- Question:
-- Delete cancelled order 1004.

-- Check the order before deleting.

SELECT *
FROM orders
WHERE order_id = 1004;


-- Delete the order.
-- This DELETE has already been executed.

DELETE FROM orders
WHERE order_id = 1004;


-- Verify that the order no longer exists.

SELECT *
FROM orders
WHERE order_id = 1004;


-- Count the remaining orders.

SELECT COUNT(*) AS remaining_orders
FROM orders;


-- =========================================================
-- LAB 11: AGGREGATE FUNCTIONS
-- =========================================================

-- Question A:
-- Count all orders.

SELECT COUNT(*) AS total_orders
FROM orders;


-- Question B:
-- Calculate total quantity ordered.

SELECT SUM(quantity) AS total_quantity
FROM orders;


-- Question C:
-- Calculate average unit price across orders.

SELECT ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM orders;


-- Additional practice:
-- Calculate average product price.

SELECT ROUND(AVG(unit_price), 2) AS average_price
FROM products;


-- Question D:
-- Find minimum and maximum order unit prices.

SELECT MIN(unit_price) AS min_unit_price,
       MAX(unit_price) AS max_unit_price
FROM orders;


-- Additional practice:
-- Find cheapest and most expensive product prices.

SELECT MIN(unit_price) AS lowest_price,
       MAX(unit_price) AS highest_price
FROM products;


-- =========================================================
-- LAB 12: GROUP BY AND HAVING
-- =========================================================

-- Step 1:
-- Count orders for each customer.

SELECT customer_id,
       COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;


-- Step 2:
-- Calculate total spending for each customer.

SELECT customer_id,
       SUM(quantity * unit_price) AS total_spent
FROM orders
GROUP BY customer_id;


-- Step 3:
-- Show customers who spent more than 20000.

SELECT customer_id,
       SUM(quantity * unit_price) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(quantity * unit_price) > 20000;


-- =========================================================
-- LAB 13: INNER JOIN
-- =========================================================

-- Step 1:
-- Connect orders with customer names.

SELECT orders.order_id,
       customers.customer_name
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id;


-- Step 2:
-- Display delivered orders with customer information.

SELECT orders.order_id,
       customers.customer_name,
       orders.product_id,
       orders.quantity,
       orders.order_date
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.status = 'delivered';


-- =========================================================
-- LAB 14: LEFT JOIN
-- =========================================================

-- Step 1:
-- Display orders alongside matching payment IDs.

SELECT orders.order_id,
       payments.payment_id
FROM orders
LEFT JOIN payments
ON orders.order_id = payments.order_id;


-- Step 2:
-- Find orders without matching payment records.

SELECT orders.order_id,
       orders.customer_id,
       orders.order_date
FROM orders
LEFT JOIN payments
ON orders.order_id = payments.order_id
WHERE payments.payment_id IS NULL;


-- =========================================================
-- LAB 15: JOIN WITH AGGREGATION
-- =========================================================

-- Step 1:
-- Connect orders with product categories.

SELECT orders.order_id,
       products.category,
       orders.quantity
FROM orders
INNER JOIN products
ON orders.product_id = products.product_id;


-- Step 2:
-- Calculate units sold by category.

SELECT products.category,
       SUM(orders.quantity) AS total_units_sold
FROM orders
INNER JOIN products
ON orders.product_id = products.product_id
GROUP BY products.category;


-- Step 3:
-- Calculate total revenue and units sold by category.

SELECT products.category,
       SUM(orders.quantity) AS total_units_sold,
       SUM(orders.quantity * orders.unit_price) AS total_revenue
FROM orders
INNER JOIN products
ON orders.product_id = products.product_id
GROUP BY products.category
ORDER BY total_revenue DESC;


-- =========================================================
-- LAB 16: FINAL BUSINESS REPORT
-- =========================================================

-- Step 1:
-- Find orders placed in 2022.

SELECT order_id,
       customer_id,
       order_date
FROM orders
WHERE order_date BETWEEN '2022-01-01'
                     AND '2022-12-31';


-- Step 2:
-- Include only delivered and returned orders.

SELECT order_id,
       customer_id,
       order_date,
       status
FROM orders
WHERE order_date BETWEEN '2022-01-01'
                     AND '2022-12-31'
AND status IN ('delivered', 'returned');


-- Step 3:
-- Connect qualifying orders with customer information.

SELECT customers.customer_id,
       customers.customer_name,
       customers.city,
       orders.order_id,
       orders.order_date,
       orders.status
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.order_date BETWEEN '2022-01-01'
                            AND '2022-12-31'
AND orders.status IN ('delivered', 'returned');


-- Step 4:
-- Calculate spending by customer.

SELECT customers.customer_id,
       customers.customer_name,
       customers.city,
       SUM(orders.quantity * orders.unit_price) AS total_spending
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.order_date BETWEEN '2022-01-01'
                            AND '2022-12-31'
AND orders.status IN ('delivered', 'returned')
GROUP BY customers.customer_id,
         customers.customer_name,
         customers.city;


-- Step 5:
-- Add order count, first order date, and last order date.

SELECT customers.customer_id,
       customers.customer_name,
       customers.city,
       SUM(orders.quantity * orders.unit_price) AS total_spending,
       COUNT(*) AS number_of_orders,
       MIN(orders.order_date) AS first_order_date,
       MAX(orders.order_date) AS last_order_date
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.order_date BETWEEN '2022-01-01'
                            AND '2022-12-31'
AND orders.status IN ('delivered', 'returned')
GROUP BY customers.customer_id,
         customers.customer_name,
         customers.city;


-- Step 6:
-- FINAL REPORT: TOP 5 CUSTOMERS BY TOTAL SPENDING.

SELECT customers.customer_id,
       customers.customer_name,
       customers.city,
       SUM(orders.quantity * orders.unit_price) AS total_spending,
       COUNT(*) AS number_of_orders,
       MIN(orders.order_date) AS first_order_date,
       MAX(orders.order_date) AS last_order_date
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
WHERE orders.order_date BETWEEN '2022-01-01'
                            AND '2022-12-31'
AND orders.status IN ('delivered', 'returned')
GROUP BY customers.customer_id,
         customers.customer_name,
         customers.city
ORDER BY total_spending DESC
LIMIT 5;


-- =========================================================
-- END OF WEEK 1 SQL ASSIGNMENT
-- ALL 16 LABS COMPLETED
-- =========================================================
