package com.um6p.dao;

import com.um6p.model.Student;
import com.um6p.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    // Constants for better maintainability
    private static final String STUDENTS_TABLE = "students";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public boolean createStudent(Student student) {
        String sql = "INSERT INTO " + STUDENTS_TABLE + " (user_id, enrollment_date, major, student_id_number, phone) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, student.getUserId());
            stmt.setString(2, student.getEnrollmentDate().format(DATE_FORMATTER)); // FIXED: Convert LocalDate to String
            stmt.setString(3, student.getMajor());
            stmt.setString(4, student.getStudentIdNumber());
            stmt.setString(5, student.getPhone());

            int rowsInserted = stmt.executeUpdate();

            // Set the generated ID back to the student object
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        student.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error creating student: " + e.getMessage());
            return false;
        }
    }

    public Student getStudentById(int id) {
        String sql = "SELECT * FROM " + STUDENTS_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToStudent(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting student by ID " + id + ": " + e.getMessage());
        }
        return null;
    }

    public Student getStudentByUserId(int userId) {
        String sql = "SELECT * FROM " + STUDENTS_TABLE + " WHERE user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToStudent(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting student by user ID " + userId + ": " + e.getMessage());
        }
        return null;
    }

    public Student getStudentByStudentId(String studentIdNumber) {
        String sql = "SELECT * FROM " + STUDENTS_TABLE + " WHERE student_id_number = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, studentIdNumber);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToStudent(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting student by ID number " + studentIdNumber + ": " + e.getMessage());
        }
        return null;
    }

    public boolean updateStudent(Student student) {
        String sql = "UPDATE " + STUDENTS_TABLE + " SET enrollment_date=?, major=?, student_id_number=?, phone=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getEnrollmentDate().format(DATE_FORMATTER)); // FIXED: Convert LocalDate to String
            stmt.setString(2, student.getMajor());
            stmt.setString(3, student.getStudentIdNumber());
            stmt.setString(4, student.getPhone());
            stmt.setInt(5, student.getId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error updating student ID " + student.getId() + ": " + e.getMessage());
            return false;
        }
    }

    public boolean deleteStudent(int id) {
        String sql = "DELETE FROM " + STUDENTS_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting student ID " + id + ": " + e.getMessage());
            return false;
        }
    }

    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM " + STUDENTS_TABLE + " ORDER BY major, student_id_number";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all students: " + e.getMessage());
        }
        return students;
    }

    public List<Student> getStudentsByMajor(String major) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM " + STUDENTS_TABLE + " WHERE major = ? ORDER BY student_id_number";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, major);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting students by major " + major + ": " + e.getMessage());
        }
        return students;
    }

    public List<Student> searchStudentsByName(String name) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT s.* FROM " + STUDENTS_TABLE + " s JOIN users u ON s.user_id = u.id WHERE u.name LIKE ? ORDER BY u.name";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + name + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching students by name " + name + ": " + e.getMessage());
        }
        return students;
    }

    public List<String> getAllMajors() {
        List<String> majors = new ArrayList<>();
        String sql = "SELECT DISTINCT major FROM " + STUDENTS_TABLE + " WHERE major IS NOT NULL ORDER BY major";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                majors.add(rs.getString("major"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting majors: " + e.getMessage());
        }
        return majors;
    }

    public int getStudentCount() {
        String sql = "SELECT COUNT(*) FROM " + STUDENTS_TABLE;
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting student count: " + e.getMessage());
        }
        return 0;
    }

    public int getStudentCountByMajor(String major) {
        String sql = "SELECT COUNT(*) FROM " + STUDENTS_TABLE + " WHERE major = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, major);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("Error getting student count for major " + major + ": " + e.getMessage());
            return 0;
        }
    }

    public Student getStudentWithUserDetails(int studentId) {
        String sql = "SELECT s.*, u.name, u.email FROM " + STUDENTS_TABLE + " s JOIN users u ON s.user_id = u.id WHERE s.id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Student student = mapResultSetToStudent(rs);
                // Additional user details can be set here if needed
                return student;
            }
        } catch (SQLException e) {
            System.err.println("Error getting student with user details ID " + studentId + ": " + e.getMessage());
        }
        return null;
    }

    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setId(rs.getInt("id"));
        student.setUserId(rs.getInt("user_id"));

        // FIXED: Convert String to LocalDate
        String enrollmentDateStr = rs.getString("enrollment_date");
        if (enrollmentDateStr != null) {
            student.setEnrollmentDate(LocalDate.parse(enrollmentDateStr));
        }

        student.setMajor(rs.getString("major"));
        student.setStudentIdNumber(rs.getString("student_id_number"));
        student.setPhone(rs.getString("phone"));
        return student;
    }
}