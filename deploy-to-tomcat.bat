@echo off
REM UM6P Learning Center - Tomcat Deployment Script
REM This script deploys your project to Tomcat and starts the server

echo ╔══════════════════════════════════════════════════════════╗
echo ║   UM6P Learning Center - Tomcat Deployment              ║
echo ╚══════════════════════════════════════════════════════════╝
echo.

REM Set Tomcat directory
set TOMCAT_DIR=C:\Program Files\Apache Software Foundation\Tomcat 9.0
set PROJECT_DIR=%~dp0

echo [1/5] Checking Tomcat installation...
if not exist "%TOMCAT_DIR%" (
    echo ERROR: Tomcat not found at: %TOMCAT_DIR%
    echo Please update TOMCAT_DIR in this script to point to your Tomcat installation
    pause
    exit /b 1
)
echo ✓ Tomcat found at: %TOMCAT_DIR%
echo.

echo [2/5] Stopping Tomcat if running...
call "%TOMCAT_DIR%\bin\shutdown.bat" 2>nul
timeout /t 3 /nobreak >nul
echo ✓ Tomcat stopped
echo.

echo [3/5] Copying project to Tomcat webapps...
if exist "%TOMCAT_DIR%\webapps\um6p_learning_center" (
    rmdir /s /q "%TOMCAT_DIR%\webapps\um6p_learning_center"
)
xcopy "%PROJECT_DIR%src\main\webapp" "%TOMCAT_DIR%\webapps\um6p_learning_center\" /E /I /Y >nul
echo ✓ Project copied to webapps
echo.

echo [4/5] Starting Tomcat...
start "" "%TOMCAT_DIR%\bin\startup.bat"
timeout /t 5 /nobreak >nul
echo ✓ Tomcat starting...
echo.

echo [5/5] Opening browser...
timeout /t 3 /nobreak >nul
start http://localhost:8080/um6p_learning_center/views/public/index.jsp
echo ✓ Browser opened
echo.

echo ╔══════════════════════════════════════════════════════════╗
echo ║              ✓ DEPLOYMENT COMPLETE!                     ║
echo ╚══════════════════════════════════════════════════════════╝
echo.
echo Your UM6P Learning Center is now running at:
echo http://localhost:8080/um6p_learning_center/views/public/index.jsp
echo.
echo To stop Tomcat later, run: stop-tomcat.bat
echo.
pause
