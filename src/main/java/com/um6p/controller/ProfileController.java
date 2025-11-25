package com.um6p.controller;

import com.um6p.dao.StudentDAO;
import com.um6p.dao.StaffDAO;
import com.um6p.dao.UserDAO;
import com.um6p.model.Student;
import com.um6p.model.Staff;
import com.um6p.model.User;
import com.um6p.util.PasswordUtil;
import com.um6p.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile/*")
public class ProfileController extends HttpServlet {

    private UserDAO userDAO;
    private StudentDAO studentDAO;
    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        studentDAO = new StudentDAO();
        staffDAO = new StaffDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // View profile
            viewProfile(request, response);
        } else if (pathInfo.equals("/edit")) {
            // Show edit profile form
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
        } else if (pathInfo.equals("/change-password")) {
            // Show change password form
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } else if (pathInfo.equals("/update")) {
            // Update profile
            updateProfile(request, response);
        } else if (pathInfo.equals("/change-password")) {
            // Change password
            changePassword(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get role-specific details
        if ("student".equals(user.getRole())) {
            Student student = studentDAO.getStudentByUserId(user.getId());
            request.setAttribute("student", student);
        } else if ("staff".equals(user.getRole())) {
            Staff staff = staffDAO.getStaffByUserId(user.getId());
            request.setAttribute("staff", staff);
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Validation
        if (!ValidationUtil.isValidName(name)) {
            request.setAttribute("error", "Invalid name format");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("error", "Invalid phone number");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
            return;
        }

        // Check if email is being changed and if it already exists
        if (!email.equals(user.getEmail()) && userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already exists. Please use a different email.");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
            return;
        }

        // Update user
        user.setName(name);
        user.setEmail(email);
        boolean userUpdated = userDAO.updateUser(user);

        // Update role-specific details
        boolean roleUpdated = false;
        if ("student".equals(user.getRole())) {
            Student student = studentDAO.getStudentByUserId(user.getId());
            if (student != null) {
                student.setPhone(phone);
                roleUpdated = studentDAO.updateStudent(student);
            }
        } else if ("staff".equals(user.getRole())) {
            Staff staff = staffDAO.getStaffByUserId(user.getId());
            if (staff != null) {
                staff.setPhone(phone);
                roleUpdated = staffDAO.updateStaff(staff);
            }
        }

        if (userUpdated) {
            // Update session
            session.setAttribute("user", user);
            session.setAttribute("userName", user.getName());
            response.sendRedirect(request.getContextPath() + "/profile?success=Profile updated successfully");
        } else {
            request.setAttribute("error", "Failed to update profile");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/editProfile.jsp").forward(request, response);
        }
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate current password
        if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
            request.setAttribute("error", "Current password is incorrect");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // Validate new password is different from current
        if (currentPassword.equals(newPassword)) {
            request.setAttribute("error", "New password must be different from current password");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // Validate new password strength
        if (!PasswordUtil.isStrongPassword(newPassword)) {
            request.setAttribute("error", "New password must be at least 8 characters long and contain letters and numbers");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // Update password
        boolean passwordChanged = userDAO.changePassword(user.getId(), newPassword);

        if (passwordChanged) {
            // Invalidate session for security - force re-login with new password
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp?success=Password changed successfully. Please login with your new password.");
        } else {
            request.setAttribute("error", "Failed to change password");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
        }
    }
}