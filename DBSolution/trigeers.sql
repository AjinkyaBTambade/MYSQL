-- Active: 1712217931410@@127.0.0.1@3306@classicmodels
USE classicmodels;

-- Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    AverageGrade FLOAT
);

-- Create Grades table
CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    StudentID INT,
    Grade FLOAT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- Insert sample data into Students table
INSERT INTO Students (StudentID, Name, AverageGrade)
VALUES 
    (1, 'Ajinkya Tambade', 85.5),
    (2, 'Shridhar Patil', 92.0);

-- Insert sample data into Grades table
INSERT INTO Grades (GradeID, StudentID, Grade)
VALUES 
    (1, 1, 90.0),
    (2, 1, 88.0),
    (3, 2, 95.0);

-- Change delimiter to create trigger with compound statement
DELIMITER //

-- Create trigger to update AverageGrade in Students table
CREATE TRIGGER UpdateAverageGrade
AFTER INSERT ON Grades
FOR EACH ROW
BEGIN
    DECLARE total_grades FLOAT;
    DECLARE num_grades INT;
    SELECT SUM(Grade), COUNT(*) INTO total_grades, num_grades
    FROM Grades
    WHERE StudentID = NEW.StudentID;

    UPDATE Students
    SET AverageGrade = total_grades / num_grades
    WHERE StudentID = NEW.StudentID;
END//

-- Reset delimiter
DELIMITER ;


-- Insert a new grade for StudentID 1 within the same transaction
START TRANSACTION;
INSERT INTO Grades (GradeID, StudentID, Grade)
VALUES (4, 1, 92.0);
COMMIT;

-- Query the Students table to see the updated data
SELECT * FROM Students;

Select * from grades;

USE classicmodels;

----------------------------------------------------------------------------------------------------

drop database HRDB;
CREATE database HRDB;
use HRDB;
 
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
 
 
-- create a trigger named update_last_updated that updates the last_updated column
--  whenever a row is inserted or updated in the employees table
DELIMITER //
CREATE TRIGGER update_last_updated
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
SET NEW.last_updated = current_timestamp();
END;
//
 
 
CREATE TRIGGER update_last_updated_on_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.last_updated = CURRENT_TIMESTAMP;
END;
//
DELIMITER ;
 
 
-- after   defining table   try to write  DML queries to test triggers are working
-- as per expectation of buisiness logic
 
-- Insert a new employee
INSERT INTO employees (name, department) VALUES ('Ravi Tambade', 'training');
 
-- Update existing record
 
UPDATE  employees  SET department="BOD" WHERE id=1;

SELECT * FROM employees;

