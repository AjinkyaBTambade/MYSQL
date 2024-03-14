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
