package com.um6p.controller;

import com.um6p.dao.StudentDAO;
import com.um6p.dao.StaffDAO;
import com.um6p.dao.UserDAO;
import com.um6p.model.Student;
import com.um6p.model.Staff;
import com.um6p.model.User;
import com.um6p.model.User.UserRole;
import com.um6p.util.PasswordUtil;
import com.um6p.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

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
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get all parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");
        String major = request.getParameter("major");
        String studentIdNumber = request.getParameter("studentIdNumber");
        String department = request.getParameter("department");
        String position = request.getParameter("position");
        String officeLocation = request.getParameter("officeLocation");

        // Preserve form data for error cases
        preserveFormData(request, name, email, phone, role, major, studentIdNumber, department, position, officeLocation);

        // Validation
        StringBuilder errors = validateRegistration(name, email, password, confirmPassword, role, phone, studentIdNumber);

        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Hash password
        String hashedPassword = PasswordUtil.hashPassword(password);

        UserRole userRole;
        try {
            // FIX: Ensure the role string is converted safely to the UserRole enum
            userRole = UserRole.valueOf(role.toUpperCase());
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid user role specified.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Create user
        User user = new User(email, hashedPassword, name, userRole);
        boolean userCreated = userDAO.createUser(user);

        if (!userCreated) {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Get the created user to get the ID
        user = userDAO.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Registration failed. Could not retrieve new user record.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        boolean roleSpecificCreated = false;

        try {
            if ("student".equals(role)) {
                // FIX: Use default constructor and setters (resolves "No suitable constructor found for Student")
                Student student = new Student();
                student.setUserId(user.getId());
                student.setEnrollmentDate(LocalDate.now());
                student.setMajor(major);
                student.setStudentIdNumber(studentIdNumber);
                student.setPhone(phone);
                roleSpecificCreated = studentDAO.createStudent(student);

            } else if ("staff".equals(role)) {
                // FIX: Use default constructor and setters (resolves "No suitable constructor found for Staff")
                Staff staff = new Staff();
                staff.setUserId(user.getId());
                staff.setDepartment(department);
                staff.setPosition(position);
                staff.setHireDate(LocalDate.now());
                staff.setPhone(phone);
                staff.setOfficeLocation(officeLocation);
                roleSpecificCreated = staffDAO.createStaff(staff);
            }

            if (roleSpecificCreated) {
                // Registration successful - redirect to prevent form resubmission
                response.sendRedirect(request.getContextPath() + "/login?success=Registration successful! Please log in.");
            } else {
                // Rollback user creation
                userDAO.deleteUser(user.getId());
                request.setAttribute("error", "Registration failed in role-specific record creation. Please try again.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Rollback user creation on any error
            userDAO.deleteUser(user.getId());
            request.setAttribute("error", "Registration failed due to system error: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private StringBuilder validateRegistration(String name, String email, String password,
                                               String confirmPassword, String role,
                                               String phone, String studentIdNumber) {
        StringBuilder errors = new StringBuilder();

        if (!ValidationUtil.isValidName(name)) {
            errors.append("Invalid name. Name must contain only letters and be at least 2 characters long. ");
        }

        if (!ValidationUtil.isUM6PEmail(email)) {
            errors.append("Invalid email. Must be a valid UM6P email (@um6p.ma). ");
        }

        if (!PasswordUtil.isStrongPassword(password)) {
            errors.append("Password must be at least 8 characters long and contain letters and numbers. ");
        }

        if (!password.equals(confirmPassword)) {
            errors.append("Passwords do not match. ");
        }

        if (!ValidationUtil.isValidPhone(phone)) {
            errors.append("Invalid phone number. Must be 10 digits. ");
        }

        if (userDAO.emailExists(email)) {
            errors.append("Email already registered. ");
        }

        if ("student".equals(role) && !ValidationUtil.isValidStudentId(studentIdNumber)) {
            errors.append("Invalid student ID format. Must be STD followed by 3 digits (e.g., STD001). ");
        }

        return errors;
    }

    private void preserveFormData(HttpServletRequest request, String name, String email,
                                  String phone, String role, String major, String studentIdNumber,
                                  String department, String position, String officeLocation) {
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("role", role);
        request.setAttribute("major", major);
        request.setAttribute("studentIdNumber", studentIdNumber);
        request.setAttribute("department", department);
        request.setAttribute("position", position);
        request.setAttribute("officeLocation", officeLocation);
    }
}