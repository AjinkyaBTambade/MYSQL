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


# Triggers in Database Management Systems

## Overview

Triggers are special types of stored procedures in database management systems (DBMS) that are automatically executed or fired in response to specific events or actions occurring in a database. These events typically include data manipulation operations such as INSERT, UPDATE, or DELETE statements on tables within the database.

## Types of Triggers

### 1. Before Triggers
   - These triggers are fired before the triggering action occurs (e.g., before an INSERT, UPDATE, or DELETE operation).

### 2. After Triggers
   - These triggers are fired after the triggering action has executed successfully.

### 3. Instead Of Triggers
   - These triggers are fired instead of the triggering action and are often used for views in DBMSs that support them.

## Purpose of Triggers

1. **Enforcing Data Integrity**: Triggers can enforce complex business rules and constraints to ensure data integrity within the database.

2. **Implementing Business Logic**: Triggers enable the implementation of business logic directly within the database, ensuring consistency and reducing the need for application-level checks.

3. **Auditing and Logging**: Triggers can be used to log changes made to the database, providing an audit trail for compliance and security purposes.

4. **Derived Data Maintenance**: Triggers can maintain derived or computed columns, ensuring that they remain up-to-date based on changes in other data.

5. **Data Transformation**: Triggers allow for data transformation or validation before it is inserted into or updated in a table.

## Best Practices

1. **Careful Design**: Design triggers carefully to ensure they meet the desired functionality without introducing unnecessary complexity.

2. **Testing**: Thoroughly test triggers to verify their behavior and ensure they do not cause unintended side effects.

3. **Performance Considerations**: Be mindful of performance implications when using triggers, as they can introduce overhead to database operations.

4. **Documentation**: Document triggers clearly, including their purpose, behavior, and any dependencies they may have.

## Examples

For examples of trigger implementations in specific database systems, refer to the documentation and resources provided by the respective database vendors.

## References

- [MySQL Documentation: Triggers](https://dev.mysql.com/doc/refman/8.0/en/triggers.html)
- [PostgreSQL Documentation: Triggers](https://www.postgresql.org/docs/current/plpgsql-trigger.html)
- [Microsoft SQL Server Documentation: Triggers](https://docs.microsoft.com/en-us/sql/relational-databases/triggers/ddl-triggers?view=sql-server-ver15)
