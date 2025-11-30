-- Quick Database Setup for UM6P Learning Center
-- Simple test password: test123

DROP DATABASE IF EXISTS um6p_learning_center;
CREATE DATABASE um6p_learning_center CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE um6p_learning_center;

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert test admin user
-- Email: admin@um6p.ma
-- Password: test123
INSERT INTO users (email, password, name, role) VALUES
('admin@um6p.ma', '$2a$10$N9qo8uLOickgx2ZMRZoMye', 'Admin User', 'ADMIN');

-- Verify
SELECT 'Database setup complete!' AS status;
SELECT email, name, role FROM users;
