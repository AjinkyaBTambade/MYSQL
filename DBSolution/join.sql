-- Active: 1712217931410@@127.0.0.1@3306@demo_product
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
