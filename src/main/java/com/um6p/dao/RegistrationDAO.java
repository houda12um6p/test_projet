package com.um6p.dao;

import com.um6p.model.Registration;
import com.um6p.model.Registration.RegistrationStatus;
import com.um6p.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class RegistrationDAO {

    // Constants for better maintainability
    private static final String REGISTRATIONS_TABLE = "registrations";
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public boolean createRegistration(Registration registration) {
        String sql = "INSERT INTO " + REGISTRATIONS_TABLE + " (user_id, event_id, registration_date, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, registration.getUserId());
            stmt.setInt(2, registration.getEventId());
            stmt.setString(3, registration.getRegistrationDate().format(DATE_TIME_FORMATTER));
            stmt.setString(4, registration.getStatus().name());

            int rowsInserted = stmt.executeUpdate();

            // Set the generated ID back to the registration object
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        registration.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error creating registration: " + e.getMessage());
            return false;
        }
    }

    public Registration getRegistrationById(int id) {
        String sql = "SELECT * FROM " + REGISTRATIONS_TABLE + " WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToRegistration(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting registration by ID " + id + ": " + e.getMessage());
        }
        return null;
    }

    public boolean updateRegistrationStatus(int id, RegistrationStatus status) {
        String sql = "UPDATE " + REGISTRATIONS_TABLE + " SET status = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status.name());
            stmt.setInt(2, id);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error updating registration status for ID " + id + ": " + e.getMessage());
            return false;
        }
    }

    public boolean cancelRegistration(int id) {
        return updateRegistrationStatus(id, RegistrationStatus.CANCELLED);
    }

    public boolean deleteRegistration(int id) {
        String sql = "DELETE FROM " + REGISTRATIONS_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting registration ID " + id + ": " + e.getMessage());
            return false;
        }
    }

    public List<Registration> getRegistrationsByUser(int userId) {
        List<Registration> registrations = new ArrayList<>();
        String sql = "SELECT * FROM " + REGISTRATIONS_TABLE + " WHERE user_id = ? ORDER BY registration_date DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                registrations.add(mapResultSetToRegistration(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting registrations for user " + userId + ": " + e.getMessage());
        }
        return registrations;
    }

    public List<Registration> getRegistrationsByEvent(int eventId) {
        List<Registration> registrations = new ArrayList<>();
        String sql = "SELECT * FROM " + REGISTRATIONS_TABLE + " WHERE event_id = ? AND status = ? ORDER BY registration_date ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            stmt.setString(2, RegistrationStatus.CONFIRMED.name()); // FIXED: Use CONFIRMED instead of REGISTERED
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                registrations.add(mapResultSetToRegistration(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting registrations for event " + eventId + ": " + e.getMessage());
        }
        return registrations;
    }

    public boolean isUserRegistered(int userId, int eventId) {
        String sql = "SELECT id FROM " + REGISTRATIONS_TABLE + " WHERE user_id = ? AND event_id = ? AND status = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);
            stmt.setString(3, RegistrationStatus.CONFIRMED.name()); // FIXED: Use CONFIRMED instead of REGISTERED
            ResultSet rs = stmt.executeQuery();

            return rs.next();
        } catch (SQLException e) {
            System.err.println("Error checking if user " + userId + " is registered for event " + eventId + ": " + e.getMessage());
            return false;
        }
    }

    public boolean addToWaitlist(int userId, int eventId) {
        String sql = "INSERT INTO " + REGISTRATIONS_TABLE + " (user_id, event_id, registration_date, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);
            stmt.setString(3, LocalDateTime.now().format(DATE_TIME_FORMATTER));
            stmt.setString(4, RegistrationStatus.WAITLISTED.name());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding user " + userId + " to waitlist for event " + eventId + ": " + e.getMessage());
            return false;
        }
    }

    public List<Registration> getWaitlistByEvent(int eventId) {
        List<Registration> waitlist = new ArrayList<>();
        String sql = "SELECT * FROM " + REGISTRATIONS_TABLE + " WHERE event_id = ? AND status = ? ORDER BY registration_date ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            stmt.setString(2, RegistrationStatus.WAITLISTED.name());
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                waitlist.add(mapResultSetToRegistration(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting waitlist for event " + eventId + ": " + e.getMessage());
        }
        return waitlist;
    }

    public int getRegistrationCountByEvent(int eventId) {
        String sql = "SELECT COUNT(*) FROM " + REGISTRATIONS_TABLE + " WHERE event_id = ? AND status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            stmt.setString(2, RegistrationStatus.CONFIRMED.name()); // FIXED: Use CONFIRMED instead of REGISTERED
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("Error getting registration count for event " + eventId + ": " + e.getMessage());
            return 0;
        }
    }

    public int getUserRegistrationCount(int userId) {
        String sql = "SELECT COUNT(*) FROM " + REGISTRATIONS_TABLE + " WHERE user_id = ? AND status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, RegistrationStatus.CONFIRMED.name()); // FIXED: Use CONFIRMED instead of REGISTERED
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("Error getting registration count for user " + userId + ": " + e.getMessage());
            return 0;
        }
    }

    public boolean promoteFromWaitlist(int registrationId) {
        return updateRegistrationStatus(registrationId, RegistrationStatus.CONFIRMED); // FIXED: Use CONFIRMED instead of REGISTERED
    }

    private Registration mapResultSetToRegistration(ResultSet rs) throws SQLException {
        Registration registration = new Registration();
        registration.setId(rs.getInt("id"));
        registration.setUserId(rs.getInt("user_id"));
        registration.setEventId(rs.getInt("event_id"));

        // Convert String to LocalDateTime
        String registrationDateStr = rs.getString("registration_date");
        if (registrationDateStr != null) {
            registration.setRegistrationDate(LocalDateTime.parse(registrationDateStr.replace(" ", "T")));
        }

        // Convert String to RegistrationStatus enum
        String statusStr = rs.getString("status");
        if (statusStr != null) {
            registration.setStatus(RegistrationStatus.valueOf(statusStr.toUpperCase()));
        }

        return registration;
    }
}