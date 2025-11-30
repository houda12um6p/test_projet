# UM6P Learning Center - Complete AI Agent Build Instructions
## Professional Full-Stack Development Guide

---

## 🎯 PROJECT OVERVIEW

**Project Name:** UM6P Learning Center Management System  
**Client:** Mohammed VI Polytechnic University (UM6P)  
**Purpose:** Complete web-based platform for library management, event registration, and student services

**Tech Stack:**
- **Backend:** Java (JSP/Servlets), MySQL, Apache Tomcat 9
- **Frontend:** HTML5, CSS3, JavaScript (Vanilla)
- **Architecture:** MVC (Model-View-Controller) Pattern
- **Database:** MySQL 8.0+
- **Server:** Apache Tomcat 9.x

**Target Users:**
1. **Students** - Browse books, reserve materials, register for events, view history
2. **Librarians** - Manage books, approve reservations, track inventory, generate reports
3. **Event Organizers** - Create/manage workshops, seminars, cultural events
4. **Administrators** - Full system control, user management, analytics, system configuration

---

## 🎨 DESIGN SYSTEM - EXACT SPECIFICATIONS

### Brand Colors (Extracted from Logo)

```css
:root {
    /* Primary UM6P Colors - From Official Logo */
    --um6p-orange: #D95D39;        /* UM6P brand orange */
    --um6p-orange-dark: #C24D29;   /* Hover states */
    
    /* Learning Center Colors - From Logo Building */
    --lc-purple: #7B3FA4;          /* Purple building base */
    --lc-blue: #3FA4D9;            /* Blue building section */
    --lc-cyan: #40C4D9;            /* Cyan building accent */
    --lc-magenta: #D939A4;         /* Magenta building accent */
    --lc-yellow: #F2B134;          /* Yellow diagonal stripe */
    --lc-gold: #F2A134;            /* Gold circle */
    --lc-navy: #1E3A8A;            /* Navy blue text */
    
    /* Neutral Palette */
    --white: #FFFFFF;
    --gray-50: #F9FAFB;
    --gray-100: #F3F4F6;
    --gray-200: #E5E7EB;
    --gray-300: #D1D5DB;
    --gray-400: #9CA3AF;
    --gray-500: #6B7280;
    --gray-600: #4B5563;
    --gray-700: #374151;
    --gray-800: #1F2937;
    --gray-900: #111827;
    --black: #000000;
    
    /* Functional Colors */
    --success: #10B981;
    --warning: #F59E0B;
    --error: #EF4444;
    --info: #3B82F6;
}
```

### Typography - Poppins Font Family

```css
/* Import Poppins from Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap');

/* Font Usage */
body {
    font-family: 'Poppins', sans-serif;
    font-weight: 400;
    font-size: 16px;
    line-height: 1.6;
    color: var(--gray-900);
}

h1, h2, h3, h4, h5, h6 {
    font-family: 'Poppins', sans-serif;
    font-weight: 700;
    line-height: 1.2;
}

/* Font Weights Available */
.light { font-weight: 300; }
.regular { font-weight: 400; }
.medium { font-weight: 500; }
.semibold { font-weight: 600; }
.bold { font-weight: 700; }
.extrabold { font-weight: 800; }
.black { font-weight: 900; }
```

### Typography Scale

```css
/* Heading Sizes */
.text-h1 { font-size: 48px; font-weight: 800; }
.text-h2 { font-size: 40px; font-weight: 700; }
.text-h3 { font-size: 32px; font-weight: 700; }
.text-h4 { font-size: 24px; font-weight: 600; }
.text-h5 { font-size: 20px; font-weight: 600; }
.text-h6 { font-size: 18px; font-weight: 600; }

/* Body Sizes */
.text-lg { font-size: 18px; }
.text-base { font-size: 16px; }
.text-sm { font-size: 14px; }
.text-xs { font-size: 12px; }
```

### Spacing System (8px base unit)

```css
/* Spacing Scale */
--space-1: 4px;
--space-2: 8px;
--space-3: 12px;
--space-4: 16px;
--space-5: 20px;
--space-6: 24px;
--space-7: 28px;
--space-8: 32px;
--space-10: 40px;
--space-12: 48px;
--space-16: 64px;
--space-20: 80px;
--space-24: 96px;
```

### Border Radius

```css
--radius-sm: 4px;
--radius-md: 8px;
--radius-lg: 12px;
--radius-xl: 16px;
--radius-2xl: 24px;
--radius-full: 9999px;
```

### Shadows

```css
--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
--shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
--shadow-2xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
```

---

## 📂 COMPLETE PROJECT STRUCTURE

```
SoftwareEng/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── um6p/
│   │   │           └── lc/
│   │   │               ├── controllers/
│   │   │               │   ├── AuthController.java
│   │   │               │   ├── BookController.java
│   │   │               │   ├── EventController.java
│   │   │               │   ├── ReservationController.java
│   │   │               │   ├── RegistrationController.java
│   │   │               │   ├── UserController.java
│   │   │               │   ├── DashboardController.java
│   │   │               │   └── NotificationController.java
│   │   │               │
│   │   │               ├── models/
│   │   │               │   ├── User.java
│   │   │               │   ├── Book.java
│   │   │               │   ├── Event.java
│   │   │               │   ├── Reservation.java
│   │   │               │   ├── Registration.java
│   │   │               │   └── Notification.java
│   │   │               │
│   │   │               ├── dao/
│   │   │               │   ├── UserDAO.java
│   │   │               │   ├── BookDAO.java
│   │   │               │   ├── EventDAO.java
│   │   │               │   ├── ReservationDAO.java
│   │   │               │   ├── RegistrationDAO.java
│   │   │               │   ├── NotificationDAO.java
│   │   │               │   └── DatabaseConnection.java
│   │   │               │
│   │   │               ├── services/
│   │   │               │   ├── AuthService.java
│   │   │               │   ├── BookService.java
│   │   │               │   ├── EventService.java
│   │   │               │   ├── ReservationService.java
│   │   │               │   ├── RegistrationService.java
│   │   │               │   └── NotificationService.java
│   │   │               │
│   │   │               ├── filters/
│   │   │               │   ├── AuthenticationFilter.java
│   │   │               │   ├── AuthorizationFilter.java
│   │   │               │   └── CORSFilter.java
│   │   │               │
│   │   │               └── utils/
│   │   │                   ├── PasswordUtil.java
│   │   │                   ├── ValidationUtil.java
│   │   │                   ├── DateUtil.java
│   │   │                   ├── EmailUtil.java
│   │   │                   └── SessionUtil.java
│   │   │
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── web.xml
│   │       │   └── lib/
│   │       │
│   │       ├── assets/
│   │       │   ├── css/
│   │       │   │   ├── main.css
│   │       │   │   ├── components.css
│   │       │   │   └── responsive.css
│   │       │   ├── js/
│   │       │   │   ├── main.js
│   │       │   │   ├── carousel.js
│   │       │   │   ├── forms.js
│   │       │   │   └── api.js
│   │       │   └── images/
│   │       │       ├── logo.png
│   │       │       ├── learning-center-interior.jpg
│   │       │       ├── event-poster-1.png
│   │       │       └── event-poster-2.png
│   │       │
│   │       ├── views/
│   │       │   ├── public/
│   │       │   │   ├── index.jsp
│   │       │   │   └── login.jsp
│   │       │   │
│   │       │   ├── student/
│   │       │   │   ├── dashboard.jsp
│   │       │   │   ├── books.jsp
│   │       │   │   ├── book-details.jsp
│   │       │   │   ├── my-reservations.jsp
│   │       │   │   ├── events.jsp
│   │       │   │   ├── event-details.jsp
│   │       │   │   ├── my-registrations.jsp
│   │       │   │   ├── profile.jsp
│   │       │   │   └── history.jsp
│   │       │   │
│   │       │   ├── librarian/
│   │       │   │   ├── dashboard.jsp
│   │       │   │   ├── manage-books.jsp
│   │       │   │   ├── add-book.jsp
│   │       │   │   ├── edit-book.jsp
│   │       │   │   ├── reservations.jsp
│   │       │   │   └── reports.jsp
│   │       │   │
│   │       │   ├── organizer/
│   │       │   │   ├── dashboard.jsp
│   │       │   │   ├── manage-events.jsp
│   │       │   │   ├── add-event.jsp
│   │       │   │   ├── edit-event.jsp
│   │       │   │   ├── registrations.jsp
│   │       │   │   └── attendance.jsp
│   │       │   │
│   │       │   └── admin/
│   │       │       ├── dashboard.jsp
│   │       │       ├── users.jsp
│   │       │       ├── add-user.jsp
│   │       │       ├── edit-user.jsp
│   │       │       ├── analytics.jsp
│   │       │       └── settings.jsp
│   │       │
│   │       └── components/
│   │           ├── header.jsp
│   │           ├── footer.jsp
│   │           ├── sidebar.jsp
│   │           ├── navigation.jsp
│   │           └── notifications.jsp
│   │
│   └── test/
│       └── java/
│           └── com/
│               └── um6p/
│                   └── lc/
│                       ├── dao/
│                       ├── services/
│                       └── controllers/
│
├── database/
│   ├── schema.sql
│   ├── seed-data.sql
│   └── README.md
│
├── pom.xml
└── README.md
```

---

## 🗄️ DATABASE SCHEMA - COMPLETE

### Table 1: users

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role ENUM('student', 'librarian', 'organizer', 'admin') NOT NULL DEFAULT 'student',
    phone VARCHAR(20),
    address TEXT,
    student_id VARCHAR(50) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    profile_image_url VARCHAR(500),
    
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_student_id (student_id),
    INDEX idx_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Table 2: books

```sql
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    isbn VARCHAR(13) UNIQUE,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    publisher VARCHAR(255),
    publication_year INT,
    category VARCHAR(100),
    language VARCHAR(50) DEFAULT 'English',
    pages INT,
    description TEXT,
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1,
    cover_image_url VARCHAR(500),
    shelf_location VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_isbn (isbn),
    INDEX idx_title (title),
    INDEX idx_author (author),
    INDEX idx_category (category),
    INDEX idx_language (language),
    INDEX idx_available (available_copies)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Table 3: events

```sql
CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    event_type ENUM('workshop', 'seminar', 'conference', 'cultural', 'masterclass') NOT NULL,
    event_date DATETIME NOT NULL,
    end_date DATETIME,
    duration_minutes INT,
    location VARCHAR(255),
    room_number VARCHAR(50),
    instructor VARCHAR(255),
    instructor_bio TEXT,
    max_capacity INT DEFAULT 50,
    current_registrations INT DEFAULT 0,
    poster_image_url VARCHAR(500),
    organizer_id INT NOT NULL,
    status ENUM('upcoming', 'ongoing', 'completed', 'cancelled') DEFAULT 'upcoming',
    is_online BOOLEAN DEFAULT FALSE,
    meeting_link VARCHAR(500),
    prerequisites TEXT,
    learning_outcomes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (organizer_id) REFERENCES users(user_id) ON DELETE RESTRICT,
    INDEX idx_event_date (event_date),
    INDEX idx_event_type (event_type),
    INDEX idx_status (status),
    INDEX idx_organizer (organizer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Table 4: reservations

```sql
CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,
    status ENUM('reserved', 'borrowed', 'returned', 'overdue', 'cancelled') DEFAULT 'reserved',
    approved_by INT,
    approval_date TIMESTAMP NULL,
    notes TEXT,
    fine_amount DECIMAL(10, 2) DEFAULT 0.00,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_book_id (book_id),
    INDEX idx_status (status),
    INDEX idx_due_date (due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Table 5: event_registrations

```sql
CREATE TABLE event_registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    attendance_status ENUM('registered', 'attended', 'absent', 'cancelled') DEFAULT 'registered',
    attendance_marked_at TIMESTAMP NULL,
    marked_by INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    feedback TEXT,
    certificate_url VARCHAR(500),
    
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (marked_by) REFERENCES users(user_id) ON DELETE SET NULL,
    UNIQUE KEY unique_registration (user_id, event_id),
    INDEX idx_user_id (user_id),
    INDEX idx_event_id (event_id),
    INDEX idx_attendance (attendance_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Table 6: notifications

```sql
CREATE TABLE notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    notification_type ENUM('reservation', 'event', 'overdue', 'general', 'reminder') NOT NULL,
    related_id INT,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_is_read (is_read),
    INDEX idx_created_at (created_at),
    INDEX idx_type (notification_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

### Table 7: activity_logs

```sql
CREATE TABLE activity_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50),
    entity_id INT,
    details TEXT,
    ip_address VARCHAR(45),
    user_agent VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

---

## 💻 COMPLETE CODE TEMPLATES

### 1. DatabaseConnection.java

```java
package com.um6p.lc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Database Connection Manager
 * Provides connection pooling and management for MySQL database
 */
public class DatabaseConnection {
    private static final Logger LOGGER = Logger.getLogger(DatabaseConnection.class.getName());
    
    // Database Configuration
    private static final String URL = "jdbc:mysql://localhost:3306/learning_center?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "your_password"; // Change this
    
    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            LOGGER.log(Level.INFO, "MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "MySQL JDBC Driver not found", e);
            throw new RuntimeException("Failed to load MySQL JDBC Driver", e);
        }
    }
    
    /**
     * Get a connection to the database
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            LOGGER.log(Level.FINE, "Database connection established");
            return conn;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Failed to establish database connection", e);
            throw e;
        }
    }
    
    /**
     * Close database connection safely
     * @param conn Connection to close
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                LOGGER.log(Level.FINE, "Database connection closed");
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing database connection", e);
            }
        }
    }
    
    /**
     * Test database connection
     * @return true if connection is successful
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database connection test failed", e);
            return false;
        }
    }
}
```

### 2. User.java (Complete Model)

```java
package com.um6p.lc.models;

import java.time.LocalDateTime;

/**
 * User Model
 * Represents a user in the Learning Center system
 */
public class User {
    // Fields
    private int userId;
    private String email;
    private String passwordHash;
    private String firstName;
    private String lastName;
    private String role; // student, librarian, organizer, admin
    private String phone;
    private String address;
    private String studentId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime lastLogin;
    private boolean isActive;
    private String profileImageUrl;
    
    // Constructors
    public User() {}
    
    public User(String email, String firstName, String lastName, String role) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPasswordHash() {
        return passwordHash;
    }
    
    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getFullName() {
        return firstName + " " + lastName;
    }
    
    public String getRole() {
        return role;
    }
    
    public void setRole(String role) {
        this.role = role;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public LocalDateTime getLastLogin() {
        return lastLogin;
    }
    
    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }
    
    public boolean isActive() {
        return isActive;
    }
    
    public void setActive(boolean active) {
        isActive = active;
    }
    
    public String getProfileImageUrl() {
        return profileImageUrl;
    }
    
    public void setProfileImageUrl(String profileImageUrl) {
        this.profileImageUrl = profileImageUrl;
    }
    
    // Helper Methods
    public boolean isStudent() {
        return "student".equalsIgnoreCase(role);
    }
    
    public boolean isLibrarian() {
        return "librarian".equalsIgnoreCase(role);
    }
    
    public boolean isOrganizer() {
        return "organizer".equalsIgnoreCase(role);
    }
    
    public boolean isAdmin() {
        return "admin".equalsIgnoreCase(role);
    }
    
    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", email='" + email + '\'' +
                ", fullName='" + getFullName() + '\'' +
                ", role='" + role + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}
```

### 3. UserDAO.java (Complete with Authentication)

```java
package com.um6p.lc.dao;

import com.um6p.lc.models.User;
import com.um6p.lc.utils.PasswordUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * User Data Access Object
 * Handles all database operations for User entity
 */
public class UserDAO {
    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    
    /**
     * Create a new user in the database
     * @param user User object with details
     * @param password Plain text password
     * @return true if user created successfully
     */
    public boolean createUser(User user, String password) {
        String query = "INSERT INTO users (email, password_hash, first_name, last_name, " +
                      "role, phone, address, student_id, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, PasswordUtil.hashPassword(password));
            pstmt.setString(3, user.getFirstName());
            pstmt.setString(4, user.getLastName());
            pstmt.setString(5, user.getRole());
            pstmt.setString(6, user.getPhone());
            pstmt.setString(7, user.getAddress());
            pstmt.setString(8, user.getStudentId());
            pstmt.setBoolean(9, user.isActive());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    user.setUserId(rs.getInt(1));
                }
                LOGGER.log(Level.INFO, "User created successfully: " + user.getEmail());
                return true;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating user: " + user.getEmail(), e);
        }
        return false;
    }
    
    /**
     * Authenticate user with email and password
     * @param email User email
     * @param password Plain text password
     * @return User object if authentication successful, null otherwise
     */
    public User authenticateUser(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND is_active = true";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                
                if (PasswordUtil.verifyPassword(password, storedHash)) {
                    User user = mapResultSetToUser(rs);
                    updateLastLogin(user.getUserId());
                    LOGGER.log(Level.INFO, "User authenticated successfully: " + email);
                    return user;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error authenticating user: " + email, e);
        }
        return null;
    }
    
    /**
     * Get user by ID
     * @param userId User ID
     * @return User object or null
     */
    public User getUserById(int userId) {
        String query = "SELECT * FROM users WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting user by ID: " + userId, e);
        }
        return null;
    }
    
    /**
     * Get user by email
     * @param email User email
     * @return User object or null
     */
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting user by email: " + email, e);
        }
        return null;
    }
    
    /**
     * Get all users with optional role filter
     * @param role Optional role filter (null for all users)
     * @return List of users
     */
    public List<User> getAllUsers(String role) {
        List<User> users = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM users WHERE 1=1");
        
        if (role != null && !role.isEmpty()) {
            query.append(" AND role = ?");
        }
        query.append(" ORDER BY created_at DESC");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query.toString())) {
            
            if (role != null && !role.isEmpty()) {
                pstmt.setString(1, role);
            }
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all users", e);
        }
        return users;
    }
    
    /**
     * Update user information
     * @param user User object with updated data
     * @return true if update successful
     */
    public boolean updateUser(User user) {
        String query = "UPDATE users SET first_name = ?, last_name = ?, phone = ?, " +
                      "address = ?, student_id = ?, profile_image_url = ?, updated_at = NOW() " +
                      "WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getStudentId());
            pstmt.setString(6, user.getProfileImageUrl());
            pstmt.setInt(7, user.getUserId());
            
            int affectedRows = pstmt.executeUpdate();
            LOGGER.log(Level.INFO, "User updated: " + user.getUserId());
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating user: " + user.getUserId(), e);
        }
        return false;
    }
    
    /**
     * Update user password
     * @param userId User ID
     * @param newPassword New plain text password
     * @return true if update successful
     */
    public boolean updatePassword(int userId, String newPassword) {
        String query = "UPDATE users SET password_hash = ?, updated_at = NOW() WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, PasswordUtil.hashPassword(newPassword));
            pstmt.setInt(2, userId);
            
            int affectedRows = pstmt.executeUpdate();
            LOGGER.log(Level.INFO, "Password updated for user: " + userId);
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating password for user: " + userId, e);
        }
        return false;
    }
    
    /**
     * Update user role (Admin only)
     * @param userId User ID
     * @param newRole New role
     * @return true if update successful
     */
    public boolean updateUserRole(int userId, String newRole) {
        String query = "UPDATE users SET role = ?, updated_at = NOW() WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, newRole);
            pstmt.setInt(2, userId);
            
            int affectedRows = pstmt.executeUpdate();
            LOGGER.log(Level.INFO, "Role updated for user: " + userId + " to " + newRole);
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating role for user: " + userId, e);
        }
        return false;
    }
    
    /**
     * Deactivate user account
     * @param userId User ID
     * @return true if deactivation successful
     */
    public boolean deactivateUser(int userId) {
        String query = "UPDATE users SET is_active = false, updated_at = NOW() WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userId);
            
            int affectedRows = pstmt.executeUpdate();
            LOGGER.log(Level.INFO, "User deactivated: " + userId);
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deactivating user: " + userId, e);
        }
        return false;
    }
    
    /**
     * Delete user (hard delete)
     * @param userId User ID
     * @return true if deletion successful
     */
    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userId);
            
            int affectedRows = pstmt.executeUpdate();
            LOGGER.log(Level.INFO, "User deleted: " + userId);
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting user: " + userId, e);
        }
        return false;
    }
    
    /**
     * Check if email already exists
     * @param email Email to check
     * @return true if email exists
     */
    public boolean emailExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking email existence: " + email, e);
        }
        return false;
    }
    
    /**
     * Update last login timestamp
     * @param userId User ID
     */
    private void updateLastLogin(int userId) {
        String query = "UPDATE users SET last_login = NOW() WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error updating last login for user: " + userId, e);
        }
    }
    
    /**
     * Map ResultSet to User object
     * @param rs ResultSet from query
     * @return User object
     * @throws SQLException if mapping fails
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setRole(rs.getString("role"));
        user.setPhone(rs.getString("phone"));
        user.setAddress(rs.getString("address"));
        user.setStudentId(rs.getString("student_id"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            user.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        
        Timestamp lastLogin = rs.getTimestamp("last_login");
        if (lastLogin != null) {
            user.setLastLogin(lastLogin.toLocalDateTime());
        }
        
        user.setActive(rs.getBoolean("is_active"));
        user.setProfileImageUrl(rs.getString("profile_image_url"));
        
        return user;
    }
    
    /**
     * Get user statistics
     * @param userId User ID
     * @return Array of [books_borrowed, events_attended, books_due_soon]
     */
    public int[] getUserStatistics(int userId) {
        int[] stats = new int[3];
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Books borrowed
            String query1 = "SELECT COUNT(*) FROM reservations WHERE user_id = ? AND status = 'borrowed'";
            try (PreparedStatement pstmt = conn.prepareStatement(query1)) {
                pstmt.setInt(1, userId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats[0] = rs.getInt(1);
            }
            
            // Events attended
            String query2 = "SELECT COUNT(*) FROM event_registrations WHERE user_id = ? AND attendance_status = 'attended'";
            try (PreparedStatement pstmt = conn.prepareStatement(query2)) {
                pstmt.setInt(1, userId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats[1] = rs.getInt(1);
            }
            
            // Books due soon (within 3 days)
            String query3 = "SELECT COUNT(*) FROM reservations WHERE user_id = ? AND status = 'borrowed' " +
                           "AND due_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 3 DAY)";
            try (PreparedStatement pstmt = conn.prepareStatement(query3)) {
                pstmt.setInt(1, userId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) stats[2] = rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting user statistics: " + userId, e);
        }
        
        return stats;
    }
}
```

### 4. PasswordUtil.java

```java
package com.um6p.lc.utils;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Password Utility for hashing and verification
 * Uses BCrypt for secure password hashing
 */
public class PasswordUtil {
    
    // BCrypt work factor (10-12 recommended for good security/performance balance)
    private static final int WORK_FACTOR = 12;
    
    /**
     * Hash a plain text password
     * @param plainPassword Plain text password
     * @return Hashed password
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(WORK_FACTOR));
    }
    
    /**
     * Verify a plain text password against a hash
     * @param plainPassword Plain text password
     * @param hashedPassword Hashed password from database
     * @return true if password matches
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * Check if password meets minimum requirements
     * @param password Password to check
     * @return true if password is valid
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        // At least one uppercase, one lowercase, one digit
        boolean hasUppercase = password.chars().anyMatch(Character::isUpperCase);
        boolean hasLowercase = password.chars().anyMatch(Character::isLowercase);
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        
        return hasUppercase && hasLowercase && hasDigit;
    }
    
    /**
     * Get password strength description
     * @param password Password to check
     * @return Strength description (Weak, Medium, Strong)
     */
    public static String getPasswordStrength(String password) {
        if (password == null || password.length() < 8) {
            return "Weak";
        }
        
        int score = 0;
        
        if (password.length() >= 12) score++;
        if (password.chars().anyMatch(Character::isUpperCase)) score++;
        if (password.chars().anyMatch(Character::isLowercase)) score++;
        if (password.chars().anyMatch(Character::isDigit)) score++;
        if (password.chars().anyMatch(ch -> !Character.isLetterOrDigit(ch))) score++;
        
        if (score >= 4) return "Strong";
        if (score >= 2) return "Medium";
        return "Weak";
    }
}
```

### 5. AuthController.java (Login/Logout Servlet)

```java
package com.um6p.lc.controllers;

import com.um6p.lc.dao.UserDAO;
import com.um6p.lc.models.User;
import com.um6p.lc.utils.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Authentication Controller
 * Handles user login, logout, and registration
 */
@WebServlet("/auth/*")
public class AuthController extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AuthController.class.getName());
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if ("/logout".equals(pathInfo)) {
            handleLogout(request, response);
        } else if ("/check-session".equals(pathInfo)) {
            checkSession(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if ("/login".equals(pathInfo)) {
            handleLogin(request, response);
        } else if ("/register".equals(pathInfo)) {
            handleRegister(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    /**
     * Handle user login
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        // Validate inputs
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format");
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Password is required");
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        User user = userDAO.authenticateUser(email, password);
        
        if (user != null) {
            // Create session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userName", user.getFullName());
            
            // Set session timeout (30 minutes)
            session.setMaxInactiveInterval(30 * 60);
            
            // Handle remember me
            if ("on".equals(remember)) {
                session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
            }
            
            LOGGER.log(Level.INFO, "User logged in: " + email);
            
            // Redirect based on role
            String redirectUrl = getRedirectUrlByRole(user.getRole());
            response.sendRedirect(request.getContextPath() + redirectUrl);
            
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle user registration
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String studentId = request.getParameter("studentId");
        String phone = request.getParameter("phone");
        
        // Validate inputs
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format");
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 8 characters with uppercase, lowercase, and digit");
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already registered");
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User newUser = new User();
        newUser.setEmail(email);
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setRole("student"); // Default role
        newUser.setStudentId(studentId);
        newUser.setPhone(phone);
        newUser.setActive(true);
        
        boolean created = userDAO.createUser(newUser, password);
        
        if (created) {
            LOGGER.log(Level.INFO, "New user registered: " + email);
            request.setAttribute("success", "Registration successful! Please log in.");
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/views/public/login.jsp").forward(request, response);
        }
    }
    
    /**
     * Handle user logout
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            String userEmail = (String) session.getAttribute("userEmail");
            session.invalidate();
            LOGGER.log(Level.INFO, "User logged out: " + userEmail);
        }
        
        response.sendRedirect(request.getContextPath() + "/views/public/index.jsp");
    }
    
    /**
     * Check if session is valid
     */
    private void checkSession(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        HttpSession session = request.getSession(false);
        
        response.setContentType("application/json");
        
        if (session != null && session.getAttribute("userId") != null) {
            response.getWriter().write("{\"valid\": true}");
        } else {
            response.getWriter().write("{\"valid\": false}");
        }
    }
    
    /**
     * Get redirect URL based on user role
     */
    private String getRedirectUrlByRole(String role) {
        switch (role.toLowerCase()) {
            case "admin":
                return "/views/admin/dashboard.jsp";
            case "librarian":
                return "/views/librarian/dashboard.jsp";
            case "organizer":
                return "/views/organizer/dashboard.jsp";
            case "student":
            default:
                return "/views/student/dashboard.jsp";
        }
    }
}
```

### 6. ValidationUtil.java

```java
package com.um6p.lc.utils;

import java.util.regex.Pattern;

/**
 * Validation Utility
 * Provides methods for validating user inputs
 */
public class ValidationUtil {
    
    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    
    // Phone validation pattern (international format)
    private static final Pattern PHONE_PATTERN = 
        Pattern.compile("^\\+?[1-9]\\d{1,14}$");
    
    // ISBN validation pattern (ISBN-10 or ISBN-13)
    private static final Pattern ISBN_PATTERN = 
        Pattern.compile("^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$");
    
    /**
     * Validate email format
     * @param email Email to validate
     * @return true if valid
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }
    
    /**
     * Validate phone number
     * @param phone Phone to validate
     * @return true if valid
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return true; // Phone is optional
        }
        String cleanPhone = phone.replaceAll("[\\s()-]", "");
        return PHONE_PATTERN.matcher(cleanPhone).matches();
    }
    
    /**
     * Validate ISBN
     * @param isbn ISBN to validate
     * @return true if valid
     */
    public static boolean isValidISBN(String isbn) {
        if (isbn == null || isbn.trim().isEmpty()) {
            return false;
        }
        String cleanISBN = isbn.replaceAll("[\\s-]", "");
        return cleanISBN.length() == 10 || cleanISBN.length() == 13;
    }
    
    /**
     * Validate password strength
     * @param password Password to validate
     * @return true if valid (at least 8 chars, upper, lower, digit)
     */
    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUppercase = password.chars().anyMatch(Character::isUpperCase);
        boolean hasLowercase = password.chars().anyMatch(Character::isLowercase);
        boolean hasDigit = password.chars().anyMatch(Character::isDigit);
        
        return hasUppercase && hasLowercase && hasDigit;
    }
    
    /**
     * Validate string is not null or empty
     * @param str String to validate
     * @return true if valid
     */
    public static boolean isNotEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }
    
    /**
     * Validate integer is positive
     * @param num Number to validate
     * @return true if positive
     */
    public static boolean isPositive(int num) {
        return num > 0;
    }
    
    /**
     * Sanitize input string (prevent XSS)
     * @param input Input string
     * @return Sanitized string
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        
        return input.replaceAll("<", "&lt;")
                   .replaceAll(">", "&gt;")
                   .replaceAll("\"", "&quot;")
                   .replaceAll("'", "&#x27;")
                   .replaceAll("/", "&#x2F;");
    }
}
```

### 7. login.jsp (Complete with Poppins Font)

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - UM6P Learning Center</title>
    
    <!-- Poppins Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --um6p-orange: #D95D39;
            --um6p-orange-dark: #C24D29;
            --lc-purple: #7B3FA4;
            --lc-blue: #3FA4D9;
            --lc-navy: #1E3A8A;
            --gray-50: #F9FAFB;
            --gray-100: #F3F4F6;
            --gray-200: #E5E7EB;
            --gray-700: #374151;
            --gray-900: #111827;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, var(--lc-navy) 0%, #0F172A 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .bg-pattern {
            position: absolute;
            opacity: 0.05;
        }

        .pattern-1 {
            top: -100px;
            right: -100px;
            width: 400px;
            height: 400px;
            border: 2px solid white;
            border-radius: 50%;
        }

        .pattern-2 {
            bottom: -100px;
            left: -100px;
            width: 300px;
            height: 300px;
            border: 2px solid white;
            border-radius: 50%;
        }

        .login-container {
            background: white;
            border-radius: 0;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 1000px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            overflow: hidden;
            position: relative;
            z-index: 10;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-left {
            background: linear-gradient(135deg, var(--um6p-orange) 0%, var(--um6p-orange-dark) 100%);
            padding: 60px;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .logo-section img {
            height: 60px;
            margin-bottom: 24px;
        }

        .brand-title {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 16px;
            line-height: 1.2;
        }

        .brand-subtitle {
            font-size: 18px;
            font-weight: 400;
            opacity: 0.95;
            line-height: 1.6;
            margin-bottom: 40px;
        }

        .features-list {
            list-style: none;
        }

        .feature-item {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .feature-icon {
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .feature-text {
            font-size: 16px;
            font-weight: 500;
        }

        .copyright {
            font-size: 13px;
            opacity: 0.7;
            margin-top: 40px;
        }

        .login-right {
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            margin-bottom: 40px;
        }

        .login-header h2 {
            font-size: 32px;
            font-weight: 800;
            color: var(--gray-900);
            margin-bottom: 8px;
        }

        .login-header p {
            color: var(--gray-700);
            font-size: 15px;
            font-weight: 400;
        }

        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-size: 14px;
            font-weight: 500;
        }

        .alert-error {
            background: #FEE2E2;
            color: #991B1B;
            border: 1px solid #FECACA;
        }

        .alert-success {
            background: #D1FAE5;
            color: #065F46;
            border: 1px solid #A7F3D0;
        }

        .form-group {
            margin-bottom: 24px;
        }

        label {
            display: block;
            color: var(--gray-900);
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-700);
            font-size: 18px;
        }

        input[type="email"],
        input[type="password"],
        input[type="text"] {
            width: 100%;
            padding: 14px 16px 14px 48px;
            border: 2px solid var(--gray-200);
            border-radius: 8px;
            font-size: 15px;
            font-family: 'Poppins', sans-serif;
            font-weight: 400;
            transition: all 0.3s ease;
            background: var(--gray-50);
        }

        input:focus {
            outline: none;
            border-color: var(--um6p-orange);
            background: white;
        }

        .options-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--gray-700);
            font-size: 14px;
            font-weight: 500;
        }

        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .forgot-link {
            color: var(--um6p-orange);
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .forgot-link:hover {
            color: var(--um6p-orange-dark);
        }

        .login-button {
            width: 100%;
            padding: 16px;
            background: var(--um6p-orange);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .login-button:hover {
            background: var(--um6p-orange-dark);
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(217, 93, 57, 0.3);
        }

        .divider {
            display: flex;
            align-items: center;
            gap: 16px;
            margin: 32px 0;
            color: var(--gray-700);
            font-size: 14px;
            font-weight: 500;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--gray-200);
        }

        .register-link {
            text-align: center;
            color: var(--gray-700);
            font-size: 14px;
            font-weight: 500;
        }

        .register-link a {
            color: var(--um6p-orange);
            text-decoration: none;
            font-weight: 700;
            transition: color 0.3s ease;
        }

        .register-link a:hover {
            color: var(--um6p-orange-dark);
        }

        @media (max-width: 968px) {
            .login-container {
                grid-template-columns: 1fr;
                max-width: 500px;
            }

            .login-left {
                display: none;
            }

            .login-right {
                padding: 40px;
            }
        }

        @media (max-width: 480px) {
            .login-right {
                padding: 30px;
            }

            .login-header h2 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
    <div class="bg-pattern pattern-1"></div>
    <div class="bg-pattern pattern-2"></div>

    <div class="login-container">
        <!-- Left Side - Branding -->
        <div class="login-left">
            <div class="logo-section">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="UM6P Learning Center">
                
                <h1 class="brand-title">Learning Center Portal</h1>
                <p class="brand-subtitle">Access your academic resources and connect with UM6P's vibrant learning community</p>
            </div>

            <ul class="features-list">
                <li class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <span class="feature-text">Access 5,000+ books and resources</span>
                </li>
                <li class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-calendar"></i>
                    </div>
                    <span class="feature-text">Register for workshops and events</span>
                </li>
                <li class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <span class="feature-text">Track your learning progress</span>
                </li>
                <li class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <span class="feature-text">Connect with the academic community</span>
                </li>
            </ul>

            <div class="copyright">
                © 2025 Mohammed VI Polytechnic University
            </div>
        </div>

        <!-- Right Side - Login Form -->
        <div class="login-right">
            <div class="login-header">
                <h2>Welcome Back</h2>
                <p>Sign in to your account to continue</p>
            </div>

            <!-- Error/Success Messages -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <!-- Login Form -->
            <form id="loginForm" action="${pageContext.request.contextPath}/auth/login" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrapper">
                        <i class="input-icon fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="student@um6p.ma" value="${email}" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <i class="input-icon fas fa-lock"></i>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>
                </div>

                <div class="options-row">
                    <label class="remember-me">
                        <input type="checkbox" id="remember" name="remember">
                        <span>Remember me</span>
                    </label>
                    <a href="#forgot" class="forgot-link">Forgot Password?</a>
                </div>

                <button type="submit" class="login-button">Sign In</button>

                <div class="divider">OR</div>

                <div class="register-link">
                    Don't have an account? <a href="#register">Create Account</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            
            if (!email || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
            }
        });
    </script>
</body>
</html>
```

---

## 📦 DEPENDENCIES (pom.xml)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.um6p.lc</groupId>
    <artifactId>learning-center</artifactId>
    <version>1.0.0</version>
    <packaging>war</packaging>

    <name>UM6P Learning Center</name>
    <description>Learning Center Management System for UM6P</description>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <!-- MySQL Connector -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.33</version>
        </dependency>

        <!-- Servlet API -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
            <scope>provided</scope>
        </dependency>

        <!-- JSP API -->
        <dependency>
            <groupId>javax.servlet.jsp</groupId>
            <artifactId>javax.servlet.jsp-api</artifactId>
            <version>2.3.3</version>
            <scope>provided</scope>
        </dependency>

        <!-- JSTL -->
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>jstl</artifactId>
            <version>1.2</version>
        </dependency>

        <!-- BCrypt for Password Hashing -->
        <dependency>
            <groupId>org.mindrot</groupId>
            <artifactId>jbcrypt</artifactId>
            <version>0.4</version>
        </dependency>

        <!-- JSON Processing (Gson) -->
        <dependency>
            <groupId>com.google.code.gson</groupId>
            <artifactId>gson</artifactId>
            <version>2.10.1</version>
        </dependency>

        <!-- Apache Commons Lang -->
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>3.12.0</version>
        </dependency>

        <!-- Apache Commons IO -->
        <dependency>
            <groupId>commons-io</groupId>
            <artifactId>commons-io</artifactId>
            <version>2.11.0</version>
        </dependency>

        <!-- File Upload (for handling image uploads) -->
        <dependency>
            <groupId>commons-fileupload</groupId>
            <artifactId>commons-fileupload</artifactId>
            <version>1.5</version>
        </dependency>

        <!-- Email Support (JavaMail) -->
        <dependency>
            <groupId>com.sun.mail</groupId>
            <artifactId>javax.mail</artifactId>
            <version>1.6.2</version>
        </dependency>

        <!-- Logging (SLF4J + Logback) -->
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>2.0.7</version>
        </dependency>
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>1.4.8</version>
        </dependency>

        <!-- JUnit for Testing -->
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <finalName>learning-center</finalName>
        <plugins>
            <!-- Maven Compiler Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>11</source>
                    <target>11</target>
                </configuration>
            </plugin>

            <!-- Maven WAR Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.3.2</version>
                <configuration>
                    <warName>learning-center</warName>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
```

---

## 🚀 IMPLEMENTATION ROADMAP

### Phase 1: Foundation (Week 1)
**Goal:** Set up project structure and authentication

1. **Day 1-2: Project Setup**
   - Create Maven project with pom.xml
   - Set up folder structure
   - Configure Tomcat server
   - Create database and tables

2. **Day 3-4: Authentication System**
   - Implement User model and UserDAO
   - Create AuthController servlet
   - Build login.jsp page
   - Test login/logout flow

3. **Day 5-7: Core Utilities**
   - Create PasswordUtil, ValidationUtil, DateUtil
   - Set up authentication filter
   - Create session management
   - Build user dashboard skeleton

**Deliverables:**
- Working authentication system
- User can register, login, logout
- Session management active
- Basic dashboard access by role

---

### Phase 2: Book Management (Week 2-3)
**Goal:** Complete book catalog and reservation system

1. **Week 2: Book Module**
   - Create Book model and BookDAO
   - Implement BookController
   - Build books.jsp catalog page
   - Add search and filter functionality

2. **Week 3: Reservations**
   - Create Reservation model and ReservationDAO
   - Implement ReservationController
   - Build my-reservations.jsp
   - Add borrow/return workflow

**Deliverables:**
- Full book catalog with search/filter
- Book reservation system working
- Students can reserve and view books
- Librarians can manage reservations

---

### Phase 3: Event Management (Week 4)
**Goal:** Events and workshop registration

1. **Event Creation**
   - Create Event model and EventDAO
   - Implement EventController
   - Build manage-events.jsp (organizer)

2. **Event Registration**
   - Create Registration model and RegistrationDAO
   - Implement RegistrationController
   - Build events.jsp (student view)
   - Add capacity checking logic

**Deliverables:**
- Event creation and management
- Student event registration
- Capacity tracking
- Attendance marking

---

### Phase 4: Dashboards & Reports (Week 5)
**Goal:** Complete dashboards for all roles

1. **Student Dashboard**
   - Statistics cards
   - Recent activities
   - Quick actions

2. **Librarian Dashboard**
   - Book management
   - Reservation approvals
   - Reports

3. **Admin Dashboard**
   - User management
   - System analytics
   - Settings

**Deliverables:**
- Complete dashboards for all 4 roles
- Analytics and statistics
- Report generation

---

### Phase 5: Polish & Features (Week 6)
**Goal:** Final features and testing

1. **Notifications**
   - Create NotificationDAO
   - Implement notification system
   - Email notifications (optional)

2. **Search & Filters**
   - Global search functionality
   - Advanced filters
   - Sort options

3. **Testing & Bug Fixes**
   - Cross-browser testing
   - Responsive design fixes
   - Security audit
   - Performance optimization

**Deliverables:**
- Notification system
- Enhanced search
- Bug-free application
- Production-ready code

---

## 🔐 SECURITY CHECKLIST

### Authentication & Authorization
- [ ] Passwords hashed with BCrypt
- [ ] Session timeout (30 minutes)
- [ ] Session invalidation on logout
- [ ] Role-based access control
- [ ] Password complexity requirements
- [ ] Account lockout after failed attempts

### Data Security
- [ ] SQL injection prevention (PreparedStatements)
- [ ] XSS prevention (input sanitization)
- [ ] CSRF protection (tokens)
- [ ] Secure file upload validation
- [ ] Database connection pooling
- [ ] Sensitive data encryption

### Server Security
- [ ] HTTPS enabled
- [ ] Security headers configured
- [ ] Error pages don't reveal info
- [ ] Logging sensitive operations
- [ ] Regular security updates

---

## 📊 API ENDPOINTS REFERENCE

```
AUTHENTICATION
POST   /auth/login              - User login
POST   /auth/logout             - User logout
POST   /auth/register           - New user registration
GET    /auth/check-session      - Verify session validity

BOOKS
GET    /books                   - List all books
GET    /books/search            - Search books (params: query, category, language)
GET    /books/{id}              - Get book details
POST   /books/create            - Create book (Librarian+)
PUT    /books/{id}/update       - Update book (Librarian+)
DELETE /books/{id}/delete       - Delete book (Admin)

RESERVATIONS
GET    /reservations/my         - User's reservations
POST   /reservations/create     - Reserve a book
POST   /reservations/cancel     - Cancel reservation
PUT    /reservations/{id}/borrow - Mark as borrowed (Librarian)
PUT    /reservations/{id}/return - Mark as returned (Librarian)
GET    /reservations/overdue    - Get overdue reservations

EVENTS
GET    /events                  - List upcoming events
GET    /events/search           - Search events
GET    /events/{id}             - Event details
POST   /events/create           - Create event (Organizer+)
PUT    /events/{id}/update      - Update event (Organizer+)
DELETE /events/{id}/cancel      - Cancel event (Admin)

REGISTRATIONS
GET    /registrations/my        - User's event registrations
POST   /registrations/create    - Register for event
POST   /registrations/cancel    - Cancel registration
GET    /registrations/event/{id} - Event attendees (Organizer+)
POST   /registrations/attendance - Mark attendance (Organizer+)

USERS
GET    /users                   - List users (Admin)
GET    /users/{id}              - User details
POST   /users/create            - Create user (Admin)
PUT    /users/{id}/update       - Update user
PUT    /users/{id}/role         - Update user role (Admin)
DELETE /users/{id}/delete       - Delete user (Admin)

NOTIFICATIONS
GET    /notifications/my        - User's notifications
POST   /notifications/mark-read - Mark notification as read
DELETE /notifications/{id}      - Delete notification

DASHBOARD
GET    /dashboard/stats         - Dashboard statistics
GET    /dashboard/activities    - Recent activities
```

---

## 🎯 HOW TO USE THIS DOCUMENT WITH AI AGENTS

### Method 1: Complete Build Request

```
I need you to build the complete UM6P Learning Center Management System.

Use this exact design system:
- Font: Poppins (all weights)
- Colors: From UM6P logo (orange #D95D39, purple #7B3FA4, blue #3FA4D9, navy #1E3A8A)
- Spacing: 8px base unit
- Border radius: 8px for cards and inputs

Build in this order:
1. Database setup (use provided schema)
2. Authentication system (User, UserDAO, AuthController, login.jsp)
3. Book management (Book, BookDAO, BookController, books.jsp)
4. Reservation system
5. Event management
6. Registration system
7. Dashboards for all roles

Use the provided code templates as reference.
All code must be production-ready with proper error handling and logging.
```

### Method 2: Feature-by-Feature Request

**For Authentication:**
```
Create the complete authentication system using:
- Poppins font family
- Colors from UM6P logo (orange #D95D39, navy #1E3A8A)
- User.java model (provided)
- UserDAO.java with authentication methods (provided)
- AuthController.java servlet (provided)
- login.jsp with exact styling (provided)
- BCrypt password hashing
- Session management

Include all error handling and validation.
```

**For Book Catalog:**
```
Create the book catalog system:
- Book.java model with all fields
- BookDAO.java with search functionality
- BookController.java servlet
- books.jsp catalog page
- Use Poppins font and UM6P colors
- Grid layout with cards
- Search and filter sidebar
- Pagination

Follow the design system specifications provided.
```

### Method 3: Incremental Building

Start small and build up:

1. "Create User.java model with all fields from the schema"
2. "Create UserDAO.java with authentication methods"
3. "Create AuthController.java servlet"
4. "Create login.jsp with Poppins font and UM6P styling"
5. "Test the authentication flow"

Then move to next module.

---

## ✅ TESTING CHECKLIST

### Functional Testing
- [ ] User can register with valid data
- [ ] User can login with correct credentials
- [ ] Login fails with wrong password
- [ ] Session persists across pages
- [ ] Logout clears session
- [ ] Role-based access works
- [ ] Book search returns correct results
- [ ] Book reservation creates record
- [ ] Reservation status updates correctly
- [ ] Event registration checks capacity
- [ ] Duplicate registration prevented
- [ ] Notifications created properly

### UI/UX Testing
- [ ] Poppins font loads correctly
- [ ] UM6P colors applied everywhere
- [ ] Forms validate inputs
- [ ] Error messages display
- [ ] Success messages display
- [ ] Loading states work
- [ ] Hover effects smooth
- [ ] Responsive on mobile
- [ ] Tables paginate
- [ ] Search filters work

### Security Testing
- [ ] SQL injection prevented
- [ ] XSS attacks blocked
- [ ] Passwords hashed (never plain text)
- [ ] Sessions expire
- [ ] Unauthorized access blocked
- [ ] File uploads validated

---

## 🎨 DESIGN GUIDELINES

### Color Usage

**Primary Actions:** UM6P Orange (#D95D39)
- Login buttons
- Primary CTAs
- Active states
- Links

**Backgrounds:** Navy Blue (#1E3A8A)
- Headers
- Sidebars
- Hero sections

**Accents:** Use logo colors sparingly
- Purple (#7B3FA4) - Special badges
- Blue (#3FA4D9) - Info messages
- Cyan (#40C4D9) - Secondary actions

**Neutrals:** Gray scale
- Text: gray-900, gray-700
- Backgrounds: gray-50, gray-100
- Borders: gray-200, gray-300

### Typography Usage

```css
/* Page Titles */
h1 { font-size: 48px; font-weight: 800; }

/* Section Headings */
h2 { font-size: 40px; font-weight: 700; }

/* Card Titles */
h3 { font-size: 24px; font-weight: 600; }

/* Body Text */
body { font-size: 16px; font-weight: 400; line-height: 1.6; }

/* Small Text */
.text-sm { font-size: 14px; font-weight: 400; }

/* Labels */
label { font-size: 14px; font-weight: 600; }

/* Buttons */
button { font-size: 16px; font-weight: 700; }
```

---

## 📝 FINAL NOTES FOR AI AGENTS

1. **Always use Poppins font** - Import from Google Fonts
2. **Exact colors from logo** - Use the CSS variables provided
3. **8px spacing system** - All margins/padding must be multiples of 8
4. **Professional look** - Clean, corporate, academic aesthetic
5. **Error handling** - Every database operation must have try-catch
6. **Logging** - Log all important operations
7. **Validation** - Validate all user inputs (client + server)
8. **Security** - Use PreparedStatements, hash passwords, sanitize inputs
9. **Comments** - Add JavaDoc comments to all methods
10. **Consistency** - Follow the patterns in the provided templates

---

## 🎓 SUCCESS CRITERIA

The system is complete when:
- ✅ All 4 user roles can login
- ✅ Students can browse and reserve books
- ✅ Students can register for events
- ✅ Librarians can manage books and reservations
- ✅ Organizers can create and manage events
- ✅ Admins can manage users and view analytics
- ✅ All pages use Poppins font
- ✅ All pages use UM6P logo colors
- ✅ Design is professional and consistent
- ✅ System is secure (no SQL injection, passwords hashed)
- ✅ Error handling works properly
- ✅ Responsive on mobile devices

---

**END OF INSTRUCTIONS**

This document contains everything needed to build the complete UM6P Learning Center Management System. Follow the structure, use the templates, apply the design system, and create production-ready code.

**Version:** 1.0  
**Last Updated:** November 28, 2025  
**Created for:** AI Agent Development
