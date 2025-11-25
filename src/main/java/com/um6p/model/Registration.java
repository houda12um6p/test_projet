package com.um6p.model;

import java.time.LocalDateTime;

public class Registration {
    private int id;
    private int eventId;
    private int studentId;
    private int userId; // ADDED: Missing userId field
    private LocalDateTime registrationDate;
    private RegistrationStatus status;
    private boolean attendanceMarked;
    private LocalDateTime attendanceDate;

    public enum RegistrationStatus {
        PENDING, CONFIRMED, WAITLISTED, CANCELLED, ATTENDED
    }

    // Constructors
    public Registration() {
        this.registrationDate = LocalDateTime.now();
        this.status = RegistrationStatus.PENDING;
        this.attendanceMarked = false;
    }

    public Registration(int eventId, int studentId) {
        this();
        this.eventId = eventId;
        this.studentId = studentId;
    }

    // ADDED: New constructor with userId
    public Registration(int eventId, int studentId, int userId) {
        this();
        this.eventId = eventId;
        this.studentId = studentId;
        this.userId = userId;
    }

    // Enhanced setters with validation
    public void setEventId(int eventId) {
        if (eventId <= 0) throw new IllegalArgumentException("Event ID must be positive");
        this.eventId = eventId;
    }

    public void setStudentId(int studentId) {
        if (studentId <= 0) throw new IllegalArgumentException("Student ID must be positive");
        this.studentId = studentId;
    }

    // ADDED: Missing getUserId() method
    public int getUserId() {
        return userId;
    }

    // ADDED: Missing setUserId() method
    public void setUserId(int userId) {
        this.userId = userId;
    }

    // Business methods
    public void markAttendance() {
        this.attendanceMarked = true;
        this.attendanceDate = LocalDateTime.now();
        this.status = RegistrationStatus.ATTENDED;
    }

    public void cancelRegistration() {
        this.status = RegistrationStatus.CANCELLED;
    }

    // Getters
    public int getId() { return id; }
    public int getEventId() { return eventId; }
    public int getStudentId() { return studentId; }
    public LocalDateTime getRegistrationDate() { return registrationDate; }
    public RegistrationStatus getStatus() { return status; }
    public boolean isAttendanceMarked() { return attendanceMarked; }
    public LocalDateTime getAttendanceDate() { return attendanceDate; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setRegistrationDate(LocalDateTime registrationDate) { this.registrationDate = registrationDate; }
    public void setStatus(RegistrationStatus status) { this.status = status; }
    public void setAttendanceMarked(boolean attendanceMarked) { this.attendanceMarked = attendanceMarked; }
    public void setAttendanceDate(LocalDateTime attendanceDate) { this.attendanceDate = attendanceDate; }

    @Override
    public String toString() {
        return "Registration{" +
                "id=" + id +
                ", eventId=" + eventId +
                ", studentId=" + studentId +
                ", userId=" + userId + // ADDED: Include userId in toString
                ", status=" + status +
                ", attendanceMarked=" + attendanceMarked +
                '}';
    }
}