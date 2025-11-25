<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Staff Dashboard - UM6P Learning Center" />
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="container">
    <!-- Welcome Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <div class="card-body p-4">
                    <h2 class="card-title">Welcome, ${sessionScope.user.name}!</h2>
                    <p class="mb-0">
                        <i class="fas fa-briefcase me-2"></i>Staff Member Dashboard
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <i class="fas fa-book fa-3x text-primary"></i>
                    </div>
                    <h3 class="card-title">Total Books</h3>
                    <p class="display-6 text-primary mb-0">5000+</p>
                    <small class="text-muted">In library catalog</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <i class="fas fa-book-reader fa-3x text-warning"></i>
                    </div>
                    <h3 class="card-title">Active Loans</h3>
                    <p class="display-6 text-warning mb-0">0</p>
                    <small class="text-muted">Books currently borrowed</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <i class="fas fa-calendar-alt fa-3x text-success"></i>
                    </div>
                    <h3 class="card-title">Events</h3>
                    <p class="display-6 text-success mb-0">0</p>
                    <small class="text-muted">Active events</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body text-center">
                    <div class="mb-3">
                        <i class="fas fa-users fa-3x text-info"></i>
                    </div>
                    <h3 class="card-title">Users</h3>
                    <p class="display-6 text-info mb-0">2000+</p>
                    <small class="text-muted">Registered users</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Staff Actions -->
    <div class="row g-4 mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h4 class="mb-0"><i class="fas fa-tools me-2 text-primary"></i>Staff Management</h4>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/books/list"
                               class="btn btn-outline-primary w-100 py-3">
                                <i class="fas fa-book fa-2x mb-2 d-block"></i>
                                Manage Books
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/events/list"
                               class="btn btn-outline-success w-100 py-3">
                                <i class="fas fa-calendar-plus fa-2x mb-2 d-block"></i>
                                Manage Events
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/borrowings/list"
                               class="btn btn-outline-warning w-100 py-3">
                                <i class="fas fa-exchange-alt fa-2x mb-2 d-block"></i>
                                View Borrowings
                            </a>
                        </div>
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/profile"
                               class="btn btn-outline-info w-100 py-3">
                                <i class="fas fa-user-circle fa-2x mb-2 d-block"></i>
                                My Profile
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Activity -->
    <div class="row g-4">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-clock me-2 text-warning"></i>Recent Borrowings</h5>
                </div>
                <div class="card-body">
                    <div class="text-center text-muted py-5">
                        <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                        <p>No recent borrowing activity</p>
                        <a href="${pageContext.request.contextPath}/borrowings/list" class="btn btn-sm btn-primary">
                            View All Borrowings
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-chart-line me-2 text-success"></i>System Overview</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom">
                        <div>
                            <h6 class="mb-0">Available Books</h6>
                            <small class="text-muted">Ready for borrowing</small>
                        </div>
                        <span class="badge bg-success fs-6">4500+</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom">
                        <div>
                            <h6 class="mb-0">Overdue Returns</h6>
                            <small class="text-muted">Require attention</small>
                        </div>
                        <span class="badge bg-danger fs-6">0</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="mb-0">Upcoming Events</h6>
                            <small class="text-muted">Next 30 days</small>
                        </div>
                        <span class="badge bg-info fs-6">0</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
