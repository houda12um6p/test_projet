<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="My Borrowings - UM6P Learning Center" />
    <jsp:param name="active" value="borrowings" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="display-4"><i class="fas fa-book-reader me-3"></i>My Borrowings</h1>
            <p class="lead text-muted">Track your borrowed books and borrowing history</p>
        </div>
    </div>

    <!-- Filter Tabs -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/borrowings" class="btn btn-outline-primary">
                    <i class="fas fa-list me-2"></i>All Borrowings
                </a>
                <a href="${pageContext.request.contextPath}/borrowings/active" class="btn btn-outline-success">
                    <i class="fas fa-book-reader me-2"></i>Active
                </a>
                <a href="${pageContext.request.contextPath}/borrowings/history" class="btn btn-outline-secondary">
                    <i class="fas fa-history me-2"></i>History
                </a>
                <c:if test="${sessionScope.user.role == 'STAFF'}">
                    <a href="${pageContext.request.contextPath}/borrowings/overdue" class="btn btn-outline-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>Overdue
                    </a>
                    <a href="${pageContext.request.contextPath}/borrowings/all" class="btn btn-outline-info">
                        <i class="fas fa-globe me-2"></i>All Users
                    </a>
                </c:if>
            </div>
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

    <!-- Summary Cards -->
    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="fas fa-book-reader fa-3x text-primary mb-3"></i>
                    <h3 class="mb-0">${not empty borrowings ? borrowings.size() : 0}</h3>
                    <small class="text-muted">Total Borrowings</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                    <h3 class="mb-0">0</h3>
                    <small class="text-muted">Active Loans</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="fas fa-undo fa-3x text-info mb-3"></i>
                    <h3 class="mb-0">0</h3>
                    <small class="text-muted">Returned</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center">
                    <i class="fas fa-exclamation-triangle fa-3x text-danger mb-3"></i>
                    <h3 class="mb-0">0</h3>
                    <small class="text-muted">Overdue</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Borrowings List -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0"><i class="fas fa-list me-2"></i>Borrowing Records</h5>
                </div>
                <div class="card-body p-0">
                    <c:choose>
                        <c:when test="${not empty borrowings}">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Book Title</th>
                                            <th>Author</th>
                                            <th>Borrow Date</th>
                                            <th>Due Date</th>
                                            <th>Return Date</th>
                                            <th>Status</th>
                                            <th>Fine</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="borrowing" items="${borrowings}">
                                            <tr>
                                                <td>
                                                    <strong>${borrowing.book.title}</strong>
                                                </td>
                                                <td>${borrowing.book.author}</td>
                                                <td>
                                                    <fmt:formatDate value="${borrowing.borrowDate}"
                                                                  pattern="yyyy-MM-dd" />
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${borrowing.dueDate}"
                                                                  pattern="yyyy-MM-dd" />
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${borrowing.returnDate != null}">
                                                            <fmt:formatDate value="${borrowing.returnDate}"
                                                                          pattern="yyyy-MM-dd" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Not returned</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${borrowing.status == 'BORROWED'}">
                                                            <span class="badge bg-success">Borrowed</span>
                                                        </c:when>
                                                        <c:when test="${borrowing.status == 'RETURNED'}">
                                                            <span class="badge bg-secondary">Returned</span>
                                                        </c:when>
                                                        <c:when test="${borrowing.status == 'OVERDUE'}">
                                                            <span class="badge bg-danger">Overdue</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${borrowing.fineAmount > 0}">
                                                            <span class="text-danger fw-bold">
                                                                ${borrowing.fineAmount} MAD
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-success">0 MAD</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${borrowing.status == 'BORROWED' || borrowing.status == 'OVERDUE'}">
                                                        <form action="${pageContext.request.contextPath}/borrowings/return/${borrowing.id}"
                                                              method="post" class="d-inline"
                                                              onsubmit="return confirm('Are you sure you want to return this book?');">
                                                            <button type="submit" class="btn btn-sm btn-primary">
                                                                <i class="fas fa-undo me-1"></i>Return
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-inbox fa-4x text-muted mb-3 d-block"></i>
                                <h4 class="text-muted">No borrowing records found</h4>
                                <p class="text-muted">You haven't borrowed any books yet</p>
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Browse Books
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Borrowing Policy Info -->
    <div class="row mt-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm bg-light">
                <div class="card-body">
                    <h6 class="mb-3"><i class="fas fa-info-circle me-2 text-primary"></i>Borrowing Policy</h6>
                    <div class="row">
                        <div class="col-md-4">
                            <p class="mb-2">
                                <i class="fas fa-check text-success me-2"></i>
                                <strong>Maximum Books:</strong> 5 books at a time
                            </p>
                        </div>
                        <div class="col-md-4">
                            <p class="mb-2">
                                <i class="fas fa-calendar text-primary me-2"></i>
                                <strong>Borrowing Period:</strong> 14 days
                            </p>
                        </div>
                        <div class="col-md-4">
                            <p class="mb-2">
                                <i class="fas fa-money-bill text-danger me-2"></i>
                                <strong>Late Fee:</strong> 5 MAD per day
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
