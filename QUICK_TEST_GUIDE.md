# 🚀 QUICK TEST GUIDE - UM6P Learning Center

## ⚡ 5-MINUTE SETUP

### 1. Database Setup (2 min)
```bash
mysql -u root -p
CREATE DATABASE um6p_learning_center;
exit;
mysql -u root -p um6p_learning_center < src/main/resources/schema.sql
```

### 2. Configure (30 sec)
Edit `src/main/resources/application.properties`:
```properties
db.password=YOUR_MYSQL_ROOT_PASSWORD
```

### 3. Build & Deploy (2 min)
```bash
mvn clean package
cp target/um6p_learning_center.war $TOMCAT_HOME/webapps/
$TOMCAT_HOME/bin/startup.sh
```

### 4. Verify (30 sec)
Open: `http://localhost:8080/um6p_learning_center/`

---

## 🧪 BROWSER TESTING URLS

### 🔐 Authentication
| Action | URL | Credentials |
|--------|-----|-------------|
| Login | `/login` | admin@um6p.ma / Admin123! |
| Register | `/register` | Fill form with @um6p.ma email |
| Logout | `/logout` | Click logout button |

### 📚 Books (All URLs relative to `/um6p_learning_center`)
| Action | URL | Access |
|--------|-----|--------|
| List Books | `/books/` | All users |
| View Book | `/books/view/1` | All users |
| Search Books | `/books/search?title=algorithms` | All users |
| Add Book | `/books/add` | Staff only |
| Edit Book | `/books/edit/1` | Staff only |

### 📖 Borrowing (Student)
| Action | URL | Access |
|--------|-----|--------|
| My Borrowings | `/borrowings/` | Logged in |
| Active Borrowings | `/borrowings/active` | Logged in |
| Borrow Book | `/borrowings/borrow?bookId=1` (POST) | Student |
| Return Book | `/borrowings/return/1` (POST) | Student |
| Overdue Books | `/borrowings/overdue` | Staff only |

### 🎉 Events
| Action | URL | Access |
|--------|-----|--------|
| List Events | `/events/` | All users |
| View Event | `/events/view/1` | All users |
| Upcoming Events | `/events/upcoming` | All users |
| My Registrations | `/events/my-registrations` | Logged in |
| Create Event | `/events/add` | Staff only |
| Register | `/events/register?eventId=1` (POST) | Logged in |

### 👤 Profile
| Action | URL | Access |
|--------|-----|--------|
| View Profile | `/profile/` | Logged in |
| Edit Profile | `/profile/edit` | Logged in |
| Change Password | `/profile/change-password` | Logged in |

---

## ✅ QUICK TEST CHECKLIST

### Phase 1: Basic Access (5 min)
```
□ Can access homepage
□ Can view login page
□ Can view registration page
□ Can view books list (without login)
□ Can view events list (without login)
```

### Phase 2: Authentication (5 min)
```
□ Admin login works
□ Student login works
□ Wrong password rejected
□ Invalid email rejected
□ Registration works
□ Logout works
```

### Phase 3: Books (10 min)
```
□ Can list all books
□ Can search books
□ Can view book details
□ [Admin] Can add book
□ [Admin] Can edit book
□ [Admin] Can delete book
```

### Phase 4: Borrowing (10 min)
```
□ [Student] Can borrow book
□ Available copies decrease
□ Can view my borrowings
□ Can return book
□ Available copies increase
□ Cannot borrow 6th book (limit)
□ [Staff] Can view all borrowings
□ [Staff] Can view overdue books
```

### Phase 5: Events (10 min)
```
□ Can view events list
□ Can view event details
□ Can register for event
□ Attendees count increases
□ Can view my registrations
□ Can cancel registration
□ [Staff] Can create event
□ [Staff] Can edit event
```

### Phase 6: Profile (5 min)
```
□ Can view profile
□ Can edit profile details
□ Can change password
□ New password works for login
```

### Phase 7: Security (10 min)
```
□ Cannot access staff pages as student
□ Session timeout after 30 min
□ CSRF token present on POST
□ SQL injection prevented
□ XSS prevented
```

---

## 🔍 TESTING SCENARIOS

### Scenario 1: Complete Student Flow (5 min)
1. Register as new student
2. Login with new credentials
3. Browse books
4. Borrow 2 books
5. View active borrowings
6. Return 1 book
7. Register for event
8. View profile

**✅ Pass Criteria:** All actions complete without errors

---

### Scenario 2: Complete Staff Flow (5 min)
1. Login as admin
2. Add new book
3. Edit book details
4. View all borrowings
5. View overdue books
6. Create new event
7. View all registrations

**✅ Pass Criteria:** All CRUD operations work

---

### Scenario 3: Race Condition Test (3 min)
1. Create book with 1 copy
2. Open 2 browser windows
3. Login as 2 different users
4. Both try to borrow same book
5. Only 1 should succeed
6. Available copies = 0 (not negative)

**✅ Pass Criteria:** No negative copies, atomic operation

---

### Scenario 4: Security Test (5 min)
1. Login as student
2. Copy staff page URL: `/books/add`
3. Try to access directly
4. Should be blocked (403)
5. Try POST without CSRF token
6. Should be blocked (403)

**✅ Pass Criteria:** All unauthorized access blocked

---

## 📊 DATABASE VERIFICATION

Run these SQL commands to verify:

```sql
-- Check sample data loaded
SELECT COUNT(*) FROM users;        -- Should be 2
SELECT COUNT(*) FROM books;        -- Should be 5
SELECT COUNT(*) FROM events;       -- Should be 1

-- Verify passwords are hashed
SELECT LENGTH(password) FROM users LIMIT 1;  -- Should be 60

-- Check no data integrity issues
SELECT * FROM books WHERE available_copies < 0;  -- Should be empty
```

---

## 🐛 COMMON ISSUES & FIXES

### Issue: Can't connect to database
```bash
# Check MySQL is running
systemctl status mysql

# Check database exists
mysql -u root -p -e "SHOW DATABASES LIKE 'um6p_learning_center';"

# Verify password in application.properties
```

### Issue: 404 errors on all pages
```bash
# Check Tomcat logs
tail -f $TOMCAT_HOME/logs/catalina.out

# Verify WAR deployed
ls -la $TOMCAT_HOME/webapps/um6p_learning_center.war

# Check context path in URLs
# Must be: /um6p_learning_center/
```

### Issue: Login not working
```sql
-- Check users exist
SELECT * FROM users;

-- Verify passwords are hashed (should start with $2a$)
SELECT email, SUBSTRING(password, 1, 10) FROM users;
```

### Issue: CSRF errors on POST
```properties
# In application.properties, verify:
security.csrf.enabled=true
```

---

## 📈 PERFORMANCE CHECKS

### Check Connection Pool
```bash
tail -f logs/application.log | grep -i hikari
```
**Expected:** "HikariCP connection pool initialized successfully"

### Check Response Times
Open Browser DevTools → Network tab
- Pages should load in < 1 second
- API calls should complete in < 500ms

### Check Logs
```bash
# Application logs
tail -f logs/application.log

# Error logs
tail -f logs/error.log

# Tomcat logs
tail -f $TOMCAT_HOME/logs/catalina.out
```

---

## ✨ ACCEPTANCE CRITERIA

The backend is working perfectly if:

✅ All 7 phases of testing pass
✅ No errors in logs
✅ Security features working
✅ Database integrity maintained
✅ Connection pooling active
✅ Session management working
✅ CSRF protection enabled
✅ Race conditions prevented

---

## 🎯 EXPECTED TEST RESULTS

| Component | Expected Result |
|-----------|----------------|
| Login | Successful with valid credentials |
| Registration | User created, redirect to login |
| Book Listing | 5 books displayed |
| Borrow Book | Available copies: 5 → 4 |
| Return Book | Available copies: 4 → 5 |
| Event Registration | Attendees: 0 → 1 |
| Profile Update | Changes saved |
| Password Change | New password works |
| CSRF Protection | POST without token blocked |
| Authorization | Staff pages blocked for students |

---

## 🚀 AUTOMATED TESTING

### Database Test Script
```bash
mysql -u root -p um6p_learning_center < src/main/resources/test-database.sql
```

This will:
- Verify all tables exist
- Check sample data
- Test data integrity
- Verify indexes
- Generate test report

---

## 📞 NEED HELP?

1. Check `logs/application.log` for errors
2. Check `logs/error.log` for stack traces
3. Check Tomcat logs: `$TOMCAT_HOME/logs/catalina.out`
4. Review `TESTING_GUIDE.md` for detailed instructions
5. Review `SETUP.md` for configuration help

---

**🎉 You're ready to test! Start with Phase 1 and work your way through.**

**Estimated Total Testing Time: 60 minutes**
