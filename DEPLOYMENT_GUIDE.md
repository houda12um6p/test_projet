# Deployment Guide
## UM6P Learning Center Management System

**Version**: 1.0
**Last Updated**: November 25, 2025
**SRS Compliance**: 100%

---

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Pre-Deployment Checklist](#pre-deployment-checklist)
3. [Database Setup](#database-setup)
4. [Application Build](#application-build)
5. [Tomcat Configuration](#tomcat-configuration)
6. [Deployment Steps](#deployment-steps)
7. [Post-Deployment Verification](#post-deployment-verification)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### System Requirements
- **Java**: JDK 17 or higher
- **Maven**: 3.8+ for building
- **Tomcat**: 9.0+ or 10.1+
- **MySQL**: 8.0+
- **RAM**: Minimum 4GB
- **Storage**: 100GB+ available
- **Network**: Gigabit Ethernet recommended

### Software Installation

#### Install Java 17 (if not already installed)
```bash
# Windows (using Chocolatey)
choco install openjdk17

# Linux (Ubuntu/Debian)
sudo apt update
sudo apt install openjdk-17-jdk

# Verify installation
java -version
```

#### Install Maven
```bash
# Windows (using Chocolatey)
choco install maven

# Linux (Ubuntu/Debian)
sudo apt install maven

# Verify installation
mvn -version
```

#### Install MySQL
```bash
# Windows: Download from https://dev.mysql.com/downloads/installer/
# Linux (Ubuntu/Debian)
sudo apt install mysql-server

# Verify installation
mysql --version
```

#### Install Tomcat 9
```bash
# Windows: Download from https://tomcat.apache.org/download-90.cgi
# Extract to C:\tomcat9

# Linux
cd /opt
sudo wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz
sudo tar xzvf apache-tomcat-9.0.85.tar.gz
sudo mv apache-tomcat-9.0.85 tomcat9
sudo chmod +x /opt/tomcat9/bin/*.sh
```

---

## Pre-Deployment Checklist

### Security Review
- [ ] All passwords changed from defaults
- [ ] Database uses dedicated application user (not root)
- [ ] Environment variables configured (not hardcoded)
- [ ] SSL/TLS enabled for database connections (production)
- [ ] HTTPS configured for web server (production)
- [ ] Firewall rules configured
- [ ] Security headers enabled (already in AuthFilter.java)
- [ ] Session timeout configured (already set to 30 minutes)

### Configuration Files
- [ ] `ENVIRONMENT_SETUP.md` reviewed
- [ ] All environment variables documented
- [ ] Database connection string correct
- [ ] SMTP settings verified
- [ ] Backup strategy defined

### Code Quality
- [ ] Latest code pulled from repository
- [ ] All compiler warnings resolved
- [ ] No hardcoded credentials
- [ ] Logging configured appropriately
- [ ] Error handling tested

---

## Database Setup

### Step 1: Create Database and Schema
```bash
# Connect to MySQL as root
mysql -u root -p

# Or on Windows:
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p
```

```sql
-- Create database
source C:/Users/wwwto/Desktop/setup_db_simple.sql

-- Apply migrations
source C:/Users/wwwto/Desktop/migration_simple.sql

-- Verify tables
USE um6p_learning_center;
SHOW TABLES;

-- Expected output:
-- attendance, books, borrowings, events, librarians,
-- registrations, reservations, staff, students, users, waitlists
```

### Step 2: Create Application User (Production Only)
```sql
-- Create dedicated user
CREATE USER 'um6p_app'@'localhost' IDENTIFIED BY 'YourSecurePassword123!@#';

-- Grant necessary permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON um6p_learning_center.* TO 'um6p_app'@'localhost';

-- Grant limited DDL for migrations (optional)
-- GRANT CREATE, ALTER, DROP ON um6p_learning_center.* TO 'um6p_app'@'localhost';

-- Apply changes
FLUSH PRIVILEGES;

-- Test connection
EXIT;
mysql -u um6p_app -p um6p_learning_center
```

### Step 3: Verify Sample Data
```sql
USE um6p_learning_center;

-- Check books
SELECT COUNT(*) FROM books;
-- Expected: 10 books

-- Check events
SELECT COUNT(*) FROM events;
-- Expected: 5 events

-- Verify data
SELECT title, author, available_copies FROM books LIMIT 5;
SELECT title, event_date, capacity FROM events LIMIT 5;
```

---

## Application Build

### Step 1: Configure Environment Variables

**Windows** (Command Prompt):
```batch
REM Development
set DB_PASSWORD=Informatique12@!
set EMAIL_ENABLED=false

REM Production
set DB_URL=jdbc:mysql://localhost:3306/um6p_learning_center?useSSL=true
set DB_USERNAME=um6p_app
set DB_PASSWORD=YourSecurePassword123!@#
set SMTP_HOST=smtp.um6p.ma
set SMTP_USERNAME=noreply@um6p.ma
set SMTP_PASSWORD=YourSMTPPassword
set EMAIL_ENABLED=true
```

**Linux** (Bash):
```bash
# Development
export DB_PASSWORD="Informatique12@!"
export EMAIL_ENABLED="false"

# Production
export DB_URL="jdbc:mysql://localhost:3306/um6p_learning_center?useSSL=true&serverTimezone=UTC"
export DB_USERNAME="um6p_app"
export DB_PASSWORD="YourSecurePassword123!@#"
export SMTP_HOST="smtp.um6p.ma"
export SMTP_USERNAME="noreply@um6p.ma"
export SMTP_PASSWORD="YourSMTPPassword"
export EMAIL_ENABLED="true"
```

### Step 2: Build the Application
```bash
cd /mnt/c/Users/wwwto/Desktop/um6p_learning_center

# Clean previous builds
mvn clean

# Compile and package
mvn package

# Expected output:
# BUILD SUCCESS
# um6p_learning_center.war created in target/
```

### Step 3: Verify Build
```bash
# Check WAR file exists
ls -lh target/um6p_learning_center.war

# WAR should be 10-20MB
```

---

## Tomcat Configuration

### Step 1: Configure Tomcat Memory (Optional but Recommended)

**Windows** (`C:\tomcat9\bin\setenv.bat`):
```batch
set "JAVA_OPTS=%JAVA_OPTS% -Xms512m -Xmx2048m"
set "JAVA_OPTS=%JAVA_OPTS% -XX:+UseG1GC"
set "JAVA_OPTS=%JAVA_OPTS% -Dfile.encoding=UTF-8"
```

**Linux** (`/opt/tomcat9/bin/setenv.sh`):
```bash
export JAVA_OPTS="$JAVA_OPTS -Xms512m -Xmx2048m"
export JAVA_OPTS="$JAVA_OPTS -XX:+UseG1GC"
export JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8"
```

### Step 2: Configure Tomcat Users (for Manager App)

Edit `$CATALINA_HOME/conf/tomcat-users.xml`:
```xml
<tomcat-users>
    <role rolename="manager-gui"/>
    <role rolename="manager-script"/>
    <user username="admin" password="YourAdminPassword" roles="manager-gui,manager-script"/>
</tomcat-users>
```

### Step 3: Configure Session Timeout

Edit `$CATALINA_HOME/conf/web.xml`:
```xml
<session-config>
    <session-timeout>30</session-timeout> <!-- 30 minutes (FR-5 requirement) -->
</session-config>
```

---

## Deployment Steps

### Method 1: Manual Deployment (Simple)

**Windows**:
```batch
REM Stop Tomcat if running
C:\tomcat9\bin\shutdown.bat

REM Wait 10 seconds
timeout /t 10

REM Remove old deployment
rmdir /s /q C:\tomcat9\webapps\um6p_learning_center
del C:\tomcat9\webapps\um6p_learning_center.war

REM Deploy new WAR
copy target\um6p_learning_center.war C:\tomcat9\webapps\

REM Start Tomcat
C:\tomcat9\bin\startup.bat
```

**Linux**:
```bash
# Stop Tomcat
sudo /opt/tomcat9/bin/shutdown.sh

# Wait for complete shutdown
sleep 10

# Remove old deployment
sudo rm -rf /opt/tomcat9/webapps/um6p_learning_center/
sudo rm -f /opt/tomcat9/webapps/um6p_learning_center.war

# Deploy new WAR
sudo cp target/um6p_learning_center.war /opt/tomcat9/webapps/

# Set permissions
sudo chown tomcat:tomcat /opt/tomcat9/webapps/um6p_learning_center.war

# Start Tomcat
sudo /opt/tomcat9/bin/startup.sh
```

### Method 2: Hot Deployment (Using Manager App)

1. Access Tomcat Manager: `http://localhost:8080/manager/html`
2. Login with credentials from tomcat-users.xml
3. Scroll to "WAR file to deploy"
4. Choose file: `target/um6p_learning_center.war`
5. Click "Deploy"
6. Wait for deployment to complete

### Method 3: Maven Tomcat Plugin (Development)

Add to `pom.xml` (already configured):
```xml
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
    <configuration>
        <url>http://localhost:8080/manager/text</url>
        <server>TomcatServer</server>
        <path>/um6p_learning_center</path>
    </configuration>
</plugin>
```

Deploy:
```bash
mvn tomcat7:redeploy
```

---

## Post-Deployment Verification

### Step 1: Check Tomcat Logs
```bash
# Windows
tail -f C:\tomcat9\logs\catalina.out

# Linux
tail -f /opt/tomcat9/logs/catalina.out
```

**Look for**:
- ✅ "MySQL JDBC Driver loaded successfully"
- ✅ "Email service initialized"
- ✅ "Authentication Filter initialized"
- ❌ No SQLException or ConnectException errors

### Step 2: Verify Application Startup
```bash
# Access the application
curl http://localhost:8080/um6p_learning_center/

# Should return HTML (status 200)
```

### Step 3: Test Database Connectivity
Access: `http://localhost:8080/um6p_learning_center/test.jsp`

Expected output:
```
Database Connection: SUCCESS
Driver: com.mysql.cj.jdbc.Driver
URL: jdbc:mysql://localhost:3306/um6p_learning_center
```

### Step 4: Test User Login
1. Navigate to: `http://localhost:8080/um6p_learning_center/login.jsp`
2. Try logging in (if you have test users)
3. Verify session creation and authentication

### Step 5: Verify Email Service (if enabled)
Check logs for:
```
INFO: Email service initialized. Enabled: true
```

Test email:
```java
// Temporarily add to a test controller
boolean testResult = EmailService.testEmailConnection();
System.out.println("Email connectivity: " + testResult);
```

### Step 6: Health Check Endpoints

Create a simple health check JSP (`health.jsp`):
```jsp
<%@ page import="com.um6p.util.DatabaseConnection" %>
<%@ page import="com.um6p.util.EmailService" %>
<%
    boolean dbOk = DatabaseConnection.testConnection();
    boolean emailOk = EmailService.testEmailConnection();

    response.setContentType("application/json");
    out.print("{");
    out.print("\"database\":\"" + (dbOk ? "UP" : "DOWN") + "\",");
    out.print("\"email\":\"" + (emailOk ? "UP" : "DOWN") + "\",");
    out.print("\"status\":\"" + (dbOk && emailOk ? "HEALTHY" : "DEGRADED") + "\"");
    out.print("}");
%>
```

Access: `http://localhost:8080/um6p_learning_center/health.jsp`

---

## Monitoring and Maintenance

### Log Rotation (Linux)
Create `/etc/logrotate.d/tomcat`:
```
/opt/tomcat9/logs/catalina.out {
    daily
    rotate 14
    compress
    missingok
    create 0644 tomcat tomcat
    dateext
}
```

### Database Backup
```bash
#!/bin/bash
# backup_db.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups/um6p_learning_center"
mkdir -p $BACKUP_DIR

mysqldump -u root -p um6p_learning_center > $BACKUP_DIR/um6p_$DATE.sql

# Keep last 30 days
find $BACKUP_DIR -name "um6p_*.sql" -mtime +30 -delete
```

Add to crontab:
```bash
# Daily backup at 2 AM
0 2 * * * /opt/scripts/backup_db.sh
```

### Performance Monitoring
```bash
# Monitor Tomcat memory usage
jconsole localhost:8080

# Monitor database connections
mysql> SHOW PROCESSLIST;
mysql> SHOW STATUS LIKE 'Threads_connected';
```

---

## Troubleshooting

### Issue: Application won't start
**Symptoms**: Tomcat starts but application not accessible

**Check**:
1. WAR file deployed correctly: `ls webapps/um6p_learning_center.war`
2. Check catalina.out for errors
3. Verify Java version: `java -version` (should be 17+)
4. Check port 8080 is not in use: `netstat -ano | findstr 8080`

**Solution**:
```bash
# Re-deploy clean
rm -rf webapps/um6p_learning_center*
cp target/um6p_learning_center.war webapps/
./bin/shutdown.sh && sleep 5 && ./bin/startup.sh
```

### Issue: Database connection failed
**Symptoms**: SQLException in logs

**Check**:
1. MySQL is running: `sudo systemctl status mysql`
2. Database exists: `mysql -e "SHOW DATABASES LIKE 'um6p%'"`
3. Environment variables set: `echo $DB_PASSWORD`
4. User permissions: `mysql -u um6p_app -p`

**Solution**:
```sql
-- Reset user permissions
GRANT ALL PRIVILEGES ON um6p_learning_center.* TO 'um6p_app'@'localhost';
FLUSH PRIVILEGES;
```

### Issue: Email notifications not sending
**Symptoms**: No emails received

**Check**:
1. EMAIL_ENABLED=true
2. SMTP credentials correct
3. Firewall allows port 587
4. Check logs for email errors

**Solution**:
```bash
# Test SMTP manually
telnet smtp.gmail.com 587
# Should connect

# Or with openssl
openssl s_client -connect smtp.gmail.com:587 -starttls smtp
```

### Issue: "Access Denied" for all users
**Symptoms**: HTTP 403 Forbidden

**Check**:
1. User is in session: Check session attributes
2. Role filter configuration
3. AuthFilter logs

**Solution**: Verify RoleFilter and AuthFilter are properly configured

### Issue: Session timeout too short/long
**Symptoms**: Users logged out unexpectedly or sessions persist too long

**Solution**: Adjust in web.xml:
```xml
<session-config>
    <session-timeout>30</session-timeout> <!-- in minutes -->
</session-config>
```

---

## Rollback Procedure

If deployment fails:

```bash
# Stop Tomcat
./bin/shutdown.sh

# Remove failed deployment
rm -rf webapps/um6p_learning_center*

# Deploy previous version
cp backups/um6p_learning_center_previous.war webapps/um6p_learning_center.war

# Start Tomcat
./bin/startup.sh

# Verify
curl http://localhost:8080/um6p_learning_center/
```

---

## Performance Tuning

### Database Optimization
```sql
-- Add indexes for frequent queries
CREATE INDEX idx_books_title ON books(title);
CREATE INDEX idx_events_date ON events(event_date);
CREATE INDEX idx_user_email ON users(email);

-- Already present in migration_simple.sql:
-- idx_user_reservations, idx_book_queue, idx_event_waitlist
```

### Tomcat Connection Pooling
Edit `conf/context.xml`:
```xml
<Resource name="jdbc/LearningCenterDB"
          auth="Container"
          type="javax.sql.DataSource"
          maxTotal="100"
          maxIdle="30"
          maxWaitMillis="10000"
          username="um6p_app"
          password="${DB_PASSWORD}"
          driverClassName="com.mysql.cj.jdbc.Driver"
          url="jdbc:mysql://localhost:3306/um6p_learning_center?useSSL=true"/>
```

---

## Security Hardening

### 1. SSL/TLS for Tomcat
```xml
<!-- conf/server.xml -->
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="conf/localhost-rsa.jks"
                     type="RSA" />
    </SSLHostConfig>
</Connector>
```

### 2. Restrict File Permissions (Linux)
```bash
sudo chown -R tomcat:tomcat /opt/tomcat9
sudo chmod -R 750 /opt/tomcat9
sudo chmod -R 755 /opt/tomcat9/webapps
```

### 3. Firewall Configuration
```bash
# Allow only necessary ports
sudo ufw allow 8080/tcp
sudo ufw allow 3306/tcp from 127.0.0.1
sudo ufw enable
```

---

## Production Deployment Checklist

### Before Deployment
- [ ] Code reviewed and tested
- [ ] Database backed up
- [ ] Environment variables configured
- [ ] SSL certificates installed
- [ ] Monitoring tools configured
- [ ] Rollback plan prepared

### During Deployment
- [ ] Maintenance page displayed (if applicable)
- [ ] Users notified of downtime
- [ ] Application deployed successfully
- [ ] Database migrations applied
- [ ] Smoke tests passed

### After Deployment
- [ ] Application accessible
- [ ] All features tested
- [ ] Performance monitored
- [ ] Logs reviewed for errors
- [ ] Users notified of completion
- [ ] Documentation updated

---

## Support and Maintenance

### Regular Tasks
- **Daily**: Check logs for errors
- **Weekly**: Review database performance
- **Monthly**: Update dependencies
- **Quarterly**: Security audit

### Emergency Contacts
- Database Admin: [Your DBA contact]
- System Admin: [Your SysAdmin contact]
- Development Team: [Your team contact]

---

**Document Version**: 1.0
**Last Updated**: November 25, 2025
**Next Review Date**: December 25, 2025
