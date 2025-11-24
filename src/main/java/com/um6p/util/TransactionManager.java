package com.um6p.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.function.Function;

public class TransactionManager {
    private static final Logger logger = LoggerFactory.getLogger(TransactionManager.class);

    /**
     * Execute a database operation within a transaction
     * Automatically commits on success and rolls back on failure
     */
    public static <T> T executeInTransaction(Function<Connection, T> operation) throws SQLException {
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            connection.setAutoCommit(false);

            logger.debug("Transaction started");
            T result = operation.apply(connection);

            connection.commit();
            logger.debug("Transaction committed successfully");
            return result;

        } catch (Exception e) {
            if (connection != null) {
                try {
                    connection.rollback();
                    logger.warn("Transaction rolled back due to error: {}", e.getMessage());
                } catch (SQLException rollbackEx) {
                    logger.error("Failed to rollback transaction", rollbackEx);
                }
            }
            throw new SQLException("Transaction failed: " + e.getMessage(), e);
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    logger.error("Error closing connection", e);
                }
            }
        }
    }

    /**
     * Execute a void database operation within a transaction
     */
    public static void executeInTransaction(TransactionOperation operation) throws SQLException {
        Connection connection = null;
        try {
            connection = DatabaseConnection.getConnection();
            connection.setAutoCommit(false);

            logger.debug("Transaction started");
            operation.execute(connection);

            connection.commit();
            logger.debug("Transaction committed successfully");

        } catch (Exception e) {
            if (connection != null) {
                try {
                    connection.rollback();
                    logger.warn("Transaction rolled back due to error: {}", e.getMessage());
                } catch (SQLException rollbackEx) {
                    logger.error("Failed to rollback transaction", rollbackEx);
                }
            }
            throw new SQLException("Transaction failed: " + e.getMessage(), e);
        } finally {
            if (connection != null) {
                try {
                    connection.setAutoCommit(true);
                    connection.close();
                } catch (SQLException e) {
                    logger.error("Error closing connection", e);
                }
            }
        }
    }

    @FunctionalInterface
    public interface TransactionOperation {
        void execute(Connection connection) throws SQLException;
    }
}
