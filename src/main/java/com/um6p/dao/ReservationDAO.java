package com.um6p.dao;

import com.um6p.model.Reservation;
import com.um6p.util.DatabaseConnection;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public boolean create(Reservation reservation) throws SQLException {
        String sql = "INSERT INTO reservations (user_id, book_id, reservation_date, status, queue_position) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            int queuePosition = getQueuePosition(reservation.getBookId()) + 1;

            stmt.setInt(1, reservation.getUserId());
            stmt.setInt(2, reservation.getBookId());
            stmt.setTimestamp(3, Timestamp.valueOf(reservation.getReservationDate()));
            stmt.setString(4, Reservation.STATUS_PENDING);
            stmt.setInt(5, queuePosition);

            int affected = stmt.executeUpdate();
            if (affected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    reservation.setId(rs.getInt(1));
                    reservation.setQueuePosition(queuePosition);
                }
                return true;
            }
            return false;
        }
    }

    public int getQueuePosition(int bookId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM reservations WHERE book_id = ? AND status = 'PENDING'";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    public List<Reservation> getByUserId(int userId) throws SQLException {
        String sql = "SELECT r.*, u.name as user_name, u.email as user_email, b.title as book_title, b.author as book_author " +
                     "FROM reservations r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN books b ON r.book_id = b.id " +
                     "WHERE r.user_id = ? AND r.status IN ('PENDING', 'AVAILABLE') " +
                     "ORDER BY r.reservation_date ASC";
        return executeQuery(sql, userId);
    }

    public List<Reservation> getByBookId(int bookId) throws SQLException {
        String sql = "SELECT r.*, u.name as user_name, u.email as user_email, b.title as book_title, b.author as book_author " +
                     "FROM reservations r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN books b ON r.book_id = b.id " +
                     "WHERE r.book_id = ? AND r.status = 'PENDING' " +
                     "ORDER BY r.queue_position ASC";
        return executeQuery(sql, bookId);
    }

    public Reservation getNextPending(int bookId) throws SQLException {
        String sql = "SELECT r.*, u.name as user_name, u.email as user_email, b.title as book_title, b.author as book_author " +
                     "FROM reservations r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN books b ON r.book_id = b.id " +
                     "WHERE r.book_id = ? AND r.status = 'PENDING' " +
                     "ORDER BY r.queue_position ASC LIMIT 1";
        List<Reservation> results = executeQuery(sql, bookId);
        return results.isEmpty() ? null : results.get(0);
    }

    public boolean markAsAvailable(int reservationId) throws SQLException {
        String sql = "UPDATE reservations SET status = 'AVAILABLE', available_date = ?, expiry_date = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            LocalDateTime now = LocalDateTime.now();
            stmt.setTimestamp(1, Timestamp.valueOf(now));
            stmt.setTimestamp(2, Timestamp.valueOf(now.plusHours(48)));
            stmt.setInt(3, reservationId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean markAsFulfilled(int reservationId) throws SQLException {
        return updateStatus(reservationId, Reservation.STATUS_FULFILLED);
    }

    public boolean cancel(int reservationId) throws SQLException {
        return updateStatus(reservationId, Reservation.STATUS_CANCELLED);
    }

    public void expireOldReservations() throws SQLException {
        String sql = "UPDATE reservations SET status = 'EXPIRED' WHERE status = 'AVAILABLE' AND expiry_date < ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            stmt.executeUpdate();
        }
    }

    private boolean updateStatus(int reservationId, String status) throws SQLException {
        String sql = "UPDATE reservations SET status = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, reservationId);
            return stmt.executeUpdate() > 0;
        }
    }

    private List<Reservation> executeQuery(String sql, int param) throws SQLException {
        List<Reservation> reservations = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, param);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                reservations.add(extractFromResultSet(rs));
            }
        }
        return reservations;
    }

    private Reservation extractFromResultSet(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setId(rs.getInt("id"));
        r.setUserId(rs.getInt("user_id"));
        r.setBookId(rs.getInt("book_id"));
        r.setReservationDate(rs.getTimestamp("reservation_date").toLocalDateTime());
        r.setStatus(rs.getString("status"));
        r.setQueuePosition(rs.getInt("queue_position"));

        Timestamp available = rs.getTimestamp("available_date");
        if (available != null) r.setAvailableDate(available.toLocalDateTime());

        Timestamp expiry = rs.getTimestamp("expiry_date");
        if (expiry != null) r.setExpiryDate(expiry.toLocalDateTime());

        r.setUserName(rs.getString("user_name"));
        r.setUserEmail(rs.getString("user_email"));
        r.setBookTitle(rs.getString("book_title"));
        r.setBookAuthor(rs.getString("book_author"));

        return r;
    }
}
