# UM6P Learning Center - Automatic Database Setup
# This script tries common MySQL passwords and sets up the database

$ErrorActionPreference = "SilentlyContinue"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "UM6P Learning Center - Auto Database Setup" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$schemaFile = "C:\Users\wwwto\Desktop\um6p_learning_center\database-schema.sql"
$passwords = @("", "root", "admin", "password", "123456", "mysql", "Informatique12@!")

$success = $false

foreach ($pwd in $passwords) {
    Write-Host "Trying password: " -NoNewline
    if ($pwd -eq "") {
        Write-Host "(empty)" -ForegroundColor Yellow
        $pwdArg = ""
    } else {
        Write-Host "$pwd" -ForegroundColor Yellow
        $pwdArg = "-p$pwd"
    }

    # Test connection
    $testCmd = "mysql -u root $pwdArg -e 'SELECT 1;' 2>&1"
    $result = Invoke-Expression $testCmd

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✓ Connected to MySQL successfully!" -ForegroundColor Green
        Write-Host "  Setting up database...`n" -ForegroundColor Cyan

        # Run schema
        $setupCmd = "mysql -u root $pwdArg < `"$schemaFile`" 2>&1"
        Invoke-Expression $setupCmd

        if ($LASTEXITCODE -eq 0) {
            Write-Host "`n========================================" -ForegroundColor Green
            Write-Host "DATABASE SETUP SUCCESSFUL!" -ForegroundColor Green
            Write-Host "========================================`n" -ForegroundColor Green

            Write-Host "You can now login at: http://localhost:8080/learning-center/login`n" -ForegroundColor Cyan

            Write-Host "Test Accounts:" -ForegroundColor Yellow
            Write-Host "  Admin:     admin@um6p.ma / Password123" -ForegroundColor White
            Write-Host "  Librarian: librarian@um6p.ma / Password123" -ForegroundColor White
            Write-Host "  Organizer: organizer@um6p.ma / Password123" -ForegroundColor White
            Write-Host "  Student:   student@um6p.ma / Password123`n" -ForegroundColor White

            $success = $true
            break
        } else {
            Write-Host "  ✗ Database setup failed" -ForegroundColor Red
        }
    }
}

if (-not $success) {
    Write-Host "`n========================================" -ForegroundColor Red
    Write-Host "AUTOMATIC SETUP FAILED" -ForegroundColor Red
    Write-Host "========================================`n" -ForegroundColor Red
    Write-Host "Please enter your MySQL root password manually:`n" -ForegroundColor Yellow

    $userPwd = Read-Host "MySQL root password"

    Write-Host "`nSetting up database..." -ForegroundColor Cyan
    $setupCmd = "mysql -u root -p$userPwd < `"$schemaFile`" 2>&1"
    Invoke-Expression $setupCmd

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`nDatabase setup successful!" -ForegroundColor Green
        Write-Host "You can now login with admin@um6p.ma / Password123`n" -ForegroundColor Cyan
    } else {
        Write-Host "`nSetup failed. Please check your MySQL password.`n" -ForegroundColor Red
    }
}

Write-Host "`nPress any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
