@echo off
echo ========================================
echo UM6P Learning Center - Database Setup
echo ========================================
echo.
echo This script will set up your database.
echo.
echo Please enter your MySQL root password when prompted.
echo.
pause

cd /d "%~dp0"

echo Running database setup...
mysql -u root -p < database\complete_database_setup.sql

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo DATABASE SETUP SUCCESSFUL!
    echo ========================================
    echo.
    echo You can now login with these student accounts:
    echo   Email: ahmed.benali@um6p.ma
    echo   Password: Password123
    echo.
    echo   Email: fatima.elkhaldi@um6p.ma
    echo   Password: Password123
    echo.
    echo Admin account:
    echo   Email: admin@um6p.ma
    echo   Password: Password123
    echo.
) else (
    echo.
    echo ========================================
    echo DATABASE SETUP FAILED!
    echo ========================================
    echo Please check your MySQL password and try again.
    echo.
)

pause
