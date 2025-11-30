<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - UM6P Learning Center</title>
    <!-- Google Fonts - Montserrat & Open Sans -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@600;700;800&family=Open+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Custom CSS Framework -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/core.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/components.css">

    <style>
        body {
            background-color: var(--gray-100);
            min-height: 100vh;
            padding: var(--space-10) 0;
        }
        .register-container {
            max-width: 700px;
            margin: 0 auto;
        }
        .register-card {
            background: var(--white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            overflow: hidden;
        }
        .register-header {
            background: linear-gradient(135deg, #D94A3D 0%, #B83D32 100%);
            color: var(--white);
            padding: var(--space-10);
            text-align: center;
        }
        .register-header h2 {
            margin: 0;
            font-size: 32px;
            font-weight: 800;
            font-family: 'Montserrat', sans-serif;
        }
        .register-body {
            padding: var(--space-10);
        }
        .role-fields {
            display: none;
            margin-top: var(--space-6);
            padding: var(--space-6);
            background-color: var(--gray-100);
            border-radius: var(--radius-md);
        }
        .role-fields.active {
            display: block;
        }
        .login-link {
            text-align: center;
            margin-top: var(--space-6);
            padding-top: var(--space-6);
            border-top: 1px solid var(--gray-300);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <div class="register-card">
                <div class="register-header">
                    <i class="fas fa-user-plus" style="font-size: 48px; margin-bottom: var(--space-4); display: block;"></i>
                    <h2>Create Account</h2>
                    <p style="margin: var(--space-2) 0 0 0; opacity: 0.9;">Join the UM6P Learning Center</p>
                </div>

                <div class="register-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-error">
                            <i class="fas fa-exclamation-circle"></i>
                            <span>${error}</span>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                        <div class="grid grid-cols-1 gap-4">
                            <div class="form-group">
                                <label class="form-label">Full Name</label>
                                <div class="input-with-icon">
                                    <i class="input-icon fas fa-user"></i>
                                    <input type="text" class="form-input" name="name" value="${name}" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">UM6P Email</label>
                                <div class="input-with-icon">
                                    <i class="input-icon fas fa-envelope"></i>
                                    <input type="email" class="form-input" name="email" placeholder="your.name@um6p.ma" value="${email}" required>
                                </div>
                                <small style="color: var(--gray-600); font-size: 12px;">Must end with @um6p.ma</small>
                            </div>

                            <div class="form-group">
                                <label class="form-label">Phone Number</label>
                                <div class="input-with-icon">
                                    <i class="input-icon fas fa-phone"></i>
                                    <input type="tel" class="form-input" name="phone" value="${phone}" required>
                                </div>
                            </div>

                            <div class="grid grid-cols-2 gap-4">
                                <div class="form-group">
                                    <label class="form-label">Password</label>
                                    <div class="input-with-icon">
                                        <i class="input-icon fas fa-lock"></i>
                                        <input type="password" class="form-input" name="password" minlength="6" required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Confirm Password</label>
                                    <div class="input-with-icon">
                                        <i class="input-icon fas fa-lock"></i>
                                        <input type="password" class="form-input" name="confirmPassword" minlength="6" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">I am a</label>
                                <select class="form-select" name="role" id="roleSelect" required>
                                    <option value="">-- Select Role --</option>
                                    <option value="STUDENT" ${role == 'STUDENT' ? 'selected' : ''}>Student</option>
                                    <option value="STAFF" ${role == 'STAFF' ? 'selected' : ''}>Staff Member</option>
                                    <option value="LIBRARIAN" ${role == 'LIBRARIAN' ? 'selected' : ''}>Librarian</option>
                                    <option value="ADMINISTRATOR" ${role == 'ADMINISTRATOR' ? 'selected' : ''}>Administrator</option>
                                </select>
                            </div>
                        </div>

                        <!-- Student-specific fields -->
                        <div id="studentFields" class="role-fields">
                            <h6 style="font-size: 16px; font-weight: 700; margin-bottom: var(--space-4);">
                                <i class="fas fa-graduation-cap"></i> Student Information
                            </h6>
                            <div class="grid grid-cols-2 gap-4">
                                <div class="form-group">
                                    <label class="form-label">Student ID</label>
                                    <input type="text" class="form-input" name="studentIdNumber" value="${studentIdNumber}">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Major</label>
                                    <input type="text" class="form-input" name="major" value="${major}">
                                </div>
                            </div>
                        </div>

                        <!-- Staff-specific fields -->
                        <div id="staffFields" class="role-fields">
                            <h6 style="font-size: 16px; font-weight: 700; margin-bottom: var(--space-4);">
                                <i class="fas fa-briefcase"></i> Staff Information
                            </h6>
                            <div class="grid grid-cols-2 gap-4 mb-4">
                                <div class="form-group">
                                    <label class="form-label">Department</label>
                                    <input type="text" class="form-input" name="department" value="${department}">
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Position</label>
                                    <input type="text" class="form-input" name="position" value="${position}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Office Location</label>
                                <input type="text" class="form-input" name="officeLocation" value="${officeLocation}">
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block" style="margin-top: var(--space-6);">
                            <i class="fas fa-user-plus"></i> Create Account
                        </button>
                    </form>

                    <div class="login-link">
                        <p style="margin: 0; color: var(--gray-700);">
                            Already have an account?
                            <a href="${pageContext.request.contextPath}/login" style="color: var(--orange-primary); font-weight: 600; text-decoration: none;">
                                Sign in here
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const roleSelect = document.getElementById('roleSelect');
        const studentFields = document.getElementById('studentFields');
        const staffFields = document.getElementById('staffFields');

        roleSelect.addEventListener('change', function() {
            studentFields.classList.remove('active');
            staffFields.classList.remove('active');

            if (this.value === 'STUDENT') {
                studentFields.classList.add('active');
            } else if (this.value === 'STAFF') {
                staffFields.classList.add('active');
            }
        });

        // Trigger on page load if role is pre-selected
        if (roleSelect.value) {
            roleSelect.dispatchEvent(new Event('change'));
        }

        // Password validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });
    </script>
</body>
</html>
