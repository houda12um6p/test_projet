package com.um6p.model;

import java.time.LocalDateTime;

/**
 * Represents a book reservation in the UM6P Learning Center system.
 * Manages reservation lifecycle, queue positions, and expiry.
 */
public class Reservation {
    public static final String STATUS_PENDING = "PENDING";
    public static final String STATUS_AVAILABLE = "AVAILABLE";
    public static final String STATUS_FULFILLED = "FULFILLED";
    public static final String STATUS_EXPIRED = "EXPIRED";
    public static final String STATUS_CANCELLED = "CANCELLED";

    private int id;
    private int bookId;
    private int userId;
    private int studentId;
    private LocalDateTime reservationDate;
    private LocalDateTime availableDate;
    private LocalDateTime expiryDate;
    private String status;
    private int queuePosition;
    private LocalDateTime completionDate;

    // Display fields
    private String userName;
    private String userEmail;
    private String bookTitle;
    private String bookAuthor;

    /**
     * Enum representing possible reservation statuses
     */
    public enum ReservationStatus {
        ACTIVE, PENDING, COMPLETED, CANCELLED, EXPIRED
    }

    // ===== CONSTRUCTORS =====

    /**
     * Default constructor - initializes with default values
     */
    public Reservation() {
        this.reservationDate = LocalDateTime.now();
        this.status = STATUS_PENDING;
        this.queuePosition = 0;
    }

    /**
     * Business constructor for new reservations
     */
    public Reservation(int userId, int bookId) {
        this();
        this.userId = userId;
        this.bookId = bookId;
        this.studentId = userId;
    }

    /**
     * Full constructor for complete object creation
     */
    public Reservation(int id, int bookId, int studentId, LocalDateTime reservationDate,
                       LocalDateTime expiryDate, String status, int queuePosition) {
        this.id = id;
        setBookId(bookId);
        setStudentId(studentId);
        this.reservationDate = reservationDate;
        this.expiryDate = expiryDate;
        this.status = status;
        this.queuePosition = queuePosition;
    }

    // ===== ENHANCED SETTERS WITH VALIDATION =====

    public void setBookId(int bookId) {
        if (bookId <= 0) throw new IllegalArgumentException("Book ID must be positive");
        this.bookId = bookId;
    }

    public void setStudentId(int studentId) {
        if (studentId <= 0) throw new IllegalArgumentException("Student ID must be positive");
        this.studentId = studentId;
    }

    public void setQueuePosition(int queuePosition) {
        if (queuePosition < 0) throw new IllegalArgumentException("Queue position cannot be negative");
        this.queuePosition = queuePosition;
    }

    public void setStatus(String status) {
        if (status == null) throw new IllegalArgumentException("Status cannot be null");
        this.status = status;
    }

    public void setStatus(ReservationStatus status) {
        if (status == null) throw new IllegalArgumentException("Status cannot be null");
        this.status = status.name();
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setAvailableDate(LocalDateTime availableDate) {
        this.availableDate = availableDate;
    }

    // ===== BUSINESS METHODS =====

    /**
     * Marks reservation as completed
     */
    public void markCompleted() {
        this.status = STATUS_FULFILLED;
        this.completionDate = LocalDateTime.now();
    }

    /**
     * Cancels this reservation
     */
    public void cancel() {
        this.status = STATUS_CANCELLED;
    }

    /**
     * Marks reservation as expired
     */
    public void markExpired() {
        this.status = STATUS_EXPIRED;
    }

    /**
     * Checks if reservation is pending
     */
    public boolean isPending() {
        return STATUS_PENDING.equals(this.status);
    }

    /**
     * Checks if book is available for pickup
     */
    public boolean isAvailable() {
        return STATUS_AVAILABLE.equals(this.status);
    }

    /**
     * Checks if reservation is expired
     */
    public boolean isExpired() {
        if (STATUS_AVAILABLE.equals(this.status) && expiryDate != null) {
            return LocalDateTime.now().isAfter(expiryDate);
        }
        return STATUS_EXPIRED.equals(this.status);
    }

    /**
     * Marks reservation as available (book ready for pickup)
     */
    public void markAsAvailable() {
        this.status = STATUS_AVAILABLE;
        this.availableDate = LocalDateTime.now();
        this.expiryDate = LocalDateTime.now().plusHours(48); // 48-hour hold
    }

    /**
     * Marks reservation as fulfilled (book picked up)
     */
    public void markAsFulfilled() {
        this.status = STATUS_FULFILLED;
        this.completionDate = LocalDateTime.now();
    }

    /**
     * Checks if reservation is active and not expired
     */
    public boolean isActive() {
        return STATUS_PENDING.equals(this.status) || STATUS_AVAILABLE.equals(this.status);
    }

    /**
     * Checks if reservation can be cancelled
     */
    public boolean canBeCancelled() {
        return STATUS_PENDING.equals(this.status) || STATUS_AVAILABLE.equals(this.status);
    }

    /**
     * Marks reservation as cancelled
     */
    public void markAsCancelled() {
        this.status = STATUS_CANCELLED;
    }

    /**
     * Updates queue position
     */
    public void updateQueuePosition(int newPosition) {
        setQueuePosition(newPosition);
        if (newPosition == 0 && STATUS_PENDING.equals(this.status)) {
            this.status = STATUS_AVAILABLE;
        }
    }

    // ===== STANDARD GETTERS =====

    public int getId() { return id; }
    public int getBookId() { return bookId; }
    public int getUserId() { return userId; }
    public int getStudentId() { return studentId; }
    public LocalDateTime getReservationDate() { return reservationDate; }
    public LocalDateTime getAvailableDate() { return availableDate; }
    public LocalDateTime getExpiryDate() { return expiryDate; }
    public String getStatus() { return status; }
    public int getQueuePosition() { return queuePosition; }
    public LocalDateTime getCompletionDate() { return completionDate; }
    public String getUserName() { return userName; }
    public String getUserEmail() { return userEmail; }
    public String getBookTitle() { return bookTitle; }
    public String getBookAuthor() { return bookAuthor; }

    // ===== STANDARD SETTERS =====

    public void setId(int id) { this.id = id; }
    public void setReservationDate(LocalDateTime reservationDate) { this.reservationDate = reservationDate; }
    public void setExpiryDate(LocalDateTime expiryDate) { this.expiryDate = expiryDate; }
    public void setCompletionDate(LocalDateTime completionDate) { this.completionDate = completionDate; }
    public void setUserName(String userName) { this.userName = userName; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    public void setBookTitle(String bookTitle) { this.bookTitle = bookTitle; }
    public void setBookAuthor(String bookAuthor) { this.bookAuthor = bookAuthor; }

    @Override
    public String toString() {
        return "Reservation{" +
                "id=" + id +
                ", bookId=" + bookId +
                ", studentId=" + studentId +
                ", status=" + status +
                ", queuePosition=" + queuePosition +
                ", isActive=" + isActive() +
                '}';
    }
}