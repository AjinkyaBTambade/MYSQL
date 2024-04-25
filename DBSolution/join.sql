-- Active: 1712217931410@@127.0.0.1@3306@classicmodels
/* Creating two tables */
CREATE TABLE members (
    member_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (member_id)
);

CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (committee_id)
);

/* Inserting data into tables */
INSERT INTO members(name)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');

INSERT INTO committees(name)
VALUES('John'),('Mary'),('Amelia'),('Joe'),('sahil');

/* Inner Join */
SELECT m.member_id, c.committee_id, c.name AS name
FROM members m INNER JOIN committees c ON m.name = c.name;

/* Inner Join with USING */
SELECT m.member_id, c.committee_id, c.name AS name
FROM members m INNER JOIN committees c USING(name);

/* Left Join */
SELECT m.member_id, m.name as name, c.committee_id, c.name AS name
FROM members m LEFT JOIN committees c  ON m.name = c.name;

/* Left Join with NULL values */
SELECT m.member_id, m.name as name, c.committee_id, c.name AS name
FROM members m LEFT JOIN committees c  ON m.name = c.name WHERE c.name IS NULL;

/* Right Join */
SELECT m.member_id, m.name AS member, c.committee_id, c.name AS committee
FROM members m RIGHT JOIN committees c USING (name);

/* Right Join with NULL values */
SELECT m.member_id, m.name AS member, c.committee_id, c.name AS committee
FROM members m RIGHT JOIN committees c USING (name) WHERE m.name IS NULL;

/* Cross Join */
SELECT m.member_id, m.name AS member, c.committee_id, c.name AS committee
FROM members m CROSS JOIN committees c;

/* Group By with Inner Join */
SELECT t1.orderNumber, t1.status, SUM(quantityOrdered * priceEach) AS total
FROM orders t1 INNER JOIN orderdetails t2 ON t1.orderNumber = t2.orderNumber
GROUP BY status;

/* Ordering with Inner Join */
SELECT o.orderNumber, orderDate, orderLineNumber, productCode, productName, quantityOrdered, priceEach
FROM orders o INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products USING (productCode)
ORDER BY orderNumber, orderLineNumber;

/* Join with Conditions */
SELECT orderNumber, productName, msrp, priceEach
FROM products p INNER JOIN orderdetails o ON p.productcode = o.productcode
WHERE p.msrp > o.priceEach AND p.buyPrice > 50;

/* Group By */
SELECT status, COUNT(*) FROM orders
GROUP BY status;

/* Group By with SUM */
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS total
FROM orderdetails
GROUP BY orderNumber
ORDER BY total DESC;

/* Group By with HAVING */
SELECT YEAR(orderDate) AS year, SUM(quantityOrdered * priceEach) AS total
FROM orders INNER JOIN orderdetails USING (orderNumber)
WHERE status = 'cancelled'
GROUP BY year
ORDER BY total DESC;

/* Group By with HAVING and Inner Join */
SELECT YEAR(orderDate) AS year, SUM(quantityOrdered * priceEach) AS total
FROM orders INNER JOIN orderdetails USING (orderNumber)
WHERE status = 'Shipped'
GROUP BY year HAVING year >= 2003;

/* Rollup with Group By */
SELECT YEAR(orderDate) AS year, ROUND(SUM(quantityOrdered*priceEach)) AS totalOrderValue
FROM orders, orderdetails
GROUP BY year WITH ROLLUP;

/* Exists Operator */
SELECT customerNumber, customerName
FROM customers
WHERE EXISTS (SELECT 1 FROM orders WHERE orders.customerNumber = customers.customerNumber);




# Joins in Database Management Systems

## Overview

In database management systems (DBMS), a join is an operation that combines rows from two or more tables based on a related column between them. Joins allow for the retrieval of related data from multiple tables, enabling complex queries and data analysis.

## Types of Joins

### 1. Inner Join
   - An inner join returns only the rows that have matching values in both tables based on the join condition.

### 2. Left Join (or Left Outer Join)
   - A left join returns all rows from the left table and matching rows from the right table, with null values for rows in the right table that have no match.

### 3. Right Join (or Right Outer Join)
   - A right join returns all rows from the right table and matching rows from the left table, with null values for rows in the left table that have no match.

### 4. Full Join (or Full Outer Join)
   - A full join returns all rows from both tables, matching rows from both tables where available, and null values for unmatched rows.

### 5. Cross Join
   - A cross join returns the Cartesian product of the two tables, resulting in a combination of every row from the first table with every row from the second table.

## Join Conditions

Join conditions specify how tables should be combined based on the values in their related columns. Common join conditions include:

- **Equality Join**: Joining tables based on the equality of values in their related columns.
- **Non-equality Join**: Joining tables based on non-equality comparisons, such as greater than or less than.
- **Multiple Join Conditions**: Joining tables based on multiple related columns.

## Purpose of Joins

1. **Retrieving Related Data**: Joins allow for the retrieval of related data from multiple tables, enabling comprehensive analysis and reporting.

2. **Data Normalization**: By storing related data in separate tables and using joins, databases can avoid data redundancy and maintain data integrity through normalization.

3. **Aggregating Data**: Joins facilitate the aggregation of data from multiple tables, enabling the calculation of summary statistics and metrics.

4. **Data Integration**: Joins are essential for integrating data from disparate sources or systems, enabling unified views and analysis.

## Best Practices

1. **Selecting Appropriate Join Type**: Choose the most appropriate join type based on the relationship between the tables and the desired result.

2. **Optimizing Queries**: Optimize join queries by indexing columns used in join conditions, minimizing the number of rows processed, and avoiding unnecessary joins.

3. **Understanding Performance Implications**: Be mindful of the performance implications of joins, especially for large tables or complex queries.

4. **Testing and Validation**: Test join queries thoroughly to ensure they return the expected results and validate their performance in different scenarios.


## References

- [MySQL Documentation: Join Syntax](https://dev.mysql.com/doc/refman/8.0/en/join.html)
- [PostgreSQL Documentation: Joins](https://www.postgresql.org/docs/current/queries-table-expressions.html#QUERIES-TABLES-JOIN)
- [Microsoft SQL Server Documentation: Joins](https://docs.microsoft.com/en-us/sql/t-sql/queries/from-transact-sql?view=sql-server-ver15#joins)
