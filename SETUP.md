# UM6P Learning Center Management System - Setup Guide

This guide will help you set up and run the UM6P Learning Center Management System.

## Prerequisites

- **Java 17** or higher
- **Maven 3.6+**
- **MySQL 8.0+** (or MariaDB 10.5+)
- **Apache Tomcat 9.0+** or any Java EE compatible application server

## Database Setup

### 1. Create the Database

```bash
mysql -u root -p
```

```sql
CREATE DATABASE um6p_learning_center CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
exit;
```

### 2. Run the Schema Script

```bash
mysql -u root -p um6p_learning_center < src/main/resources/schema.sql
```

This will:
- Create all necessary tables (users, students, staff, books, borrowings, events, registrations, notifications, reservations)
- Insert sample data including:
  - Admin user: `admin@um6p.ma` / `Admin123!`
  - Test student: `student@um6p.ma` / `Student123!`
  - Sample books and events

### 3. Configure Database Credentials

Edit `src/main/resources/application.properties`:

```properties
db.url=jdbc:mysql://localhost:3306/um6p_learning_center?useSSL=false&serverTimezone=UTC
db.username=root
db.password=YOUR_MYSQL_PASSWORD
```

## Build the Project

```bash
mvn clean install
```

This will:
- Download all dependencies
- Compile the Java code
- Run tests (if any)
- Package the application as a WAR file

The output WAR file will be located at: `target/um6p_learning_center.war`

## Deploy to Tomcat

### Option 1: Manual Deployment

1. Copy the WAR file to Tomcat's webapps directory:
   ```bash
   cp target/um6p_learning_center.war $TOMCAT_HOME/webapps/
   ```

2. Start Tomcat:
   ```bash
   $TOMCAT_HOME/bin/startup.sh  # Linux/Mac
   $TOMCAT_HOME\bin\startup.bat  # Windows
   ```

3. Access the application at: `http://localhost:8080/um6p_learning_center/`

### Option 2: IDE Deployment (IntelliJ IDEA / Eclipse)

1. Configure Tomcat server in your IDE
2. Add the project to the server
3. Run the server

## Configuration

All application settings are in `src/main/resources/application.properties`:

### Key Configuration Options

```properties
# Borrowing Settings
borrowing.max.limit=5              # Maximum books per user
borrowing.period.days=14           # Borrowing period in days
borrowing.fine.per.day=5.0        # Fine amount per day

# Session Settings
session.timeout.minutes=30         # Session timeout

# Security Settings
security.csrf.enabled=true         # Enable/disable CSRF protection
security.rate.limit.max.attempts=5 # Max login attempts
```

## Default Credentials

### Admin/Staff Account
- **Email:** admin@um6p.ma
- **Password:** Admin123!
- **Role:** Staff (full access)

### Student Account
- **Email:** student@um6p.ma
- **Password:** Student123!
- **Role:** Student

## Architecture Overview

### Technology Stack
- **Backend:** Java Servlets & JSP
- **Database:** MySQL with HikariCP connection pooling
- **Security:** BCrypt password hashing, CSRF protection, session management
- **Logging:** SLF4J with Logback

### Key Features
1. **User Management:** Registration, authentication, role-based access control
2. **Library System:** Book catalog, borrowing with due dates, inventory tracking
3. **Event Management:** Event creation, registration, capacity tracking
4. **Notifications:** User notifications for various events
5. **Reservations:** Book reservation system with queue management

### Security Features
- Session-based authentication with session fixation prevention
- BCrypt password hashing (cost factor: 12)
- CSRF token protection on all state-changing operations
- Security headers (CSP, X-Frame-Options, etc.)
- Input validation and sanitization
- Rate limiting on login attempts
- Database query parameterization (SQL injection prevention)
- Atomic operations to prevent race conditions

## Project Structure

```
src/main/
├── java/com/um6p/
│   ├── controller/      # Servlets handling HTTP requests
│   ├── dao/             # Data Access Objects for database operations
│   ├── filter/          # Security filters (Auth, CSRF)
│   ├── model/           # Domain models (User, Book, Event, etc.)
│   └── util/            # Utility classes (Config, Logging, Validation)
├── resources/
│   ├── application.properties  # Configuration file
│   ├── logback.xml            # Logging configuration
│   └── schema.sql             # Database schema
└── webapp/
    └── WEB-INF/
        └── web.xml      # Servlet configuration
```

## API Endpoints

### Authentication
- `GET/POST /login` - User login
- `GET/POST /register` - User registration
- `GET/POST /logout` - User logout

### Books
- `GET /books/` - List all books
- `GET /books/search` - Search books
- `GET /books/view/{id}` - View book details
- `POST /books/add` - Add new book (staff only)
- `POST /books/update/{id}` - Update book (staff only)
- `POST /books/delete/{id}` - Delete book (staff only)

### Borrowings
- `GET /borrowings/` - User's borrowings
- `GET /borrowings/active` - Active borrowings
- `GET /borrowings/history` - Borrowing history
- `POST /borrowings/borrow` - Borrow a book
- `POST /borrowings/return/{id}` - Return a book
- `GET /borrowings/overdue` - Overdue books (staff only)

### Events
- `GET /events/` - List all events
- `GET /events/upcoming` - Upcoming events
- `GET /events/view/{id}` - Event details
- `POST /events/register` - Register for event
- `POST /events/cancel/{id}` - Cancel registration
- `POST /events/add` - Create event (staff only)

### Profile
- `GET /profile/` - View profile
- `GET /profile/edit` - Edit profile form
- `POST /profile/update` - Update profile
- `POST /profile/change-password` - Change password

## Logging

Logs are written to:
- `logs/application.log` - All application logs
- `logs/error.log` - Error logs only

Log levels can be configured in `logback.xml`.

## Troubleshooting

### Database Connection Issues
- Verify MySQL is running: `systemctl status mysql`
- Check credentials in `application.properties`
- Ensure database exists: `mysql -u root -p -e "SHOW DATABASES;"`

### Compilation Errors
- Ensure Java 17 is installed: `java -version`
- Clean and rebuild: `mvn clean install`
- Check Maven version: `mvn -version`

### Deployment Issues
- Check Tomcat logs: `$TOMCAT_HOME/logs/catalina.out`
- Verify WAR file was deployed correctly
- Ensure no port conflicts (default: 8080)

### Application Errors
- Check application logs in `logs/` directory
- Enable DEBUG logging in `logback.xml` for detailed information
- Verify database schema is up to date

## Development

### Running Tests
```bash
mvn test
```

### Building for Production
```bash
mvn clean package -P production
```

### Code Style
- Follow Java naming conventions
- Use SLF4J for logging (not System.out)
- Always use prepared statements for SQL queries
- Validate and sanitize all user input

## Security Best Practices

1. **Change Default Passwords:** Update all default credentials after deployment
2. **Use HTTPS:** Enable SSL/TLS in production
3. **Database Backups:** Regular automated backups
4. **Update Dependencies:** Keep all libraries up to date
5. **Monitor Logs:** Regular review of security logs
6. **Access Control:** Implement proper role-based permissions

## Support

For issues or questions:
- Check logs in `logs/` directory
- Review this documentation
- Contact the development team

## License

Copyright © 2025 UM6P Learning Center Management System
