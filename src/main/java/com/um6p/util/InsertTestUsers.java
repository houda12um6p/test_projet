package com.um6p.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class InsertTestUsers {

    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("  INSERTING TEST USERS");
        System.out.println("========================================\n");

        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("✓ Database connection successful!\n");

            // Clear existing test users
            String deleteSql = "DELETE FROM users WHERE email IN ('admin@um6p.ma', 'librarian@um6p.ma', 'organizer@um6p.ma', 'student@um6p.ma')";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
            int deleted = deleteStmt.executeUpdate();
            System.out.println("Removed " + deleted + " existing test users\n");

            // Generate FRESH BCrypt hash for "Password123"
            String password = "Password123";
            String passwordHash = PasswordUtil.hashPassword(password);
            System.out.println("Generated hash: " + passwordHash);

            // Insert test users - using 'password' column not 'password_hash'
            String insertSql = "INSERT INTO users (email, password, name, role) VALUES (?, ?, ?, ?)";

            // Admin
            PreparedStatement stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, "admin@um6p.ma");
            stmt.setString(2, passwordHash);
            stmt.setString(3, "Admin User");
            stmt.setString(4, "admin");
            stmt.executeUpdate();
            System.out.println("✓ Inserted: admin@um6p.ma");

            // Librarian
            stmt.setString(1, "librarian@um6p.ma");
            stmt.setString(2, passwordHash);
            stmt.setString(3, "Sarah Johnson");
            stmt.setString(4, "librarian");
            stmt.executeUpdate();
            System.out.println("✓ Inserted: librarian@um6p.ma");

            // Organizer
            stmt.setString(1, "organizer@um6p.ma");
            stmt.setString(2, passwordHash);
            stmt.setString(3, "Mohammed Alaoui");
            stmt.setString(4, "organizer");
            stmt.executeUpdate();
            System.out.println("✓ Inserted: organizer@um6p.ma");

            // Student
            stmt.setString(1, "student@um6p.ma");
            stmt.setString(2, passwordHash);
            stmt.setString(3, "Houda Toudali");
            stmt.setString(4, "student");
            stmt.executeUpdate();
            System.out.println("✓ Inserted: student@um6p.ma");

            // Verify
            System.out.println("\n========================================");
            System.out.println("Verifying users in database:");
            System.out.println("========================================\n");

            String verifySql = "SELECT id, email, name, role FROM users WHERE email LIKE '%@um6p.ma'";
            PreparedStatement verifyStmt = conn.prepareStatement(verifySql);
            ResultSet rs = verifyStmt.executeQuery();

            int count = 0;
            while (rs.next()) {
                count++;
                System.out.printf("  %d. %s (%s) - Role: %s\n",
                    rs.getInt("id"),
                    rs.getString("email"),
                    rs.getString("name"),
                    rs.getString("role")
                );
            }

            System.out.println("\n========================================");
            System.out.println("SUCCESS! " + count + " test users inserted!");
            System.out.println("========================================\n");
            System.out.println("You can now login at:");
            System.out.println("  http://localhost:8080/learning-center/login\n");
            System.out.println("Test Accounts:");
            System.out.println("  admin@um6p.ma / Password123");
            System.out.println("  librarian@um6p.ma / Password123");
            System.out.println("  organizer@um6p.ma / Password123");
            System.out.println("  student@um6p.ma / Password123\n");

        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
