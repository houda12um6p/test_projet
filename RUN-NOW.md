# 🚀 RUN YOUR PROJECT NOW - 2 EASY METHODS

## ✅ Your Project is Ready on Desktop!

Location: `C:\Users\wwwto\Desktop\um6p_learning_center`

---

## Method 1: Double-Click Batch File (EASIEST)

### Step 1: Run the Deployment Script
1. Go to your Desktop
2. Open the folder: `um6p_learning_center`
3. **Double-click**: `deploy-to-tomcat.bat`
4. Wait 10 seconds
5. Browser opens automatically!

**That's it!** Your website is running! 🎉

### What the Script Does:
- ✅ Stops Tomcat if running
- ✅ Copies your project to Tomcat webapps
- ✅ Starts Tomcat
- ✅ Opens browser automatically

### To Stop Later:
- Double-click: `stop-tomcat.bat`

---

## Method 2: Manual Deployment (If Script Doesn't Work)

### Step 1: Copy Project to Tomcat
1. Open File Explorer
2. Navigate to: `C:\Users\wwwto\Desktop\um6p_learning_center\src\main\webapp`
3. **Copy** the entire `webapp` folder
4. Navigate to: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps`
5. **Paste** and rename to: `um6p_learning_center`

### Step 2: Start Tomcat
1. Navigate to: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin`
2. **Double-click**: `startup.bat`
3. Wait 5-10 seconds for Tomcat to start

### Step 3: Open Browser
1. Open your browser (Chrome, Firefox, Edge)
2. Go to: `http://localhost:8080/um6p_learning_center/views/public/index.jsp`

**Done!** Your beautiful homepage with carousel is running! 🎊

---

## Method 3: Run from IntelliJ (Most Professional)

### Step 1: Open in IntelliJ
1. Launch IntelliJ IDEA
2. File → Open
3. Select: `C:\Users\wwwto\Desktop\um6p_learning_center`
4. Click OK

### Step 2: Configure Tomcat
1. Run → Edit Configurations
2. + → Tomcat Server → Local
3. **Server tab:**
   - Configure → Browse to: `C:\Program Files\Apache Software Foundation\Tomcat 9.0`
   - HTTP port: 8080
4. **Deployment tab:**
   - + → Artifact → Select your project
   - Application context: `/um6p_learning_center`
5. Apply → OK

### Step 3: Run
1. Click green ▶ button (or Shift+F10)
2. Browser opens automatically!

---

## 🌐 Access Your Website

Once running, open any of these URLs:

**Homepage:**
```
http://localhost:8080/um6p_learning_center/views/public/index.jsp
```

**Login Page:**
```
http://localhost:8080/um6p_learning_center/views/public/login.jsp
```

**Direct Access (if web.xml configured):**
```
http://localhost:8080/um6p_learning_center/
```

---

## ✅ Success Indicators

You'll know it's working when you see:

1. **Tomcat Console** shows "Server startup in [X] milliseconds"
2. **Browser opens** automatically
3. **Homepage displays** with:
   - Beautiful carousel auto-playing your 3 images
   - UM6P logo in navbar
   - Orange/Navy color scheme
   - Stats cards showing "5,000+ Books"
   - Your 2 masterclass event posters
   - Professional footer

---

## 🔧 Troubleshooting

### Issue: Port 8080 already in use
**Solution:**
```batch
netstat -ano | findstr :8080
taskkill /PID <PID_NUMBER> /F
```
Then run deploy-to-tomcat.bat again

### Issue: Tomcat won't start
**Solution:**
1. Check if Java is installed: `java -version`
2. If not, download Java JDK 11 or higher
3. Restart computer
4. Try again

### Issue: Page shows 404 error
**Solution:**
1. Check Tomcat is running: `http://localhost:8080`
2. Verify folder exists: `C:\Program Files\...\Tomcat 9.0\webapps\um6p_learning_center`
3. Check the URL is correct (include `/views/public/index.jsp`)

### Issue: CSS not loading
**Solution:**
1. Clear browser cache: Ctrl+Shift+Delete
2. Restart Tomcat: Double-click `stop-tomcat.bat` then `deploy-to-tomcat.bat`
3. Hard refresh browser: Ctrl+F5

---

## 📸 What You'll See

### Homepage Features:
```
┌─────────────────────────────────────────────────────┐
│  [UM6P Logo]  Home About Services Events [Sign In] │
├─────────────────────────────────────────────────────┤
│                                                     │
│      ╔══════════════════════════════════╗          │
│      ║   CAROUSEL AUTO-PLAYING!        ║          │
│      ║   → Cultural Club Event (GIF)   ║          │
│      ║   → Community Event (GIF)       ║          │
│      ║   → Learning Center Building    ║          │
│      ║   [←]  ● ● ○  [→]              ║          │
│      ╚══════════════════════════════════╝          │
│                                                     │
│  Welcome to UM6P Learning Center                   │
│  [Get Started]  [Learn More]                       │
│                                                     │
├─────────────────────────────────────────────────────┤
│  ┌──────┐ ┌──────┐ ┌──────┐ ┌──────┐             │
│  │5,000+│ │ 50+  │ │2,500+│ │ 200+ │             │
│  │Books │ │Events│ │Users │ │Shops │             │
│  └──────┘ └──────┘ └──────┘ └──────┘             │
├─────────────────────────────────────────────────────┤
│  About Section (3 feature cards)                   │
├─────────────────────────────────────────────────────┤
│  Your 2 Masterclass Event Posters                  │
├─────────────────────────────────────────────────────┤
│  Footer: About | Resources | Contact               │
└─────────────────────────────────────────────────────┘
```

---

## 🎨 Design Features

- ✅ **Poppins font** throughout
- ✅ **UM6P Orange** (#D95D39) - buttons, links
- ✅ **Navy Blue** (#1E3A8A) - headers, footer
- ✅ **No gradients** - clean, flat design
- ✅ **Professional** - corporate/academic look
- ✅ **Your images** - all 8 integrated
- ✅ **Working carousel** - auto-plays every 5 seconds
- ✅ **Responsive** - works on mobile too

---

## ⚡ Quick Commands

**Start Tomcat:**
```batch
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin"
startup.bat
```

**Stop Tomcat:**
```batch
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin"
shutdown.bat
```

**Check Tomcat Status:**
```
Open browser: http://localhost:8080
```
If you see the Tomcat page, it's running!

---

## 🎊 You're Ready!

**Easiest method:**
1. Double-click `deploy-to-tomcat.bat` on your Desktop
2. Wait 10 seconds
3. Browser opens with your beautiful website!

**That's it!** 🚀

---

**Created:** November 28, 2025
**Status:** Ready to Run
**Your Location:** C:\Users\wwwto\Desktop\um6p_learning_center
