# UM6P Learning Center - Complete Testing Guide

## 🚀 Quick Start Testing (5 Minutes)

### Step 1: Setup Database
```bash
# Create database
mysql -u root -p
CREATE DATABASE um6p_learning_center CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
exit;

# Load schema and sample data
mysql -u root -p um6p_learning_center < src/main/resources/schema.sql
```

### Step 2: Configure Database Password
Edit `src/main/resources/application.properties`:
```properties
db.password=YOUR_MYSQL_PASSWORD_HERE
```

### Step 3: Build and Deploy
```bash
mvn clean package
cp target/um6p_learning_center.war $TOMCAT_HOME/webapps/
$TOMCAT_HOME/bin/startup.sh
```

### Step 4: Access the Application
Open browser: `http://localhost:8080/um6p_learning_center/`

---

## 🧪 COMPREHENSIVE BROWSER TESTING

### ✅ TEST 1: Authentication System

#### 1.1 Login Testing
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/login`
2. **Test Admin Login:**
   - Email: `admin@um6p.ma`
   - Password: `Admin123!`
   - Click "Login"
   - ✅ **Expected:** Redirect to staff dashboard

3. **Test Student Login:**
   - Logout (click Logout button)
   - Email: `student@um6p.ma`
   - Password: `Student123!`
   - ✅ **Expected:** Redirect to student dashboard

4. **Test Invalid Credentials:**
   - Email: `test@um6p.ma`
   - Password: `wrongpassword`
   - ✅ **Expected:** Error message "Invalid email or password"

5. **Test Rate Limiting:**
   - Try 5 failed login attempts
   - ✅ **Expected:** "Too many login attempts" message

6. **Test Session Fixation Prevention:**
   - Before login, check browser cookies (Dev Tools → Application → Cookies)
   - Note JSESSIONID value
   - Login successfully
   - Check JSESSIONID again
   - ✅ **Expected:** JSESSIONID should be different (new session created)

#### 1.2 Registration Testing
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/register`
2. **Test Student Registration:**
   ```
   Name: Test Student 2
   Email: student2@um6p.ma
   Password: Student123!
   Confirm Password: Student123!
   Role: Student
   Phone: +212-600-000002
   Major: Computer Science
   Student ID: 20240002
   ```
   - Click "Register"
   - ✅ **Expected:** Redirect to login with success message

3. **Test Staff Registration:**
   ```
   Name: Test Staff
   Email: staff@um6p.ma
   Password: Staff123!
   Role: Staff
   Phone: +212-600-000003
   Department: IT
   Position: Developer
   Office: Building A, Room 101
   ```
   - ✅ **Expected:** Successful registration

4. **Test Validation:**
   - Try invalid email: `test@gmail.com`
   - ✅ **Expected:** "Only UM6P email addresses allowed"
   - Try weak password: `123`
   - ✅ **Expected:** Password strength error
   - Try mismatched passwords
   - ✅ **Expected:** "Passwords do not match"

---

### ✅ TEST 2: Book Management System

#### 2.1 View Books (All Users)
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/books/`
2. ✅ **Expected:** List of all available books (5 sample books should show)
3. **Check displayed info:**
   - Title, Author, Genre, ISBN
   - Available copies count
   - Status (available/unavailable)

#### 2.2 Search Books
1. **Search by Title:**
   - Navigate to: `http://localhost:8080/um6p_learning_center/books/search?title=algorithms`
   - ✅ **Expected:** "Introduction to Algorithms" appears

2. **Search by Author:**
   - Navigate to: `http://localhost:8080/um6p_learning_center/books/search?author=Martin`
   - ✅ **Expected:** "Clean Code" by Robert C. Martin appears

3. **Search by Genre:**
   - Navigate to: `http://localhost:8080/um6p_learning_center/books/search?genre=Computer%20Science`
   - ✅ **Expected:** Computer Science books appear

#### 2.3 View Book Details
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/books/view/1`
2. ✅ **Expected:** Complete book information:
   - Title, Author, ISBN, Genre
   - Total copies and available copies
   - Location in library
   - Borrow button (if student)

#### 2.4 Add Book (Staff Only)
1. **Login as admin:** `admin@um6p.ma` / `Admin123!`
2. **Navigate to:** `http://localhost:8080/um6p_learning_center/books/add`
3. **Fill form:**
   ```
   Title: Test Book
   Author: Test Author
   ISBN: 978-0123456789
   Genre: Testing
   Total Copies: 3
   Available Copies: 3
   Location: Floor 1 - Section TEST
   ```
4. Click "Add Book"
5. ✅ **Expected:** Book created successfully, redirects to book list

#### 2.5 Edit Book (Staff Only)
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/books/edit/1`
2. Modify title or author
3. Click "Update"
4. ✅ **Expected:** Book updated successfully

#### 2.6 Delete Book (Staff Only)
1. **Navigate to book list**
2. Click "Delete" on a book
3. Confirm deletion
4. ✅ **Expected:** Book removed from list

---

### ✅ TEST 3: Borrowing System

#### 3.1 Borrow a Book (Student)
1. **Login as student:** `student@um6p.ma` / `Student123!`
2. **Navigate to:** `http://localhost:8080/um6p_learning_center/books/view/1`
3. Click "Borrow Book" button
4. ✅ **Expected:**
   - Success message
   - Available copies decremented by 1
   - Book appears in "My Borrowings"

#### 3.2 View Active Borrowings
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/borrowings/active`
2. ✅ **Expected:** List of currently borrowed books with:
   - Book title
   - Borrow date
   - Due date (14 days from borrow date)
   - Status: BORROWED
   - Return button

#### 3.3 View Borrowing History
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/borrowings/history`
2. ✅ **Expected:** All borrowings (active + returned)

#### 3.4 Return a Book
1. **Navigate to active borrowings**
2. Click "Return Book" button
3. ✅ **Expected:**
   - Book marked as RETURNED
   - Available copies incremented by 1
   - Can borrow the book again

#### 3.5 Test Borrowing Limits
1. **Borrow 5 different books** (one at a time)
2. Try to borrow a 6th book
3. ✅ **Expected:** Error message "Maximum borrowing limit reached"

#### 3.6 Test Overdue Prevention
1. **Manually set a borrowing to overdue** (in database):
   ```sql
   UPDATE borrowings SET due_date = '2025-01-01' WHERE user_id = 2 AND status = 'BORROWED';
   ```
2. Try to borrow another book
3. ✅ **Expected:** Error "You have overdue books"

#### 3.7 View Overdue Books (Staff Only)
1. **Login as admin**
2. **Navigate to:** `http://localhost:8080/um6p_learning_center/borrowings/overdue`
3. ✅ **Expected:** List of all overdue borrowings across all users

---

### ✅ TEST 4: Event Management

#### 4.1 View Events (All Users)
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/events/`
2. ✅ **Expected:** List of all active events
3. Sample event should appear: "Introduction to Machine Learning Workshop"

#### 4.2 View Event Details
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/events/view/1`
2. ✅ **Expected:** Event information:
   - Title, Description
   - Date, Location
   - Capacity and current attendees
   - Category, Status
   - Register button

#### 4.3 Register for Event
1. **Login as student**
2. Click "Register" button on event
3. ✅ **Expected:**
   - Success message
   - Current attendees incremented
   - "Registered" badge appears

#### 4.4 View My Registrations
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/events/my-registrations`
2. ✅ **Expected:** List of events user registered for

#### 4.5 Cancel Registration
1. Click "Cancel Registration" button
2. ✅ **Expected:**
   - Registration cancelled
   - Current attendees decremented
   - Can register again

#### 4.6 Create Event (Staff Only)
1. **Login as admin**
2. **Navigate to:** `http://localhost:8080/um6p_learning_center/events/add`
3. **Fill form:**
   ```
   Title: Test Event
   Description: This is a test event
   Date: 2025-12-31 14:00
   Location: Room 101
   Capacity: 50
   Category: WORKSHOP
   ```
4. ✅ **Expected:** Event created successfully

#### 4.7 Test Capacity Management
1. Create event with capacity 1
2. Register first user
3. Try to register second user
4. ✅ **Expected:** Second user added to waitlist

---

### ✅ TEST 5: Profile Management

#### 5.1 View Profile
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/profile/`
2. ✅ **Expected:** User information displayed:
   - Name, Email, Role
   - Student: Major, Student ID, Enrollment Date
   - Staff: Department, Position, Office Location

#### 5.2 Edit Profile
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/profile/edit`
2. Modify name or phone
3. Click "Update"
4. ✅ **Expected:** Profile updated successfully

#### 5.3 Change Password
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/profile/change-password`
2. **Enter:**
   ```
   Current Password: Student123!
   New Password: NewPassword123!
   Confirm Password: NewPassword123!
   ```
3. ✅ **Expected:** Password changed successfully
4. **Test:** Logout and login with new password

---

### ✅ TEST 6: Security Features

#### 6.1 Test Authorization
1. **Login as student**
2. Try to access staff-only page:
   - `http://localhost:8080/um6p_learning_center/books/add`
3. ✅ **Expected:** 403 Forbidden error or redirect

#### 6.2 Test CSRF Protection
1. **Open browser DevTools → Network tab**
2. Login successfully
3. Make a POST request (e.g., borrow book)
4. **Check request headers:**
   - ✅ **Expected:** `X-CSRF-Token` header present
5. **Try POST without CSRF token:**
   - Use Postman or curl
   - ✅ **Expected:** 403 Forbidden

#### 6.3 Test Session Timeout
1. Login successfully
2. Wait 30 minutes (or modify session.timeout.minutes in config)
3. Try to access protected page
4. ✅ **Expected:** Redirect to login with "session_timeout" error

#### 6.4 Test XSS Prevention
1. Try to register with name: `<script>alert('XSS')</script>`
2. ✅ **Expected:** Script tags should be escaped/sanitized
3. View profile
4. ✅ **Expected:** No JavaScript execution

#### 6.5 Test SQL Injection Prevention
1. Try login with email: `' OR '1'='1`
2. ✅ **Expected:** Invalid credentials error (not database error)

---

### ✅ TEST 7: Race Condition Testing

#### 7.1 Test Concurrent Book Borrowing
1. **Setup:** Book with only 1 copy available
2. **Test Method:**
   - Open 2 browser windows
   - Login as different users
   - Both try to borrow the same book simultaneously
3. ✅ **Expected:**
   - Only one succeeds
   - Other gets "Book not available" error
   - Available copies = 0 (not negative)

---

### ✅ TEST 8: Error Handling

#### 8.1 Test 404 Error
1. **Navigate to:** `http://localhost:8080/um6p_learning_center/nonexistent`
2. ✅ **Expected:** Custom 404 error page

#### 8.2 Test 500 Error
1. Cause an intentional error (e.g., access book with invalid ID)
2. **Navigate to:** `http://localhost:8080/um6p_learning_center/books/view/99999`
3. ✅ **Expected:** Graceful error handling (not stack trace)

---

## 📊 TESTING CHECKLIST

### ✅ Pre-Deployment Checklist
- [ ] Database schema loaded successfully
- [ ] Sample data inserted correctly
- [ ] Application.properties configured
- [ ] Maven build successful (no errors)
- [ ] WAR file deployed to Tomcat
- [ ] Tomcat started without errors
- [ ] Application accessible in browser

### ✅ Functional Testing
- [ ] User registration works (both student and staff)
- [ ] User login works with correct credentials
- [ ] Login fails with incorrect credentials
- [ ] Session timeout works
- [ ] Logout works correctly
- [ ] Books can be listed and searched
- [ ] Books can be borrowed and returned
- [ ] Borrowing limits enforced (5 books max)
- [ ] Overdue books prevent new borrowing
- [ ] Events can be viewed and registered
- [ ] Event capacity managed correctly
- [ ] Profile can be viewed and updated
- [ ] Password can be changed

### ✅ Security Testing
- [ ] CSRF tokens present on POST requests
- [ ] Unauthorized access blocked (403)
- [ ] Session fixation prevented
- [ ] SQL injection prevented
- [ ] XSS attacks prevented
- [ ] Rate limiting works (5 attempts)
- [ ] Passwords hashed with BCrypt
- [ ] Security headers present in responses

### ✅ Staff-Only Features
- [ ] Can add new books
- [ ] Can edit existing books
- [ ] Can delete books
- [ ] Can view all borrowings
- [ ] Can view overdue borrowings
- [ ] Can create events
- [ ] Can edit/delete events

### ✅ Performance Testing
- [ ] Connection pooling active (check logs)
- [ ] No memory leaks during extended use
- [ ] Page load times acceptable
- [ ] Database queries optimized
- [ ] Race conditions prevented

---

## 🔍 MONITORING & LOGS

### Check Application Logs
```bash
tail -f logs/application.log
```

### Check Error Logs
```bash
tail -f logs/error.log
```

### Check Tomcat Logs
```bash
tail -f $TOMCAT_HOME/logs/catalina.out
```

### Check Database Connection Pool
Look for log entries like:
```
HikariCP connection pool initialized successfully
Active: 2, Idle: 8, Total: 10, Waiting: 0
```

---

## 🐛 TROUBLESHOOTING

### Issue: Application won't start
**Check:**
1. Database is running: `systemctl status mysql`
2. Database credentials correct in application.properties
3. Tomcat logs for errors: `tail -f $TOMCAT_HOME/logs/catalina.out`

### Issue: Login not working
**Check:**
1. Database has users: `SELECT * FROM users;`
2. Passwords are hashed correctly
3. Session cookies enabled in browser

### Issue: CSRF errors on POST
**Check:**
1. CSRF enabled in application.properties
2. Forms include CSRF token
3. Browser cookies enabled

### Issue: 404 errors
**Check:**
1. Application context path: `/um6p_learning_center`
2. Servlet mappings in web.xml
3. URL patterns match servlet annotations

---

## 🎯 EXPECTED BEHAVIOR SUMMARY

| Feature | Expected Behavior |
|---------|------------------|
| Login | Session created, redirect to dashboard |
| Invalid Login | Error message, attempts counted |
| Register | User created, redirect to login |
| Borrow Book | Copies decremented atomically |
| Return Book | Copies incremented, status updated |
| Max Borrowing | 5 books limit enforced |
| Overdue Check | Prevents new borrowing |
| Event Register | Attendees incremented, capacity checked |
| CSRF | All POST requests require valid token |
| Session Timeout | 30 minutes, redirect to login |
| Authorization | Role-based access enforced |

---

## 📝 TEST REPORTING

Document your test results:

### Test Pass/Fail Template
```
Test Case: [Name]
URL: [URL tested]
Expected: [Expected behavior]
Actual: [Actual behavior]
Status: ✅ PASS / ❌ FAIL
Notes: [Any observations]
```

---

## ✅ FINAL VERIFICATION

Run these SQL queries to verify data integrity:

```sql
-- Check users created
SELECT COUNT(*) as total_users FROM users;

-- Check borrowings
SELECT COUNT(*) as active_borrowings FROM borrowings WHERE status = 'BORROWED';

-- Check book availability matches
SELECT id, title, total_copies, available_copies,
       total_copies - available_copies as borrowed
FROM books;

-- Check event registrations
SELECT e.title, COUNT(r.id) as registrations, e.capacity
FROM events e
LEFT JOIN registrations r ON e.id = r.event_id
GROUP BY e.id;
```

All counts should be accurate and no negative values should exist.

---

**Happy Testing! 🚀**

If you find any issues, check the logs in `logs/` directory and refer to the troubleshooting section.
