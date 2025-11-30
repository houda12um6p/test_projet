package com.um6p.servlet;

import com.um6p.dao.UserDAO;
import com.um6p.model.User;
import com.um6p.model.User.UserRole;
import com.um6p.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/setup-users")
public class SetupUsersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>User Setup</title></head><body>");
        out.println("<h1>Setting Up Test Users...</h1>");

        UserDAO userDAO = new UserDAO();
        String password = "Password123";
        String hashedPassword = PasswordUtil.hashPassword(password);

        out.println("<p>Password: " + password + "</p>");
        out.println("<p>Hashed: " + hashedPassword + "</p>");

        // Test verification
        boolean verified = PasswordUtil.verifyPassword(password, hashedPassword);
        out.println("<p>New hash verification: " + (verified ? "SUCCESS" : "FAILED") + "</p>");

        // Test old hash
        String oldHash = "$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyJgHlqKe/TK";
        boolean oldVerified = PasswordUtil.verifyPassword(password, oldHash);
        out.println("<p>Old hash verification: " + (oldVerified ? "SUCCESS" : "FAILED") + "</p>");

        out.println("<hr>");

        // First, delete existing users with same emails
        try {
            java.sql.Connection conn = com.um6p.util.DatabaseConnection.getConnection();
            String deleteSql = "DELETE FROM users WHERE email IN ('admin@um6p.ma', 'librarian@um6p.ma', 'organizer@um6p.ma', 'student@um6p.ma')";
            java.sql.Statement stmt = conn.createStatement();
            int deleted = stmt.executeUpdate(deleteSql);
            out.println("<p>Deleted " + deleted + " existing test users</p>");
            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:orange'>Warning deleting old users: " + e.getMessage() + "</p>");
        }

        // Create users using UserDAO
        try {
            // Admin
            User admin = new User();
            admin.setEmail("admin@um6p.ma");
            admin.setPassword(hashedPassword);
            admin.setName("Admin User");
            admin.setRole(UserRole.ADMIN);

            out.println("<p>Creating admin with role: " + admin.getRole().name() + "</p>");
            boolean adminCreated = userDAO.createUser(admin);
            out.println("<p>Admin user: " + (adminCreated ? "CREATED" : "FAILED") + "</p>");

            // Librarian
            User librarian = new User();
            librarian.setEmail("librarian@um6p.ma");
            librarian.setPassword(hashedPassword);
            librarian.setName("Sarah Johnson");
            librarian.setRole(UserRole.LIBRARIAN);

            boolean librarianCreated = userDAO.createUser(librarian);
            out.println("<p>Librarian user: " + (librarianCreated ? "CREATED" : "FAILED") + "</p>");

            // Organizer
            User organizer = new User();
            organizer.setEmail("organizer@um6p.ma");
            organizer.setPassword(hashedPassword);
            organizer.setName("Mohammed Alaoui");
            organizer.setRole(UserRole.ORGANIZER);

            boolean organizerCreated = userDAO.createUser(organizer);
            out.println("<p>Organizer user: " + (organizerCreated ? "CREATED" : "FAILED") + "</p>");

            // Student
            User student = new User();
            student.setEmail("student@um6p.ma");
            student.setPassword(hashedPassword);
            student.setName("Houda Toudali");
            student.setRole(UserRole.STUDENT);

            boolean studentCreated = userDAO.createUser(student);
            out.println("<p>Student user: " + (studentCreated ? "CREATED" : "FAILED") + "</p>");

            out.println("<hr>");
            out.println("<h2>DONE! Try logging in now with:</h2>");
            out.println("<p>Email: admin@um6p.ma</p>");
            out.println("<p>Password: Password123</p>");

        } catch (Exception e) {
            out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace(out);
        }

        out.println("</body></html>");
    }
}
