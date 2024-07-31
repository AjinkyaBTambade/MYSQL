-- Create new user
 use sp;
 
 DROP PROCEDURE IF EXISTS CreateNewUser;
 
DELIMITER //

CREATE PROCEDURE CreateNewUser(
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255)
)
BEGIN
    INSERT INTO users (name, email) VALUES (p_name, p_email);
END //

DELIMITER ;

CALL CreateNewUser('Ajinkya Tambade', 'ajinkya@gmail.com');



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

CALL UpdateUser(1, 'Shridhar', 'shri@gmail.com');




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
    INSERT INTO users (name) VALUES ('Ash'), ('Ram'), ('Sham');
    INSERT INTO products (name) VALUES ('Product A'), ('Product B'), ('Product C');
    INSERT INTO orders (user_id, product_id, quantity) VALUES
        (2, 1, 10),
        (3, 2, 5), 
        (2, 3, 8);  

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


-------------------------------------------------------------------------------------------------------
-- Complex Store Procedure--

create database warehouse;
use warehouse;
 
-- Create the Inventory table
CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL
);
 
-- Create the ChangeLog table
CREATE TABLE ChangeLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    QuantityChange INT,
    UpdatedBy VARCHAR(50),
    ChangeDate DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Inventory(ProductID)
);
 
-- Insert sample data into Inventory
INSERT INTO Inventory (ProductID, ProductName, Quantity)
VALUES (1, 'Widget A', 100),
		(2, 'Widget B', 150),
		(3, 'Widget C', 200);
 
 
DELIMITER //
 
CREATE PROCEDURE UpdateInventory(
    IN p_ProductID INT,
    IN p_QuantityChange INT,
    IN p_UpdatedBy VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction on error
        ROLLBACK;
    END;
 
    -- Start a transaction
    START TRANSACTION;
 
    -- Update the inventory table
    UPDATE Inventory
    SET Quantity = Quantity + p_QuantityChange
    WHERE ProductID = p_ProductID;
 
    -- Check if the update was successful
    IF ROW_COUNT() = 0 THEN
        -- No rows affected, so the product ID might be invalid
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Product ID does not exist.';
    END IF;
 
    -- Insert a record into the ChangeLog table
    INSERT INTO ChangeLog (ProductID, QuantityChange, UpdatedBy, ChangeDate)
    VALUES (p_ProductID, p_QuantityChange, p_UpdatedBy, NOW());
 
    -- Commit the transaction
    COMMIT;
END //
 
DELIMITER ;
 
-- Invoking Stored Procedure
 
CALL UpdateInventory(1, 20, 'admin');
CALL UpdateInventory(2, 50, 'manager');
 