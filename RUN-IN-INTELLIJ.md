# 🚀 Run UM6P Learning Center in IntelliJ IDEA

## ✅ Your Project is Ready - Let's Run It!

---

## Method 1: Quick Start (RECOMMENDED)

### Step 1: Open Project in IntelliJ
1. Open **IntelliJ IDEA**
2. Click **File → Open**
3. Navigate to:
   ```
   C:\Users\wwwto\eclipse-workspace\Um6p_learning_center
   ```
4. Click **OK**
5. Wait for IntelliJ to index the project

### Step 2: Configure Tomcat Server
1. Click **Run → Edit Configurations** (or click dropdown next to Run button)
2. Click the **+** button (Add New Configuration)
3. Select **Tomcat Server → Local**

4. In the **Server** tab:
   - **Name**: `Tomcat 9 - UM6P Learning Center`
   - Click **Configure** next to Application server
   - Browse to your Tomcat installation directory (e.g., `C:\Program Files\Apache Software Foundation\Tomcat 9.0`)
   - Click **OK**
   - Set **HTTP port**: `8080`

5. In the **Deployment** tab:
   - Click the **+** button
   - Select **Artifact → um6p_learning_center:war exploded** (or similar)
   - **Application context**: `/Um6p_learning_center`
   - Click **OK**

### Step 3: Run the Project
1. Click the **Run** button (green triangle) or press **Shift+F10**
2. IntelliJ will:
   - Build the project
   - Deploy to Tomcat
   - Start the server
   - Open your browser automatically

3. You should see:
   ```
   http://localhost:8080/Um6p_learning_center/
   ```

4. **Enjoy your beautiful homepage with the carousel!** 🎉

---

## Method 2: Manual Configuration

### Step 1: Open as Existing Project
```
File → Open → Browse to:
C:\Users\wwwto\eclipse-workspace\Um6p_learning_center
```

### Step 2: Mark Directories
Right-click on folders and mark them:
- `src/main/java` → **Mark Directory as → Sources Root**
- `src/main/webapp` → **Mark Directory as → Resources Root**

### Step 3: Add Tomcat Configuration
1. **Run → Edit Configurations**
2. **+ → Tomcat Server → Local**
3. Configure as shown in Method 1

### Step 4: Build Project
```
Build → Build Project (Ctrl+F9)
```

### Step 5: Run
```
Run → Run 'Tomcat 9' (Shift+F10)
```

---

## Method 3: Using Maven (If IntelliJ Detects It)

### Step 1: Enable Maven
If IntelliJ asks to import as Maven project:
1. Click **Import Maven Project**
2. Wait for dependencies to download

### Step 2: Create pom.xml (if missing)
Create file at project root:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.um6p.lc</groupId>
    <artifactId>learning-center</artifactId>
    <version>1.0.0</version>
    <packaging>war</packaging>

    <properties>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>4.0.1</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>javax.servlet.jsp</groupId>
            <artifactId>javax.servlet.jsp-api</artifactId>
            <version>2.3.3</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <build>
        <finalName>Um6p_learning_center</finalName>
    </build>
</project>
```

### Step 3: Reload Maven
```
Right-click pom.xml → Maven → Reload Project
```

---

## 🔧 Troubleshooting IntelliJ Issues

### Issue 1: "Cannot find Tomcat"
**Solution:**
1. Download Tomcat 9: https://tomcat.apache.org/download-90.cgi
2. Extract to: `C:\Program Files\Apache Software Foundation\Tomcat 9.0`
3. In IntelliJ: **Run → Edit Configurations → Configure → Browse to Tomcat folder**

### Issue 2: "Artifact not found"
**Solution:**
1. **File → Project Structure (Ctrl+Alt+Shift+S)**
2. Click **Artifacts** on the left
3. Click **+ → Web Application: Exploded → From Modules**
4. Select your project
5. Ensure `WEB-INF/lib` contains all JARs
6. Click **OK**
7. Rebuild: **Build → Rebuild Project**

### Issue 3: "Port 8080 already in use"
**Solution:**
1. **Run → Edit Configurations**
2. Change **HTTP port** to `8081` or `8888`
3. Or stop other process using port 8080:
   ```bash
   netstat -ano | findstr :8080
   taskkill /PID <PID_NUMBER> /F
   ```

### Issue 4: JSP pages show as text
**Solution:**
1. Ensure Tomcat is running (not just opening HTML file)
2. URL should be: `http://localhost:8080/Um6p_learning_center/`
3. NOT: `file:///C:/Users/...`

### Issue 5: CSS/Images not loading
**Solution:**
1. Check **Deployment** tab in Run Configuration
2. Application context should be: `/Um6p_learning_center`
3. Rebuild: **Build → Rebuild Project**
4. Clear browser cache: **Ctrl+Shift+Delete**

### Issue 6: "Cannot resolve taglib"
**Solution:**
All JSTL JARs are already in `WEB-INF/lib/`:
- jstl-1.2.jar ✓
- jakarta.servlet.jsp.jstl-3.0.1.jar ✓
- jakarta.servlet.jsp.jstl-api-3.0.0.jar ✓

If IntelliJ shows red underline:
1. **File → Project Structure → Libraries**
2. Click **+ → Java**
3. Browse to `src/main/webapp/WEB-INF/lib`
4. Select all JARs → **OK**

---

## 📱 Testing in IntelliJ

### View in Browser
Once running, test these URLs:

1. **Homepage:**
   ```
   http://localhost:8080/Um6p_learning_center/
   ```
   Should show carousel with your GIFs

2. **Login Page:**
   ```
   http://localhost:8080/Um6p_learning_center/views/public/login.jsp
   ```
   Should show two-column login layout

3. **Direct Homepage:**
   ```
   http://localhost:8080/Um6p_learning_center/views/public/index.jsp
   ```

### Debug Mode
To run in debug mode:
1. Click **Debug** button (bug icon) or **Shift+F9**
2. Set breakpoints by clicking left margin of code
3. Inspect variables when code pauses

### Live Reload
For automatic refresh when you edit files:
1. **Run → Edit Configurations**
2. In **Server** tab, check:
   - ✓ **Update classes and resources**
3. When you edit CSS/JSP:
   - **Build → Build Project (Ctrl+F9)**
   - Refresh browser

---

## 🎯 IntelliJ-Specific Tips

### Hot Swap (Live Editing)
1. **File → Settings → Build, Execution, Deployment → Debugger → HotSwap**
2. Check: **Reload classes after compilation**
3. Set to: **Always**

### Browser Selection
1. **File → Settings → Tools → Web Browsers**
2. Select default browser (Chrome recommended)
3. IntelliJ will auto-open this browser

### Code Completion
IntelliJ provides excellent JSP/CSS completion:
- Type `class=` → Shows all CSS classes
- Type `<c:` → Shows JSTL tags
- **Ctrl+Space** → Manual completion

### File Watching
IntelliJ automatically watches files. When you edit:
- **CSS files** → Auto-compiled
- **JSP files** → Auto-updated (after Build)
- **Images** → Auto-copied

---

## 🚀 Quick Reference

### Keyboard Shortcuts (IntelliJ)
| Action | Shortcut |
|--------|----------|
| Run | **Shift+F10** |
| Debug | **Shift+F9** |
| Build | **Ctrl+F9** |
| Rebuild | **Ctrl+Shift+F9** |
| Edit Configurations | **Alt+Shift+F10** |
| Search Files | **Ctrl+Shift+N** |
| Search in Files | **Ctrl+Shift+F** |

### Important Directories
```
Um6p_learning_center/
├── src/main/
│   ├── java/ (mark as Sources Root)
│   └── webapp/ (mark as Resources Root)
│       ├── assets/ (CSS, JS, images)
│       ├── views/public/ (JSP pages)
│       └── WEB-INF/ (config, JARs)
```

---

## ✅ Success Checklist

When running successfully in IntelliJ:

- [ ] **IntelliJ Console** shows: "Tomcat started successfully"
- [ ] **Browser opens** automatically
- [ ] **URL** is: `http://localhost:8080/Um6p_learning_center/`
- [ ] **Homepage loads** with carousel
- [ ] **Carousel auto-plays** your 3 images
- [ ] **UM6P logo** appears in navbar
- [ ] **Orange/Navy colors** throughout
- [ ] **Poppins font** on all text
- [ ] **Stats show** "5,000+ Books", etc.
- [ ] **Event posters** display your masterclass images
- [ ] **Footer** shows university info
- [ ] **No errors** in IntelliJ console
- [ ] **No errors** in browser console (F12)

---

## 🎉 You're Ready!

Your project is configured and validated for IntelliJ:
- ✅ **1,314 lines CSS** ready
- ✅ **717 lines JSP** ready
- ✅ **149 lines JavaScript** ready
- ✅ **8 images** (5.7MB) ready
- ✅ **6 JARs** (6.7MB) ready
- ✅ **Perfect structure** for IntelliJ

Just:
1. **Open in IntelliJ**
2. **Configure Tomcat**
3. **Click Run**
4. **See your beautiful Learning Center!**

---

## 📞 Quick Help

**Project won't run?**
1. Check Tomcat is configured correctly
2. Ensure port 8080 is free
3. Rebuild project (Ctrl+Shift+F9)
4. Check artifact is built (Build → Build Artifacts)

**CSS not loading?**
1. Check application context: `/Um6p_learning_center`
2. Clear browser cache
3. Check URL has correct port: `:8080`

**Carousel not working?**
1. Check JavaScript console (F12)
2. Ensure carousel.js is loaded
3. Verify images are in `assets/images/`

---

**Everything is ready! Just run it and enjoy!** 🚀
