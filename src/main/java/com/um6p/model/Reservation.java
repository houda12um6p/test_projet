package com.um6p.model;

import java.time.LocalDateTime;

/**
 * Represents a book reservation in the UM6P Learning Center system.
 * Manages reservation lifecycle, queue positions, and expiry.
 */
public class Reservation {
    private int id;
    private int bookId;
    private int studentId;
    private LocalDateTime reservationDate;
    private LocalDateTime expiryDate;
    private ReservationStatus status;
    private int queuePosition;
    private LocalDateTime completionDate;

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
        this.status = ReservationStatus.ACTIVE;
        this.queuePosition = 0;
        // Default expiry: 7 days from reservation
        this.expiryDate = LocalDateTime.now().plusDays(7);
    }

    /**
     * Business constructor for new reservations
     */
    public Reservation(int bookId, int studentId) {
        this();
        setBookId(bookId);
        setStudentId(studentId);
    }

    /**
     * Full constructor for complete object creation
     */
    public Reservation(int id, int bookId, int studentId, LocalDateTime reservationDate,
                       LocalDateTime expiryDate, ReservationStatus status, int queuePosition) {
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

    public void setStatus(ReservationStatus status) {
        if (status == null) throw new IllegalArgumentException("Status cannot be null");
        this.status = status;
    }

    // ===== BUSINESS METHODS =====

    /**
     * Marks reservation as completed
     */
    public void markCompleted() {
        this.status = ReservationStatus.COMPLETED;
        this.completionDate = LocalDateTime.now();
    }

    /**
     * Cancels this reservation
     */
    public void cancel() {
        this.status = ReservationStatus.CANCELLED;
    }

    /**
     * Marks reservation as expired
     */
    public void markExpired() {
        this.status = ReservationStatus.EXPIRED;
    }

    /**
     * Checks if reservation is active and not expired
     */
    public boolean isActive() {
        return this.status == ReservationStatus.ACTIVE
                && LocalDateTime.now().isBefore(this.expiryDate);
    }

    /**
     * Checks if reservation can be cancelled
     */
    public boolean canBeCancelled() {
        return this.status == ReservationStatus.ACTIVE
                || this.status == ReservationStatus.PENDING;
    }

    /**
     * Updates queue position
     */
    public void updateQueuePosition(int newPosition) {
        setQueuePosition(newPosition);
        if (newPosition == 0 && this.status == ReservationStatus.PENDING) {
            this.status = ReservationStatus.ACTIVE;
        }
    }

    // ===== STANDARD GETTERS =====

    public int getId() { return id; }
    public int getBookId() { return bookId; }
    public int getStudentId() { return studentId; }
    public LocalDateTime getReservationDate() { return reservationDate; }
    public LocalDateTime getExpiryDate() { return expiryDate; }
    public ReservationStatus getStatus() { return status; }
    public int getQueuePosition() { return queuePosition; }
    public LocalDateTime getCompletionDate() { return completionDate; }

    // ===== STANDARD SETTERS =====

    public void setId(int id) { this.id = id; }
    public void setReservationDate(LocalDateTime reservationDate) { this.reservationDate = reservationDate; }
    public void setExpiryDate(LocalDateTime expiryDate) { this.expiryDate = expiryDate; }
    public void setCompletionDate(LocalDateTime completionDate) { this.completionDate = completionDate; }

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