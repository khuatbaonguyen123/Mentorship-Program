import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
    // Database credentials
    private String url;
    private String user;
    private String password;
    private Connection connection;

    // Constructor to initialize the connection details
    public DatabaseConnector(String databaseName, String user, String password) {
        this.url = "jdbc:mysql://localhost:3306/" + databaseName; // JDBC URL for MySQL
        this.user = user;
        this.password = password;
    }

    // Method to establish the connection
    public Connection connect() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection(url, user, password);
            System.out.println("Connection successful!");
        }
        return connection;
    }

    // Method to close the connection
    public void disconnect() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Connection closed.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Optional: Get the connection object
    public Connection getConnection() {
        return connection;
    }
}
