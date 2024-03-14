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

                    using (MySqlCommand cmd = new MySqlCommand("CreateNewUser", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@p_name", newName);
                        cmd.Parameters.AddWithValue("@p_email", newEmail);

                        cmd.ExecuteNonQuery();
                    }

                    Console.WriteLine("User created successfully!");
                }

                // UpdateUser stored procedure
                int userIdToUpdate = 1;
                string updatedName = "Akash";
                string updatedEmail = "akash@example.com";

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    using (MySqlCommand cmd = new MySqlCommand("UpdateUser", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@p_id", userIdToUpdate);
                        cmd.Parameters.AddWithValue("@p_name", updatedName);
                        cmd.Parameters.AddWithValue("@p_email", updatedEmail);

                        cmd.ExecuteNonQuery();
                    }

                    Console.WriteLine("User updated successfully!");
                }

                // DeleteUser stored procedure
                int userIdToDelete = 5;

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    using (MySqlCommand cmd = new MySqlCommand("DeleteUser", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@p_id", userIdToDelete);

                        cmd.ExecuteNonQuery();
                    }

                    Console.WriteLine("User deleted successfully!");
                }

                // GetUserById stored procedure
                int userIdToGet = 15;

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    conn.Open();

                    using (MySqlCommand cmd = new MySqlCommand("GetUserById", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@p_id", userIdToGet);

                        using (MySqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string name = reader.GetString("name");
                                string email = reader.GetString("email");
                                
                                Console.WriteLine($"Name: {name}, Email: {email}");
                            }
                            else
                            {
                                Console.WriteLine("User not found!");
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
