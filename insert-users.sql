-- Insert test users into existing um6p_learning_center database
USE um6p_learning_center;

-- Delete any existing test users first
DELETE FROM users WHERE email IN ('admin@um6p.ma', 'librarian@um6p.ma', 'organizer@um6p.ma', 'student@um6p.ma');

-- Password for all test users: Password123
-- BCrypt hash: $2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyJgHlqKe/TK

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

-- Verify the inserts
SELECT 'Users inserted successfully!' AS status;
SELECT user_id, email, first_name, last_name, role FROM users;
