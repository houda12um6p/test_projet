package com.um6p.dao;

import com.um6p.model.Notification;
import com.um6p.util.DatabaseConnection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {
    private static final Logger logger = LoggerFactory.getLogger(NotificationDAO.class);
    private static final String NOTIFICATIONS_TABLE = "notifications";

    public boolean createNotification(Notification notification) {
        String sql = "INSERT INTO " + NOTIFICATIONS_TABLE +
                     " (user_id, title, message, type, is_read, created_at) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, notification.getUserId());
            stmt.setString(2, notification.getTitle());
            stmt.setString(3, notification.getMessage());
            stmt.setString(4, notification.getType());
            stmt.setBoolean(5, notification.isRead());
            stmt.setTimestamp(6, Timestamp.valueOf(notification.getCreatedAt()));

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        notification.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            logger.error("Error creating notification for user {}: {}",
                    notification.getUserId(), e.getMessage(), e);
            return false;
        }
    }

    public Notification getNotificationById(int id) {
        String sql = "SELECT * FROM " + NOTIFICATIONS_TABLE + " WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToNotification(rs);
            }
        } catch (SQLException e) {
            logger.error("Error getting notification by ID {}: {}", id, e.getMessage(), e);
        }
        return null;
    }

    public List<Notification> getNotificationsByUser(int userId) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM " + NOTIFICATIONS_TABLE +
                     " WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                notifications.add(mapResultSetToNotification(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting notifications for user {}: {}", userId, e.getMessage(), e);
        }
        return notifications;
    }

    public List<Notification> getUnreadNotificationsByUser(int userId) {
        List<Notification> notifications = new ArrayList<>();
        String sql = "SELECT * FROM " + NOTIFICATIONS_TABLE +
                     " WHERE user_id = ? AND is_read = FALSE ORDER BY created_at DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                notifications.add(mapResultSetToNotification(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting unread notifications for user {}: {}", userId, e.getMessage(), e);
        }
        return notifications;
    }

    public boolean markAsRead(int notificationId) {
        String sql = "UPDATE " + NOTIFICATIONS_TABLE + " SET is_read = TRUE WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, notificationId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error marking notification {} as read: {}", notificationId, e.getMessage(), e);
            return false;
        }
    }

    public boolean markAllAsRead(int userId) {
        String sql = "UPDATE " + NOTIFICATIONS_TABLE + " SET is_read = TRUE WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error marking all notifications as read for user {}: {}", userId, e.getMessage(), e);
            return false;
        }
    }

    public boolean deleteNotification(int id) {
        String sql = "DELETE FROM " + NOTIFICATIONS_TABLE + " WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error deleting notification {}: {}", id, e.getMessage(), e);
            return false;
        }
    }

    public int getUnreadCount(int userId) {
        String sql = "SELECT COUNT(*) FROM " + NOTIFICATIONS_TABLE +
                     " WHERE user_id = ? AND is_read = FALSE";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            logger.error("Error getting unread count for user {}: {}", userId, e.getMessage(), e);
        }
        return 0;
    }

    private Notification mapResultSetToNotification(ResultSet rs) throws SQLException {
        Notification notification = new Notification();
        notification.setId(rs.getInt("id"));
        notification.setUserId(rs.getInt("user_id"));
        notification.setTitle(rs.getString("title"));
        notification.setMessage(rs.getString("message"));
        notification.setType(rs.getString("type"));
        notification.setRead(rs.getBoolean("is_read"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            notification.setCreatedAt(createdAt.toLocalDateTime());
        }

        return notification;
    }
}
