CREATE DATABASE banks;

USE banks;

CREATE TABLE users (
    id INT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255)
);

START TRANSACTION;

INSERT INTO users (id, username) 
VALUES (1, 'Ajinkya');


UPDATE users 
SET email = 'ajtheboss@gmail.com' 
WHERE id = 1;

SELECT * FROM users;

commit;

START TRANSACTION;
INSERT INTO users (id, username) 
VALUES (2, 'Shri');


UPDATE users 
SET email = 'shri@gmail.com' 
WHERE id = 2;

SELECT * FROM users;
-- commit;
rollback;

SELECT * FROM users;

CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT  PRIMARY KEY ,
    account_holder VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
);

CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_type ENUM('DEPOSIT', 'WITHDRAWAL') NOT NULL,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

INSERT INTO accounts (account_holder, balance) 
VALUES ('Ram', 1000.00),
       ('Sham', 500.00);
       
select * from accounts;
 --   drop procedure transfer;   
DELIMITER //
CREATE PROCEDURE transfer(
    IN sender_id INT,
    IN receiver_id INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE rollback_message VARCHAR(255) DEFAULT 'Transaction rolled back: Insufficient funds';
    DECLARE commit_message VARCHAR(255) DEFAULT 'Transaction committed successfully';

    -- Start the transaction
    START TRANSACTION;

    -- Attempt to debit money from account 1
    UPDATE accounts SET balance = balance - amount WHERE account_id = sender_id;

    -- Attempt to credit money to account 2
    UPDATE accounts SET balance = balance + amount WHERE account_id = receiver_id;

    -- Check if there are sufficient funds in account 1
    -- Simulate a condition where there are insufficient funds
    IF (SELECT balance FROM accounts WHERE account_id = sender_id) < amount THEN
        -- Roll back the transaction if there are insufficient funds
        ROLLBACK;
        SELECT rollback_message AS 'Result';
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = rollback_message;
    ELSE
        -- Log the transactions if there are sufficient funds
        INSERT INTO transactions (account_id, amount, transaction_type) VALUES (sender_id, -amount, 'WITHDRAWAL');
        INSERT INTO transactions (account_id, amount, transaction_type) VALUES (receiver_id, amount, 'DEPOSIT');
        
        -- Commit the transaction
        COMMIT;
        SELECT commit_message AS 'Result';
    END IF;
END //

DELIMITER ;       

call transfer(1,2,50);
select * from transactions;
select * from accounts;
call transfer(2,1,50);