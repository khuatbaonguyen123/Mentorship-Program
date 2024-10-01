import org.junit.jupiter.api.Test;

import database.DatabaseConnection;

import org.junit.jupiter.api.Assertions;
import java.sql.Connection;
import java.sql.SQLException;

class DatabaseConnectionTest {

    @Test
    void testGetConnection() {
        Connection connection = null;
        try {
            // Get the database connection
            connection = DatabaseConnection.getConnection();

            // Test that the connection is not null and is open
            Assertions.assertNotNull(connection, "Connection should not be null");
            Assertions.assertFalse(connection.isClosed(), "Connection should be open");

        } catch (SQLException e) {
            Assertions.fail("Connection failed with SQLException: " + e.getMessage());
        } finally {
            // Ensure the connection is closed after the test
            if (connection != null) {
                DatabaseConnection.closeConnection();
            }
        }
    }

    @Test
    void testCloseConnection() {
        Connection connection = null;
        try {
            // Get the connection first
            connection = DatabaseConnection.getConnection();

            // Close the connection
            DatabaseConnection.closeConnection();

            // Test that the connection is closed
            Assertions.assertTrue(connection.isClosed(), "Connection should be closed after calling closeConnection");
            
        } catch (SQLException e) {
            Assertions.fail("Connection closing failed with SQLException: " + e.getMessage());
        }
    }
}
