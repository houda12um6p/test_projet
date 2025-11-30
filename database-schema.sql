-- ================================================
-- UM6P Learning Center - Database Schema
-- MySQL 8.0+
-- ================================================

CREATE DATABASE IF NOT EXISTS um6p_learning_center CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE um6p_learning_center;

-- ================================================
-- TABLE: users
-- ================================================
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

-- ================================================
-- TABLE: books
-- ================================================
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

-- ================================================
-- TABLE: events
-- ================================================
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

-- ================================================
-- TABLE: reservations
-- ================================================
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

-- ================================================
-- TABLE: event_registrations
-- ================================================
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

-- ================================================
-- TABLE: notifications
-- ================================================
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

-- ================================================
-- SEED DATA - Test Users
-- ================================================

-- Password for all test users: Password123

-- Admin User
INSERT INTO users (email, password_hash, first_name, last_name, role, is_active) VALUES
('admin@um6p.ma', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyJgHlqKe/TK', 'Admin', 'User', 'admin', TRUE);

-- Librarian User
INSERT INTO users (email, password_hash, first_name, last_name, role, is_active) VALUES
('librarian@um6p.ma', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyJgHlqKe/TK', 'Sarah', 'Johnson', 'librarian', TRUE);

-- Organizer User
INSERT INTO users (email, password_hash, first_name, last_name, role, is_active) VALUES
('organizer@um6p.ma', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyJgHlqKe/TK', 'Mohammed', 'Alaoui', 'organizer', TRUE);

-- Student User
INSERT INTO users (email, password_hash, first_name, last_name, role, student_id, is_active) VALUES
('student@um6p.ma', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyJgHlqKe/TK', 'Houda', 'Toudali', 'student', 'STU2025001', TRUE);

-- ================================================
-- SEED DATA - Sample Books
-- ================================================
INSERT INTO books (isbn, title, author, publisher, publication_year, category, language, pages, description, total_copies, available_copies, created_by) VALUES
('9780134685991', 'Effective Java', 'Joshua Bloch', 'Addison-Wesley', 2018, 'Programming', 'English', 416, 'Best practices for Java programming', 3, 3, 2),
('9780596009205', 'Head First Design Patterns', 'Eric Freeman', 'O''Reilly Media', 2004, 'Programming', 'English', 638, 'Design patterns explained with examples', 2, 2, 2),
('9781449355739', 'Learning MySQL', 'Seyed Tahaghoghi', 'O''Reilly Media', 2021, 'Database', 'English', 624, 'Comprehensive guide to MySQL', 2, 1, 2);

-- ================================================
-- SEED DATA - Sample Events
-- ================================================
INSERT INTO events (title, description, event_type, event_date, location, instructor, max_capacity, current_registrations, poster_image_url, organizer_id, status) VALUES
('Pr. Ali Benmakhlouf - Mémoriser le Coran, vivre l''islam', 'A masterclass on memorizing the Quran and living Islam', 'masterclass', '2025-11-25 18:00:00', 'Showroom - Learning Center EMINES', 'Prof. Ali Benmakhlouf', 50, 40, '/assets/images/event-1.png', 3, 'upcoming'),
('Halim Mahmoudi - Falloujah: Ma campagne perdue', 'Discussion about the Fallujah campaign', 'masterclass', '2025-10-16 18:00:00', 'Showroom - Learning Center EMINES', 'Halim Mahmoudi', 50, 50, '/assets/images/event-4.png', 3, 'completed');

-- ================================================
-- END OF SCHEMA
-- ================================================
