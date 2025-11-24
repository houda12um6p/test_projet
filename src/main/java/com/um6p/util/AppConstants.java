package com.um6p.util;

/**
 * Application-wide constants
 * Configuration values are loaded from application.properties via ConfigLoader
 */
public class AppConstants {

    // Borrowing Constants
    public static final int MAX_BORROWING_LIMIT = ConfigLoader.getMaxBorrowingLimit();
    public static final int BORROWING_PERIOD_DAYS = ConfigLoader.getBorrowingPeriodDays();
    public static final double BORROWING_FINE_PER_DAY = ConfigLoader.getBorrowingFinePerDay();

    // Session Constants
    public static final int SESSION_TIMEOUT_MINUTES = ConfigLoader.getSessionTimeoutMinutes();
    public static final int SESSION_TIMEOUT_SECONDS = SESSION_TIMEOUT_MINUTES * 60;

    // Security Constants
    public static final int RATE_LIMIT_MAX_ATTEMPTS = ConfigLoader.getRateLimitMaxAttempts();
    public static final int RATE_LIMIT_WINDOW_MINUTES = ConfigLoader.getRateLimitWindowMinutes();
    public static final boolean CSRF_ENABLED = ConfigLoader.isCsrfEnabled();

    // Book Status Constants
    public static final String BOOK_STATUS_AVAILABLE = "available";
    public static final String BOOK_STATUS_UNAVAILABLE = "unavailable";
    public static final String BOOK_STATUS_MAINTENANCE = "maintenance";

    // User Roles
    public static final String ROLE_STUDENT = "STUDENT";
    public static final String ROLE_STAFF = "STAFF";
    public static final String ROLE_ADMIN = "ADMIN";

    // Borrowing Status
    public static final String BORROWING_STATUS_BORROWED = "BORROWED";
    public static final String BORROWING_STATUS_RETURNED = "RETURNED";
    public static final String BORROWING_STATUS_OVERDUE = "OVERDUE";

    // Event Status
    public static final String EVENT_STATUS_ACTIVE = "active";
    public static final String EVENT_STATUS_CANCELLED = "cancelled";
    public static final String EVENT_STATUS_COMPLETED = "completed";

    // Registration Status
    public static final String REGISTRATION_STATUS_PENDING = "PENDING";
    public static final String REGISTRATION_STATUS_CONFIRMED = "CONFIRMED";
    public static final String REGISTRATION_STATUS_WAITLISTED = "WAITLISTED";
    public static final String REGISTRATION_STATUS_CANCELLED = "CANCELLED";
    public static final String REGISTRATION_STATUS_ATTENDED = "ATTENDED";

    // Reservation Status
    public static final String RESERVATION_STATUS_ACTIVE = "ACTIVE";
    public static final String RESERVATION_STATUS_PENDING = "PENDING";
    public static final String RESERVATION_STATUS_COMPLETED = "COMPLETED";
    public static final String RESERVATION_STATUS_CANCELLED = "CANCELLED";
    public static final String RESERVATION_STATUS_EXPIRED = "EXPIRED";

    // Notification Types
    public static final String NOTIFICATION_TYPE_EVENT_REGISTRATION = "EVENT_REGISTRATION";
    public static final String NOTIFICATION_TYPE_EVENT_CANCELLATION = "EVENT_CANCELLATION";
    public static final String NOTIFICATION_TYPE_BOOK_RESERVATION = "BOOK_RESERVATION";
    public static final String NOTIFICATION_TYPE_BOOK_READY = "BOOK_READY";
    public static final String NOTIFICATION_TYPE_BOOK_OVERDUE = "BOOK_OVERDUE";
    public static final String NOTIFICATION_TYPE_SYSTEM_ANNOUNCEMENT = "SYSTEM_ANNOUNCEMENT";

    // Reservation Expiry
    public static final int RESERVATION_EXPIRY_DAYS = 7;

    // Pagination
    public static final int DEFAULT_PAGE_SIZE = 20;
    public static final int MAX_PAGE_SIZE = 100;

    // Validation
    public static final int MIN_PASSWORD_LENGTH = 8;
    public static final int MAX_PASSWORD_LENGTH = 128;
    public static final int MIN_NAME_LENGTH = 2;
    public static final int MAX_NAME_LENGTH = 100;

    // File Upload
    public static final long MAX_FILE_SIZE = ConfigLoader.getIntProperty("upload.max.file.size", 10485760); // 10MB
    public static final String[] ALLOWED_FILE_EXTENSIONS =
            ConfigLoader.getProperty("upload.allowed.extensions", "pdf,doc,docx").split(",");

    private AppConstants() {
        // Prevent instantiation
    }
}
