package com.um6p.dao;

import com.um6p.model.Librarian;
import com.um6p.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LibrarianDAO {

    public boolean create(Librarian librarian) throws SQLException {
        String sql = "INSERT INTO librarians (user_id, employee_id, department, phone, office_location, hire_date, shift) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, librarian.getUserId());
            stmt.setString(2, librarian.getEmployeeId());
            stmt.setString(3, librarian.getDepartment());
            stmt.setString(4, librarian.getPhone());
            stmt.setString(5, librarian.getOfficeLocation());
            stmt.setDate(6, Date.valueOf(librarian.getHireDate()));
            stmt.setString(7, librarian.getShift());

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    librarian.setId(rs.getInt(1));
                }
                return true;
            }
            return false;
        }
    }

    public Librarian getByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM librarians WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractFromResultSet(rs);
            }
            return null;
        }
    }

    public Librarian getById(int id) throws SQLException {
        String sql = "SELECT * FROM librarians WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractFromResultSet(rs);
            }
            return null;
        }
    }

    public List<Librarian> getAll() throws SQLException {
        List<Librarian> librarians = new ArrayList<>();
        String sql = "SELECT * FROM librarians ORDER BY hire_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                librarians.add(extractFromResultSet(rs));
            }
        }
        return librarians;
    }

    public boolean update(Librarian librarian) throws SQLException {
        String sql = "UPDATE librarians SET employee_id = ?, department = ?, phone = ?, office_location = ?, shift = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, librarian.getEmployeeId());
            stmt.setString(2, librarian.getDepartment());
            stmt.setString(3, librarian.getPhone());
            stmt.setString(4, librarian.getOfficeLocation());
            stmt.setString(5, librarian.getShift());
            stmt.setInt(6, librarian.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM librarians WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    private Librarian extractFromResultSet(ResultSet rs) throws SQLException {
        Librarian librarian = new Librarian();
        librarian.setId(rs.getInt("id"));
        librarian.setUserId(rs.getInt("user_id"));
        librarian.setEmployeeId(rs.getString("employee_id"));
        librarian.setDepartment(rs.getString("department"));
        librarian.setPhone(rs.getString("phone"));
        librarian.setOfficeLocation(rs.getString("office_location"));
        librarian.setHireDate(rs.getDate("hire_date").toLocalDate());
        librarian.setShift(rs.getString("shift"));
        return librarian;
    }
}
