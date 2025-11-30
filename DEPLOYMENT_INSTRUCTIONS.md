# UM6P Learning Center - Deployment Instructions

## Quick Fix for 404 Error

### Method 1: Use the Rebuild Script (RECOMMENDED)

1. **Double-click** `rebuild-and-deploy.bat` in the project folder
2. Wait for the build and deployment to complete
3. After 10-15 seconds, open your browser and go to:
   ```
   http://localhost:8080/learning-center/
   ```

### Method 2: Manual Deployment

If the batch script doesn't work, follow these manual steps:

#### Step 1: Build the Project

Open Command Prompt in the project folder and run:

```batch
set JAVA_HOME=C:\Program Files\Java\jdk-25
set PATH=%JAVA_HOME%\bin;%PATH%
mvn clean package -DskipTests
```

**Note**: Adjust the `JAVA_HOME` path to match your actual Java installation.

#### Step 2: Stop Tomcat

1. Navigate to: `C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\bin`
2. Run: `shutdown.bat`
3. Wait 5 seconds

#### Step 3: Deploy the WAR File

1. Delete old deployment:
   - Delete: `C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\learning-center.war`
   - Delete folder: `C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\learning-center`

2. Copy new WAR:
   ```batch
   copy C:\Users\wwwto\Desktop\um6p_learning_center\target\learning-center.war C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\
   ```

#### Step 4: Start Tomcat

1. Navigate to: `C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\bin`
2. Run: `startup.bat`
3. Wait 10-15 seconds for deployment

#### Step 5: Access the Application

Open your browser and navigate to:
```
http://localhost:8080/learning-center/
```

## Troubleshooting

### If you still get 404:

1. **Check Tomcat is running**:
   - Open: http://localhost:8080/
   - You should see the Tomcat home page

2. **Check the WAR deployed correctly**:
   - Look in `C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\`
   - You should see both `learning-center.war` and `learning-center` folder

3. **Check Tomcat logs**:
   - Open: `C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\logs\catalina.out`
   - Look for errors

### Java Not Found Error:

Find your Java installation:
```batch
where java
```

Then set JAVA_HOME to the directory containing `java.exe` (minus the `\bin\java.exe` part).

Common locations:
- `C:\Program Files\Java\jdk-25`
- `C:\Program Files\Java\jdk-17`
- `C:\Program Files\Java\jdk-11`

## What Pages Are Available Now:

After deployment, you can access:

1. **Homepage**: `http://localhost:8080/learning-center/`
   - Beautiful carousel
   - UM6P branding
   - Services and events showcase

2. **Login**: `http://localhost:8080/learning-center/login`
   - Split-screen design
   - UM6P branded

## Need Help?

If you continue to get errors, please:

1. Check that Tomcat is running on port 8080
2. Make sure Java is properly installed
3. Verify the WAR file exists in `target/learning-center.war`
4. Check Tomcat logs for specific errors

---

## Next Steps After Deployment Works:

Once the homepage loads successfully, I will create all the remaining pages:
- Books catalog with filters
- Events calendar
- Student dashboard
- Staff dashboard
- Profile page
- My borrowings
- My registrations

All with the same professional UM6P branding!
