package com.um6p.dao;

import com.um6p.model.Reservation;
import com.um6p.util.DatabaseConnection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    private static final Logger logger = LoggerFactory.getLogger(ReservationDAO.class);
    private static final String RESERVATIONS_TABLE = "reservations";

    public boolean createReservation(Reservation reservation) {
        String sql = "INSERT INTO " + RESERVATIONS_TABLE +
                     " (user_id, book_id, reservation_date, expiry_date, status, queue_position) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, reservation.getUserId());
            stmt.setInt(2, reservation.getBookId());
            stmt.setTimestamp(3, Timestamp.valueOf(reservation.getReservationDate()));
            stmt.setTimestamp(4, Timestamp.valueOf(reservation.getExpiryDate()));
            stmt.setString(5, reservation.getStatus());
            stmt.setInt(6, reservation.getQueuePosition());

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        reservation.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            logger.error("Error creating reservation for user {} and book {}: {}",
                    reservation.getUserId(), reservation.getBookId(), e.getMessage(), e);
            return false;
        }
    }

    public Reservation getReservationById(int id) {
        String sql = "SELECT * FROM " + RESERVATIONS_TABLE + " WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToReservation(rs);
            }
        } catch (SQLException e) {
            logger.error("Error getting reservation by ID {}: {}", id, e.getMessage(), e);
        }
        return null;
    }

    public List<Reservation> getReservationsByUser(int userId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM " + RESERVATIONS_TABLE +
                     " WHERE user_id = ? ORDER BY reservation_date DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                reservations.add(mapResultSetToReservation(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting reservations for user {}: {}", userId, e.getMessage(), e);
        }
        return reservations;
    }

    public List<Reservation> getActiveReservationsByUser(int userId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM " + RESERVATIONS_TABLE +
                     " WHERE user_id = ? AND status = 'ACTIVE' ORDER BY reservation_date DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                reservations.add(mapResultSetToReservation(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting active reservations for user {}: {}", userId, e.getMessage(), e);
        }
        return reservations;
    }

    public List<Reservation> getReservationsByBook(int bookId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM " + RESERVATIONS_TABLE +
                     " WHERE book_id = ? AND status = 'ACTIVE' ORDER BY queue_position ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                reservations.add(mapResultSetToReservation(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting reservations for book {}: {}", bookId, e.getMessage(), e);
        }
        return reservations;
    }

    public boolean updateReservationStatus(int reservationId, String status) {
        String sql = "UPDATE " + RESERVATIONS_TABLE + " SET status = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, reservationId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error updating reservation {} status to {}: {}",
                    reservationId, status, e.getMessage(), e);
            return false;
        }
    }

    public boolean cancelReservation(int reservationId) {
        return updateReservationStatus(reservationId, "CANCELLED");
    }

    public boolean completeReservation(int reservationId) {
        return updateReservationStatus(reservationId, "COMPLETED");
    }

    public boolean expireReservation(int reservationId) {
        return updateReservationStatus(reservationId, "EXPIRED");
    }

    public List<Reservation> getExpiredReservations() {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM " + RESERVATIONS_TABLE +
                     " WHERE status = 'ACTIVE' AND expiry_date < NOW()";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                reservations.add(mapResultSetToReservation(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting expired reservations: {}", e.getMessage(), e);
        }
        return reservations;
    }

    public boolean deleteReservation(int id) {
        String sql = "DELETE FROM " + RESERVATIONS_TABLE + " WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error deleting reservation {}: {}", id, e.getMessage(), e);
            return false;
        }
    }

    public int getNextQueuePosition(int bookId) {
        String sql = "SELECT MAX(queue_position) FROM " + RESERVATIONS_TABLE +
                     " WHERE book_id = ? AND status = 'ACTIVE'";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
        } catch (SQLException e) {
            logger.error("Error getting next queue position for book {}: {}", bookId, e.getMessage(), e);
        }
        return 1; // First in queue
    }

    private Reservation mapResultSetToReservation(ResultSet rs) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setId(rs.getInt("id"));
        reservation.setUserId(rs.getInt("user_id"));
        reservation.setBookId(rs.getInt("book_id"));
        reservation.setStatus(rs.getString("status"));
        reservation.setQueuePosition(rs.getInt("queue_position"));

        Timestamp reservationDate = rs.getTimestamp("reservation_date");
        if (reservationDate != null) {
            reservation.setReservationDate(reservationDate.toLocalDateTime());
        }

        Timestamp expiryDate = rs.getTimestamp("expiry_date");
        if (expiryDate != null) {
            reservation.setExpiryDate(expiryDate.toLocalDateTime());
        }

        return reservation;
    }
}
