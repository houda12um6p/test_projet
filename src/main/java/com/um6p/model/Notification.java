package com.um6p.model;

public class Notification {
    // Notification type constants
    public static final String TYPE_EVENT_REGISTRATION = "event_registration";
    public static final String TYPE_EVENT_CANCELLATION = "event_cancellation";
    public static final String TYPE_BOOK_RESERVATION = "book_reservation";
    public static final String TYPE_BOOK_READY = "book_ready";
    public static final String TYPE_BOOK_OVERDUE = "book_overdue";
    public static final String TYPE_SYSTEM_ANNOUNCEMENT = "system_announcement";

    private int id;
    private int userId;
    private String title;
    private String message;
    private String type;
    private boolean isRead;
    private String createdDate;
    private String readDate;

    // Default Constructor
    public Notification() {
    }

    // Parameterized Constructor for existing notifications
    public Notification(int id, int userId, String title, String message, String type) {
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.message = message;
        this.type = type;
        this.isRead = false;
    }

    // Constructor for creating new notifications
    public Notification(int userId, String title, String message, String type) {
        this.userId = userId;
        this.title = title;
        this.message = message;
        this.type = type;
        this.isRead = false;
        this.createdDate = java.time.LocalDateTime.now().toString();
    }

    // Constructor for system announcements
    public Notification(String title, String message) {
        this.userId = 0; // 0 represents system-wide notification
        this.title = title;
        this.message = message;
        this.type = TYPE_SYSTEM_ANNOUNCEMENT;
        this.isRead = false;
        this.createdDate = java.time.LocalDateTime.now().toString();
    }

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getTitle() { return title; }
    public String getMessage() { return message; }
    public String getType() { return type; }
    public boolean isRead() { return isRead; }
    public String getCreatedDate() { return createdDate; }
    public String getReadDate() { return readDate; }

    // Setters with validation
    public void setId(int id) { this.id = id; }

    public void setUserId(int userId) {
        if (userId < 0) {
            throw new IllegalArgumentException("User ID cannot be negative");
        }
        this.userId = userId;
    }

    public void setTitle(String title) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Notification title cannot be null or empty");
        }
        this.title = title;
    }

    public void setMessage(String message) {
        if (message == null || message.trim().isEmpty()) {
            throw new IllegalArgumentException("Notification message cannot be null or empty");
        }
        this.message = message;
    }

    public void setType(String type) {
        if (!isValidType(type)) {
            throw new IllegalArgumentException("Invalid notification type: " + type);
        }
        this.type = type;
    }

    public void setRead(boolean read) {
        this.isRead = read;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public void setReadDate(String readDate) {
        this.readDate = readDate;
    }

    // Business logic methods
    public void markAsRead() {
        if (!isRead) {
            this.isRead = true;
            this.readDate = java.time.LocalDateTime.now().toString();
        }
    }

    public void markAsUnread() {
        this.isRead = false;
        this.readDate = null;
    }

    public boolean isSystemNotification() {
        return TYPE_SYSTEM_ANNOUNCEMENT.equals(type);
    }

    public boolean isEventRelated() {
        return TYPE_EVENT_REGISTRATION.equals(type) ||
                TYPE_EVENT_CANCELLATION.equals(type);
    }

    public boolean isBookRelated() {
        return TYPE_BOOK_RESERVATION.equals(type) ||
                TYPE_BOOK_READY.equals(type) ||
                TYPE_BOOK_OVERDUE.equals(type);
    }

    public boolean isForAllUsers() {
        return userId == 0;
    }

    public String getStatus() {
        return isRead ? "Read" : "Unread";
    }

    public String getTypeDescription() {
        switch (type) {
            case TYPE_EVENT_REGISTRATION: return "Event Registration";
            case TYPE_EVENT_CANCELLATION: return "Event Cancellation";
            case TYPE_BOOK_RESERVATION: return "Book Reservation";
            case TYPE_BOOK_READY: return "Book Ready for Pickup";
            case TYPE_BOOK_OVERDUE: return "Book Overdue";
            case TYPE_SYSTEM_ANNOUNCEMENT: return "System Announcement";
            default: return "Notification";
        }
    }

    // Validation helper
    private boolean isValidType(String type) {
        return TYPE_EVENT_REGISTRATION.equals(type) ||
                TYPE_EVENT_CANCELLATION.equals(type) ||
                TYPE_BOOK_RESERVATION.equals(type) ||
                TYPE_BOOK_READY.equals(type) ||
                TYPE_BOOK_OVERDUE.equals(type) ||
                TYPE_SYSTEM_ANNOUNCEMENT.equals(type);
    }

    @Override
    public String toString() {
        return "Notification{" +
                "id=" + id +
                ", userId=" + userId +
                ", title='" + title + '\'' +
                ", type='" + type + '\'' +
                ", isRead=" + isRead +
                '}';
    }

    // Equals and hashCode for proper object comparison
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Notification that = (Notification) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(id);
    }
}