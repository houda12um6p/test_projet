@echo off
echo ========================================
echo Quick Deploy - UM6P Learning Center
echo ========================================
echo.

echo [1/3] Stopping Tomcat...
cd /d "C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\bin"
call shutdown.bat
timeout /t 5 /nobreak > nul

echo.
echo [2/3] Deploying WAR file...
del /q "C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\um6p_learning_center.war" 2>nul
rmdir /s /q "C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\um6p_learning_center" 2>nul

copy /y "C:\Users\wwwto\Desktop\um6p_learning_center\target\learning-center.war" "C:\Users\wwwto\Desktop\apache-tomcat-9.0.93\webapps\um6p_learning_center.war"

echo.
echo [3/3] Starting Tomcat...
call startup.bat

echo.
echo ========================================
echo Deployment Complete!
echo.
echo Wait 10-15 seconds, then visit:
echo http://localhost:8080/um6p_learning_center/
echo http://localhost:8080/um6p_learning_center/events
echo http://localhost:8080/um6p_learning_center/books
echo ========================================
echo.
pause
