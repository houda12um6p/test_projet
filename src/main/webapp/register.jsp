<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - UM6P Learning Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .register-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden;
            max-width: 600px;
            margin: 0 auto;
        }
        .register-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .register-header h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }
        .register-body {
            padding: 40px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
        }
        .input-group-text {
            background-color: #f8f9fa;
        }
        .role-fields {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 10px;
        }
        .role-fields.active {
            display: block;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #dee2e6;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <div class="register-header">
                <i class="fas fa-user-plus fa-3x mb-3"></i>
                <h2>Create Account</h2>
                <p>Join the UM6P Learning Center</p>
            </div>

            <div class="register-body">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
                    <div class="row">
                        <div class="col-md-12 mb-3">
                            <label class="form-label">Full Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" name="name"
                                       value="${name}" required>
                            </div>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label">UM6P Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" class="form-control" name="email"
                                       placeholder="your.name@um6p.ma" value="${email}" required>
                            </div>
                            <small class="text-muted">Must end with @um6p.ma</small>
                        </div>

                        <div class="col-md-12 mb-3">
                            <label class="form-label">Phone Number</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                <input type="tel" class="form-control" name="phone"
                                       value="${phone}" required>
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control" name="password"
                                       minlength="6" required>
                            </div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Confirm Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control" name="confirmPassword"
                                       minlength="6" required>
                            </div>
                        </div>

                        <div class="col-md-12 mb-3">
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
                        <h6 class="mb-3"><i class="fas fa-graduation-cap me-2"></i>Student Information</h6>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Student ID</label>
                                <input type="text" class="form-control" name="studentIdNumber"
                                       value="${studentIdNumber}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Major</label>
                                <input type="text" class="form-control" name="major"
                                       value="${major}">
                            </div>
                        </div>
                    </div>

                    <!-- Staff-specific fields -->
                    <div id="staffFields" class="role-fields">
                        <h6 class="mb-3"><i class="fas fa-briefcase me-2"></i>Staff Information</h6>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Department</label>
                                <input type="text" class="form-control" name="department"
                                       value="${department}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Position</label>
                                <input type="text" class="form-control" name="position"
                                       value="${position}">
                            </div>
                            <div class="col-md-12 mb-3">
                                <label class="form-label">Office Location</label>
                                <input type="text" class="form-control" name="officeLocation"
                                       value="${officeLocation}">
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-register w-100 mt-3">
                        <i class="fas fa-user-plus me-2"></i>Create Account
                    </button>
                </form>

                <div class="login-link">
                    <p class="mb-0">Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in here</a></p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
