package com.um6p.model;

import java.time.LocalDate;

public class Librarian {
    private int id;
    private int userId;
    private String employeeId;
    private String department;
    private String phone;
    private String officeLocation;
    private LocalDate hireDate;
    private String shift;

    public Librarian() {}

    public Librarian(int userId, String employeeId, String department, String phone, String officeLocation) {
        this.userId = userId;
        this.employeeId = employeeId;
        this.department = department;
        this.phone = phone;
        this.officeLocation = officeLocation;
        this.hireDate = LocalDate.now();
        this.shift = "morning";
    }

    public Librarian(int id, int userId, String employeeId, String department, String phone,
                     String officeLocation, LocalDate hireDate, String shift) {
        this.id = id;
        this.userId = userId;
        this.employeeId = employeeId;
        this.department = department;
        this.phone = phone;
        this.officeLocation = officeLocation;
        this.hireDate = hireDate;
        this.shift = shift;
    }

    // Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getEmployeeId() { return employeeId; }
    public String getDepartment() { return department; }
    public String getPhone() { return phone; }
    public String getOfficeLocation() { return officeLocation; }
    public LocalDate getHireDate() { return hireDate; }
    public String getShift() { return shift; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }
    public void setDepartment(String department) { this.department = department; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setOfficeLocation(String officeLocation) { this.officeLocation = officeLocation; }
    public void setHireDate(LocalDate hireDate) { this.hireDate = hireDate; }
    public void setShift(String shift) { this.shift = shift; }

    @Override
    public String toString() {
        return "Librarian{" +
                "id=" + id +
                ", userId=" + userId +
                ", employeeId='" + employeeId + '\'' +
                ", department='" + department + '\'' +
                ", shift='" + shift + '\'' +
                '}';
    }
}
