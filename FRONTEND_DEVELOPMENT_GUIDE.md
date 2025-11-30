# Complete Frontend Development Guide
## UM6P Learning Center Management System

**Version**: 1.0
**Date**: November 25, 2025
**Status**: Backend Complete - Frontend Development Guide

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Technology Stack](#technology-stack)
3. [Design System](#design-system)
4. [Page-by-Page Development](#page-by-page-development)
5. [Component Library](#component-library)
6. [JavaScript Functionality](#javascript-functionality)
7. [Responsive Design](#responsive-design)
8. [Best Practices](#best-practices)
9. [Testing Checklist](#testing-checklist)
10. [Deployment](#deployment)

---

## 1. Overview

### Project Structure
```
webapp/
├── assets/
│   ├── css/
│   │   ├── main.css              # Main stylesheet
│   │   ├── components.css        # Reusable components
│   │   ├── dashboard.css         # Dashboard styles
│   │   ├── forms.css            # Form styles
│   │   └── responsive.css       # Media queries
│   ├── js/
│   │   ├── main.js              # Core functionality
│   │   ├── auth.js              # Authentication
│   │   ├── books.js             # Book management
│   │   ├── events.js            # Event management
│   │   ├── reservations.js      # Reservation system
│   │   └── utils.js             # Utility functions
│   └── images/
│       ├── logo.svg
│       ├── icons/
│       └── illustrations/
├── WEB-INF/
│   ├── includes/
│   │   ├── header.jsp
│   │   ├── footer.jsp
│   │   ├── sidebar.jsp
│   │   └── notifications.jsp
│   └── web.xml
├── public/                       # Public pages
│   ├── index.jsp
│   ├── about.jsp
│   ├── contact.jsp
│   ├── books.jsp
│   └── events.jsp
├── student/                      # Student portal
│   ├── dashboard.jsp
│   ├── my-books.jsp
│   ├── my-events.jsp
│   ├── browse-books.jsp
│   └── profile.jsp
├── staff/                        # Staff portal
│   ├── dashboard.jsp
│   ├── manage-events.jsp
│   └── reports.jsp
├── librarian/                    # Librarian portal
│   ├── dashboard.jsp
│   ├── manage-books.jsp
│   ├── manage-borrowings.jsp
│   ├── reservations.jsp
│   └── library-reports.jsp
├── admin/                        # Administrator portal
│   ├── dashboard.jsp
│   ├── events.jsp
│   ├── attendance.jsp
│   └── analytics.jsp
├── system-admin/                 # System Admin portal
│   ├── dashboard.jsp
│   ├── users.jsp
│   ├── system-config.jsp
│   └── logs.jsp
├── login.jsp
└── register.jsp
```

---

## 2. Technology Stack

### Required Libraries (CDN or Local)

#### CSS Frameworks
```html
<!-- Bootstrap 5.3 (Recommended) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- OR Tailwind CSS (Alternative) -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
```

#### JavaScript Libraries
```html
<!-- jQuery (for simplicity) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- DataTables (for table management) -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>

<!-- SweetAlert2 (for beautiful alerts) -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Chart.js (for analytics) -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>

<!-- FullCalendar (for event calendar) -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/main.min.js'></script>
```

---

## 3. Design System

### Color Palette

```css
:root {
    /* Primary Colors - UM6P Brand */
    --primary: #003366;           /* UM6P Navy Blue */
    --primary-dark: #002244;
    --primary-light: #1a4d7a;

    /* Secondary Colors */
    --secondary: #28a745;         /* Success Green */
    --accent: #ffc107;           /* Warning/Accent Yellow */
    --danger: #dc3545;           /* Error Red */

    /* Neutral Colors */
    --text-primary: #212529;
    --text-secondary: #6c757d;
    --text-light: #adb5bd;

    /* Background Colors */
    --bg-primary: #ffffff;
    --bg-secondary: #f8f9fa;
    --bg-dark: #212529;

    /* Border Colors */
    --border-color: #dee2e6;
    --border-light: #e9ecef;

    /* Status Colors */
    --success: #28a745;
    --info: #17a2b8;
    --warning: #ffc107;
    --error: #dc3545;

    /* Shadows */
    --shadow-sm: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    --shadow-md: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
    --shadow-lg: 0 1rem 3rem rgba(0, 0, 0, 0.175);

    /* Transitions */
    --transition: all 0.3s ease;

    /* Border Radius */
    --radius-sm: 0.25rem;
    --radius-md: 0.5rem;
    --radius-lg: 1rem;

    /* Spacing */
    --spacing-xs: 0.5rem;
    --spacing-sm: 1rem;
    --spacing-md: 1.5rem;
    --spacing-lg: 2rem;
    --spacing-xl: 3rem;
}
```

### Typography

```css
body {
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-size: 16px;
    line-height: 1.6;
    color: var(--text-primary);
}

h1, h2, h3, h4, h5, h6 {
    font-weight: 600;
    line-height: 1.2;
    margin-bottom: 1rem;
}

h1 { font-size: 2.5rem; }
h2 { font-size: 2rem; }
h3 { font-size: 1.75rem; }
h4 { font-size: 1.5rem; }
h5 { font-size: 1.25rem; }
h6 { font-size: 1rem; }

.text-small { font-size: 0.875rem; }
.text-tiny { font-size: 0.75rem; }
```

---

## 4. Page-by-Page Development

### 4.1 Login Page (`login.jsp`)

**Professional Design with Modern UI**

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - UM6P Learning Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        :root {
            --primary: #003366;
            --primary-dark: #002244;
        }

        body {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Inter', sans-serif;
        }

        .login-card {
            background: white;
            border-radius: 1rem;
            box-shadow: 0 1rem 3rem rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }

        .login-left {
            background: var(--primary);
            color: white;
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-right {
            padding: 3rem;
        }

        .logo {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(0, 51, 102, 0.25);
        }

        .btn-primary {
            background: var(--primary);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        .input-group-text {
            background: transparent;
            border-right: none;
        }

        .form-control {
            border-left: none;
        }

        .alert {
            border-radius: 0.5rem;
            border: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="login-card row g-0">
                    <!-- Left Side - Branding -->
                    <div class="col-md-5 login-left">
                        <div class="logo">
                            <i class="fas fa-book-reader"></i> Learning Center
                        </div>
                        <h2 class="mb-4">Welcome Back!</h2>
                        <p class="lead">Access your personalized learning dashboard</p>
                        <ul class="list-unstyled mt-4">
                            <li class="mb-3"><i class="fas fa-check-circle me-2"></i> Browse 1000+ Books</li>
                            <li class="mb-3"><i class="fas fa-check-circle me-2"></i> Register for Workshops</li>
                            <li class="mb-3"><i class="fas fa-check-circle me-2"></i> Reserve Books Online</li>
                        </ul>
                    </div>

                    <!-- Right Side - Login Form -->
                    <div class="col-md-7 login-right">
                        <h3 class="mb-4">Sign In</h3>

                        <!-- Error Alert -->
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <%
                                    String error = request.getParameter("error");
                                    if ("invalid".equals(error)) {
                                        out.print("Invalid email or password. Please try again.");
                                    } else if ("session_timeout".equals(error)) {
                                        out.print("Your session has expired. Please login again.");
                                    } else if ("login_required".equals(error)) {
                                        out.print("Please login to access this page.");
                                    }
                                %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>

                        <!-- Success Alert -->
                        <% if (request.getParameter("registered") != null) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="fas fa-check-circle me-2"></i>
                                Registration successful! Please login with your credentials.
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        <% } %>

                        <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                            <!-- Email Input -->
                            <div class="mb-4">
                                <label for="email" class="form-label">Email Address</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-envelope"></i>
                                    </span>
                                    <input type="email" class="form-control" id="email" name="email"
                                           placeholder="your.name@um6p.ma" required>
                                </div>
                            </div>

                            <!-- Password Input -->
                            <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-lock"></i>
                                    </span>
                                    <input type="password" class="form-control" id="password" name="password"
                                           placeholder="Enter your password" required>
                                    <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Remember Me & Forgot Password -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="remember" name="remember">
                                    <label class="form-check-label" for="remember">
                                        Remember me
                                    </label>
                                </div>
                                <a href="#" class="text-decoration-none">Forgot Password?</a>
                            </div>

                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-primary w-100 mb-3">
                                <i class="fas fa-sign-in-alt me-2"></i> Sign In
                            </button>

                            <!-- Register Link -->
                            <div class="text-center">
                                <p class="text-muted mb-0">
                                    Don't have an account?
                                    <a href="${pageContext.request.contextPath}/register.jsp" class="text-decoration-none fw-bold">
                                        Register Now
                                    </a>
                                </p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');

            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;

            // Check if email ends with @um6p.ma
            if (!email.endsWith('@um6p.ma')) {
                e.preventDefault();
                alert('Please use your UM6P email address (@um6p.ma)');
                return false;
            }
        });
    </script>
</body>
</html>
```

### 4.2 Student Dashboard (`student/dashboard.jsp`)

**Modern Dashboard with Cards and Statistics**

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.um6p.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.isStudent()) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - UM6P Learning Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #003366;
            --sidebar-width: 250px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fa;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: var(--primary);
            color: white;
            padding: 0;
            z-index: 1000;
            transition: all 0.3s;
        }

        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-menu {
            padding: 1rem 0;
        }

        .sidebar-menu a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            padding: 0.75rem 1.5rem;
            display: flex;
            align-items: center;
            transition: all 0.3s;
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .sidebar-menu i {
            width: 20px;
            margin-right: 1rem;
        }

        /* Main Content */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
        }

        /* Top Navbar */
        .top-navbar {
            background: white;
            padding: 1rem 2rem;
            margin: -2rem -2rem 2rem -2rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }

        /* Stats Cards */
        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            transition: all 0.3s;
            border-left: 4px solid var(--primary);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        .stat-card .icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .stat-card.books .icon {
            background: rgba(0, 123, 255, 0.1);
            color: #007bff;
        }

        .stat-card.events .icon {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .stat-card.reservations .icon {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        .stat-card.borrowed .icon {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        /* Cards */
        .card {
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }

        .card-header {
            background: white;
            border-bottom: 1px solid #e9ecef;
            padding: 1.25rem;
            font-weight: 600;
        }

        /* Badges */
        .badge {
            padding: 0.5rem 1rem;
            border-radius: 2rem;
        }

        /* Quick Actions */
        .quick-action {
            background: linear-gradient(135deg, var(--primary) 0%, #002244 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 1rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: block;
        }

        .quick-action:hover {
            transform: translateY(-5px);
            box-shadow: 0 1rem 2rem rgba(0, 0, 0, 0.2);
            color: white;
        }

        .quick-action i {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h4 class="mb-0"><i class="fas fa-book-reader me-2"></i>Learning Center</h4>
            <small class="text-white-50">Student Portal</small>
        </div>

        <nav class="sidebar-menu">
            <a href="dashboard.jsp" class="active">
                <i class="fas fa-home"></i> Dashboard
            </a>
            <a href="browse-books.jsp">
                <i class="fas fa-search"></i> Browse Books
            </a>
            <a href="my-books.jsp">
                <i class="fas fa-book"></i> My Books
            </a>
            <a href="my-events.jsp">
                <i class="fas fa-calendar"></i> My Events
            </a>
            <a href="profile.jsp">
                <i class="fas fa-user"></i> Profile
            </a>
            <a href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <div class="top-navbar d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-0">Welcome back, <%= user.getName() %>! 👋</h4>
                <small class="text-muted">Here's what's happening with your account today.</small>
            </div>
            <div>
                <button class="btn btn-outline-primary me-2">
                    <i class="fas fa-bell"></i>
                    <span class="badge bg-danger rounded-pill ms-1">3</span>
                </button>
                <img src="https://ui-avatars.com/api/?name=<%= user.getName() %>&background=003366&color=fff"
                     class="rounded-circle" width="40" height="40" alt="Avatar">
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card books">
                    <div class="d-flex align-items-center">
                        <div class="icon">
                            <i class="fas fa-book"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">12</h3>
                            <small class="text-muted">Books Borrowed</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card events">
                    <div class="d-flex align-items-center">
                        <div class="icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">5</h3>
                            <small class="text-muted">Events Registered</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card reservations">
                    <div class="d-flex align-items-center">
                        <div class="icon">
                            <i class="fas fa-bookmark"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">2</h3>
                            <small class="text-muted">Active Reservations</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="stat-card borrowed">
                    <div class="d-flex align-items-center">
                        <div class="icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="ms-3">
                            <h3 class="mb-0">1</h3>
                            <small class="text-muted">Overdue Books</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Quick Actions -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-bolt me-2"></i>Quick Actions
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <a href="browse-books.jsp" class="quick-action">
                                    <i class="fas fa-search"></i>
                                    <h6 class="mt-2 mb-0">Browse Books</h6>
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="../events.jsp" class="quick-action">
                                    <i class="fas fa-calendar-plus"></i>
                                    <h6 class="mt-2 mb-0">Register Event</h6>
                                </a>
                            </div>
                            <div class="col-md-4">
                                <a href="my-books.jsp" class="quick-action">
                                    <i class="fas fa-book-open"></i>
                                    <h6 class="mt-2 mb-0">My Books</h6>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Current Borrowings -->
                <div class="card mt-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-book me-2"></i>Current Borrowings</span>
                        <a href="my-books.jsp" class="text-decoration-none">View All</a>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Book</th>
                                        <th>Borrow Date</th>
                                        <th>Due Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <strong>Clean Code</strong><br>
                                            <small class="text-muted">Robert C. Martin</small>
                                        </td>
                                        <td>Nov 15, 2025</td>
                                        <td>Nov 29, 2025</td>
                                        <td><span class="badge bg-success">Active</span></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Design Patterns</strong><br>
                                            <small class="text-muted">Gang of Four</small>
                                        </td>
                                        <td>Nov 10, 2025</td>
                                        <td>Nov 24, 2025</td>
                                        <td><span class="badge bg-warning">Due Soon</span></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Database Systems</strong><br>
                                            <small class="text-muted">Abraham Silberschatz</small>
                                        </td>
                                        <td>Nov 5, 2025</td>
                                        <td>Nov 19, 2025</td>
                                        <td><span class="badge bg-danger">Overdue</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Upcoming Events -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-calendar me-2"></i>Upcoming Events
                    </div>
                    <div class="card-body">
                        <!-- Event Item -->
                        <div class="border-start border-primary border-4 ps-3 mb-3">
                            <h6 class="mb-1">Machine Learning Workshop</h6>
                            <small class="text-muted d-block"><i class="fas fa-calendar me-1"></i>Dec 1, 2025 - 2:00 PM</small>
                            <small class="text-muted d-block"><i class="fas fa-map-marker-alt me-1"></i>Room 301</small>
                            <span class="badge bg-primary mt-2">Registered</span>
                        </div>

                        <div class="border-start border-success border-4 ps-3 mb-3">
                            <h6 class="mb-1">Web Development Seminar</h6>
                            <small class="text-muted d-block"><i class="fas fa-calendar me-1"></i>Dec 5, 2025 - 10:00 AM</small>
                            <small class="text-muted d-block"><i class="fas fa-map-marker-alt me-1"></i>Auditorium A</small>
                            <span class="badge bg-success mt-2">Registered</span>
                        </div>

                        <div class="border-start border-warning border-4 ps-3 mb-3">
                            <h6 class="mb-1">Cybersecurity Workshop</h6>
                            <small class="text-muted d-block"><i class="fas fa-calendar me-1"></i>Dec 15, 2025 - 3:00 PM</small>
                            <small class="text-muted d-block"><i class="fas fa-map-marker-alt me-1"></i>Room 205</small>
                            <button class="btn btn-sm btn-outline-primary mt-2">Register Now</button>
                        </div>
                    </div>
                </div>

                <!-- Active Reservations -->
                <div class="card mt-4">
                    <div class="card-header">
                        <i class="fas fa-bookmark me-2"></i>Active Reservations
                    </div>
                    <div class="card-body">
                        <div class="alert alert-warning">
                            <i class="fas fa-clock me-2"></i>
                            <strong>Deep Learning</strong> is ready for pickup!
                            <br><small>Expires in 36 hours</small>
                        </div>

                        <div class="border rounded p-3">
                            <h6 class="mb-1">Introduction to Algorithms</h6>
                            <small class="text-muted">Queue Position: <strong>2</strong></small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

---

## 5. Component Library

### Reusable Header Component (`WEB-INF/includes/header.jsp`)

```jsp
<%@ page import="com.um6p.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="UM6P Learning Center Management System">
    <meta name="author" content="UM6P">

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="<%= contextPath %>/assets/images/favicon.ico">

    <!-- CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/main.css">
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/components.css">
    <link rel="stylesheet" href="<%= contextPath %>/assets/css/responsive.css">

    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "UM6P Learning Center" %></title>
</head>
<body>
```

### Reusable Footer Component (`WEB-INF/includes/footer.jsp`)

```jsp
    <!-- Footer -->
    <footer class="footer mt-auto py-4 bg-dark text-white">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5><i class="fas fa-book-reader me-2"></i>Learning Center</h5>
                    <p class="text-white-50">Mohammed VI Polytechnic University</p>
                </div>
                <div class="col-md-4">
                    <h6>Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="<%= request.getContextPath() %>/books.jsp" class="text-white-50">Browse Books</a></li>
                        <li><a href="<%= request.getContextPath() %>/events.jsp" class="text-white-50">Events</a></li>
                        <li><a href="<%= request.getContextPath() %>/about.jsp" class="text-white-50">About Us</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h6>Contact</h6>
                    <p class="text-white-50 mb-0">Email: library@um6p.ma</p>
                    <p class="text-white-50">Phone: +212 5XX-XXXXXX</p>
                </div>
            </div>
            <hr class="border-white-50">
            <div class="text-center text-white-50">
                <p class="mb-0">&copy; 2025 UM6P Learning Center. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Custom Scripts -->
    <script src="<%= request.getContextPath() %>/assets/js/main.js"></script>
</body>
</html>
```

---

## 6. JavaScript Functionality

### Main JavaScript (`assets/js/main.js`)

```javascript
// Global Configuration
const App = {
    contextPath: '',
    apiBase: '/api',

    init() {
        this.contextPath = document.querySelector('meta[name="context-path"]')?.content || '';
        this.setupAjaxDefaults();
        this.setupGlobalEventListeners();
    },

    setupAjaxDefaults() {
        // Setup default AJAX settings
        $.ajaxSetup({
            beforeSend: function(xhr) {
                // Add loading indicator
                App.showLoading();
            },
            complete: function() {
                App.hideLoading();
            },
            error: function(xhr, status, error) {
                App.handleAjaxError(xhr, status, error);
            }
        });
    },

    setupGlobalEventListeners() {
        // Auto-dismiss alerts after 5 seconds
        $('.alert:not(.alert-permanent)').each(function() {
            setTimeout(() => {
                $(this).fadeOut();
            }, 5000);
        });
    },

    showLoading() {
        if (!$('#globalLoader').length) {
            $('body').append(`
                <div id="globalLoader" class="global-loader">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            `);
        }
    },

    hideLoading() {
        $('#globalLoader').fadeOut(300, function() {
            $(this).remove();
        });
    },

    handleAjaxError(xhr, status, error) {
        let message = 'An error occurred. Please try again.';

        if (xhr.status === 401) {
            message = 'Session expired. Please login again.';
            setTimeout(() => {
                window.location.href = this.contextPath + '/login.jsp';
            }, 2000);
        } else if (xhr.status === 403) {
            message = 'Access denied. You don't have permission to perform this action.';
        } else if (xhr.status === 500) {
            message = 'Server error. Please contact support.';
        }

        this.showError(message);
    },

    showSuccess(message) {
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: message,
            timer: 3000,
            showConfirmButton: false
        });
    },

    showError(message) {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: message
        });
    },

    showConfirm(title, text, confirmText = 'Yes', cancelText = 'No') {
        return Swal.fire({
            title: title,
            text: text,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: confirmText,
            cancelButtonText: cancelText,
            confirmButtonColor: '#003366',
            cancelButtonColor: '#6c757d'
        });
    }
};

// Initialize on document ready
$(document).ready(function() {
    App.init();
});

// Utility Functions
function formatDate(dateString) {
    const date = new Date(dateString);
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
}

function formatDateTime(dateString) {
    const date = new Date(dateString);
    const options = {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
    };
    return date.toLocaleDateString('en-US', options);
}

function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}
```

### Book Search JavaScript (`assets/js/books.js`)

```javascript
const BookManager = {
    searchTimeout: null,

    init() {
        this.setupSearchHandlers();
        this.setupFilterHandlers();
        this.setupReservationHandlers();
    },

    setupSearchHandlers() {
        $('#bookSearch').on('input', debounce((e) => {
            this.searchBooks(e.target.value);
        }, 500));
    },

    searchBooks(query) {
        if (query.length < 2) {
            this.loadAllBooks();
            return;
        }

        $.ajax({
            url: App.contextPath + '/books/search',
            method: 'GET',
            data: { q: query },
            success: (data) => {
                this.renderBooks(data);
            }
        });
    },

    loadAllBooks() {
        $.ajax({
            url: App.contextPath + '/books/all',
            method: 'GET',
            success: (data) => {
                this.renderBooks(data);
            }
        });
    },

    renderBooks(books) {
        const container = $('#booksContainer');
        container.empty();

        if (books.length === 0) {
            container.html(`
                <div class="col-12 text-center py-5">
                    <i class="fas fa-book-open fa-3x text-muted mb-3"></i>
                    <h5>No books found</h5>
                    <p class="text-muted">Try adjusting your search criteria</p>
                </div>
            `);
            return;
        }

        books.forEach(book => {
            container.append(this.createBookCard(book));
        });
    },

    createBookCard(book) {
        const isAvailable = book.availableCopies > 0;
        const statusBadge = isAvailable
            ? `<span class="badge bg-success">Available (${book.availableCopies})</span>`
            : `<span class="badge bg-danger">Not Available</span>`;

        return `
            <div class="col-md-4 mb-4">
                <div class="card h-100 book-card">
                    <div class="card-body">
                        <h5 class="card-title">${book.title}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">${book.author}</h6>
                        <p class="card-text">
                            <small class="text-muted">
                                <i class="fas fa-tag me-1"></i>${book.genre || 'General'}
                                <br>
                                <i class="fas fa-barcode me-1"></i>${book.isbn || 'N/A'}
                                <br>
                                <i class="fas fa-map-marker-alt me-1"></i>${book.location || 'See librarian'}
                            </small>
                        </p>
                        <div class="d-flex justify-content-between align-items-center">
                            ${statusBadge}
                            ${isAvailable
                                ? `<button class="btn btn-sm btn-primary" onclick="BookManager.reserveBook(${book.id})">
                                     <i class="fas fa-bookmark me-1"></i>Reserve
                                   </button>`
                                : `<button class="btn btn-sm btn-secondary" disabled>
                                     <i class="fas fa-times me-1"></i>Unavailable
                                   </button>`
                            }
                        </div>
                    </div>
                </div>
            </div>
        `;
    },

    reserveBook(bookId) {
        App.showConfirm(
            'Reserve Book',
            'Are you sure you want to reserve this book?',
            'Yes, Reserve'
        ).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: App.contextPath + '/reservations/create',
                    method: 'POST',
                    data: { bookId: bookId },
                    success: (data) => {
                        App.showSuccess('Book reserved successfully! You will receive an email when it\'s ready for pickup.');
                        this.loadAllBooks(); // Refresh the list
                    }
                });
            }
        });
    }
};

$(document).ready(function() {
    if ($('#booksContainer').length) {
        BookManager.init();
        BookManager.loadAllBooks();
    }
});
```

---

### Event Management JavaScript (`assets/js/events.js`)

```javascript
const EventManager = {
    calendar: null,

    init() {
        this.setupCalendar();
        this.setupRegistrationHandlers();
        this.loadUpcomingEvents();
    },

    setupCalendar() {
        if (!$('#eventCalendar').length) return;

        const calendarEl = document.getElementById('eventCalendar');
        this.calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,listWeek'
            },
            events: App.contextPath + '/events/calendar',
            eventClick: (info) => {
                this.showEventDetails(info.event);
            },
            eventColor: '#003366'
        });

        this.calendar.render();
    },

    loadUpcomingEvents() {
        $.ajax({
            url: App.contextPath + '/events/upcoming',
            method: 'GET',
            success: (events) => {
                this.renderEventsList(events);
            }
        });
    },

    renderEventsList(events) {
        const container = $('#eventsListContainer');
        container.empty();

        if (events.length === 0) {
            container.html(`
                <div class="text-center py-5">
                    <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                    <h5>No upcoming events</h5>
                    <p class="text-muted">Check back later for new workshops and seminars</p>
                </div>
            `);
            return;
        }

        events.forEach(event => {
            container.append(this.createEventCard(event));
        });
    },

    createEventCard(event) {
        const spotsLeft = event.maxCapacity - event.currentParticipants;
        const isFull = spotsLeft <= 0;
        const isRegistered = event.userRegistered || false;

        return `
            <div class="col-md-6 mb-4">
                <div class="card h-100 event-card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <h5 class="card-title mb-0">${event.title}</h5>
                            ${isRegistered
                                ? '<span class="badge bg-success"><i class="fas fa-check me-1"></i>Registered</span>'
                                : isFull
                                    ? '<span class="badge bg-danger">Full</span>'
                                    : '<span class="badge bg-primary">' + spotsLeft + ' spots left</span>'
                            }
                        </div>
                        <p class="card-text">${event.description || 'No description available'}</p>
                        <div class="event-details">
                            <p class="mb-2">
                                <i class="fas fa-calendar text-primary me-2"></i>
                                <strong>${formatDateTime(event.eventDate)}</strong>
                            </p>
                            <p class="mb-2">
                                <i class="fas fa-map-marker-alt text-primary me-2"></i>
                                ${event.location || 'TBD'}
                            </p>
                            <p class="mb-2">
                                <i class="fas fa-users text-primary me-2"></i>
                                ${event.currentParticipants} / ${event.maxCapacity} participants
                            </p>
                            ${event.instructor ? `
                                <p class="mb-2">
                                    <i class="fas fa-chalkboard-teacher text-primary me-2"></i>
                                    ${event.instructor}
                                </p>
                            ` : ''}
                        </div>
                        <div class="mt-3">
                            ${isRegistered
                                ? `<button class="btn btn-outline-danger btn-sm" onclick="EventManager.cancelRegistration(${event.id})">
                                     <i class="fas fa-times me-1"></i>Cancel Registration
                                   </button>`
                                : isFull
                                    ? `<button class="btn btn-secondary btn-sm" disabled>
                                         <i class="fas fa-users-slash me-1"></i>Event Full
                                       </button>`
                                    : `<button class="btn btn-primary btn-sm" onclick="EventManager.registerForEvent(${event.id})">
                                         <i class="fas fa-user-plus me-1"></i>Register Now
                                       </button>`
                            }
                            <button class="btn btn-outline-primary btn-sm" onclick="EventManager.showEventDetails(${JSON.stringify(event).replace(/"/g, '&quot;')})">
                                <i class="fas fa-info-circle me-1"></i>Details
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
    },

    registerForEvent(eventId) {
        App.showConfirm(
            'Register for Event',
            'Are you sure you want to register for this event?',
            'Yes, Register'
        ).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: App.contextPath + '/registrations/create',
                    method: 'POST',
                    data: { eventId: eventId },
                    success: (data) => {
                        App.showSuccess('Registration successful! You will receive a confirmation email.');
                        this.loadUpcomingEvents();
                        if (this.calendar) this.calendar.refetchEvents();
                    }
                });
            }
        });
    },

    cancelRegistration(eventId) {
        App.showConfirm(
            'Cancel Registration',
            'Are you sure you want to cancel your registration?',
            'Yes, Cancel',
            'No, Keep Registration'
        ).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: App.contextPath + '/registrations/cancel',
                    method: 'POST',
                    data: { eventId: eventId },
                    success: (data) => {
                        App.showSuccess('Registration cancelled successfully.');
                        this.loadUpcomingEvents();
                        if (this.calendar) this.calendar.refetchEvents();
                    }
                });
            }
        });
    },

    showEventDetails(event) {
        Swal.fire({
            title: event.title,
            html: `
                <div class="text-start">
                    <p><strong>Description:</strong><br>${event.description || 'No description'}</p>
                    <p><strong>Date & Time:</strong><br>${formatDateTime(event.eventDate)}</p>
                    <p><strong>Location:</strong><br>${event.location || 'TBD'}</p>
                    ${event.instructor ? `<p><strong>Instructor:</strong><br>${event.instructor}</p>` : ''}
                    <p><strong>Capacity:</strong><br>${event.currentParticipants} / ${event.maxCapacity} participants</p>
                </div>
            `,
            icon: 'info',
            confirmButtonColor: '#003366',
            width: '600px'
        });
    }
};

$(document).ready(function() {
    if ($('#eventsListContainer').length || $('#eventCalendar').length) {
        EventManager.init();
    }
});
```

---

## 7. Advanced Page Templates

### 7.1 Librarian Dashboard (`librarian/dashboard.jsp`)

**Complete Book Management Interface**

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.um6p.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.canManageBooks()) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Librarian Dashboard - UM6P Learning Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
    <style>
        :root {
            --primary: #003366;
            --sidebar-width: 260px;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: var(--primary);
            color: white;
            overflow-y: auto;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
            background: #f8f9fa;
            min-height: 100vh;
        }

        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            border-left: 4px solid var(--primary);
        }

        .action-buttons .btn {
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .table-actions {
            white-space: nowrap;
        }

        .table-actions .btn {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="p-4 border-bottom border-white border-opacity-10">
            <h4><i class="fas fa-book-reader me-2"></i>Librarian Portal</h4>
            <small class="text-white-50"><%= user.getName() %></small>
        </div>

        <nav class="p-3">
            <a href="dashboard.jsp" class="nav-link text-white active bg-white bg-opacity-10 rounded mb-2 p-3">
                <i class="fas fa-home me-2"></i>Dashboard
            </a>
            <a href="manage-books.jsp" class="nav-link text-white-50 hover-white p-3">
                <i class="fas fa-book me-2"></i>Manage Books
            </a>
            <a href="manage-borrowings.jsp" class="nav-link text-white-50 p-3">
                <i class="fas fa-handshake me-2"></i>Borrowings
            </a>
            <a href="reservations.jsp" class="nav-link text-white-50 p-3">
                <i class="fas fa-bookmark me-2"></i>Reservations Queue
            </a>
            <a href="library-reports.jsp" class="nav-link text-white-50 p-3">
                <i class="fas fa-chart-bar me-2"></i>Reports
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link text-white-50 p-3">
                <i class="fas fa-sign-out-alt me-2"></i>Logout
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h2 class="mb-4">Librarian Dashboard</h2>

        <!-- Statistics -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <h6 class="text-muted mb-2">Total Books</h6>
                    <h2 class="mb-0">1,247</h2>
                    <small class="text-success"><i class="fas fa-arrow-up me-1"></i>12% increase</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card" style="border-left-color: #28a745;">
                    <h6 class="text-muted mb-2">Active Borrowings</h6>
                    <h2 class="mb-0">342</h2>
                    <small class="text-info">Currently checked out</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card" style="border-left-color: #ffc107;">
                    <h6 class="text-muted mb-2">Pending Reservations</h6>
                    <h2 class="mb-0">28</h2>
                    <small class="text-warning">Require processing</small>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card" style="border-left-color: #dc3545;">
                    <h6 class="text-muted mb-2">Overdue Books</h6>
                    <h2 class="mb-0">15</h2>
                    <small class="text-danger">Need attention</small>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-bolt me-2"></i>Quick Actions
            </div>
            <div class="card-body action-buttons">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                    <i class="fas fa-plus me-1"></i>Add New Book
                </button>
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#checkoutBookModal">
                    <i class="fas fa-hand-holding me-1"></i>Checkout Book
                </button>
                <button class="btn btn-info" data-bs-toggle="modal" data-bs-target="#returnBookModal">
                    <i class="fas fa-undo me-1"></i>Return Book
                </button>
                <button class="btn btn-warning" onclick="processReservations()">
                    <i class="fas fa-tasks me-1"></i>Process Reservations
                </button>
                <button class="btn btn-danger" onclick="sendOverdueReminders()">
                    <i class="fas fa-bell me-1"></i>Send Overdue Notices
                </button>
            </div>
        </div>

        <!-- Pending Actions Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fas fa-tasks me-2"></i>Pending Actions</span>
                <button class="btn btn-sm btn-outline-primary" onclick="refreshPendingActions()">
                    <i class="fas fa-sync-alt"></i> Refresh
                </button>
            </div>
            <div class="card-body">
                <table id="pendingActionsTable" class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Book</th>
                            <th>User</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Dynamic content loaded via JavaScript -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Book Modal -->
    <div class="modal fade" id="addBookModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-book me-2"></i>Add New Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addBookForm">
                        <div class="mb-3">
                            <label class="form-label">Title *</label>
                            <input type="text" class="form-control" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Author *</label>
                            <input type="text" class="form-control" name="author" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">ISBN</label>
                            <input type="text" class="form-control" name="isbn">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Genre</label>
                            <select class="form-select" name="genre">
                                <option value="">Select Genre</option>
                                <option value="Fiction">Fiction</option>
                                <option value="Non-Fiction">Non-Fiction</option>
                                <option value="Science">Science</option>
                                <option value="Technology">Technology</option>
                                <option value="History">History</option>
                                <option value="Biography">Biography</option>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Total Copies *</label>
                                <input type="number" class="form-control" name="totalCopies" min="1" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Location</label>
                                <input type="text" class="form-control" name="location" placeholder="e.g., Shelf A-12">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="submitAddBook()">
                        <i class="fas fa-save me-1"></i>Add Book
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        const contextPath = '<%= request.getContextPath() %>';

        $(document).ready(function() {
            // Initialize DataTable
            $('#pendingActionsTable').DataTable({
                ajax: contextPath + '/librarian/pending-actions',
                columns: [
                    { data: 'type' },
                    { data: 'bookTitle' },
                    { data: 'userName' },
                    { data: 'date' },
                    {
                        data: 'status',
                        render: function(data) {
                            const colors = {
                                'Ready': 'success',
                                'Pending': 'warning',
                                'Overdue': 'danger'
                            };
                            return `<span class="badge bg-${colors[data] || 'secondary'}">${data}</span>`;
                        }
                    },
                    {
                        data: null,
                        render: function(row) {
                            return `
                                <div class="table-actions">
                                    <button class="btn btn-sm btn-success" onclick="approveAction(${row.id})">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="rejectAction(${row.id})">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            `;
                        }
                    }
                ]
            });
        });

        function submitAddBook() {
            const formData = $('#addBookForm').serialize();
            $.ajax({
                url: contextPath + '/books/add',
                method: 'POST',
                data: formData,
                success: function(response) {
                    Swal.fire('Success!', 'Book added successfully', 'success');
                    $('#addBookModal').modal('hide');
                    $('#addBookForm')[0].reset();
                }
            });
        }

        function processReservations() {
            $.ajax({
                url: contextPath + '/librarian/process-reservations',
                method: 'POST',
                success: function(response) {
                    Swal.fire('Success!', `Processed ${response.count} reservations`, 'success');
                    $('#pendingActionsTable').DataTable().ajax.reload();
                }
            });
        }

        function sendOverdueReminders() {
            Swal.fire({
                title: 'Send Overdue Reminders?',
                text: 'This will send email reminders to all users with overdue books.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Yes, Send',
                confirmButtonColor: '#003366'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: contextPath + '/librarian/send-overdue-reminders',
                        method: 'POST',
                        success: function(response) {
                            Swal.fire('Sent!', `Reminders sent to ${response.count} users`, 'success');
                        }
                    });
                }
            });
        }
    </script>
</body>
</html>
```

### 7.2 Administrator Dashboard (`admin/dashboard.jsp`)

**Event Management & Analytics Interface**

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.um6p.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.canManageEvents()) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrator Dashboard - UM6P Learning Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/main.min.css' rel='stylesheet' />
    <style>
        :root {
            --primary: #003366;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #f8f9fa;
        }

        .top-navbar {
            background: white;
            padding: 1.5rem 2rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            text-align: center;
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }

        .stat-card .icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 1rem;
        }

        .stat-card.events .icon {
            background: rgba(0, 123, 255, 0.1);
            color: #007bff;
        }

        .stat-card.participants .icon {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }

        .stat-card.upcoming .icon {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        .stat-card.completion .icon {
            background: rgba(23, 162, 184, 0.1);
            color: #17a2b8;
        }

        #eventCalendar {
            background: white;
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }

        .chart-container {
            background: white;
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
    </style>
</head>
<body>
    <!-- Top Navbar -->
    <div class="top-navbar">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h3 class="mb-0"><i class="fas fa-user-shield me-2"></i>Administrator Dashboard</h3>
                <small class="text-muted">Event & Workshop Management</small>
            </div>
            <div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createEventModal">
                    <i class="fas fa-plus me-1"></i>Create Event
                </button>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </div>

    <div class="container-fluid px-4">
        <!-- Statistics -->
        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card events">
                    <div class="icon">
                        <i class="fas fa-calendar"></i>
                    </div>
                    <h3 class="mb-1">45</h3>
                    <p class="text-muted mb-0">Total Events</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card participants">
                    <div class="icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3 class="mb-1">1,234</h3>
                    <p class="text-muted mb-0">Total Participants</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card upcoming">
                    <div class="icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <h3 class="mb-1">8</h3>
                    <p class="text-muted mb-0">Upcoming Events</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card completion">
                    <div class="icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h3 class="mb-1">87%</h3>
                    <p class="text-muted mb-0">Avg Attendance</p>
                </div>
            </div>
        </div>

        <div class="row g-4">
            <!-- Event Calendar -->
            <div class="col-md-8">
                <div id="eventCalendar"></div>
            </div>

            <!-- Event Statistics Chart -->
            <div class="col-md-4">
                <div class="chart-container">
                    <h5 class="mb-3">Event Categories</h5>
                    <canvas id="eventCategoriesChart"></canvas>
                </div>

                <div class="chart-container mt-4">
                    <h5 class="mb-3">Monthly Participation</h5>
                    <canvas id="participationChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Recent Events Table -->
        <div class="card mt-4">
            <div class="card-header">
                <i class="fas fa-list me-2"></i>Recent Events
            </div>
            <div class="card-body">
                <table class="table table-hover" id="eventsTable">
                    <thead>
                        <tr>
                            <th>Event</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Participants</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Dynamic content -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Create Event Modal -->
    <div class="modal fade" id="createEventModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-calendar-plus me-2"></i>Create New Event</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="createEventForm">
                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label class="form-label">Event Title *</label>
                                <input type="text" class="form-control" name="title" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Max Capacity *</label>
                                <input type="number" class="form-control" name="maxCapacity" min="1" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Event Date & Time *</label>
                                <input type="datetime-local" class="form-control" name="eventDate" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Location *</label>
                                <input type="text" class="form-control" name="location" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Instructor</label>
                                <input type="text" class="form-control" name="instructor">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Category</label>
                                <select class="form-select" name="category">
                                    <option value="Workshop">Workshop</option>
                                    <option value="Seminar">Seminar</option>
                                    <option value="Training">Training</option>
                                    <option value="Conference">Conference</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="submitCreateEvent()">
                        <i class="fas fa-save me-1"></i>Create Event
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.9/main.min.js'></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        const contextPath = '<%= request.getContextPath() %>';
        let calendar;

        $(document).ready(function() {
            initCalendar();
            initCharts();
            loadEventsTable();
        });

        function initCalendar() {
            const calendarEl = document.getElementById('eventCalendar');
            calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,listMonth'
                },
                events: contextPath + '/admin/events/calendar',
                eventClick: function(info) {
                    showEventDetails(info.event.id);
                },
                editable: true,
                eventDrop: function(info) {
                    updateEventDate(info.event.id, info.event.start);
                }
            });
            calendar.render();
        }

        function initCharts() {
            // Event Categories Pie Chart
            new Chart(document.getElementById('eventCategoriesChart'), {
                type: 'doughnut',
                data: {
                    labels: ['Workshops', 'Seminars', 'Training', 'Conferences'],
                    datasets: [{
                        data: [35, 25, 20, 20],
                        backgroundColor: ['#007bff', '#28a745', '#ffc107', '#17a2b8']
                    }]
                }
            });

            // Participation Line Chart
            new Chart(document.getElementById('participationChart'), {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Participants',
                        data: [120, 190, 150, 220, 180, 240],
                        borderColor: '#003366',
                        backgroundColor: 'rgba(0, 51, 102, 0.1)',
                        tension: 0.4
                    }]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        }

        function submitCreateEvent() {
            const formData = $('#createEventForm').serialize();
            $.ajax({
                url: contextPath + '/admin/events/create',
                method: 'POST',
                data: formData,
                success: function(response) {
                    Swal.fire('Success!', 'Event created successfully', 'success');
                    $('#createEventModal').modal('hide');
                    $('#createEventForm')[0].reset();
                    calendar.refetchEvents();
                    loadEventsTable();
                }
            });
        }
    </script>
</body>
</html>
```

---

## 8. API Integration Reference

### Complete Backend Endpoint Mapping

```javascript
// Authentication Endpoints
POST   /login                          - User login
POST   /register                       - User registration
GET    /logout                         - User logout

// Book Endpoints
GET    /books/all                      - Get all books
GET    /books/search?q={query}         - Search books
GET    /books/{id}                     - Get book details
POST   /books/add                      - Add new book (Librarian+)
PUT    /books/{id}/update              - Update book (Librarian+)
DELETE /books/{id}/delete              - Delete book (Librarian+)

// Borrowing Endpoints
GET    /borrowings/my                  - Get user's borrowings
POST   /borrowings/checkout            - Checkout book (Librarian)
POST   /borrowings/return              - Return book (Librarian)
GET    /borrowings/overdue             - Get overdue borrowings (Librarian)

// Reservation Endpoints
GET    /reservations/my                - Get user's reservations
POST   /reservations/create            - Create reservation
POST   /reservations/cancel            - Cancel reservation
GET    /reservations/queue/{bookId}    - Get reservation queue (Librarian)
POST   /reservations/process           - Process next in queue (Librarian)

// Event Endpoints
GET    /events/upcoming                - Get upcoming events
GET    /events/calendar                - Get events for calendar
GET    /events/{id}                    - Get event details
POST   /events/create                  - Create event (Administrator+)
PUT    /events/{id}/update             - Update event (Administrator+)
DELETE /events/{id}/cancel             - Cancel event (Administrator+)

// Registration Endpoints
GET    /registrations/my               - Get user's registrations
POST   /registrations/create           - Register for event
POST   /registrations/cancel           - Cancel registration
GET    /registrations/event/{eventId}  - Get event registrations (Administrator)
POST   /registrations/attendance       - Mark attendance (Administrator)

// User Management Endpoints (System Admin only)
GET    /users/all                      - Get all users
GET    /users/{id}                     - Get user details
POST   /users/create                   - Create user
PUT    /users/{id}/update              - Update user
DELETE /users/{id}/delete              - Delete user
PUT    /users/{id}/role                - Change user role

// Reports Endpoints
GET    /reports/library-statistics     - Library statistics (Librarian+)
GET    /reports/event-analytics        - Event analytics (Administrator+)
GET    /reports/user-activity          - User activity (System Admin)
```

---

## 9. Testing Checklist

### Functional Testing

**Authentication & Authorization:**
- [ ] Login with valid @um6p.ma email
- [ ] Login fails with invalid credentials
- [ ] Login fails with non-@um6p.ma email
- [ ] Registration creates new account
- [ ] Session expires after 30 minutes
- [ ] Logout clears session
- [ ] Each role can only access authorized pages

**Book Management:**
- [ ] Browse all books
- [ ] Search books by title
- [ ] Search books by author
- [ ] Search books by genre
- [ ] Reserve available book
- [ ] Cannot reserve unavailable book
- [ ] Reservation queue works correctly
- [ ] Librarian can add new book
- [ ] Librarian can update book
- [ ] Librarian can delete book
- [ ] Book availability updates correctly

**Borrowing System:**
- [ ] Librarian can checkout book
- [ ] Available copies decrease on checkout
- [ ] Librarian can return book
- [ ] Available copies increase on return
- [ ] Fine calculation for overdue books
- [ ] Overdue notifications sent

**Event Management:**
- [ ] Display upcoming events
- [ ] User can register for event
- [ ] Registration fails when event is full
- [ ] Email confirmation sent on registration
- [ ] User can cancel registration
- [ ] Administrator can create event
- [ ] Administrator can update event
- [ ] Administrator can cancel event
- [ ] Capacity management works
- [ ] Calendar displays correctly

### UI/UX Testing

**Responsive Design:**
- [ ] Desktop (1920x1080)
- [ ] Laptop (1366x768)
- [ ] Tablet (768x1024)
- [ ] Mobile (375x667)

**Cross-Browser Compatibility:**
- [ ] Google Chrome
- [ ] Mozilla Firefox
- [ ] Microsoft Edge
- [ ] Safari

**Accessibility:**
- [ ] All forms have labels
- [ ] Keyboard navigation works
- [ ] Color contrast meets WCAG standards
- [ ] Screen reader compatible

**Performance:**
- [ ] Page load time < 3 seconds
- [ ] Search returns results < 1 second
- [ ] Tables load efficiently with DataTables
- [ ] Images optimized
- [ ] No console errors

---

## 10. Deployment Checklist

### Pre-Deployment

- [ ] All environment variables configured
- [ ] Database migrated to latest schema
- [ ] Email service tested
- [ ] All tests passing
- [ ] Build successful: `mvn clean package`
- [ ] WAR file generated

### Production Setup

- [ ] Set `EMAIL_ENABLED=true`
- [ ] Configure production SMTP credentials
- [ ] Use dedicated database user (not root)
- [ ] Enable SSL for database connection
- [ ] Configure firewall rules
- [ ] Set secure passwords (12+ characters)
- [ ] Remove or disable test accounts

### Tomcat Deployment

```bash
# Windows
cmd /c "copy target\um6p_learning_center.war C:\tomcat9\webapps\"
cmd /c "C:\tomcat9\bin\startup.bat"

# Linux
sudo cp target/um6p_learning_center.war /opt/tomcat/webapps/
sudo systemctl start tomcat
```

### Post-Deployment Verification

- [ ] Application accessible at http://your-server:8080/um6p_learning_center
- [ ] Login works
- [ ] All roles can access their dashboards
- [ ] Database connection successful
- [ ] Email notifications working
- [ ] All CRUD operations functional
- [ ] Check logs for errors: `$CATALINA_HOME/logs/catalina.out`

---

## 11. Best Practices Summary

### Code Quality
- Use consistent naming conventions
- Comment complex logic
- Validate all user input
- Handle errors gracefully
- Use PreparedStatements to prevent SQL injection

### Security
- Never expose sensitive data in client-side code
- Sanitize all user input (XSS prevention)
- Use HTTPS in production
- Implement CSRF protection for forms
- Regular security audits

### Performance
- Minimize database queries
- Use indexes on frequently queried columns
- Lazy load images and heavy resources
- Cache static assets
- Compress CSS and JavaScript for production

### User Experience
- Provide clear error messages
- Show loading indicators
- Confirm destructive actions
- Auto-save form data where appropriate
- Responsive design for all devices

---

## 12. Troubleshooting Guide

### Common Issues

**Issue: Login fails with correct credentials**
- Check session timeout settings
- Verify database connection
- Check password hashing (BCrypt)
- Review AuthFilter configuration

**Issue: Email notifications not sending**
- Verify EMAIL_ENABLED=true
- Check SMTP credentials
- Test SMTP connection
- Review firewall/port 587 settings
- Check email logs in catalina.out

**Issue: DataTables not loading**
- Check jQuery loaded before DataTables
- Verify AJAX endpoint returns JSON
- Check browser console for errors
- Ensure table structure matches column definitions

**Issue: Calendar not displaying**
- Verify FullCalendar CSS and JS loaded
- Check events endpoint returns correct JSON format
- Inspect browser console for errors

---

## 13. Next Steps for Production

1. **Professional Design Polish**
   - Create custom logo and branding
   - Professional color scheme
   - Custom illustrations/icons
   - Consistent spacing and typography

2. **Advanced Features**
   - Book recommendations based on borrowing history
   - Advanced search filters
   - QR code generation for books
   - Mobile app integration
   - Social sharing features

3. **Analytics Dashboard**
   - Real-time statistics
   - Usage trends
   - Popular books/events
   - User engagement metrics

4. **Notifications Enhancement**
   - In-app notifications
   - SMS notifications
   - Push notifications
   - Notification preferences

5. **Documentation**
   - User manual
   - Admin guide
   - API documentation
   - Video tutorials

---

## Conclusion

This comprehensive guide provides everything needed to complete the UM6P Learning Center Management System frontend. The backend is 100% complete and fully functional. Follow this guide step-by-step to create a professional, feature-rich application.

**Project Status:**
- ✅ Backend: 100% Complete
- ✅ Database: 100% Complete
- ✅ Security: 100% Complete
- ✅ Email System: 100% Complete
- 🔄 Frontend: Ready for Development (this guide)

**Quick Start:**
1. Copy page templates from this guide
2. Implement JavaScript functionality
3. Customize design system colors/fonts
4. Test all features
5. Deploy to production

**Support Resources:**
- PROJECT_SUMMARY.txt - Quick reference
- SRS_COMPLIANCE_ANALYSIS.md - Requirements verification
- ENVIRONMENT_SETUP.md - Configuration guide
- DEPLOYMENT_GUIDE.md - Deployment instructions

**Good luck with your frontend development! 🚀**

---

**Document Version:** 1.0 (Complete)
**Last Updated:** November 25, 2025
**Status:** ✅ READY FOR IMPLEMENTATION
