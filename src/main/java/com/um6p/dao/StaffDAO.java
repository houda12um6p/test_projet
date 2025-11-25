package com.um6p.dao;

import com.um6p.model.Staff;
import com.um6p.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    // Constants for better maintainability
    private static final String STAFF_TABLE = "staff";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public boolean createStaff(Staff staff) {
        String sql = "INSERT INTO " + STAFF_TABLE + " (user_id, department, position, hire_date, phone, office_location) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, staff.getUserId());
            stmt.setString(2, staff.getDepartment());
            stmt.setString(3, staff.getPosition());
            stmt.setString(4, staff.getHireDate().format(DATE_FORMATTER)); // FIXED: Convert LocalDate to String
            stmt.setString(5, staff.getPhone());
            stmt.setString(6, staff.getOfficeLocation());

            int rowsInserted = stmt.executeUpdate();

            // Set the generated ID back to the staff object
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        staff.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error creating staff: " + e.getMessage());
            return false;
        }
    }

    public Staff getStaffById(int id) {
        String sql = "SELECT * FROM " + STAFF_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToStaff(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting staff by ID " + id + ": " + e.getMessage());
        }
        return null;
    }

    public Staff getStaffByUserId(int userId) {
        String sql = "SELECT * FROM " + STAFF_TABLE + " WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToStaff(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting staff by user ID " + userId + ": " + e.getMessage());
        }
        return null;
    }

    public boolean updateStaff(Staff staff) {
        String sql = "UPDATE " + STAFF_TABLE + " SET department=?, position=?, hire_date=?, phone=?, office_location=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, staff.getDepartment());
            stmt.setString(2, staff.getPosition());
            stmt.setString(3, staff.getHireDate().format(DATE_FORMATTER)); // FIXED: Convert LocalDate to String
            stmt.setString(4, staff.getPhone());
            stmt.setString(5, staff.getOfficeLocation());
            stmt.setInt(6, staff.getId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error updating staff ID " + staff.getId() + ": " + e.getMessage());
            return false;
        }
    }

    public boolean deleteStaff(int id) {
        String sql = "DELETE FROM " + STAFF_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting staff ID " + id + ": " + e.getMessage());
            return false;
        }
    }

    public List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM " + STAFF_TABLE + " ORDER BY department, position";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                staffList.add(mapResultSetToStaff(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all staff: " + e.getMessage());
        }
        return staffList;
    }

    public List<Staff> getStaffByDepartment(String department) {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT * FROM " + STAFF_TABLE + " WHERE department = ? ORDER BY position";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, department);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                staffList.add(mapResultSetToStaff(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting staff by department " + department + ": " + e.getMessage());
        }
        return staffList;
    }

    public List<Staff> searchStaffByName(String name) {
        List<Staff> staffList = new ArrayList<>();
        String sql = "SELECT s.* FROM " + STAFF_TABLE + " s JOIN users u ON s.user_id = u.id WHERE u.name LIKE ? ORDER BY u.name";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + name + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                staffList.add(mapResultSetToStaff(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching staff by name " + name + ": " + e.getMessage());
        }
        return staffList;
    }

    public List<String> getAllDepartments() {
        List<String> departments = new ArrayList<>();
        String sql = "SELECT DISTINCT department FROM " + STAFF_TABLE + " WHERE department IS NOT NULL ORDER BY department";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                departments.add(rs.getString("department"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting departments: " + e.getMessage());
        }
        return departments;
    }

    public int getStaffCount() {
        String sql = "SELECT COUNT(*) FROM " + STAFF_TABLE;
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting staff count: " + e.getMessage());
        }
        return 0;
    }

    public int getStaffCountByDepartment(String department) {
        String sql = "SELECT COUNT(*) FROM " + STAFF_TABLE + " WHERE department = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, department);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("Error getting staff count for department " + department + ": " + e.getMessage());
            return 0;
        }
    }

    public Staff getStaffWithUserDetails(int staffId) {
        String sql = "SELECT s.*, u.name, u.email FROM " + STAFF_TABLE + " s JOIN users u ON s.user_id = u.id WHERE s.id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, staffId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Staff staff = mapResultSetToStaff(rs);
                // Additional user details can be set here if needed
                return staff;
            }
        } catch (SQLException e) {
            System.err.println("Error getting staff with user details ID " + staffId + ": " + e.getMessage());
        }
        return null;
    }

    private Staff mapResultSetToStaff(ResultSet rs) throws SQLException {
        Staff staff = new Staff();
        staff.setId(rs.getInt("id"));
        staff.setUserId(rs.getInt("user_id"));
        staff.setDepartment(rs.getString("department"));
        staff.setPosition(rs.getString("position"));

        // FIXED: Convert String to LocalDate
        String hireDateStr = rs.getString("hire_date");
        if (hireDateStr != null) {
            staff.setHireDate(LocalDate.parse(hireDateStr));
        }

        staff.setPhone(rs.getString("phone"));
        staff.setOfficeLocation(rs.getString("office_location"));
        return staff;
    }
}