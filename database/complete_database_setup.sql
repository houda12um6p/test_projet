-- ================================================================
-- UM6P LEARNING CENTER - COMPLETE DATABASE SETUP
-- Based on SRS Requirements Document
-- Creates all tables and populates with realistic sample data
-- ================================================================

-- Drop database if exists and create fresh
DROP DATABASE IF EXISTS um6p_learning_center;
CREATE DATABASE um6p_learning_center CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE um6p_learning_center;

-- ================================================================
-- TABLE 1: USERS (Main authentication table)
-- ================================================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'STAFF', 'LIBRARIAN', 'ADMIN') NOT NULL DEFAULT 'STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB;

-- ================================================================
-- TABLE 2: STUDENTS (Student-specific information)
-- ================================================================
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    student_number VARCHAR(50) NOT NULL UNIQUE,
    major VARCHAR(100) NOT NULL,
    year_level INT NOT NULL,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_student_number (student_number)
) ENGINE=InnoDB;

-- ================================================================
-- TABLE 3: STAFF (Staff-specific information)
-- ================================================================
CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    staff_number VARCHAR(50) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_staff_number (staff_number)
) ENGINE=InnoDB;

-- ================================================================
-- TABLE 4: BOOKS (Library catalog)
-- ================================================================
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(200) NOT NULL,
    publisher VARCHAR(200),
    publication_year INT,
    genre VARCHAR(100) NOT NULL,
    description TEXT,
    language VARCHAR(50) DEFAULT 'English',
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    location VARCHAR(100) NOT NULL,
    status ENUM('available', 'maintenance', 'retired') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_isbn (isbn),
    INDEX idx_title (title),
    INDEX idx_author (author),
    INDEX idx_genre (genre),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- ================================================================
-- TABLE 5: EVENTS (Workshops and events)
-- ================================================================
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    location VARCHAR(200) NOT NULL,
    instructor VARCHAR(200),
    category ENUM('Workshop', 'Seminar', 'Conference', 'Training', 'Masterclass') NOT NULL,
    capacity INT NOT NULL,
    current_attendees INT DEFAULT 0,
    status ENUM('active', 'cancelled', 'completed') DEFAULT 'active',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    INDEX idx_event_date (event_date),
    INDEX idx_category (category),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- ================================================================
-- TABLE 6: BORROWINGS (Book loan tracking)
-- ================================================================
CREATE TABLE borrowings (
    borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    status ENUM('active', 'returned', 'overdue') DEFAULT 'active',
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    INDEX idx_user_id (user_id),
    INDEX idx_book_id (book_id),
    INDEX idx_status (status),
    INDEX idx_due_date (due_date)
) ENGINE=InnoDB;

-- ================================================================
-- TABLE 7: RESERVATIONS (Book reservations)
-- ================================================================
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expiry_date TIMESTAMP NULL,
    status ENUM('pending', 'available', 'expired', 'cancelled', 'fulfilled') DEFAULT 'pending',
    queue_position INT,
    notified BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    INDEX idx_user_id (user_id),
    INDEX idx_book_id (book_id),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- ================================================================
-- TABLE 8: REGISTRATIONS (Event registrations)
-- ================================================================
CREATE TABLE registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('confirmed', 'cancelled', 'attended', 'no_show') DEFAULT 'confirmed',
    confirmation_sent BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    UNIQUE KEY unique_registration (user_id, event_id),
    INDEX idx_user_id (user_id),
    INDEX idx_event_id (event_id),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- ================================================================
-- TABLE 9: NOTIFICATIONS (System notifications)
-- ================================================================
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('info', 'warning', 'success', 'error') DEFAULT 'info',
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX idx_user_id (user_id),
    INDEX idx_is_read (is_read),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB;

-- ================================================================
-- POPULATE WITH REALISTIC SAMPLE DATA
-- ================================================================

-- ----------------------------------------------------------------
-- INSERT USERS (Passwords are BCrypt hashed for "Password123")
-- ----------------------------------------------------------------
-- BCrypt hash for "Password123": $2a$10$N9qo8uLOickgx2ZMRZoMye

INSERT INTO users (name, email, password, role, created_at, last_login) VALUES
-- Students
('Ahmed Benali', 'ahmed.benali@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Fatima Zahra Alami', 'fatima.alami@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Youssef El Idrissi', 'youssef.idrissi@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Sara Amrani', 'sara.amrani@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Mehdi Tazi', 'mehdi.tazi@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Leila Berrada', 'leila.berrada@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Omar Chakir', 'omar.chakir@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Malak Senhaji', 'malak.senhaji@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Hamza Benjelloun', 'hamza.benjelloun@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),
('Nadia Lahlou', 'nadia.lahlou@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STUDENT', NOW(), NOW()),

-- Staff & Librarians
('Imane Fouad', 'imane.fouad@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STAFF', NOW(), NOW()),
('Karim Alaoui', 'karim.alaoui@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STAFF', NOW(), NOW()),
('Zineb Fassi', 'zineb.fassi@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'LIBRARIAN', NOW(), NOW()),
('Hassan Toudali', 'hassan.toudali@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STAFF', NOW(), NOW()),
('Asma Khamri', 'asma.khamri@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhkC', 'STAFF', NOW(), NOW());

-- ----------------------------------------------------------------
-- INSERT STUDENT DETAILS
-- ----------------------------------------------------------------
INSERT INTO students (user_id, student_number, major, year_level, enrollment_date) VALUES
(1, 'UM6P2022001', 'Computer Science', 3, '2022-09-01'),
(2, 'UM6P2023015', 'Data Science', 2, '2023-09-01'),
(3, 'UM6P2021087', 'Software Engineering', 4, '2021-09-01'),
(4, 'UM6P2023042', 'Artificial Intelligence', 2, '2023-09-01'),
(5, 'UM6P2022056', 'Cybersecurity', 3, '2022-09-01'),
(6, 'UM6P2024003', 'Computer Science', 1, '2024-09-01'),
(7, 'UM6P2023078', 'Data Science', 2, '2023-09-01'),
(8, 'UM6P2022091', 'Software Engineering', 3, '2022-09-01'),
(9, 'UM6P2021045', 'Computer Science', 4, '2021-09-01'),
(10, 'UM6P2024018', 'Artificial Intelligence', 1, '2024-09-01');

-- ----------------------------------------------------------------
-- INSERT STAFF DETAILS
-- ----------------------------------------------------------------
INSERT INTO staff (user_id, staff_number, department, position, hire_date) VALUES
(11, 'STAFF001', 'Learning Center', 'Director', '2020-01-15'),
(12, 'STAFF002', 'Learning Center', 'Events Coordinator', '2021-03-10'),
(13, 'STAFF003', 'Library', 'Senior Librarian', '2019-07-01'),
(14, 'STAFF004', 'Learning Center', 'Workshop Facilitator', '2022-09-01'),
(15, 'STAFF005', 'Learning Center', 'Program Manager', '2021-11-15');

-- ----------------------------------------------------------------
-- INSERT BOOKS (Realistic academic library collection)
-- ----------------------------------------------------------------
INSERT INTO books (isbn, title, author, publisher, publication_year, genre, description, language, total_copies, available_copies, location, status) VALUES
-- Computer Science
('978-0262033848', 'Introduction to Algorithms', 'Thomas H. Cormen', 'MIT Press', 2009, 'Computer Science', 'Comprehensive introduction to algorithms and data structures', 'English', 5, 3, 'Section A - Shelf 1', 'available'),
('978-0134685991', 'Effective Java', 'Joshua Bloch', 'Addison-Wesley', 2018, 'Programming', 'Best practices for Java programming language', 'English', 4, 4, 'Section A - Shelf 2', 'available'),
('978-0135957059', 'The Pragmatic Programmer', 'David Thomas', 'Addison-Wesley', 2019, 'Software Engineering', 'Your journey to mastery in software development', 'English', 3, 2, 'Section A - Shelf 3', 'available'),
('978-1491950357', 'Building Microservices', 'Sam Newman', "O'Reilly Media", 2021, 'Software Architecture', 'Designing fine-grained systems', 'English', 3, 3, 'Section A - Shelf 4', 'available'),
('978-0321573513', 'Algorithms', 'Robert Sedgewick', 'Addison-Wesley', 2011, 'Computer Science', 'Fourth edition of algorithms textbook', 'English', 4, 2, 'Section A - Shelf 1', 'available'),

-- Data Science & AI
('978-1492032649', 'Hands-On Machine Learning', 'Aurélien Géron', "O'Reilly Media", 2019, 'Machine Learning', 'Scikit-Learn, Keras, and TensorFlow practical guide', 'English', 6, 4, 'Section B - Shelf 1', 'available'),
('978-1449369415', 'Python for Data Analysis', 'Wes McKinney', "O'Reilly Media", 2017, 'Data Science', 'Data wrangling with Pandas, NumPy, and IPython', 'English', 5, 5, 'Section B - Shelf 2', 'available'),
('978-0262035613', 'Deep Learning', 'Ian Goodfellow', 'MIT Press', 2016, 'Artificial Intelligence', 'Comprehensive introduction to deep learning', 'English', 4, 3, 'Section B - Shelf 3', 'available'),
('978-1617294433', 'Deep Learning with Python', 'François Chollet', 'Manning', 2021, 'Machine Learning', 'Deep learning using Keras and TensorFlow', 'English', 4, 4, 'Section B - Shelf 4', 'available'),
('978-1491952962', 'Data Science from Scratch', 'Joel Grus', "O'Reilly Media", 2019, 'Data Science', 'First principles with Python', 'English', 3, 2, 'Section B - Shelf 1', 'available'),

-- Cybersecurity
('978-1119620105', 'The Art of Invisibility', 'Kevin Mitnick', 'Little, Brown', 2017, 'Cybersecurity', 'Protecting your personal data in the digital age', 'English', 3, 3, 'Section C - Shelf 1', 'available'),
('978-1119572145', 'Cybersecurity Essentials', 'Charles J. Brooks', 'Wiley', 2020, 'Cybersecurity', 'Comprehensive introduction to cybersecurity', 'English', 4, 3, 'Section C - Shelf 2', 'available'),
('978-1593279509', 'The Web Application Hacker Handbook', 'Dafydd Stuttard', 'Wiley', 2011, 'Security', 'Finding and exploiting security flaws', 'English', 2, 1, 'Section C - Shelf 3', 'available'),
('978-1118963814', 'Hacking: The Art of Exploitation', 'Jon Erickson', 'No Starch Press', 2008, 'Security', 'Second edition of hacking fundamentals', 'English', 3, 3, 'Section C - Shelf 4', 'available'),

-- Software Engineering
('978-0132350884', 'Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, 'Software Engineering', 'A handbook of agile software craftsmanship', 'English', 5, 4, 'Section A - Shelf 5', 'available'),
('978-0201633610', 'Design Patterns', 'Erich Gamma', 'Addison-Wesley', 1994, 'Software Engineering', 'Elements of reusable object-oriented software', 'English', 4, 2, 'Section A - Shelf 6', 'available'),
('978-0137081073', 'The Clean Coder', 'Robert C. Martin', 'Prentice Hall', 2011, 'Professional Development', 'A code of conduct for professional programmers', 'English', 3, 3, 'Section A - Shelf 7', 'available'),
('978-0135974445', 'Domain-Driven Design', 'Eric Evans', 'Addison-Wesley', 2003, 'Software Architecture', 'Tackling complexity in the heart of software', 'English', 2, 2, 'Section A - Shelf 8', 'available'),

-- Business & Management
('978-0345538987', 'The Phoenix Project', 'Gene Kim', 'IT Revolution Press', 2018, 'IT Management', 'A novel about IT, DevOps, and helping your business win', 'English', 3, 2, 'Section D - Shelf 1', 'available'),
('978-0321601919', 'Continuous Delivery', 'Jez Humble', 'Addison-Wesley', 2010, 'DevOps', 'Reliable software releases through build, test, and deployment', 'English', 2, 2, 'Section D - Shelf 2', 'available'),

-- French Language Books
('978-2212673708', 'Python pour les nuls', 'John Paul Mueller', 'First Interactive', 2019, 'Programming', 'Introduction à Python en français', 'French', 4, 4, 'Section E - Shelf 1', 'available'),
('978-2409028939', 'Intelligence Artificielle', 'Aurelien Geron', 'ENI', 2021, 'Artificial Intelligence', 'Introduction à l''IA et machine learning', 'French', 3, 3, 'Section E - Shelf 2', 'available'),

-- Arabic Language Books
('978-9957532734', 'مقدمة في علم الحاسوب', 'محمد الأمين', 'دار الفكر', 2020, 'Computer Science', 'Introduction to Computer Science in Arabic', 'Arabic', 3, 3, 'Section E - Shelf 3', 'available'),
('978-9957123456', 'البرمجة بلغة جافا', 'أحمد السيد', 'دار المعرفة', 2021, 'Programming', 'Java Programming in Arabic', 'Arabic', 2, 2, 'Section E - Shelf 4', 'available'),

-- Mathematics & Statistics
('978-0071154517', 'Calculus: Early Transcendentals', 'James Stewart', 'McGraw-Hill', 2015, 'Mathematics', 'Comprehensive calculus textbook', 'English', 6, 5, 'Section F - Shelf 1', 'available'),
('978-0538733526', 'The Practice of Statistics', 'Daren Starnes', 'W.H. Freeman', 2014, 'Statistics', 'Introduction to statistical thinking', 'English', 4, 4, 'Section F - Shelf 2', 'available'),
('978-1461471370', 'An Introduction to Statistical Learning', 'Gareth James', 'Springer', 2013, 'Statistics', 'With applications in R', 'English', 5, 3, 'Section F - Shelf 3', 'available');

-- ----------------------------------------------------------------
-- INSERT EVENTS (Upcoming workshops and events)
-- ----------------------------------------------------------------
INSERT INTO events (title, description, event_date, event_time, location, instructor, category, capacity, current_attendees, status, created_by) VALUES
-- Upcoming Events (Next 3 months)
('Introduction to Machine Learning', 'Learn the fundamentals of machine learning algorithms and applications. Hands-on workshop with Python and scikit-learn.', '2025-12-15', '14:00:00', 'Learning Center - Room 101', 'Dr. Karim Alaoui', 'Workshop', 50, 0, 'active', 12),
('Web Development with React', 'Build modern web applications using React.js. From basics to advanced concepts including hooks and state management.', '2025-12-20', '10:00:00', 'Learning Center - Lab A', 'Hassan Toudali', 'Workshop', 40, 0, 'active', 14),
('Cybersecurity Best Practices', 'Essential cybersecurity practices for developers. Learn about common vulnerabilities and how to prevent them.', '2026-01-10', '15:00:00', 'Learning Center - Auditorium', 'Zineb Fassi', 'Seminar', 80, 0, 'active', 13),
('Data Visualization with Python', 'Create stunning data visualizations using Matplotlib, Seaborn, and Plotly. Practical examples and projects.', '2026-01-18', '14:00:00', 'Learning Center - Room 102', 'Asma Khamri', 'Workshop', 45, 0, 'active', 15),
('Introduction to Cloud Computing', 'Explore cloud computing concepts with AWS and Azure. Hands-on labs and real-world scenarios.', '2026-01-25', '10:00:00', 'Learning Center - Lab B', 'Dr. Karim Alaoui', 'Training', 35, 0, 'active', 12),
('Agile Software Development', 'Master Scrum and Agile methodologies. Team collaboration, sprint planning, and continuous delivery.', '2026-02-05', '13:00:00', 'Learning Center - Room 103', 'Hassan Toudali', 'Workshop', 50, 0, 'active', 14),
('Deep Learning Fundamentals', 'Introduction to neural networks and deep learning using TensorFlow and Keras. Build your first neural network.', '2026-02-15', '14:30:00', 'Learning Center - Lab A', 'Dr. Karim Alaoui', 'Workshop', 40, 0, 'active', 12),
('Mobile App Development', 'Create native mobile apps for iOS and Android using React Native. Cross-platform development techniques.', '2026-02-22', '10:00:00', 'Learning Center - Lab C', 'Asma Khamri', 'Training', 30, 0, 'active', 15),

-- Featured Masterclass (From your event posters)
('Pr. Ali Benmakhlouf - Mémoriser le Coran, vivre l''islam', 'Masterclass with Professor Ali Benmakhlouf discussing memorization of the Quran and living Islamic values.', '2025-11-25', '18:00:00', 'Showroom - Learning Center EMINES', 'Pr. Ali Benmakhlouf', 'Masterclass', 50, 40, 'active', 11),
('Halim Mahmoudi - Falloujah: Ma campagne perdue', 'Discussion with Halim Mahmoudi about his book Falloujah and war journalism experiences.', '2025-10-16', '18:00:00', 'Showroom - Learning Center EMINES', 'Halim Mahmoudi', 'Masterclass', 50, 50, 'active', 11),

-- Past Events
('Python Programming Basics', 'Introduction to Python programming for beginners. Variables, loops, functions, and object-oriented programming.', '2025-10-05', '14:00:00', 'Learning Center - Lab A', 'Hassan Toudali', 'Workshop', 45, 42, 'completed', 14),
('Git & GitHub Workshop', 'Version control with Git and collaboration using GitHub. Essential skills for every developer.', '2025-09-28', '10:00:00', 'Learning Center - Room 101', 'Asma Khamri', 'Workshop', 40, 38, 'completed', 15);

-- ----------------------------------------------------------------
-- INSERT SAMPLE BORROWINGS (Active and historical)
-- ----------------------------------------------------------------
INSERT INTO borrowings (user_id, book_id, borrow_date, due_date, return_date, status) VALUES
-- Active borrowings
(1, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), DATE_ADD(CURDATE(), INTERVAL 9 DAY), NULL, 'active'),
(1, 6, DATE_SUB(CURDATE(), INTERVAL 3 DAY), DATE_ADD(CURDATE(), INTERVAL 11 DAY), NULL, 'active'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 7 DAY), DATE_ADD(CURDATE(), INTERVAL 7 DAY), NULL, 'active'),
(3, 5, DATE_SUB(CURDATE(), INTERVAL 10 DAY), DATE_ADD(CURDATE(), INTERVAL 4 DAY), NULL, 'active'),
(4, 8, DATE_SUB(CURDATE(), INTERVAL 2 DAY), DATE_ADD(CURDATE(), INTERVAL 12 DAY), NULL, 'active'),
(5, 10, DATE_SUB(CURDATE(), INTERVAL 6 DAY), DATE_ADD(CURDATE(), INTERVAL 8 DAY), NULL, 'active'),

-- Overdue borrowings
(6, 13, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 6 DAY), NULL, 'overdue'),
(7, 16, DATE_SUB(CURDATE(), INTERVAL 25 DAY), DATE_SUB(CURDATE(), INTERVAL 11 DAY), NULL, 'overdue'),

-- Returned borrowings
(1, 3, DATE_SUB(CURDATE(), INTERVAL 30 DAY), DATE_SUB(CURDATE(), INTERVAL 16 DAY), DATE_SUB(CURDATE(), INTERVAL 17 DAY), 'returned'),
(2, 7, DATE_SUB(CURDATE(), INTERVAL 25 DAY), DATE_SUB(CURDATE(), INTERVAL 11 DAY), DATE_SUB(CURDATE(), INTERVAL 12 DAY), 'returned'),
(3, 9, DATE_SUB(CURDATE(), INTERVAL 45 DAY), DATE_SUB(CURDATE(), INTERVAL 31 DAY), DATE_SUB(CURDATE(), INTERVAL 30 DAY), 'returned'),
(4, 15, DATE_SUB(CURDATE(), INTERVAL 20 DAY), DATE_SUB(CURDATE(), INTERVAL 6 DAY), DATE_SUB(CURDATE(), INTERVAL 8 DAY), 'returned'),
(5, 18, DATE_SUB(CURDATE(), INTERVAL 35 DAY), DATE_SUB(CURDATE(), INTERVAL 21 DAY), DATE_SUB(CURDATE(), INTERVAL 22 DAY), 'returned');

-- Update available copies based on active borrowings
UPDATE books SET available_copies = total_copies - (SELECT COUNT(*) FROM borrowings WHERE book_id = books.book_id AND status = 'active');

-- ----------------------------------------------------------------
-- INSERT SAMPLE RESERVATIONS
-- ----------------------------------------------------------------
INSERT INTO reservations (user_id, book_id, reservation_date, status, queue_position) VALUES
(8, 1, NOW(), 'pending', 1),
(9, 1, NOW(), 'pending', 2),
(10, 5, NOW(), 'pending', 1),
(6, 16, NOW(), 'available', NULL),
(7, 13, NOW(), 'available', NULL);

-- ----------------------------------------------------------------
-- INSERT SAMPLE REGISTRATIONS
-- ----------------------------------------------------------------
INSERT INTO registrations (user_id, event_id, registration_date, status, confirmation_sent) VALUES
-- For Ali Benmakhlouf Masterclass (40/50 registered)
(1, 9, DATE_SUB(NOW(), INTERVAL 5 DAY), 'confirmed', TRUE),
(2, 9, DATE_SUB(NOW(), INTERVAL 4 DAY), 'confirmed', TRUE),
(3, 9, DATE_SUB(NOW(), INTERVAL 3 DAY), 'confirmed', TRUE),
(4, 9, DATE_SUB(NOW(), INTERVAL 2 DAY), 'confirmed', TRUE),
(5, 9, DATE_SUB(NOW(), INTERVAL 1 DAY), 'confirmed', TRUE),

-- For other upcoming events
(1, 1, NOW(), 'confirmed', TRUE),
(2, 2, NOW(), 'confirmed', TRUE),
(3, 3, NOW(), 'confirmed', TRUE),
(4, 4, NOW(), 'confirmed', TRUE),
(5, 5, NOW(), 'confirmed', TRUE),
(6, 1, NOW(), 'confirmed', TRUE),
(7, 2, NOW(), 'confirmed', TRUE),
(8, 3, NOW(), 'confirmed', TRUE),

-- Past event attendees
(1, 11, DATE_SUB(NOW(), INTERVAL 30 DAY), 'attended', TRUE),
(2, 11, DATE_SUB(NOW(), INTERVAL 30 DAY), 'attended', TRUE),
(3, 12, DATE_SUB(NOW(), INTERVAL 35 DAY), 'attended', TRUE),
(4, 12, DATE_SUB(NOW(), INTERVAL 35 DAY), 'no_show', TRUE);

-- Update event current_attendees based on registrations
UPDATE events SET current_attendees = (SELECT COUNT(*) FROM registrations WHERE event_id = events.event_id AND status IN ('confirmed', 'attended'));

-- ================================================================
-- DATABASE SETUP COMPLETE!
-- ================================================================

SELECT 'Database setup completed successfully!' AS Status;
SELECT COUNT(*) AS Total_Users FROM users;
SELECT COUNT(*) AS Total_Books FROM books;
SELECT COUNT(*) AS Total_Events FROM events;
SELECT COUNT(*) AS Active_Borrowings FROM borrowings WHERE status = 'active';
SELECT COUNT(*) AS Total_Registrations FROM registrations;
