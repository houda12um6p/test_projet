package com.um6p.controller;

import com.um6p.dao.UserDAO;
import com.um6p.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // User already logged in, redirect to appropriate dashboard
            User user = (User) session.getAttribute("user");
            if ("staff".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard.jsp");
            }
            return;
        }

        // Redirect to login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both email and password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Validate UM6P email domain
        if (!email.endsWith("@um6p.ma")) {
            request.setAttribute("error", "Only UM6P email addresses (@um6p.ma) are allowed.");
            request.setAttribute("email", email); // Preserve entered email
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Check login attempts (basic rate limiting)
        HttpSession session = request.getSession();
        Integer loginAttempts = (Integer) session.getAttribute("loginAttempts");

        if (loginAttempts == null) {
            loginAttempts = 0;
        }

        if (loginAttempts >= 5) {
            request.setAttribute("error", "Too many login attempts. Please try again later.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Validate login credentials
        User user = userDAO.validateLogin(email, password);

        if (user != null) {
            // Login successful - create session
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getName());
            session.setAttribute("loginAttempts", 0); // Reset attempts
            session.setMaxInactiveInterval(30 * 60); // 30 minutes session timeout

            // Redirect based on role
            if ("staff".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard.jsp");
            }
        } else {
            // Login failed - increment attempts
            session.setAttribute("loginAttempts", loginAttempts + 1);
            request.setAttribute("error", "Invalid email or password. Please try again.");
            request.setAttribute("email", email); // Preserve entered email
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}