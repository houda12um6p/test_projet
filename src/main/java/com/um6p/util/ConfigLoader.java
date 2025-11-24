package com.um6p.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
    private static final Logger logger = LoggerFactory.getLogger(ConfigLoader.class);
    private static final Properties properties = new Properties();
    private static boolean loaded = false;

    static {
        loadProperties();
    }

    private static void loadProperties() {
        if (loaded) return;

        try (InputStream input = ConfigLoader.class.getClassLoader()
                .getResourceAsStream("application.properties")) {

            if (input == null) {
                logger.error("Unable to find application.properties");
                throw new RuntimeException("Configuration file not found");
            }

            properties.load(input);
            loaded = true;
            logger.info("Configuration loaded successfully");

        } catch (IOException ex) {
            logger.error("Error loading application.properties", ex);
            throw new RuntimeException("Failed to load configuration", ex);
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }

    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }

    public static int getIntProperty(String key, int defaultValue) {
        String value = properties.getProperty(key);
        if (value == null) return defaultValue;
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            logger.warn("Invalid integer value for property {}: {}", key, value);
            return defaultValue;
        }
    }

    public static double getDoubleProperty(String key, double defaultValue) {
        String value = properties.getProperty(key);
        if (value == null) return defaultValue;
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            logger.warn("Invalid double value for property {}: {}", key, value);
            return defaultValue;
        }
    }

    public static boolean getBooleanProperty(String key, boolean defaultValue) {
        String value = properties.getProperty(key);
        if (value == null) return defaultValue;
        return Boolean.parseBoolean(value);
    }

    // Specific getters for common configuration values
    public static String getDbUrl() {
        return getProperty("db.url");
    }

    public static String getDbUsername() {
        return getProperty("db.username");
    }

    public static String getDbPassword() {
        return getProperty("db.password");
    }

    public static String getDbDriver() {
        return getProperty("db.driver");
    }

    public static int getMaxBorrowingLimit() {
        return getIntProperty("borrowing.max.limit", 5);
    }

    public static int getBorrowingPeriodDays() {
        return getIntProperty("borrowing.period.days", 14);
    }

    public static double getBorrowingFinePerDay() {
        return getDoubleProperty("borrowing.fine.per.day", 5.0);
    }

    public static int getSessionTimeoutMinutes() {
        return getIntProperty("session.timeout.minutes", 30);
    }

    public static boolean isCsrfEnabled() {
        return getBooleanProperty("security.csrf.enabled", true);
    }

    public static int getRateLimitMaxAttempts() {
        return getIntProperty("security.rate.limit.max.attempts", 5);
    }

    public static int getRateLimitWindowMinutes() {
        return getIntProperty("security.rate.limit.window.minutes", 15);
    }
}
