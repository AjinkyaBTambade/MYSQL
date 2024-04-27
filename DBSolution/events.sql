-- Active: 1712217931410@@127.0.0.1@3306@classicmodels
-- Create the example database
USE classicmodels;

-- Create the example table
CREATE TABLE IF NOT EXISTS Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    value INT
);

-- Insert sample data into the example table
INSERT INTO Users (value) VALUES (10), (20), (30);

-- Create the event
DELIMITER //
SET GLOBAL event_scheduler = ON;
CREATE EVENT IF NOT EXISTS update_values_event
ON SCHEDULE EVERY 10 SECOND
DO
BEGIN
    UPDATE Users SET value = value + 5;
END//
DELIMITER ;

-- Select all records from the Users table to observe the updates
SELECT * FROM Users;


--------------------------------------------------------------------------------------------------------------------


-- Create the example table
CREATE TABLE IF NOT EXISTS SensorData (
    id INT AUTO_INCREMENT PRIMARY KEY,
    temperature FLOAT,
    humidity FLOAT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into the example table
INSERT INTO SensorData (temperature, humidity) VALUES (20.5, 60.2), (21.0, 59.8), (20.8, 61.5), (22.3, 58.9);

-- Create the event to update sensor data every 5 seconds
DELIMITER //
SET GLOBAL event_scheduler = ON;
CREATE EVENT IF NOT EXISTS update_sensor_data_event
ON SCHEDULE EVERY 5 SECOND
DO
BEGIN
    INSERT INTO SensorData (temperature, humidity) 
    VALUES (RAND() * 10 + 20, RAND() * 10 + 60); -- Generate random data within a certain range
END//
DELIMITER ;

SELECT * FROM SensorData;


-- Show the status of the event scheduler
SHOW VARIABLES LIKE 'event_scheduler';
