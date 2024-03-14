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

DELIMITER //

CREATE PROCEDURE GetUserById(
    IN p_id INT
)
BEGIN
    SELECT name, email FROM users WHERE id = p_id;
END //

DELIMITER ;

CALL GetUserById(3);



DELIMITER //

CREATE PROCEDURE RetrieveUserProductOrder()
BEGIN
    -- Declare variables to store data retrieved from the tables
    DECLARE user_name VARCHAR(255);
    DECLARE product_name VARCHAR(255);
    DECLARE order_quantity INT;
    
    -- Cursor to fetch data from the users table
    DECLARE user_cursor CURSOR FOR
    SELECT name FROM users;
    
    -- Cursor to fetch data from the products table
    DECLARE product_cursor CURSOR FOR
    SELECT name FROM products;
    
    -- Cursor to fetch data from the orders table
    DECLARE order_cursor CURSOR FOR
    SELECT quantity FROM orders;
    
    -- Open user cursor and fetch data
    OPEN user_cursor;
    FETCH user_cursor INTO user_name;
    
    -- Open product cursor and fetch data
    OPEN product_cursor;
    FETCH product_cursor INTO product_name;
    
    -- Open order cursor and fetch data
    OPEN order_cursor;
    FETCH order_cursor INTO order_quantity;
    
    -- Loop through data and output
    WHILE (user_name IS NOT NULL AND product_name IS NOT NULL AND order_quantity IS NOT NULL) DO
        -- Output retrieved data
        SELECT user_name, product_name, order_quantity;
        
        -- Fetch next row from each cursor
        FETCH user_cursor INTO user_name;
        FETCH product_cursor INTO product_name;
        FETCH order_cursor INTO order_quantity;
    END WHILE;
    
    -- Close cursors
    CLOSE user_cursor;
    CLOSE product_cursor;
    CLOSE order_cursor;

     IF user_name IS NULL AND product_name IS NULL AND order_quantity IS NULL THEN
        SELECT 'No data found';
    END IF;
    

   
END //

DELIMITER ;


 CALL RetrieveUserProductOrder();
