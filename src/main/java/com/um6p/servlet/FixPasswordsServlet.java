package com.um6p.servlet;

import com.um6p.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/fix-passwords")
public class FixPasswordsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Fix Passwords</title></head><body>");
        out.println("<h1>Fixing User Passwords...</h1>");

        String password = "Password123";
        String hashedPassword = PasswordUtil.hashPassword(password);

        out.println("<p><strong>Password:</strong> " + password + "</p>");
        out.println("<p><strong>New Hash:</strong> " + hashedPassword + "</p>");

        // Test verification
        boolean verified = PasswordUtil.verifyPassword(password, hashedPassword);
        out.println("<p><strong>Verification:</strong> " + (verified ? "SUCCESS" : "FAILED") + "</p>");

        out.println("<hr>");

        // Update passwords for all test users
        try {
            Connection conn = com.um6p.util.DatabaseConnection.getConnection();
            out.println("<p>Database connection: SUCCESS</p>");

            // Update all test users with the new password hash
            String updateSql = "UPDATE users SET password = ? WHERE email IN ('admin@um6p.ma', 'librarian@um6p.ma', 'organizer@um6p.ma', 'student@um6p.ma')";
            PreparedStatement stmt = conn.prepareStatement(updateSql);
            stmt.setString(1, hashedPassword);
            int updated = stmt.executeUpdate();

            out.println("<p><strong>Users updated:</strong> " + updated + "</p>");

            // Verify the update
            String selectSql = "SELECT email, name, role FROM users WHERE email IN ('admin@um6p.ma', 'librarian@um6p.ma', 'organizer@um6p.ma', 'student@um6p.ma')";
            PreparedStatement selectStmt = conn.prepareStatement(selectSql);
            ResultSet rs = selectStmt.executeQuery();

            out.println("<h2>Updated Users:</h2>");
            out.println("<ul>");
            while (rs.next()) {
                out.println("<li>" + rs.getString("email") + " - " + rs.getString("name") + " (" + rs.getString("role") + ")</li>");
            }
            out.println("</ul>");

            conn.close();

            out.println("<hr>");
            out.println("<h2 style='color:green'>SUCCESS! All users updated!</h2>");
            out.println("<p>You can now log in with:</p>");
            out.println("<ul>");
            out.println("<li>Email: <strong>admin@um6p.ma</strong></li>");
            out.println("<li>Password: <strong>Password123</strong></li>");
            out.println("</ul>");
            out.println("<p><a href='/learning-center/login'>Go to Login Page</a></p>");

        } catch (Exception e) {
            out.println("<p style='color:red'><strong>ERROR:</strong> " + e.getMessage() + "</p>");
            out.println("<pre>");
            e.printStackTrace(out);
            out.println("</pre>");
        }

        out.println("</body></html>");
    }
}
