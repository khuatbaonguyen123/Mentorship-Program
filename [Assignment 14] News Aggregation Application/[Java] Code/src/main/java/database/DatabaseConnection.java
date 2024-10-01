package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/news_aggregation";
    private static final String USER = "root";
    private static final String PASSWORD = "password";
    private static Connection connection;

    // Private constructor to prevent instantiation
    private DatabaseConnection() { }

    // Method to get the connection instance
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Database connection established.");
            } catch (SQLException e) {
                System.err.println("Failed to establish a database connection.");
                throw e;  // Re-throwing exception after logging it
            }
        }
        return connection;
    }

    // Method to close the connection
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                System.err.println("Failed to close the database connection.");
                e.printStackTrace();
            }
        }
    }
}
