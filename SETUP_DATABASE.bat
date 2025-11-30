@echo off
echo ================================================================
echo UM6P LEARNING CENTER - DATABASE SETUP
echo ================================================================
echo.
echo This script will create and populate the complete database.
echo.
pause

echo.
echo [1/2] Creating database and tables...
mysql -u root -p < "%~dp0database\complete_database_setup.sql"

echo.
echo [2/2] Database setup complete!
echo.
echo ================================================================
echo DATABASE READY!
echo ================================================================
echo.
echo Test Users Created:
echo.
echo STUDENTS:
echo   - ahmed.benali@um6p.ma      (Password: Password123)
echo   - fatima.alami@um6p.ma      (Password: Password123)
echo   - youssef.idrissi@um6p.ma   (Password: Password123)
echo.
echo STAFF:
echo   - imane.fouad@um6p.ma       (Password: Password123)
echo   - karim.alaoui@um6p.ma      (Password: Password123)
echo.
echo LIBRARIAN:
echo   - zineb.fassi@um6p.ma       (Password: Password123)
echo.
echo ================================================================
echo NEXT STEPS:
echo 1. Go to: http://localhost:8080/um6p_learning_center/views/public/index.jsp
echo 2. Click "Sign In"
echo 3. Login with any test user above
echo 4. Explore the system!
echo ================================================================
echo.
pause
