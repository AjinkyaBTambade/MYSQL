-- Active: 1712217931410@@127.0.0.1@3306@classicmodels
use classicmodels;

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Create products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    unit_price DECIMAL(10, 2)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into customers table
INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith');

-- Insert sample data into products table
INSERT INTO products (product_id, product_name, unit_price) VALUES
(1, 'Product A', 10.00),
(2, 'Product B', 15.00);

-- Insert sample data into orders table
INSERT INTO orders (order_id, customer_id, product_id, quantity) VALUES
(1, 1, 1, 5),
(2, 2, 2, 3),
(3, 1, 2, 2);

-- Create a stored procedure to calculate total order amounts
DELIMITER //

CREATE PROCEDURE calculate_order_total_amount()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE current_order_id INT;
    DECLARE current_customer_name VARCHAR(100);
    DECLARE current_product_name VARCHAR(100);
    DECLARE current_quantity INT;
    DECLARE current_unit_price DECIMAL(10, 2);
    DECLARE current_total_amount DECIMAL(10, 2);

    -- Declare a cursor to fetch data from orders table
    DECLARE orders_cursor CURSOR FOR
        SELECT o.order_id, c.customer_name, p.product_name, o.quantity, p.unit_price
        FROM orders o
        INNER JOIN customers c ON o.customer_id = c.customer_id
        INNER JOIN products p ON o.product_id = p.product_id;

    -- Declare a continue handler to exit the loop when there are no more rows to fetch
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN orders_cursor;

    -- Start fetching rows
    fetch_loop: LOOP
        -- Fetch the next row into variables
        FETCH orders_cursor INTO current_order_id, current_customer_name, current_product_name, current_quantity, current_unit_price;

        -- Check if there are no more rows to fetch
        IF done THEN
            LEAVE fetch_loop;
        END IF;

        -- Calculate total amount for the order
        SET current_total_amount = current_quantity * current_unit_price;

        -- Print the order details and total amount
        SELECT CONCAT('Order ID: ', current_order_id, ', Customer: ', current_customer_name, ', Product: ', current_product_name, ', Quantity: ', current_quantity, ', Total Amount: ', current_total_amount);

    END LOOP;

    CLOSE orders_cursor;
END //

DELIMITER ;

-- Call the stored procedure
CALL calculate_order_total_amount();





# Cursors in Database Management Systems

## Overview

In database management systems (DBMS), a cursor is a database object that enables traversal over the records in a result set. Cursors provide a mechanism for iterating through the rows returned by a query, allowing for sequential processing of the data.

## Types of Cursors

### 1. Implicit Cursors
   - These cursors are automatically created by the DBMS when a SQL statement is executed. They are suitable for simple queries that return a single result set.

### 2. Explicit Cursors
   - These cursors are explicitly declared by the programmer and provide more control over the result set traversal. They are suitable for complex queries that require multiple steps or conditions.

## Cursor Operations

1. **Opening a Cursor**: Cursors must be explicitly opened before fetching data from them.

2. **Fetching Data**: Data can be fetched from the cursor one row at a time or in bulk, depending on the requirements.

3. **Closing a Cursor**: After processing is complete, the cursor should be closed to release associated resources.

4. **Error Handling**: Cursors should include error handling logic to handle exceptions that may occur during cursor operations.

## Purpose of Cursors

1. **Row-by-Row Processing**: Cursors enable row-by-row processing of query results, allowing for operations such as data manipulation, validation, or transformation.

2. **Scrollable Result Sets**: Cursors can provide scrollable access to result sets, allowing for forward-only or bi-directional traversal of the data.

3. **Complex Data Processing**: Cursors are useful for processing complex queries that involve joins, aggregations, or conditional logic.

4. **Cursor Variables**: Cursor variables allow for dynamic cursor operations, enabling the execution of dynamic SQL statements or parameterized queries.

## Best Practices

1. **Minimize Cursor Usage**: Cursors can introduce overhead and reduce performance, so they should be used judiciously, especially for large result sets.

2. **Optimize Query Performance**: Before using a cursor, consider optimizing the underlying query to minimize the amount of data processed.

3. **Close Cursors Promptly**: Always close cursors promptly after they are no longer needed to release database resources.

4. **Avoid Long Transactions**: Cursors should be used within short-lived transactions to minimize locking and contention issues.

