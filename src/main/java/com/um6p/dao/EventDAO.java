package com.um6p.dao;

import com.um6p.model.Event;
import com.um6p.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    // Constants for better maintainability
    private static final String EVENTS_TABLE = "events";
    private static final String STATUS_ACTIVE = "active";
    private static final String STATUS_CANCELLED = "cancelled";
    private static final String STATUS_COMPLETED = "completed";

    public boolean createEvent(Event event) {
        String sql = "INSERT INTO " + EVENTS_TABLE + " (title, description, event_date, location, capacity, current_attendees, category, status, created_by, created_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setString(3, event.getEventDate());
            stmt.setString(4, event.getLocation());
            stmt.setInt(5, event.getCapacity());
            stmt.setInt(6, 0); // Start with 0 attendees
            stmt.setString(7, event.getCategory());
            stmt.setString(8, event.getStatus());
            stmt.setInt(9, event.getCreatedBy());
            stmt.setTimestamp(10, new Timestamp(System.currentTimeMillis()));

            int rowsInserted = stmt.executeUpdate();

            // Set the generated ID back to the event object
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        event.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error creating event: " + e.getMessage());
            return false;
        }
    }

    public Event getEventById(int id) {
        String sql = "SELECT * FROM " + EVENTS_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToEvent(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting event by ID " + id + ": " + e.getMessage());
        }
        return null;
    }

    public boolean updateEvent(Event event) {
        String sql = "UPDATE " + EVENTS_TABLE + " SET title=?, description=?, event_date=?, location=?, capacity=?, category=?, status=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setString(3, event.getEventDate());
            stmt.setString(4, event.getLocation());
            stmt.setInt(5, event.getCapacity());
            stmt.setString(6, event.getCategory());
            stmt.setString(7, event.getStatus());
            stmt.setInt(8, event.getId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error updating event ID " + event.getId() + ": " + e.getMessage());
            return false;
        }
    }

    public boolean deleteEvent(int id) {
        String sql = "DELETE FROM " + EVENTS_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting event ID " + id + ": " + e.getMessage());
            return false;
        }
    }

    public List<Event> getAllEvents() {
        return getEventsByStatus(STATUS_ACTIVE);
    }

    public List<Event> getEventsByStatus(String status) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM " + EVENTS_TABLE + " WHERE status = ? ORDER BY event_date ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting events by status " + status + ": " + e.getMessage());
        }
        return events;
    }

    public List<Event> getEventsByCategory(String category) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM " + EVENTS_TABLE + " WHERE category = ? AND status = ? ORDER BY event_date ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category);
            stmt.setString(2, STATUS_ACTIVE);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting events by category " + category + ": " + e.getMessage());
        }
        return events;
    }

    public List<Event> getUpcomingEvents(int limit) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM " + EVENTS_TABLE + " WHERE status = ? AND event_date >= CURDATE() ORDER BY event_date ASC LIMIT ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, STATUS_ACTIVE);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting upcoming events: " + e.getMessage());
        }
        return events;
    }

    public boolean hasCapacity(int eventId) {
        String sql = "SELECT capacity, current_attendees FROM " + EVENTS_TABLE + " WHERE id = ? AND status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            stmt.setString(2, STATUS_ACTIVE);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int capacity = rs.getInt("capacity");
                int currentAttendees = rs.getInt("current_attendees");
                return currentAttendees < capacity;
            }
        } catch (SQLException e) {
            System.err.println("Error checking capacity for event ID " + eventId + ": " + e.getMessage());
        }
        return false;
    }

    public boolean incrementAttendees(int eventId) {
        String sql = "UPDATE " + EVENTS_TABLE + " SET current_attendees = current_attendees + 1 WHERE id = ? AND current_attendees < capacity";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error incrementing attendees for event ID " + eventId + ": " + e.getMessage());
            return false;
        }
    }

    public boolean decrementAttendees(int eventId) {
        String sql = "UPDATE " + EVENTS_TABLE + " SET current_attendees = current_attendees - 1 WHERE id = ? AND current_attendees > 0";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error decrementing attendees for event ID " + eventId + ": " + e.getMessage());
            return false;
        }
    }

    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM " + EVENTS_TABLE + " WHERE category IS NOT NULL ORDER BY category";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                categories.add(rs.getString("category"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting event categories: " + e.getMessage());
        }
        return categories;
    }

    public int getEventCountByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM " + EVENTS_TABLE + " WHERE status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } catch (SQLException e) {
            System.err.println("Error getting event count for status " + status + ": " + e.getMessage());
            return 0;
        }
    }

    private Event mapResultSetToEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setId(rs.getInt("id"));
        event.setTitle(rs.getString("title"));
        event.setDescription(rs.getString("description"));
        event.setEventDate(rs.getString("event_date"));
        event.setLocation(rs.getString("location"));
        event.setCapacity(rs.getInt("capacity"));
        event.setCurrentAttendees(rs.getInt("current_attendees"));
        event.setCategory(rs.getString("category"));
        event.setStatus(rs.getString("status"));
        event.setCreatedBy(rs.getInt("created_by"));

        Timestamp createdDate = rs.getTimestamp("created_date");
        if (createdDate != null) {
            event.setCreatedDate(createdDate.toString());
        }

        return event;
    }
}