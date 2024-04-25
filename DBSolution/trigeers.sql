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
    (1, 'John Smith', 85.5),
    (2, 'Jane Doe', 92.0);

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

Select * from students;

Select * from grades;

USE classicmodels;

-- Insert a new grade for StudentID 1 within the same transaction
START TRANSACTION;
INSERT INTO Grades (GradeID, StudentID, Grade)
VALUES (4, 1, 92.0);
COMMIT;

-- Query the Students table to see the updated data
SELECT * FROM Students;

