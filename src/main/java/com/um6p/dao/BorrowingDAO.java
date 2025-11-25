package com.um6p.dao;

import com.um6p.util.DatabaseConnection;
import com.um6p.model.Borrowing; // ADD THIS IMPORT
import com.um6p.model.Borrowing.BorrowingStatus; // ADD THIS IMPORT

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class BorrowingDAO {

    public boolean createBorrowing(Borrowing borrowing) {
        String sql = "INSERT INTO borrowings (user_id, book_id, borrow_date, due_date, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, borrowing.getUserId());
            stmt.setInt(2, borrowing.getBookId());
            stmt.setString(3, borrowing.getBorrowDate().toString()); // FIXED: Convert LocalDateTime to String
            stmt.setString(4, borrowing.getDueDate().toString()); // FIXED: Convert LocalDateTime to String
            stmt.setString(5, borrowing.getStatus().name()); // FIXED: Convert enum to String

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Borrowing getBorrowingById(int id) {
        String sql = "SELECT * FROM borrowings WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToBorrowing(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean returnBook(int borrowingId, LocalDateTime returnDate) { // CHANGED: String to LocalDateTime
        String sql = "UPDATE borrowings SET return_date = ?, status = 'RETURNED' WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, returnDate.toString()); // FIXED: Convert LocalDateTime to String
            stmt.setInt(2, borrowingId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Borrowing> getActiveBorrowingsByUser(int userId) {
        List<Borrowing> borrowings = new ArrayList<>();
        String sql = "SELECT * FROM borrowings WHERE user_id = ? AND status = 'BORROWED' ORDER BY due_date ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                borrowings.add(mapResultSetToBorrowing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return borrowings;
    }

    public List<Borrowing> getAllBorrowingsByUser(int userId) {
        List<Borrowing> borrowings = new ArrayList<>();
        String sql = "SELECT * FROM borrowings WHERE user_id = ? ORDER BY borrow_date DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                borrowings.add(mapResultSetToBorrowing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return borrowings;
    }

    public List<Borrowing> getOverdueBorrowings() {
        List<Borrowing> borrowings = new ArrayList<>();
        String sql = "SELECT * FROM borrowings WHERE status = 'BORROWED' AND due_date < CURDATE() ORDER BY due_date ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                borrowings.add(mapResultSetToBorrowing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return borrowings;
    }

    public List<Borrowing> getAllActiveBorrowings() {
        List<Borrowing> borrowings = new ArrayList<>();
        String sql = "SELECT * FROM borrowings WHERE status = 'BORROWED' ORDER BY due_date ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                borrowings.add(mapResultSetToBorrowing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return borrowings;
    }

    public boolean hasOverdueBooks(int userId) {
        String sql = "SELECT COUNT(*) as count FROM borrowings WHERE user_id = ? AND status = 'BORROWED' AND due_date < CURDATE()";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getActiveBorrowingsCount(int userId) {
        String sql = "SELECT COUNT(*) as count FROM borrowings WHERE user_id = ? AND status = 'BORROWED'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Borrowing mapResultSetToBorrowing(ResultSet rs) throws SQLException {
        Borrowing borrowing = new Borrowing();
        borrowing.setId(rs.getInt("id"));
        borrowing.setUserId(rs.getInt("user_id"));
        borrowing.setBookId(rs.getInt("book_id"));

        // FIXED: Convert String to LocalDateTime
        String borrowDateStr = rs.getString("borrow_date");
        if (borrowDateStr != null) {
            borrowing.setBorrowDate(LocalDateTime.parse(borrowDateStr));
        }

        String dueDateStr = rs.getString("due_date");
        if (dueDateStr != null) {
            borrowing.setDueDate(LocalDateTime.parse(dueDateStr));
        }

        String returnDateStr = rs.getString("return_date");
        if (returnDateStr != null) {
            borrowing.setReturnDate(LocalDateTime.parse(returnDateStr));
        }

        // FIXED: Convert String to enum
        String statusStr = rs.getString("status");
        if (statusStr != null) {
            borrowing.setStatus(BorrowingStatus.valueOf(statusStr));
        }

        return borrowing;
    }
}