@echo off
echo ========================================
echo UM6P Learning Center - Rebuild and Deploy
echo ========================================
echo.

REM Set Java path
set "JAVA_HOME=C:\Program Files\Common Files\Oracle\Java\javapath"
set "PATH=%JAVA_HOME%;%PATH%"

echo [1/4] Cleaning previous build...
call mvn clean
if errorlevel 1 (
    echo ERROR: Clean failed!
    pause
    exit /b 1
)

echo.
echo [2/4] Building project...
call mvn package -DskipTests
if errorlevel 1 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)

echo.
echo [3/4] Stopping Tomcat...
cd /d "C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\bin"
call shutdown.bat
timeout /t 5 /nobreak > nul

echo.
echo [4/4] Deploying to Tomcat...
del /q "C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\learning-center.war" 2>nul
rmdir /s /q "C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\learning-center" 2>nul

copy /y "C:\Users\wwwto\Desktop\um6p_learning_center\target\learning-center.war" "C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\"

echo.
echo [5/5] Starting Tomcat...
call startup.bat

echo.
echo ========================================
echo Deployment Complete!
echo.
echo Wait 10-15 seconds for Tomcat to start, then visit:
echo http://localhost:8080/learning-center/
echo ========================================
echo.
pause
