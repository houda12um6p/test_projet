-- ========================================
-- Database Testing & Verification Script
-- ========================================

-- 1. VERIFY TABLES EXIST
-- ========================================
SHOW TABLES;
-- Expected output: 9 tables (users, students, staff, books, borrowings, events, registrations, notifications, reservations)


-- 2. VERIFY SAMPLE DATA
-- ========================================

-- Check users exist
SELECT id, email, name, role, created_at
FROM users
ORDER BY id;
-- Expected: 2 users (admin@um6p.ma and student@um6p.ma)

-- Check students
SELECT s.id, u.name, s.major, s.student_id_number
FROM students s
JOIN users u ON s.user_id = u.id;
-- Expected: 1 student

-- Check staff
SELECT st.id, u.name, st.department, st.position
FROM staff st
JOIN users u ON st.user_id = u.id;
-- Expected: 1 staff member

-- Check books
SELECT id, title, author, genre, total_copies, available_copies, status
FROM books
ORDER BY id;
-- Expected: 5 books

-- Check events
SELECT id, title, event_date, capacity, current_attendees, status
FROM events
ORDER BY id;
-- Expected: 1 event


-- 3. TEST BORROWING FUNCTIONALITY
-- ========================================

-- Simulate a borrowing
START TRANSACTION;

-- Get student user ID
SET @student_id = (SELECT id FROM users WHERE email = 'student@um6p.ma');
SET @book_id = (SELECT id FROM books LIMIT 1);

-- Check available copies before
SELECT available_copies FROM books WHERE id = @book_id;

-- Create borrowing
INSERT INTO borrowings (user_id, book_id, borrow_date, due_date, status)
VALUES (@student_id, @book_id, NOW(), DATE_ADD(NOW(), INTERVAL 14 DAY), 'BORROWED');

-- Decrement available copies
UPDATE books SET available_copies = available_copies - 1 WHERE id = @book_id;

-- Check available copies after
SELECT available_copies FROM books WHERE id = @book_id;

-- Verify borrowing created
SELECT * FROM borrowings WHERE user_id = @student_id ORDER BY id DESC LIMIT 1;

ROLLBACK; -- Rollback test transaction
-- Expected: Available copies should be back to original value


-- 4. TEST EVENT REGISTRATION
-- ========================================

-- Simulate event registration
START TRANSACTION;

SET @student_id = (SELECT id FROM users WHERE email = 'student@um6p.ma');
SET @event_id = (SELECT id FROM events LIMIT 1);

-- Check current attendees before
SELECT current_attendees FROM events WHERE id = @event_id;

-- Create registration
INSERT INTO registrations (user_id, event_id, registration_date, status)
VALUES (@student_id, @event_id, NOW(), 'CONFIRMED');

-- Increment attendees
UPDATE events SET current_attendees = current_attendees + 1 WHERE id = @event_id;

-- Check current attendees after
SELECT current_attendees FROM events WHERE id = @event_id;

ROLLBACK; -- Rollback test transaction


-- 5. DATA INTEGRITY CHECKS
-- ========================================

-- Check for orphaned records (foreign key violations)
-- Should return 0 rows

-- Orphaned students
SELECT s.id FROM students s
LEFT JOIN users u ON s.user_id = u.id
WHERE u.id IS NULL;

-- Orphaned staff
SELECT st.id FROM staff st
LEFT JOIN users u ON st.user_id = u.id
WHERE u.id IS NULL;

-- Orphaned borrowings
SELECT b.id FROM borrowings b
LEFT JOIN users u ON b.user_id = u.id
WHERE u.id IS NULL;

SELECT b.id FROM borrowings b
LEFT JOIN books bk ON b.book_id = bk.id
WHERE bk.id IS NULL;

-- Check for negative available copies (should be 0)
SELECT id, title, available_copies
FROM books
WHERE available_copies < 0;

-- Check for available > total copies (should be 0)
SELECT id, title, total_copies, available_copies
FROM books
WHERE available_copies > total_copies;

-- Check for event attendees exceeding capacity (should be 0)
SELECT id, title, capacity, current_attendees
FROM events
WHERE current_attendees > capacity;


-- 6. PASSWORD VERIFICATION
-- ========================================

-- Verify passwords are hashed (not plain text)
SELECT id, email,
       LENGTH(password) as password_length,
       SUBSTRING(password, 1, 10) as password_start
FROM users;
-- Expected: password_length = 60 (BCrypt hash), starts with '$2a$12$'


-- 7. TIMESTAMP CHECKS
-- ========================================

-- Check all timestamps are populated
SELECT 'users' as table_name,
       COUNT(*) as total,
       COUNT(created_at) as has_created_at,
       COUNT(updated_at) as has_updated_at
FROM users

UNION ALL

SELECT 'books', COUNT(*), COUNT(date_added), NULL
FROM books;


-- 8. PERFORMANCE METRICS
-- ========================================

-- Count all records
SELECT
    (SELECT COUNT(*) FROM users) as users_count,
    (SELECT COUNT(*) FROM students) as students_count,
    (SELECT COUNT(*) FROM staff) as staff_count,
    (SELECT COUNT(*) FROM books) as books_count,
    (SELECT COUNT(*) FROM borrowings) as borrowings_count,
    (SELECT COUNT(*) FROM events) as events_count,
    (SELECT COUNT(*) FROM registrations) as registrations_count,
    (SELECT COUNT(*) FROM notifications) as notifications_count,
    (SELECT COUNT(*) FROM reservations) as reservations_count;


-- 9. VERIFY INDEXES
-- ========================================

-- Check indexes on users table
SHOW INDEX FROM users;
-- Expected: PRIMARY, idx_email, idx_role

-- Check indexes on books table
SHOW INDEX FROM books;
-- Expected: PRIMARY, idx_title, idx_author, idx_isbn, idx_genre, idx_status


-- 10. CLEANUP TEST DATA (OPTIONAL)
-- ========================================

-- To reset to initial state, run schema.sql again
-- Or use these commands:

-- DELETE FROM reservations;
-- DELETE FROM notifications;
-- DELETE FROM registrations;
-- DELETE FROM borrowings;
-- DELETE FROM events;
-- DELETE FROM books;
-- DELETE FROM staff;
-- DELETE FROM students;
-- DELETE FROM users;

-- Then re-run the inserts from schema.sql


-- 11. TEST QUERIES FOR APPLICATION
-- ========================================

-- Get user with role info
SELECT u.*,
       CASE WHEN s.id IS NOT NULL THEN 'STUDENT'
            WHEN st.id IS NOT NULL THEN 'STAFF'
            ELSE 'UNKNOWN' END as role_type
FROM users u
LEFT JOIN students s ON u.id = s.user_id
LEFT JOIN staff st ON u.id = st.user_id
WHERE u.email = 'student@um6p.ma';

-- Get available books with details
SELECT id, title, author, genre, available_copies,
       CASE WHEN available_copies > 0 THEN 'Available'
            ELSE 'Not Available' END as availability_status
FROM books
WHERE status = 'available'
ORDER BY title;

-- Get user's active borrowings with book details
SET @user_id = (SELECT id FROM users WHERE email = 'student@um6p.ma');

SELECT b.id, bk.title, bk.author,
       b.borrow_date, b.due_date,
       DATEDIFF(b.due_date, NOW()) as days_remaining
FROM borrowings b
JOIN books bk ON b.book_id = bk.id
WHERE b.user_id = @user_id AND b.status = 'BORROWED'
ORDER BY b.due_date;

-- Get upcoming events with registration status
SELECT e.*,
       COUNT(r.id) as total_registrations,
       e.capacity - e.current_attendees as available_spots
FROM events e
LEFT JOIN registrations r ON e.id = r.event_id AND r.status = 'CONFIRMED'
WHERE e.event_date > NOW() AND e.status = 'active'
GROUP BY e.id
ORDER BY e.event_date;


-- 12. GENERATE TEST REPORT
-- ========================================

SELECT '=== DATABASE TEST REPORT ===' as report;

SELECT 'Schema Version' as test, 'PASS' as status,
       'All 9 tables exist' as details
WHERE (SELECT COUNT(*) FROM information_schema.tables
       WHERE table_schema = 'um6p_learning_center') = 9;

SELECT 'Sample Data' as test, 'PASS' as status,
       CONCAT('Users: ', (SELECT COUNT(*) FROM users),
              ', Books: ', (SELECT COUNT(*) FROM books),
              ', Events: ', (SELECT COUNT(*) FROM events)) as details;

SELECT 'Data Integrity' as test,
       CASE WHEN (SELECT COUNT(*) FROM books WHERE available_copies < 0) = 0
            THEN 'PASS' ELSE 'FAIL' END as status,
       'No negative book copies' as details;

SELECT 'Security' as test, 'PASS' as status,
       'All passwords are BCrypt hashed' as details
WHERE (SELECT COUNT(*) FROM users WHERE LENGTH(password) = 60) =
      (SELECT COUNT(*) FROM users);

SELECT '=== END OF REPORT ===' as report;
