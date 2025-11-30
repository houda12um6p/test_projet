# ✅ WORKING Student Logins - UM6P Learning Center

## 🚀 Quick Solution: Create Fresh Test Account

If existing accounts don't work, use this page to create a guaranteed working account:

```
http://localhost:8080/um6p_learning_center/create-test-student.jsp
```

This will create a fresh account with known working credentials!

---

## 🔐 Method 1: Create New Test Account (RECOMMENDED)

### Step 1: Visit the Account Creator
```
http://localhost:8080/um6p_learning_center/create-test-student.jsp
```

### Step 2: Click "Create Test Account"

### Step 3: Login with:
- **Email**: `test.student@um6p.ma`
- **Password**: `student123`

---

## 🔐 Method 2: Try Existing Accounts

If the database was properly initialized, these should work:

### Account 1:
- **Email**: `ahmed.benali@um6p.ma`
- **Password**: `Password123`

### Account 2:
- **Email**: `fatima.alami@um6p.ma`
- **Password**: `Password123`

### Account 3:
- **Email**: `youssef.idrissi@um6p.ma`
- **Password**: `Password123`

---

## 🔧 Troubleshooting Login Issues

### Why login might fail:

1. **Database not initialized**
   - The database might not have the sample users
   - Solution: Use the account creator page above

2. **Password hash mismatch**
   - BCrypt hash might be different
   - Solution: Create fresh account with the tool

3. **Database connection issue**
   - Check if MySQL is running
   - Check database name: `um6p_learning_center`

---

## 📝 How to Use

### Option A: Create Fresh Account (Easiest)

1. Go to: `http://localhost:8080/um6p_learning_center/create-test-student.jsp`
2. Click "Create Test Account"
3. Login with: `test.student@um6p.ma` / `student123`

### Option B: Try Existing Accounts

1. Go to: `http://localhost:8080/um6p_learning_center/login`
2. Try: `ahmed.benali@um6p.ma` / `Password123`
3. If it doesn't work, use Option A

---

## ✨ After Login

Once logged in successfully, you can:

✅ Browse books at: `/books`
✅ View events at: `/events`
✅ Check dashboard at: `/student/dashboard`
✅ Manage profile at: `/profile`
✅ View borrowings at: `/borrowings`
✅ View registrations at: `/reservations`

---

## 🎯 Quick Test Flow

1. **Create Account**:
   ```
   http://localhost:8080/um6p_learning_center/create-test-student.jsp
   ```

2. **Click** "Create Test Account"

3. **Login**:
   ```
   Email: test.student@um6p.ma
   Password: student123
   ```

4. **Success!** You should see the dashboard

---

**Last Updated**: November 29, 2025
**Status**: ✅ Account creator page deployed and ready
