<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Books - UM6P Learning Center" />
    <jsp:param name="active" value="books" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="display-4"><i class="fas fa-book me-3"></i>Book Library</h1>
            <p class="lead text-muted">Browse and borrow from our extensive collection</p>
        </div>
    </div>

    <!-- Search Bar -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/books/search" method="get" class="row g-3">
                        <div class="col-md-3">
                            <select name="searchType" class="form-select">
                                <option value="title" ${searchType == 'title' ? 'selected' : ''}>Title</option>
                                <option value="author" ${searchType == 'author' ? 'selected' : ''}>Author</option>
                                <option value="genre" ${searchType == 'genre' ? 'selected' : ''}>Genre</option>
                            </select>
                        </div>
                        <div class="col-md-7">
                            <input type="text" name="query" class="form-control"
                                   placeholder="Search books..." value="${searchQuery}" required>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-2"></i>Search
                            </button>
                        </div>
                    </form>
                    <c:if test="${not empty searchQuery}">
                        <div class="mt-3">
                            <small class="text-muted">Showing results for: <strong>${searchQuery}</strong></small>
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-sm btn-outline-secondary ms-2">
                                Clear Search
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Staff Actions -->
    <c:if test="${sessionScope.user.role == 'STAFF'}">
        <div class="row mb-4">
            <div class="col-12">
                <a href="${pageContext.request.contextPath}/books/add" class="btn btn-success">
                    <i class="fas fa-plus me-2"></i>Add New Book
                </a>
            </div>
        </div>
    </c:if>

    <!-- Books Grid -->
    <div class="row">
        <c:choose>
            <c:when test="${not empty books}">
                <c:forEach var="book" items="${books}">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 border-0 shadow-sm">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <h5 class="card-title mb-0">${book.title}</h5>
                                    <c:choose>
                                        <c:when test="${book.status == 'available' && book.availableCopies > 0}">
                                            <span class="badge bg-success">Available</span>
                                        </c:when>
                                        <c:when test="${book.status == 'maintenance'}">
                                            <span class="badge bg-warning">Maintenance</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">Unavailable</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <p class="text-muted mb-2">
                                    <i class="fas fa-user me-2"></i><strong>Author:</strong> ${book.author}
                                </p>

                                <p class="text-muted mb-2">
                                    <i class="fas fa-tag me-2"></i><strong>Genre:</strong> ${book.genre}
                                </p>

                                <c:if test="${not empty book.isbn}">
                                    <p class="text-muted mb-2">
                                        <i class="fas fa-barcode me-2"></i><strong>ISBN:</strong> ${book.isbn}
                                    </p>
                                </c:if>

                                <p class="text-muted mb-2">
                                    <i class="fas fa-map-marker-alt me-2"></i><strong>Location:</strong> ${book.location}
                                </p>

                                <div class="progress mb-3" style="height: 25px;">
                                    <c:set var="percentage" value="${(book.availableCopies * 100) / book.totalCopies}" />
                                    <div class="progress-bar ${percentage > 50 ? 'bg-success' : percentage > 20 ? 'bg-warning' : 'bg-danger'}"
                                         style="width: ${percentage}%">
                                        ${book.availableCopies} / ${book.totalCopies} available
                                    </div>
                                </div>

                                <div class="d-grid gap-2">
                                    <c:choose>
                                        <c:when test="${book.availableCopies > 0 && book.status == 'available'}">
                                            <form action="${pageContext.request.contextPath}/borrowings/borrow" method="post">
                                                <input type="hidden" name="bookId" value="${book.id}">
                                                <button type="submit" class="btn btn-primary w-100">
                                                    <i class="fas fa-bookmark me-2"></i>Borrow Book
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/reservations/reserve" method="post">
                                                <input type="hidden" name="bookId" value="${book.id}">
                                                <button type="submit" class="btn btn-warning w-100">
                                                    <i class="fas fa-clock me-2"></i>Reserve Book
                                                </button>
                                            </form>
                                            <small class="text-muted text-center d-block mt-1">All copies currently borrowed</small>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:if test="${sessionScope.user.role == 'STAFF'}">
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/books/edit/${book.id}"
                                               class="btn btn-sm btn-outline-warning">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/books/delete/${book.id}"
                                                  method="post" class="d-inline"
                                                  onsubmit="return confirm('Are you sure you want to delete this book?');">
                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                    <i class="fas fa-trash"></i> Delete
                                                </button>
                                            </form>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body text-center py-5">
                            <i class="fas fa-book-open fa-4x text-muted mb-3 d-block"></i>
                            <h4 class="text-muted">No books found</h4>
                            <p class="text-muted">Try a different search or browse all books</p>
                            <c:if test="${not empty searchQuery}">
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                                    View All Books
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
