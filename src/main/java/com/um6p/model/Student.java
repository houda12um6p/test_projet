package com.um6p.model;

import java.time.LocalDate;

public class Student {
    private int id;
    private int userId;
    private LocalDate enrollmentDate;
    private String major;
    private String studentIdNumber;
    private String phone;

    // Constructors
    public Student() {
    }

    public Student(int userId, String major, String studentIdNumber, String phone) {
        setUserId(userId);
        setMajor(major);
        setStudentIdNumber(studentIdNumber);
        setPhone(phone);
        this.enrollmentDate = LocalDate.now();
    }

    public Student(int id, int userId, LocalDate enrollmentDate, String major,
                   String studentIdNumber, String phone) {
        this.id = id;
        setUserId(userId);
        this.enrollmentDate = enrollmentDate;
        setMajor(major);
        setStudentIdNumber(studentIdNumber);
        setPhone(phone);
    }

    // ADDED: Constructor that accepts User object and student details
    public Student(User user, String major, String studentIdNumber, String phone) {
        if (user == null) throw new IllegalArgumentException("User cannot be null");
        this.userId = user.getId();
        setMajor(major);
        setStudentIdNumber(studentIdNumber);
        setPhone(phone);
        this.enrollmentDate = LocalDate.now();
    }

    // ADDED: Constructor for RegisterController usage
    public Student(String firstName, String lastName, String email, String password,
                   String major, String studentIdNumber, String phone) {
        // This constructor would typically create both User and Student
        // For now, we'll set userId to 0 (to be set later after User creation)
        this.userId = 0;
        setMajor(major);
        setStudentIdNumber(studentIdNumber);
        setPhone(phone);
        this.enrollmentDate = LocalDate.now();
    }

    // Enhanced setters with validation
    public void setUserId(int userId) {
        if (userId <= 0) throw new IllegalArgumentException("User ID must be positive");
        this.userId = userId;
    }

    public void setMajor(String major) {
        if (major == null || major.trim().isEmpty()) {
            throw new IllegalArgumentException("Major cannot be null or empty");
        }
        this.major = major.trim();
    }

    public void setStudentIdNumber(String studentIdNumber) {
        if (studentIdNumber == null || studentIdNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Student ID number cannot be null or empty");
        }
        this.studentIdNumber = studentIdNumber.trim();
    }

    public void setPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            throw new IllegalArgumentException("Phone cannot be null or empty");
        }
        // Basic phone validation
        if (!phone.matches("^[0-9+\\-\\(\\)\\s]{8,15}$")) {
            throw new IllegalArgumentException("Invalid phone number format");
        }
        this.phone = phone.trim();
    }

    // Business methods
    public int getAcademicYear() {
        if (enrollmentDate == null) return 0;
        int years = LocalDate.now().getYear() - enrollmentDate.getYear();
        return Math.max(1, Math.min(5, years)); // Cap between 1-5 years
    }

    public boolean isValidStudentId() {
        return studentIdNumber != null && studentIdNumber.matches("^[0-9]{8,10}$");
    }

    public boolean isEnrolled() {
        return enrollmentDate != null && enrollmentDate.isBefore(LocalDate.now());
    }

    // ADDED: Method to get expected graduation year
    public int getExpectedGraduationYear() {
        if (enrollmentDate == null) return 0;
        return enrollmentDate.getYear() + 4; // Assuming 4-year program
    }

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public LocalDate getEnrollmentDate() { return enrollmentDate; }
    public String getMajor() { return major; }
    public String getStudentIdNumber() { return studentIdNumber; }
    public String getPhone() { return phone; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setEnrollmentDate(LocalDate enrollmentDate) { this.enrollmentDate = enrollmentDate; }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", userId=" + userId +
                ", enrollmentDate=" + enrollmentDate +
                ", major='" + major + '\'' +
                ", studentIdNumber='" + studentIdNumber + '\'' +
                ", phone='" + phone + '\'' +
                ", academicYear=" + getAcademicYear() +
                ", isValidStudentId=" + isValidStudentId() +
                '}';
    }
}