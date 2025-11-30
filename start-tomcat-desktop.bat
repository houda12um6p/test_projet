@echo off
REM UM6P Learning Center - Start Tomcat (Desktop Version)

echo ╔══════════════════════════════════════════════════════════╗
echo ║   UM6P Learning Center - Starting Tomcat                ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

REM Set Java and Tomcat directories
set "JAVA_HOME=C:\Program Files\Java\jdk-25"
set "CATALINA_HOME=C:\Users\wwwto\Desktop\apache-tomcat-9.0.93"
set "PROJECT_DIR=%~dp0"

echo [1/4] Checking Java installation...
if not exist "%JAVA_HOME%\bin\java.exe" (
    echo ERROR: Java not found at: %JAVA_HOME%
    echo Please update JAVA_HOME in this script
    pause
    exit /b 1
)
echo ✓ Java found at: %JAVA_HOME%
echo.

echo [2/4] Checking Tomcat installation...
if not exist "%CATALINA_HOME%\bin\startup.bat" (
    echo ERROR: Tomcat not found at: %CATALINA_HOME%
    echo Please update CATALINA_HOME in this script
    pause
    exit /b 1
)
echo ✓ Tomcat found at: %CATALINA_HOME%
echo.

echo [3/4] Deploying project...
if exist "%CATALINA_HOME%\webapps\um6p_learning_center" (
    rmdir /s /q "%CATALINA_HOME%\webapps\um6p_learning_center"
)
xcopy "%PROJECT_DIR%src\main\webapp" "%CATALINA_HOME%\webapps\um6p_learning_center\" /E /I /Y >nul
echo ✓ Project deployed
echo.

echo [4/4] Starting Tomcat...
cd /d "%CATALINA_HOME%\bin"
call startup.bat
timeout /t 8 /nobreak >nul
echo.

echo ╔══════════════════════════════════════════════════════════╗
echo ║              ✓ TOMCAT STARTED!                          ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo Your UM6P Learning Center is starting...
echo.
echo Opening browser in 3 seconds...
timeout /t 3 /nobreak >nul

start http://localhost:8080/um6p_learning_center/views/public/index.jsp

echo.
echo To stop Tomcat, run: stop-tomcat-desktop.bat
echo.
pause
