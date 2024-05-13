-- Create database
CREATE DATABASE IF NOT EXISTS SP;

-- Use the database
USE SP;




-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    description TEXT
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);




-- Insert sample data into the users table
INSERT INTO users (name) VALUES
('AJ'),
('Belly'),
('Bob');

-- Insert sample data into the products table
INSERT INTO products (name) VALUES
('Product D'),
('Product E'),
('Product F');

-- Insert sample data into the orders table
INSERT INTO orders (quantity) VALUES
(15),
(12),
(110);

SELECT * FROM users;

SELECT * FROM products;

SELECT * FROM orders;

