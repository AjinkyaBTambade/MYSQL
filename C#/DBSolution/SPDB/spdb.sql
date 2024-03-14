-- Create new user
CALL CreateNewUser('John Doe', 'john@example.com');

-- Update user
CALL UpdateUser(1, 'Jane Smith', 'jane@example.com');

-- Delete user
CALL DeleteUser(2);

-- Get user by ID
CALL GetUserById(3);
