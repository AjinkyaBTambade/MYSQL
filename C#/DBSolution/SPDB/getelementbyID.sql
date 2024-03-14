DELIMITER //

CREATE PROCEDURE GetUserById(
    IN p_id INT
)
BEGIN
    SELECT name, email FROM users WHERE id = p_id;
END //

DELIMITER ;
