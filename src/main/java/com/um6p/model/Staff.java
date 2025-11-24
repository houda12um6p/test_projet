package com.um6p.model;

import java.time.LocalDate;

public class Staff {
    private int id;
    private int userId;
    private String department;
    private String position;
    private LocalDate hireDate;
    private String phone;
    private String officeLocation;

    // Constructors
    public Staff() {
    }

    public Staff(int userId, String department, String position, String phone, String officeLocation) {
        setUserId(userId);
        setDepartment(department);
        setPosition(position);
        setPhone(phone);
        setOfficeLocation(officeLocation);
        this.hireDate = LocalDate.now();
    }

    public Staff(int id, int userId, String department, String position,
                 LocalDate hireDate, String phone, String officeLocation) {
        this.id = id;
        setUserId(userId);
        setDepartment(department);
        setPosition(position);
        this.hireDate = hireDate;
        setPhone(phone);
        setOfficeLocation(officeLocation);
    }

    // ADDED: Constructor that accepts User object and staff details
    public Staff(User user, String department, String position, String phone, String officeLocation) {
        if (user == null) throw new IllegalArgumentException("User cannot be null");
        this.userId = user.getId();
        setDepartment(department);
        setPosition(position);
        setPhone(phone);
        setOfficeLocation(officeLocation);
        this.hireDate = LocalDate.now();
    }

    // ADDED: Constructor for RegisterController usage
    public Staff(String firstName, String lastName, String email, String password,
                 String department, String position, String phone, String officeLocation) {
        // This constructor would typically create both User and Staff
        // For now, we'll set userId to 0 (to be set later after User creation)
        this.userId = 0;
        setDepartment(department);
        setPosition(position);
        setPhone(phone);
        setOfficeLocation(officeLocation);
        this.hireDate = LocalDate.now();
    }

    // Enhanced setters with validation
    public void setUserId(int userId) {
        if (userId <= 0) throw new IllegalArgumentException("User ID must be positive");
        this.userId = userId;
    }

    public void setDepartment(String department) {
        if (department == null || department.trim().isEmpty()) {
            throw new IllegalArgumentException("Department cannot be null or empty");
        }
        this.department = department.trim();
    }

    public void setPosition(String position) {
        if (position == null || position.trim().isEmpty()) {
            throw new IllegalArgumentException("Position cannot be null or empty");
        }
        this.position = position.trim();
    }

    public void setPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            throw new IllegalArgumentException("Phone cannot be null or empty");
        }
        // Enhanced phone validation
        if (!phone.matches("^[0-9+\\-\\(\\)\\s]{8,15}$")) {
            throw new IllegalArgumentException("Invalid phone number format");
        }
        this.phone = phone.trim();
    }

    public void setOfficeLocation(String officeLocation) {
        if (officeLocation == null || officeLocation.trim().isEmpty()) {
            throw new IllegalArgumentException("Office location cannot be null or empty");
        }
        this.officeLocation = officeLocation.trim();
    }

    // Business methods
    public int getYearsOfService() {
        if (hireDate == null) return 0;
        return LocalDate.now().getYear() - hireDate.getYear();
    }

    public boolean isManagement() {
        return position != null &&
                (position.toLowerCase().contains("manager") ||
                        position.toLowerCase().contains("director") ||
                        position.toLowerCase().contains("head") ||
                        position.toLowerCase().contains("chief"));
    }

    public boolean isAcademicStaff() {
        return department != null &&
                (department.toLowerCase().contains("faculty") ||
                        department.toLowerCase().contains("academic") ||
                        department.toLowerCase().contains("research") ||
                        position.toLowerCase().contains("professor") ||
                        position.toLowerCase().contains("lecturer"));
    }

    public boolean isAdministrativeStaff() {
        return !isAcademicStaff();
    }

    // ADDED: Method to check if staff can manage events
    public boolean canManageEvents() {
        return isManagement() ||
                department.toLowerCase().contains("event") ||
                position.toLowerCase().contains("coordinator");
    }

    // ADDED: Method to check if staff can manage books
    public boolean canManageBooks() {
        return isManagement() ||
                department.toLowerCase().contains("library") ||
                position.toLowerCase().contains("librarian");
    }

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getDepartment() { return department; }
    public String getPosition() { return position; }
    public LocalDate getHireDate() { return hireDate; }
    public String getPhone() { return phone; }
    public String getOfficeLocation() { return officeLocation; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setHireDate(LocalDate hireDate) { this.hireDate = hireDate; }

    @Override
    public String toString() {
        return "Staff{" +
                "id=" + id +
                ", userId=" + userId +
                ", department='" + department + '\'' +
                ", position='" + position + '\'' +
                ", hireDate=" + hireDate +
                ", phone='" + phone + '\'' +
                ", officeLocation='" + officeLocation + '\'' +
                ", yearsOfService=" + getYearsOfService() +
                ", isManagement=" + isManagement() +
                '}';
    }
}