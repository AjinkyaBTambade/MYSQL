/* Creating the database */
DROP DATABASE TFLDB;
CREATE DATABASE TFLDB;
USE TFLDB;

/* Creating tables */
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT,
    employee_name VARCHAR(100),
    department_id INT,
    PRIMARY KEY (employee_id)
);

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT,
    department_name VARCHAR(100),
    PRIMARY KEY (department_id)
);

CREATE TABLE projects (
    project_id INT AUTO_INCREMENT,
    project_name VARCHAR(100),
    department_id INT,
    PRIMARY KEY (project_id)
);

/* Inserting data into tables */
INSERT INTO employees (employee_name, department_id) VALUES
('Ajinkya', 1),
('Bhupendra', 2),
('Ritesh', 3),
('Shridhar', 1),
('Nayan', 2);

INSERT INTO departments (department_name) VALUES
('HR'),
('Engineering'),
('Marketing');

INSERT INTO projects (project_name, department_id) VALUES
('TFL Portal', 1),
('TFL Assesment ', 2),
('Common Services', 3),
('TFL E-Krushi ', 1),
('TFL GreenHouse', 2);


/* Inner Join: Retrieve employees along with their department names */
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

/* Left Join: Retrieve all employees along with their department names, including those without a department */
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

/* Right Join: Retrieve all departments along with their employees, including departments without employees */
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

/* Full Outer Join: Retrieve all employees and departments, including those without a match */
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
UNION
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;


/* Cross Join: Retrieve all possible combinations of employees and projects */
SELECT e.employee_name, p.project_name
FROM employees e
CROSS JOIN projects p;


/* Self Join: Retrieve pairs of employees who are in the same department */
SELECT e1.employee_name AS employee1, e2.employee_name AS employee2, d.department_name
FROM employees e1
INNER JOIN employees e2 ON e1.department_id = e2.department_id AND e1.employee_id <> e2.employee_id
INNER JOIN departments d ON e1.department_id = d.department_id;
