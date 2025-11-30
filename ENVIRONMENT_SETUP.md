# Environment Setup Guide
## UM6P Learning Center Management System

**Last Updated**: November 25, 2025

---

## Environment Variables Configuration

The system uses environment variables for secure configuration management. This guide explains how to set them up for different environments.

### Required Environment Variables

#### 1. Database Configuration
```bash
DB_URL=jdbc:mysql://localhost:3306/um6p_learning_center?useSSL=false&serverTimezone=UTC
DB_USERNAME=root
DB_PASSWORD=your_secure_password_here
```

#### 2. Email/SMTP Configuration (For FR-10 & FR-14)
```bash
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=your_email@um6p.ma
SMTP_PASSWORD=your_app_specific_password
FROM_EMAIL=noreply@um6p.ma
FROM_NAME=UM6P Learning Center
EMAIL_ENABLED=true
```

**Note**: For Gmail, you need to:
1. Enable 2-Factor Authentication
2. Generate an App-Specific Password
3. Use that password in `SMTP_PASSWORD`

---

## Setup Instructions by Environment

### Development Environment (Windows)

#### Option 1: System Environment Variables
1. Press `Windows + R`, type `sysdm.cpl`, press Enter
2. Go to "Advanced" tab → "Environment Variables"
3. Under "User variables", click "New" for each variable:
   ```
   Variable name: DB_PASSWORD
   Variable value: Informatique12@!
   ```
4. Repeat for all variables
5. Click OK and restart your IDE/Command Prompt

#### Option 2: IDE Configuration (IntelliJ IDEA)
1. Go to Run → Edit Configurations
2. Select your Tomcat configuration
3. In "Environment variables" section, add:
   ```
   DB_PASSWORD=Informatique12@!;SMTP_USERNAME=your_email@um6p.ma;SMTP_PASSWORD=your_app_password;EMAIL_ENABLED=false
   ```

#### Option 3: Tomcat Configuration
1. Navigate to `C:\tomcat9\bin\`
2. Create/edit `setenv.bat`:
   ```batch
   set "JAVA_OPTS=%JAVA_OPTS% -DDB_PASSWORD=Informatique12@!"
   set "JAVA_OPTS=%JAVA_OPTS% -DSMTP_USERNAME=your_email@um6p.ma"
   set "JAVA_OPTS=%JAVA_OPTS% -DSMTP_PASSWORD=your_app_password"
   set "JAVA_OPTS=%JAVA_OPTS% -DEMAIL_ENABLED=false"
   ```

**For Development**: Set `EMAIL_ENABLED=false` to disable actual email sending during testing.

---

### Production Environment (Linux)

#### Option 1: System-Wide Environment Variables
```bash
# Edit /etc/environment
sudo nano /etc/environment

# Add these lines:
DB_URL="jdbc:mysql://localhost:3306/um6p_learning_center?useSSL=true&serverTimezone=UTC"
DB_USERNAME="um6p_app_user"
DB_PASSWORD="your_very_secure_password_here"
SMTP_HOST="smtp.um6p.ma"
SMTP_PORT="587"
SMTP_USERNAME="noreply@um6p.ma"
SMTP_PASSWORD="your_secure_smtp_password"
FROM_EMAIL="noreply@um6p.ma"
FROM_NAME="UM6P Learning Center"
EMAIL_ENABLED="true"

# Save and reload:
source /etc/environment
```

#### Option 2: Tomcat Context Configuration (Recommended for Production)
1. Edit `$CATALINA_HOME/conf/context.xml` or create app-specific context:
   ```xml
   <Context>
       <!-- Database Configuration -->
       <Environment name="DB_URL" value="jdbc:mysql://localhost:3306/um6p_learning_center?useSSL=true&serverTimezone=UTC" type="java.lang.String" override="false"/>
       <Environment name="DB_USERNAME" value="um6p_app_user" type="java.lang.String" override="false"/>
       <Environment name="DB_PASSWORD" value="your_secure_password" type="java.lang.String" override="false"/>

       <!-- Email Configuration -->
       <Environment name="SMTP_HOST" value="smtp.um6p.ma" type="java.lang.String" override="false"/>
       <Environment name="SMTP_PORT" value="587" type="java.lang.String" override="false"/>
       <Environment name="SMTP_USERNAME" value="noreply@um6p.ma" type="java.lang.String" override="false"/>
       <Environment name="SMTP_PASSWORD" value="your_smtp_password" type="java.lang.String" override="false"/>
       <Environment name="EMAIL_ENABLED" value="true" type="java.lang.String" override="false"/>
   </Context>
   ```

2. In your application code (already configured):
   ```java
   // DatabaseConnection.java and EmailService.java automatically read from System.getenv()
   ```

#### Option 3: Docker Environment Variables
```yaml
# docker-compose.yml
version: '3.8'
services:
  learning-center:
    image: um6p-learning-center:latest
    environment:
      - DB_URL=jdbc:mysql://db:3306/um6p_learning_center?useSSL=false&serverTimezone=UTC
      - DB_USERNAME=root
      - DB_PASSWORD=${DB_PASSWORD}
      - SMTP_HOST=${SMTP_HOST}
      - SMTP_USERNAME=${SMTP_USERNAME}
      - SMTP_PASSWORD=${SMTP_PASSWORD}
      - EMAIL_ENABLED=true
    ports:
      - "8080:8080"
```

Create `.env` file (DO NOT commit to git):
```bash
DB_PASSWORD=your_secure_password
SMTP_HOST=smtp.gmail.com
SMTP_USERNAME=your_email@um6p.ma
SMTP_PASSWORD=your_app_password
```

---

## Email Configuration Details

### Gmail SMTP Setup
1. Enable 2-Factor Authentication on your Google Account
2. Go to: https://myaccount.google.com/apppasswords
3. Select "Mail" and your device
4. Copy the generated 16-character password
5. Use this password in `SMTP_PASSWORD` (no spaces)

### Microsoft/Outlook SMTP Setup
```bash
SMTP_HOST=smtp-mail.outlook.com
SMTP_PORT=587
SMTP_USERNAME=your_email@outlook.com
SMTP_PASSWORD=your_outlook_password
```

### Custom SMTP Server
```bash
SMTP_HOST=mail.um6p.ma
SMTP_PORT=587
SMTP_USERNAME=noreply@um6p.ma
SMTP_PASSWORD=your_custom_smtp_password
FROM_EMAIL=noreply@um6p.ma
FROM_NAME=UM6P Learning Center
```

---

## Database Setup

### 1. Create Database
```bash
# Connect to MySQL
mysql -u root -p

# Run the setup script
mysql> source C:/Users/wwwto/Desktop/setup_db_simple.sql
mysql> source C:/Users/wwwto/Desktop/migration_simple.sql
```

### 2. Create Dedicated Database User (Production)
```sql
-- Create application user
CREATE USER 'um6p_app_user'@'localhost' IDENTIFIED BY 'your_secure_password';

-- Grant permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON um6p_learning_center.* TO 'um6p_app_user'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;
```

Then update environment variables:
```bash
DB_USERNAME=um6p_app_user
DB_PASSWORD=your_secure_password
```

---

## Verification

### Test Database Connection
```bash
# Build the project
cd /mnt/c/Users/wwwto/Desktop/um6p_learning_center
mvn clean package

# Check logs for:
# "MySQL JDBC Driver loaded successfully"
# "Database connection test: SUCCESS"
```

### Test Email Configuration
```java
// Add to a test servlet or main method:
boolean emailWorks = EmailService.testEmailConnection();
System.out.println("Email connectivity: " + (emailWorks ? "SUCCESS" : "FAILED"));
```

---

## Security Best Practices

### ✅ DO:
- Use environment variables for ALL sensitive data
- Use different credentials for dev/prod
- Rotate passwords regularly
- Use SSL for database connections in production (`useSSL=true`)
- Create dedicated database users with minimum required permissions
- Use app-specific passwords for email accounts
- Keep `.env` files out of version control (add to `.gitignore`)

### ❌ DON'T:
- Hard-code passwords in source code
- Commit `.env` files or configuration files with secrets to Git
- Use the same password across environments
- Use root database account in production
- Share production credentials in documentation
- Store passwords in plain text files

---

## Troubleshooting

### Database Connection Issues
```
Error: Access denied for user 'root'@'localhost'
```
**Solution**: Check DB_PASSWORD environment variable is set correctly

```
Error: Unknown database 'um6p_learning_center'
```
**Solution**: Run setup_db_simple.sql first to create the database

### Email Issues
```
Error: Authentication failed
```
**Solution**:
- For Gmail: Use App-Specific Password, not your regular password
- Verify SMTP_USERNAME and SMTP_PASSWORD are correct
- Check 2FA is enabled

```
Error: Connection timed out
```
**Solution**:
- Verify SMTP_HOST and SMTP_PORT
- Check firewall settings
- Ensure outbound port 587 is open

### Environment Variables Not Loading
```
Error: PASSWORD is null
```
**Solution**:
- Restart your IDE/Tomcat after setting environment variables
- Verify variables are set in the correct scope (user vs system)
- For Tomcat, ensure setenv.bat/setenv.sh is in the bin directory

---

## Quick Start Commands

### Windows Development
```batch
REM Set environment variables
set DB_PASSWORD=Informatique12@!
set EMAIL_ENABLED=false

REM Build project
cd C:\Users\wwwto\Desktop\um6p_learning_center
mvn clean package

REM Deploy to Tomcat
copy target\um6p_learning_center.war C:\tomcat9\webapps\

REM Start Tomcat
C:\tomcat9\bin\startup.bat
```

### Linux Production
```bash
# Set environment variables
export DB_PASSWORD="your_secure_password"
export EMAIL_ENABLED="true"

# Build project
cd /opt/um6p_learning_center
mvn clean package

# Deploy to Tomcat
sudo cp target/um6p_learning_center.war /opt/tomcat/webapps/

# Start Tomcat
sudo systemctl start tomcat
```

---

## Environment Checklist

Before deploying, ensure:

- [ ] All environment variables are set
- [ ] Database credentials are correct
- [ ] Database schema is created and migrated
- [ ] SMTP credentials are verified
- [ ] Test email can be sent successfully
- [ ] SSL is enabled for production database
- [ ] Firewall rules allow database and SMTP connections
- [ ] Passwords are secure (minimum 12 characters, mixed case, numbers, symbols)
- [ ] `.env` files are not in version control
- [ ] Production uses dedicated database user (not root)

---

## Support

For issues or questions:
- Check logs in `$CATALINA_HOME/logs/catalina.out`
- Verify environment variables: `echo $DB_PASSWORD` (Linux) or `echo %DB_PASSWORD%` (Windows)
- Test database connection manually: `mysql -h localhost -u root -p`
- Test SMTP connection: Use telnet or openssl s_client

**Document Version**: 1.0
**Last Updated**: November 25, 2025
