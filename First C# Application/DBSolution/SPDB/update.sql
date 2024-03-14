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
