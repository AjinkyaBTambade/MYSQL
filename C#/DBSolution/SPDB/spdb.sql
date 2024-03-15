-- Create new user

DELIMITER //

CREATE PROCEDURE CreateNewUser(
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255)
)
BEGIN
    INSERT INTO users (name, email) VALUES (p_name, p_email);
END //

DELIMITER ;

CALL CreateNewUser('John Doe', 'john@example.com');



-- Update user
DROP PROCEDURE IF EXISTS UpdateUser;
DELIMITER //

CREATE PROCEDURE UpdateUser(
    IN p_id INT,
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255)
)
BEGIN
    UPDATE users SET name = p_name, email = p_email WHERE id = p_id;
END //

DELIMITER ;

CALL UpdateUser(1, 'Jane Smith', 'jane@example.com');




-- Delete user
DROP PROCEDURE IF EXISTS DeleteUser;
DELIMITER //

CREATE PROCEDURE DeleteUser(
    IN p_id INT
)
BEGIN
    DELETE FROM users WHERE id = p_id;
END //

DELIMITER ;

CALL DeleteUser(1);



-- Get user by ID
DROP PROCEDURE IF EXISTS GetUserById;
DELIMITER //

CREATE PROCEDURE GetUserById(
    IN p_id INT
)
BEGIN
    SELECT name, email FROM users WHERE id = p_id;
END //

DELIMITER ;

CALL GetUserById(3);

DROP PROCEDURE IF EXISTS RetrieveUserProductOrder;
DELIMITER //

CREATE PROCEDURE RetrieveUserProductOrder()
BEGIN
 -- Insert some sample data into the tables for demonstration
    INSERT INTO users (name) VALUES ('Alice'), ('Bob'), ('Charlie');
    INSERT INTO products (name) VALUES ('Product A'), ('Product B'), ('Product C');
    INSERT INTO orders (user_id, product_id, quantity) VALUES
        (1, 1, 10),
        (2, 2, 5), 
        (3, 3, 8);  

    -- Select data from the tables using joins
    SELECT users.name AS user_name, products.name AS product_name, orders.quantity AS order_quantity
    FROM orders
    JOIN users ON orders.user_id = users.id
    JOIN products ON orders.product_id = products.id;

    -- Check if there are no records
    IF NOT EXISTS (SELECT * FROM orders) THEN
        SELECT 'No data found';
    END IF;
END //

DELIMITER ;

CALL RetrieveUserProductOrder();
