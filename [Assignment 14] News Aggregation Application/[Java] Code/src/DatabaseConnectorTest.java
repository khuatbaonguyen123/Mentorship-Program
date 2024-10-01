import org.junit.Assert;
import org.junit.Test;

import java.sql.Connection;
import java.sql.SQLException;

class DatabaseConnectorTest {
    private DatabaseConnector dbConnector;

    @Test
    void testConnect() {
        dbConnector = new DatabaseConnector("database_name", "username", "password");

        try {
            Connection connection = dbConnector.connect();
            Assert.assertNotNull("Connection should not be null", connection);
            Assert.assertFalse(connection.isClosed());
        } catch (SQLException e) {
            Assert.fail("Should not throw SQLException: " + e.getMessage());
        }

        dbConnector.disconnect();
    }

    @Test
    void testDisconnect() {
        dbConnector = new DatabaseConnector("your_database_name", "your_username", "your_password");

        try {
            dbConnector.connect(); // Establish connection first
            dbConnector.disconnect(); // Then disconnect
            Assert.assertTrue(dbConnector.getConnection().isClosed());
        } catch (SQLException e) {
            Assert.fail("Should not throw SQLException: " + e.getMessage());
        }
    }
}
