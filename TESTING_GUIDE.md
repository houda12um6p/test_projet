# UM6P Learning Center - Testing Guide

## 🧪 Quick Start Testing Guide

This guide will help you test the UM6P Learning Center application to ensure all frontend components work correctly with your backend.

---

## 📋 Pre-Testing Checklist

Before testing, ensure:

- [ ] **Tomcat Server** is running
- [ ] **MySQL Database** is running and populated with test data
- [ ] **Project deployed** to Tomcat's webapps directory
- [ ] **JSTL library** is in WEB-INF/lib folder
- [ ] **MySQL Connector** is in WEB-INF/lib folder
- [ ] **Test users** exist in database (student and staff)

---

## 🔐 Test Credentials

Create these test users in your database:

### Student Account
- **Email:** student@um6p.ma
- **Password:** Student123
- **Role:** STUDENT

### Staff Account
- **Email:** staff@um6p.ma
- **Password:** Staff123
- **Role:** STAFF

---

## 🌐 Testing URLs

### Public Pages
```
http://localhost:8080/um6p_learning_center/views/public/index.jsp
http://localhost:8080/um6p_learning_center/views/public/login.jsp
http://localhost:8080/um6p_learning_center/register.jsp
```

### After Login (Students)
```
http://localhost:8080/um6p_learning_center/student/dashboard.jsp
http://localhost:8080/um6p_learning_center/books
http://localhost:8080/um6p_learning_center/events
http://localhost:8080/um6p_learning_center/borrowings
http://localhost:8080/um6p_learning_center/reservations
http://localhost:8080/um6p_learning_center/profile
```

### After Login (Staff)
```
http://localhost:8080/um6p_learning_center/staff/dashboard.jsp
http://localhost:8080/um6p_learning_center/books (with management options)
http://localhost:8080/um6p_learning_center/events (with management options)
http://localhost:8080/um6p_learning_center/borrowings (all users)
```

---

## ✅ Test Scenarios

### 1. Landing Page Test
**URL:** `/views/public/index.jsp`

**Steps:**
1. Open the landing page
2. Verify carousel auto-plays
3. Click previous/next buttons on carousel
4. Scroll down to view stats section
5. Check About section cards display correctly
6. Verify Events section shows sample events
7. Test footer links
8. Click "Sign In" button → Should go to login page

**Expected Results:**
- ✅ Carousel images rotate every 5 seconds
- ✅ All stats display correctly (5000+ books, 50+ events, etc.)
- ✅ Footer contains contact information
- ✅ All buttons and links work
- ✅ Page is responsive on mobile

---

### 2. Login Test
**URL:** `/views/public/login.jsp`

**Steps:**
1. **Test Invalid Login:**
   - Email: `test@gmail.com`
   - Password: `wrong`
   - Click "Sign In"
   - **Expected:** Error message "Only UM6P email addresses are allowed"

2. **Test Valid Login (Student):**
   - Email: `student@um6p.ma`
   - Password: `Student123`
   - Click "Sign In"
   - **Expected:** Redirected to `/student/dashboard.jsp`

3. **Test Valid Login (Staff):**
   - Email: `staff@um6p.ma`
   - Password: `Staff123`
   - Click "Sign In"
   - **Expected:** Redirected to `/staff/dashboard.jsp`

4. **Test Remember Me:**
   - Check "Remember me" checkbox
   - Login
   - Close browser
   - Reopen
   - **Expected:** Still logged in (if implemented)

5. **Test Form Validation:**
   - Leave email empty → Submit
   - **Expected:** Browser validation error
   - Leave password empty → Submit
   - **Expected:** Browser validation error

**Expected Results:**
- ✅ Error messages display for invalid credentials
- ✅ UM6P email validation works
- ✅ Successful login redirects to correct dashboard
- ✅ Form validation prevents empty submissions

---

### 3. Registration Test
**URL:** `/register.jsp`

**Steps:**
1. Fill out registration form:
   - Full Name: `John Doe`
   - Email: `john.doe@um6p.ma`
   - Phone: `+212 612345678`
   - Password: `Password123`
   - Confirm Password: `Password123`
   - Role: `Student`

2. For Student role:
   - Student ID: `UM6P2024001`
   - Major: `Computer Science`

3. Click "Create Account"

**Test Cases:**
- ✅ Non-UM6P email rejected (`john@gmail.com`)
- ✅ Password mismatch shows error
- ✅ Password strength indicator works
- ✅ Student fields appear when Student selected
- ✅ Staff fields appear when Staff selected
- ✅ Successful registration redirects to login

---

### 4. Student Dashboard Test
**URL:** `/student/dashboard.jsp`
**Login as:** student@um6p.ma

**Verify:**
- ✅ Welcome message shows student name
- ✅ 4 stat cards display:
  - Active Loans: 0
  - Events: 0
  - Library: 5000+
  - History: 0
- ✅ Quick Actions section has 3 buttons
- ✅ Current Borrowings shows empty state
- ✅ Upcoming Events shows empty state
- ✅ Click "Browse Books" → Goes to `/books`
- ✅ Navigation shows student links only

---

### 5. Books Page Test
**URL:** `/books`
**Login as:** student@um6p.ma

**Steps:**
1. **View Books:**
   - Verify books display in grid (3 columns)
   - Each book shows: title, author, genre, ISBN, location
   - Availability progress bar shows

2. **Search Books:**
   - Select "Title" from dropdown
   - Enter search term
   - Click "Search"
   - **Expected:** Filtered results

3. **Borrow Book:**
   - Find available book
   - Click "Borrow Book" button
   - **Expected:** Success message, redirected to borrowings

4. **Reserve Book:**
   - Find unavailable book
   - Click "Reserve Book" button
   - **Expected:** Success message, redirected to reservations

**Staff Additional Tests:**
- Login as staff@um6p.ma
- Click "Add New Book" button
- Fill out book form
- Click Save
- **Expected:** Book added to library

**Expected Results:**
- ✅ Books display correctly
- ✅ Search functionality works
- ✅ Borrow button works for available books
- ✅ Reserve button works for unavailable books
- ✅ Staff can add/edit/delete books

---

### 6. Events Page Test
**URL:** `/events`
**Login as:** student@um6p.ma

**Steps:**
1. **View Events:**
   - Verify events display in grid (2 columns)
   - Each event shows: title, description, date, location
   - Capacity bar shows current/total attendees

2. **Register for Event:**
   - Find active event with available spots
   - Click "Register for Event"
   - **Expected:** Success message, event updated

3. **View My Registrations:**
   - Click "My Registrations" tab
   - **Expected:** Shows events you registered for

**Staff Additional Tests:**
- Click "Create Event" button
- Fill out event form:
  - Title: `Java Workshop`
  - Description: `Learn Java basics`
  - Date: Select future date
  - Location: `Room 101`
  - Capacity: `50`
  - Category: `Workshop`
- Click Save
- **Expected:** Event created and visible

**Expected Results:**
- ✅ Events display correctly
- ✅ Registration works for active events
- ✅ Capacity tracking works
- ✅ Full events show "Event Full" button
- ✅ Staff can create/edit/delete events

---

### 7. Borrowings Page Test
**URL:** `/borrowings`
**Login as:** student@um6p.ma

**Steps:**
1. **View Borrowings:**
   - Check summary cards update correctly
   - Verify borrowings table displays

2. **Test Filters:**
   - Click "All Borrowings" tab
   - Click "Active" tab
   - Click "History" tab
   - **Expected:** List filters correctly

3. **Return Book:**
   - Find active borrowing
   - Click "Return" button
   - Confirm action
   - **Expected:** Book returned, status updated

**Staff Additional Tests:**
- Click "All Users" tab
- **Expected:** See all users' borrowings

**Expected Results:**
- ✅ Borrowing history displays correctly
- ✅ Filter tabs work
- ✅ Return button works
- ✅ Status badges show correctly (Active, Returned, Overdue)
- ✅ Dates format correctly

---

### 8. Reservations Page Test
**URL:** `/reservations`
**Login as:** student@um6p.ma

**Steps:**
1. **View Reservations:**
   - Verify reservation cards display
   - Check queue position shows correctly
   - Verify status badge (Pending/Available/Expired)

2. **Cancel Reservation:**
   - Click "Cancel Reservation" button
   - Confirm action
   - **Expected:** Reservation cancelled, removed from list

**Expected Results:**
- ✅ Reservations display with queue position
- ✅ Available reservations show pickup deadline
- ✅ Cancel button works
- ✅ Empty state shows when no reservations

---

### 9. Profile Page Test
**URL:** `/profile`
**Login as:** student@um6p.ma

**Steps:**
1. **View Profile:**
   - Verify user information displays correctly
   - Check role badge shows
   - Verify student info displays (if student)
   - Verify staff info displays (if staff)

2. **Edit Profile:**
   - Click "Edit Profile" button
   - Update name or phone
   - Save changes
   - **Expected:** Profile updated

3. **Change Password:**
   - Click "Change Password" button
   - Enter current password
   - Enter new password
   - Confirm new password
   - Save
   - **Expected:** Password changed, can login with new password

**Expected Results:**
- ✅ Profile information displays correctly
- ✅ Account statistics update
- ✅ Edit profile works
- ✅ Change password works
- ✅ Last login timestamp shows

---

### 10. Staff Dashboard Test
**URL:** `/staff/dashboard.jsp`
**Login as:** staff@um6p.ma

**Verify:**
- ✅ Welcome message shows staff name
- ✅ 4 stat cards display:
  - Total Books: 5000+
  - Active Loans: Dynamic count
  - Events: Dynamic count
  - Users: 2000+
- ✅ Management actions section has 4 buttons
- ✅ Recent borrowings displays
- ✅ System overview shows counts
- ✅ Navigation shows staff links only

---

### 11. Responsive Design Test

**Test on Different Devices:**

1. **Desktop (1920x1080):**
   - Open DevTools (F12)
   - Set viewport to 1920x1080
   - Verify grid layouts show full columns
   - Check navigation is horizontal

2. **Tablet (768x1024):**
   - Set viewport to 768x1024
   - Verify grids adjust to 2 columns
   - Check cards stack properly
   - Test touch interactions

3. **Mobile (375x667):**
   - Set viewport to 375x667
   - Verify single column layout
   - Check hamburger menu appears
   - Test mobile navigation
   - Verify buttons are touch-friendly

**Expected Results:**
- ✅ All pages responsive on all devices
- ✅ Mobile menu toggle works
- ✅ Text is readable on small screens
- ✅ Images scale properly
- ✅ Forms are usable on mobile

---

### 12. JavaScript Features Test

**Toast Notifications:**
1. After successful action (borrow, register, etc.)
2. Verify toast appears in top-right
3. Check it auto-dismisses after 3 seconds

**Form Validation:**
1. Try submitting empty forms
2. Verify browser validation works
3. Test email format validation
4. Test password strength indicator

**Modals:**
1. Click action that opens modal
2. Verify modal appears
3. Click outside modal → Closes
4. Press ESC key → Closes

**Search:**
1. Use search functionality
2. Verify debounce works (wait 300ms)
3. Check results filter correctly

**Expected Results:**
- ✅ Toast notifications appear and dismiss
- ✅ Form validation prevents invalid submissions
- ✅ Modals open/close correctly
- ✅ Search filters results

---

### 13. Session & Security Test

**Session Management:**
1. Login successfully
2. Wait 30 minutes (or modify timeout in web.xml)
3. Try accessing protected page
4. **Expected:** Redirected to login

**Logout Test:**
1. Login successfully
2. Click "Logout" button
3. Try accessing protected page
4. **Expected:** Redirected to login

**Role-Based Access:**
1. Login as student
2. Try accessing `/staff/dashboard.jsp`
3. **Expected:** Access denied or redirect

**Expected Results:**
- ✅ Session expires after inactivity
- ✅ Logout clears session
- ✅ Role-based pages protected
- ✅ Unauthorized access blocked

---

## 🐛 Common Issues & Solutions

### Issue 1: Pages show JSP source code
**Solution:** Deploy as WAR file, not as directory. Tomcat must process JSP.

### Issue 2: CSS/JS not loading
**Solution:**
- Check file paths in header.jsp
- Verify assets folder is in webapp root
- Clear browser cache (Ctrl+Shift+R)

### Issue 3: JSTL tags not working
**Solution:**
- Add jstl-1.2.jar to WEB-INF/lib
- Verify taglib declarations in JSP:
  ```jsp
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  ```

### Issue 4: Database connection errors
**Solution:**
- Verify MySQL is running
- Check connection string in DatabaseConnection.java
- Ensure MySQL connector JAR is in WEB-INF/lib

### Issue 5: 404 errors on servlet URLs
**Solution:**
- Verify servlet mappings in web.xml
- Check @WebServlet annotations match URLs
- Restart Tomcat server

---

## 📊 Test Results Template

Use this template to document your testing:

```markdown
## Test Results - [Date]

### Landing Page
- [ ] Carousel works
- [ ] Stats display correctly
- [ ] Links functional
- [ ] Responsive design
- **Issues:** None / [Describe issues]

### Login
- [ ] Valid login works
- [ ] Invalid login shows error
- [ ] UM6P email validation
- [ ] Redirects correctly
- **Issues:** None / [Describe issues]

### Registration
- [ ] Form validation works
- [ ] Password strength indicator
- [ ] UM6P email required
- [ ] Role-based fields
- **Issues:** None / [Describe issues]

[Continue for all pages...]
```

---

## 🎯 Success Criteria

All tests pass if:
- ✅ All pages load without errors
- ✅ Navigation works correctly
- ✅ Forms submit and validate properly
- ✅ Database operations succeed
- ✅ Session management works
- ✅ Role-based access enforced
- ✅ Responsive design functional
- ✅ JavaScript features work
- ✅ No console errors

---

## 📞 Support

If you encounter issues:
1. Check browser console for JavaScript errors (F12)
2. Check Tomcat logs in `catalina.out`
3. Verify database connections
4. Review servlet mappings
5. Test with different browsers

---

**Happy Testing! 🚀**
