<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Profile - UM6P Learning Center" />
    <jsp:param name="active" value="profile" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="display-4"><i class="fas fa-user-circle me-3"></i>My Profile</h1>
            <p class="lead text-muted">View and manage your account information</p>
        </div>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="row">
        <!-- Profile Card -->
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center p-4">
                    <div class="mb-4">
                        <i class="fas fa-user-circle fa-5x text-primary"></i>
                    </div>
                    <h4 class="card-title">${sessionScope.user.name}</h4>
                    <p class="text-muted mb-3">${sessionScope.user.email}</p>
                    <span class="badge bg-primary fs-6 px-3 py-2">
                        <i class="fas ${sessionScope.user.role == 'STAFF' ? 'fa-briefcase' : 'fa-graduation-cap'} me-2"></i>
                        ${sessionScope.user.role}
                    </span>

                    <hr class="my-4">

                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-primary">
                            <i class="fas fa-edit me-2"></i>Edit Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/profile/change-password" class="btn btn-outline-secondary">
                            <i class="fas fa-key me-2"></i>Change Password
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Details -->
        <div class="col-md-8 mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Profile Information</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-sm-4">
                            <strong><i class="fas fa-user me-2 text-primary"></i>Full Name:</strong>
                        </div>
                        <div class="col-sm-8">
                            ${sessionScope.user.name}
                        </div>
                    </div>
                    <hr>
                    <div class="row mb-3">
                        <div class="col-sm-4">
                            <strong><i class="fas fa-envelope me-2 text-primary"></i>Email:</strong>
                        </div>
                        <div class="col-sm-8">
                            ${sessionScope.user.email}
                        </div>
                    </div>
                    <hr>
                    <div class="row mb-3">
                        <div class="col-sm-4">
                            <strong><i class="fas fa-user-tag me-2 text-primary"></i>Role:</strong>
                        </div>
                        <div class="col-sm-8">
                            ${sessionScope.user.role}
                        </div>
                    </div>

                    <c:if test="${not empty student}">
                        <hr>
                        <h6 class="mt-4 mb-3 text-primary">
                            <i class="fas fa-graduation-cap me-2"></i>Student Information
                        </h6>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-id-card me-2 text-primary"></i>Student ID:</strong>
                            </div>
                            <div class="col-sm-8">
                                ${student.studentIdNumber}
                            </div>
                        </div>
                        <hr>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-book-open me-2 text-primary"></i>Major:</strong>
                            </div>
                            <div class="col-sm-8">
                                ${student.major}
                            </div>
                        </div>
                        <hr>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-phone me-2 text-primary"></i>Phone:</strong>
                            </div>
                            <div class="col-sm-8">
                                ${student.phone}
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty staff}">
                        <hr>
                        <h6 class="mt-4 mb-3 text-primary">
                            <i class="fas fa-briefcase me-2"></i>Staff Information
                        </h6>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-building me-2 text-primary"></i>Department:</strong>
                            </div>
                            <div class="col-sm-8">
                                ${staff.department}
                            </div>
                        </div>
                        <hr>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-user-tie me-2 text-primary"></i>Position:</strong>
                            </div>
                            <div class="col-sm-8">
                                ${staff.position}
                            </div>
                        </div>
                        <hr>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-map-marker-alt me-2 text-primary"></i>Office:</strong>
                            </div>
                            <div class="col-sm-8">
                                ${staff.officeLocation}
                            </div>
                        </div>
                        <hr>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-phone me-2 text-primary"></i>Phone:</strong>
                            </div>
                            <div class="col-sm-8">
                                ${staff.phone}
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${sessionScope.user.lastLogin != null}">
                        <hr>
                        <div class="row mb-3">
                            <div class="col-sm-4">
                                <strong><i class="fas fa-clock me-2 text-primary"></i>Last Login:</strong>
                            </div>
                            <div class="col-sm-8">
                                <fmt:formatDate value="${sessionScope.user.lastLogin}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Account Statistics -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Account Activity</h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-md-3">
                            <div class="p-3">
                                <i class="fas fa-book-reader fa-3x text-primary mb-2"></i>
                                <h4 class="mb-0">0</h4>
                                <small class="text-muted">Active Borrowings</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="p-3">
                                <i class="fas fa-history fa-3x text-success mb-2"></i>
                                <h4 class="mb-0">0</h4>
                                <small class="text-muted">Total Borrowed</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="p-3">
                                <i class="fas fa-calendar-check fa-3x text-info mb-2"></i>
                                <h4 class="mb-0">0</h4>
                                <small class="text-muted">Event Registrations</small>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="p-3">
                                <i class="fas fa-star fa-3x text-warning mb-2"></i>
                                <h4 class="mb-0">0</h4>
                                <small class="text-muted">Days Member</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
