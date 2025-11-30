package com.um6p.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;
import java.util.logging.Level;

public class DatabaseConnection {
    private static final Logger logger = Logger.getLogger(DatabaseConnection.class.getName());

    // Database configuration - Using environment variables for security
    private static final String URL = System.getenv("DB_URL") != null ?
        System.getenv("DB_URL") :
        "jdbc:mysql://localhost:3306/um6p_learning_center?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = System.getenv("DB_USERNAME") != null ?
        System.getenv("DB_USERNAME") :
        "root";
    private static final String PASSWORD = System.getenv("DB_PASSWORD") != null ?
        System.getenv("DB_PASSWORD") :
        "Informatique12@!"; // Default for development only - SET DB_PASSWORD environment variable in production!

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            logger.info("MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Failed to load MySQL JDBC Driver", e);
            throw new RuntimeException("Database driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    // Helper method for safe connection closing
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Error closing database connection", e);
            }
        }
    }

    // Test connection method
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database connection test failed", e);
            return false;
        }
    }
}