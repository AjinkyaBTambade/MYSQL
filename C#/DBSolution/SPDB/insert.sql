
DELIMITER //

CREATE PROCEDURE CreateNewUser(
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255)
)
BEGIN
    INSERT INTO users (name, email) VALUES (p_name, p_email);
END //

DELIMITER ;
