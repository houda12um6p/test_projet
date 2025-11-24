package com.um6p.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseConnection.class);
    private static HikariDataSource dataSource;

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName(ConfigLoader.getDbDriver());
            logger.info("MySQL JDBC Driver loaded successfully");

            // Initialize HikariCP connection pool
            initializeDataSource();
        } catch (ClassNotFoundException e) {
            logger.error("Failed to load MySQL JDBC Driver", e);
            throw new RuntimeException("Database driver not found", e);
        }
    }

    private static void initializeDataSource() {
        try {
            HikariConfig config = new HikariConfig();

            // Basic connection settings
            config.setJdbcUrl(ConfigLoader.getDbUrl());
            config.setUsername(ConfigLoader.getDbUsername());
            config.setPassword(ConfigLoader.getDbPassword());
            config.setDriverClassName(ConfigLoader.getDbDriver());

            // Pool configuration
            config.setMaximumPoolSize(ConfigLoader.getIntProperty("db.pool.maximumPoolSize", 10));
            config.setMinimumIdle(ConfigLoader.getIntProperty("db.pool.minimumIdle", 2));
            config.setConnectionTimeout(ConfigLoader.getIntProperty("db.pool.connectionTimeout", 30000));
            config.setIdleTimeout(ConfigLoader.getIntProperty("db.pool.idleTimeout", 600000));
            config.setMaxLifetime(ConfigLoader.getIntProperty("db.pool.maxLifetime", 1800000));
            config.setAutoCommit(ConfigLoader.getBooleanProperty("db.pool.autoCommit", true));

            // Performance optimizations
            config.addDataSourceProperty("cachePrepStmts",
                ConfigLoader.getProperty("db.pool.cachePrepStmts", "true"));
            config.addDataSourceProperty("prepStmtCacheSize",
                ConfigLoader.getProperty("db.pool.prepStmtCacheSize", "250"));
            config.addDataSourceProperty("prepStmtCacheSqlLimit",
                ConfigLoader.getProperty("db.pool.prepStmtCacheSqlLimit", "2048"));
            config.addDataSourceProperty("useServerPrepStmts", "true");

            // Connection pool name for monitoring
            config.setPoolName("UM6P-HikariPool");

            // Health check
            config.setConnectionTestQuery("SELECT 1");

            dataSource = new HikariDataSource(config);
            logger.info("HikariCP connection pool initialized successfully");
        } catch (Exception e) {
            logger.error("Failed to initialize HikariCP connection pool", e);
            throw new RuntimeException("Failed to initialize database connection pool", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource is not initialized");
        }
        return dataSource.getConnection();
    }

    // Helper method for safe connection closing
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                logger.warn("Error closing database connection", e);
            }
        }
    }

    // Test connection method
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            logger.error("Database connection test failed", e);
            return false;
        }
    }

    // Graceful shutdown of connection pool
    public static void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            logger.info("HikariCP connection pool shut down successfully");
        }
    }

    // Get pool statistics for monitoring
    public static String getPoolStats() {
        if (dataSource != null) {
            return String.format("Active: %d, Idle: %d, Total: %d, Waiting: %d",
                dataSource.getHikariPoolMXBean().getActiveConnections(),
                dataSource.getHikariPoolMXBean().getIdleConnections(),
                dataSource.getHikariPoolMXBean().getTotalConnections(),
                dataSource.getHikariPoolMXBean().getThreadsAwaitingConnection());
        }
        return "DataSource not initialized";
    }
}
