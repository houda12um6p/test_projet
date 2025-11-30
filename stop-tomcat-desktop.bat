@echo off
REM UM6P Learning Center - Stop Tomcat (Desktop Version)

echo Stopping Tomcat...
set "CATALINA_HOME=C:\Users\wwwto\Desktop\apache-tomcat-9.0.93"

if not exist "%CATALINA_HOME%\bin\shutdown.bat" (
    echo ERROR: Tomcat not found at: %CATALINA_HOME%
    pause
    exit /b 1
)

cd /d "%CATALINA_HOME%\bin"
call shutdown.bat
echo.
echo Tomcat stopped successfully!
pause
