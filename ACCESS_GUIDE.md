# UM6P Learning Center - Access Guide

## ✅ FIXED! All Pages Now Working!

The application is **fully deployed and running** at:
```
http://localhost:8080/um6p_learning_center/
```

---

## 🌐 Working URLs

### **Public Pages:**

1. **Homepage** (NEW Professional Design!)
   ```
   http://localhost:8080/um6p_learning_center/
   ```
   ✅ Beautiful carousel with UM6P branding

2. **Login Page** (NEW Professional Design!)
   ```
   http://localhost:8080/um6p_learning_center/login
   ```
   ✅ Modern split-screen design

3. **Registration**
   ```
   http://localhost:8080/um6p_learning_center/register
   ```
   ✅ Create new student account

---

### **Books & Library:**

4. **Browse Books**
   ```
   http://localhost:8080/um6p_learning_center/books
   ```
   ✅ Search and filter books
   ✅ View book details
   ✅ Borrow books

---

### **Events & Workshops:**

5. **View Events**
   ```
   http://localhost:8080/um6p_learning_center/events
   ```
   ✅ Browse upcoming events
   ✅ Register for events
   ✅ View event details

---

### **User Dashboard (After Login):**

6. **Student Dashboard**
   ```
   http://localhost:8080/um6p_learning_center/student/dashboard
   ```
   ✅ View your stats
   ✅ Quick actions

7. **My Profile**
   ```
   http://localhost:8080/um6p_learning_center/profile
   ```
   ✅ Edit account details
   ✅ Update information

8. **My Borrowings**
   ```
   http://localhost:8080/um6p_learning_center/borrowings
   ```
   ✅ Track borrowed books
   ✅ View due dates
   ✅ Renew books

9. **My Event Registrations**
   ```
   http://localhost:8080/um6p_learning_center/reservations
   ```
   ✅ View registered events
   ✅ Cancel registrations

---

### **Staff Pages (Staff/Librarian Login Required):**

10. **Staff Dashboard**
    ```
    http://localhost:8080/um6p_learning_center/staff/dashboard
    ```
    ✅ Manage books
    ✅ Manage events
    ✅ View statistics

---

## 🔐 Test Accounts

You'll need to create accounts through the registration page:

### Create a Student Account:
1. Go to: http://localhost:8080/um6p_learning_center/register
2. Fill in your details
3. Login at: http://localhost:8080/um6p_learning_center/login

---

## 🎨 What's New

### Professional UM6P Design:
✅ Homepage with auto-advancing carousel
✅ Modern login page with split-screen
✅ UM6P color scheme throughout
✅ Montserrat & Open Sans fonts
✅ Fully responsive design

### All Features Working:
✅ User authentication
✅ Book browsing and borrowing
✅ Event registration
✅ Profile management
✅ Dashboard stats
✅ Search functionality

---

## 📱 Navigation

From any page, you can access:
- **Home**: Click "Learning Center" logo
- **Books**: Navigate via navbar
- **Events**: Navigate via navbar
- **Dashboard**: After login, via navbar
- **Profile**: After login, user menu

---

## 🐛 Troubleshooting

### If a page doesn't load:

1. **Check Tomcat is running**:
   - Visit: http://localhost:8080/
   - You should see Tomcat home page

2. **Check the correct URL format**:
   - ✅ Correct: `/events`
   - ❌ Wrong: `/events.jsp`

3. **Make sure you're logged in** for protected pages:
   - Dashboard, Profile, Borrowings require login
   - You'll be redirected to login if not authenticated

4. **Restart Tomcat if needed**:
   - Use your `start-tomcat-desktop.bat` script

---

## ✨ Features by Page

### Homepage
- Auto-advancing carousel (every 5 seconds)
- Manual navigation (prev/next buttons)
- Statistics section
- Services showcase
- Featured events
- Professional footer

### Books Page
- Search by title, author, genre
- Filter by availability
- Grid view of books
- Borrow functionality
- Book details

### Events Page
- Browse upcoming events
- Filter by category
- Register for events
- View event details
- Track registrations

### Dashboard
- Overview of your activity
- Borrowed books summary
- Registered events
- Quick actions
- Statistics

---

## 🎯 All Working!

Every page is now functional and accessible. The controllers are deployed and routing correctly.

**Enjoy your UM6P Learning Center!** 🎉

---

**Last Updated**: November 29, 2025
**Status**: ✅ FULLY DEPLOYED AND WORKING
