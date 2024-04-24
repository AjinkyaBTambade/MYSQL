-- Active: 1712217931410@@127.0.0.1@3306@demo_product
-- Create a sample table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100)
);

-- Insert some sample data
INSERT INTO employees (employee_id, employee_name) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Michael Johnson');

-- Create a stored procedure that uses a cursor
DELIMITER //

CREATE PROCEDURE process_employees()
BEGIN
    -- Declare variables to hold the cursor data
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(100);

    -- Declare a cursor
    DECLARE employee_cursor CURSOR FOR
        SELECT employee_id, employee_name FROM employees;

    -- Declare a continue handler to exit the loop when there are no more rows to fetch
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN employee_cursor;

    -- Start fetching rows
    fetch_loop: LOOP
        -- Fetch the next row into variables
        FETCH employee_cursor INTO emp_id, emp_name;

        -- Check if there are no more rows to fetch
        IF done THEN
            LEAVE fetch_loop;
        END IF;

        -- Process the current row (example: print the employee details)
        SELECT CONCAT('Employee ID: ', emp_id, ', Employee Name: ', emp_name);

    END LOOP;

    -- Close the cursor
    CLOSE employee_cursor;
END //

DELIMITER ;

-- Call the stored procedure
CALL process_employees();
