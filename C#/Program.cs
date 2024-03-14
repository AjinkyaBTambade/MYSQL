using System;
using MySql.Data.MySqlClient;

namespace ConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            string connectionString = "server=localhost;user=root;password=password;database=SP";

            try
            {
                // CreateNewUser stored procedure
                string newName = "Ajinkya";
                string newEmail = "Ajinkya@example.com";

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    // Insert new user
                    using (MySqlCommand cmd = new MySqlCommand("CreateNewUser", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@p_name", newName);
                        cmd.Parameters.AddWithValue("@p_email", newEmail);

                        cmd.ExecuteNonQuery();
                    }

                    Console.WriteLine("User created successfully!");
                    
                    // UpdateUser stored procedure
                    int userIdToUpdate = 1;
                    string updatedName = "Akash";
                    string updatedEmail = "akash@example.com";

                    // Update user
                    using (MySqlCommand cmd = new MySqlCommand("UpdateUser", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@p_id", userIdToUpdate);
                        cmd.Parameters.AddWithValue("@p_name", updatedName);
                        cmd.Parameters.AddWithValue("@p_email", updatedEmail);

                        cmd.ExecuteNonQuery();
                    }

                    Console.WriteLine("User updated successfully!");
                    
                    // DeleteUser stored procedure
                    int userIdToDelete = 1;

                    // Delete user
                    using (MySqlCommand cmd = new MySqlCommand("DeleteUser", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@p_id", userIdToDelete);

                        cmd.ExecuteNonQuery();
                    }

                    Console.WriteLine("User deleted successfully!");
                    
                    // RetrieveUserProductOrder stored procedure
                    using (MySqlCommand cmd = new MySqlCommand("RetrieveUserProductOrder", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                // Read and process retrieved data
                                string userName = reader.GetString(0);
                                string productName = reader.GetString(1);
                                int orderQuantity = reader.GetInt32(2);

                                Console.WriteLine($"User: {userName}, Product: {productName}, Order Quantity: {orderQuantity}");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }

            Console.ReadLine();
        }
    }
}
