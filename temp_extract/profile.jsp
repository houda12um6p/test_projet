<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Profile - UM6P Learning Center" />
    <jsp:param name="active" value="profile" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="mb-8">
        <h1 style="font-size: 40px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-3);">
            <i class="fas fa-user-circle" style="margin-right: var(--space-3); color: var(--orange-primary);"></i>
            My Profile
        </h1>
        <p style="font-size: 18px; color: var(--gray-600);">View and manage your account information</p>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <span>${success}</span>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <div class="grid grid-cols-3 gap-6">
        <!-- Profile Card -->
        <div>
            <div class="card">
                <div class="card-body" style="text-align: center; padding: var(--space-8);">
                    <div style="margin-bottom: var(--space-6);">
                        <i class="fas fa-user-circle" style="font-size: 96px; color: var(--orange-primary);"></i>
                    </div>
                    <h4 style="font-size: 24px; font-weight: 700; color: var(--gray-900); margin-bottom: var(--space-2);">${sessionScope.user.name}</h4>
                    <p style="color: var(--gray-600); margin-bottom: var(--space-4);">${sessionScope.user.email}</p>
                    <span class="badge badge-${sessionScope.user.role == 'STAFF' ? 'success' : 'primary'}" style="font-size: 16px; padding: var(--space-2) var(--space-4);">
                        <i class="fas ${sessionScope.user.role == 'STAFF' ? 'fa-briefcase' : 'fa-graduation-cap'}"></i>
                        ${sessionScope.user.role}
                    </span>

                    <hr style="margin: var(--space-6) 0; border-color: var(--gray-300);">

                    <div style="display: flex; flex-direction: column; gap: var(--space-3);">
                        <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-primary btn-block">
                            <i class="fas fa-edit"></i> Edit Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/profile/change-password" class="btn btn-outline-primary btn-block">
                            <i class="fas fa-key"></i> Change Password
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Profile Details -->
        <div style="grid-column: span 2;">
            <div class="card" style="margin-bottom: var(--space-6);">
                <div class="card-header">
                    <h5 style="margin: 0; font-size: 18px; font-weight: 700;">
                        <i class="fas fa-info-circle" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                        Profile Information
                    </h5>
                </div>
                <div class="card-body">
                    <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4); margin-bottom: var(--space-4); padding-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                        <strong style="color: var(--gray-700);">
                            <i class="fas fa-user" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                            Full Name:
                        </strong>
                        <span style="color: var(--gray-900);">${sessionScope.user.name}</span>
                    </div>

                    <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4); margin-bottom: var(--space-4); padding-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                        <strong style="color: var(--gray-700);">
                            <i class="fas fa-envelope" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                            Email:
                        </strong>
                        <span style="color: var(--gray-900);">${sessionScope.user.email}</span>
                    </div>

                    <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4);">
                        <strong style="color: var(--gray-700);">
                            <i class="fas fa-user-tag" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                            Role:
                        </strong>
                        <span style="color: var(--gray-900);">${sessionScope.user.role}</span>
                    </div>

                    <c:if test="${not empty student}">
                        <hr style="margin: var(--space-6) 0;">
                        <h6 style="font-size: 16px; font-weight: 700; color: var(--orange-primary); margin-bottom: var(--space-4);">
                            <i class="fas fa-graduation-cap"></i> Student Information
                        </h6>

                        <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4); margin-bottom: var(--space-4); padding-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                            <strong style="color: var(--gray-700);">
                                <i class="fas fa-id-card" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                                Student ID:
                            </strong>
                            <span style="color: var(--gray-900);">${student.studentIdNumber}</span>
                        </div>

                        <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4); margin-bottom: var(--space-4); padding-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                            <strong style="color: var(--gray-700);">
                                <i class="fas fa-book-open" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                                Major:
                            </strong>
                            <span style="color: var(--gray-900);">${student.major}</span>
                        </div>

                        <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4);">
                            <strong style="color: var(--gray-700);">
                                <i class="fas fa-phone" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                                Phone:
                            </strong>
                            <span style="color: var(--gray-900);">${student.phone}</span>
                        </div>
                    </c:if>

                    <c:if test="${not empty staff}">
                        <hr style="margin: var(--space-6) 0;">
                        <h6 style="font-size: 16px; font-weight: 700; color: var(--orange-primary); margin-bottom: var(--space-4);">
                            <i class="fas fa-briefcase"></i> Staff Information
                        </h6>

                        <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4); margin-bottom: var(--space-4); padding-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                            <strong style="color: var(--gray-700);">
                                <i class="fas fa-building" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                                Department:
                            </strong>
                            <span style="color: var(--gray-900);">${staff.department}</span>
                        </div>

                        <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4); margin-bottom: var(--space-4); padding-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                            <strong style="color: var(--gray-700);">
                                <i class="fas fa-user-tie" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                                Position:
                            </strong>
                            <span style="color: var(--gray-900);">${staff.position}</span>
                        </div>

                        <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4); margin-bottom: var(--space-4); padding-bottom: var(--space-4); border-bottom: 1px solid var(--gray-200);">
                            <strong style="color: var(--gray-700);">
                                <i class="fas fa-map-marker-alt" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                                Office:
                            </strong>
                            <span style="color: var(--gray-900);">${staff.officeLocation}</span>
                        </div>

                        <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4);">
                            <strong style="color: var(--gray-700);">
                                <i class="fas fa-phone" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                                Phone:
                            </strong>
                            <span style="color: var(--gray-900);">${staff.phone}</span>
                        </div>
                    </c:if>

                    <c:if test="${sessionScope.user.lastLogin != null}">
                        <hr style="margin: var(--space-6) 0;">
                        <div style="display: grid; grid-template-columns: 200px 1fr; gap: var(--space-4);">
                            <strong style="color: var(--gray-700);">
                                <i class="fas fa-clock" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                                Last Login:
                            </strong>
                            <span style="color: var(--gray-900);">
                                <fmt:formatDate value="${sessionScope.user.lastLogin}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </span>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Account Statistics -->
            <div class="card">
                <div class="card-header">
                    <h5 style="margin: 0; font-size: 18px; font-weight: 700;">
                        <i class="fas fa-chart-bar" style="color: var(--orange-primary); margin-right: var(--space-2);"></i>
                        Account Activity
                    </h5>
                </div>
                <div class="card-body">
                    <div class="grid grid-cols-4 gap-6">
                        <div style="text-align: center; padding: var(--space-4);">
                            <i class="fas fa-book-reader" style="font-size: 48px; color: var(--orange-primary); margin-bottom: var(--space-3); display: block;"></i>
                            <h4 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h4>
                            <small style="color: var(--gray-600);">Active Borrowings</small>
                        </div>
                        <div style="text-align: center; padding: var(--space-4);">
                            <i class="fas fa-history" style="font-size: 48px; color: var(--success); margin-bottom: var(--space-3); display: block;"></i>
                            <h4 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h4>
                            <small style="color: var(--gray-600);">Total Borrowed</small>
                        </div>
                        <div style="text-align: center; padding: var(--space-4);">
                            <i class="fas fa-calendar-check" style="font-size: 48px; color: var(--info); margin-bottom: var(--space-3); display: block;"></i>
                            <h4 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h4>
                            <small style="color: var(--gray-600);">Event Registrations</small>
                        </div>
                        <div style="text-align: center; padding: var(--space-4);">
                            <i class="fas fa-star" style="font-size: 48px; color: var(--warning); margin-bottom: var(--space-3); display: block;"></i>
                            <h4 style="font-size: 32px; font-weight: 800; margin-bottom: var(--space-1);">0</h4>
                            <small style="color: var(--gray-600);">Days Member</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
