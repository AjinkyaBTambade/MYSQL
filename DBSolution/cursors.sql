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




