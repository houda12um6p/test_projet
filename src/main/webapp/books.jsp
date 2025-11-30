<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Books - UM6P Learning Center" />
    <jsp:param name="active" value="books" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="mb-8">
        <h1 style="font-size: 40px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-3);">
            <i class="fas fa-book" style="margin-right: var(--space-3); color: var(--orange-primary);"></i>
            Book Library
        </h1>
        <p style="font-size: 18px; color: var(--gray-600);">Browse and borrow from our extensive collection</p>
    </div>

    <!-- Search Bar -->
    <div class="mb-8">
        <div class="card">
            <div class="card-body" style="padding: var(--space-8);">
                <form action="${pageContext.request.contextPath}/books/search" method="get">
                    <div class="grid grid-cols-4 gap-4">
                        <div>
                            <select name="searchType" class="form-select">
                                <option value="title" ${searchType == 'title' ? 'selected' : ''}>Title</option>
                                <option value="author" ${searchType == 'author' ? 'selected' : ''}>Author</option>
                                <option value="genre" ${searchType == 'genre' ? 'selected' : ''}>Genre</option>
                            </select>
                        </div>
                        <div class="col-span-2">
                            <input type="text" name="query" class="form-input"
                                   placeholder="Search books..." value="${searchQuery}" required>
                        </div>
                        <div>
                            <button type="submit" class="btn btn-primary btn-block">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                    <c:if test="${not empty searchQuery}">
                        <div style="margin-top: var(--space-4); display: flex; align-items: center; gap: var(--space-3);">
                            <span style="color: var(--gray-600); font-size: 14px;">Showing results for: <strong>${searchQuery}</strong></span>
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-sm btn-outline-primary">
                                Clear Search
                            </a>
                        </div>
                    </c:if>
                </form>
            </div>
        </div>
    </div>

    <!-- Staff Actions -->
    <c:if test="${sessionScope.user.role == 'STAFF'}">
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/books/add" class="btn btn-success btn-lg">
                <i class="fas fa-plus"></i> Add New Book
            </a>
        </div>
    </c:if>

    <!-- Books Grid -->
    <div class="grid grid-cols-3 gap-6">
        <c:choose>
            <c:when test="${not empty books}">
                <c:forEach var="book" items="${books}">
                    <div>
                        <div class="card card-hover" style="height: 100%;">
                            <div class="card-body" style="display: flex; flex-direction: column;">
                                <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--space-4);">
                                    <h3 style="font-size: 18px; font-weight: 700; color: var(--gray-900); margin: 0; flex: 1;">${book.title}</h3>
                                    <c:choose>
                                        <c:when test="${book.status == 'available' && book.availableCopies > 0}">
                                            <span class="badge badge-success">Available</span>
                                        </c:when>
                                        <c:when test="${book.status == 'maintenance'}">
                                            <span class="badge badge-warning">Maintenance</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-danger">Unavailable</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div style="margin-bottom: var(--space-3); color: var(--gray-600); font-size: 14px;">
                                    <div style="display: flex; align-items: center; gap: var(--space-2); margin-bottom: var(--space-2);">
                                        <i class="fas fa-user"></i>
                                        <span><strong>Author:</strong> ${book.author}</span>
                                    </div>
                                    <div style="display: flex; align-items: center; gap: var(--space-2); margin-bottom: var(--space-2);">
                                        <i class="fas fa-tag"></i>
                                        <span><strong>Genre:</strong> ${book.genre}</span>
                                    </div>
                                    <c:if test="${not empty book.isbn}">
                                        <div style="display: flex; align-items: center; gap: var(--space-2); margin-bottom: var(--space-2);">
                                            <i class="fas fa-barcode"></i>
                                            <span><strong>ISBN:</strong> ${book.isbn}</span>
                                        </div>
                                    </c:if>
                                    <div style="display: flex; align-items: center; gap: var(--space-2);">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span><strong>Location:</strong> ${book.location}</span>
                                    </div>
                                </div>

                                <div style="margin-bottom: var(--space-4);">
                                    <c:set var="percentage" value="${(book.availableCopies * 100) / book.totalCopies}" />
                                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: var(--space-2);">
                                        <span style="font-size: 12px; font-weight: 600; color: var(--gray-700); text-transform: uppercase;">Availability</span>
                                        <span style="font-size: 14px; font-weight: 600; color: var(--gray-900);">${book.availableCopies} / ${book.totalCopies}</span>
                                    </div>
                                    <div class="progress" style="height: 8px;">
                                        <div class="progress-bar ${percentage > 50 ? 'progress-bar-success' : percentage > 20 ? 'progress-bar-warning' : 'progress-bar-danger'}"
                                             style="width: ${percentage}%">
                                        </div>
                                    </div>
                                </div>

                                <div style="margin-top: auto; display: flex; flex-direction: column; gap: var(--space-3);">
                                    <c:choose>
                                        <c:when test="${book.availableCopies > 0 && book.status == 'available'}">
                                            <form action="${pageContext.request.contextPath}/borrowings/borrow" method="post">
                                                <input type="hidden" name="bookId" value="${book.id}">
                                                <button type="submit" class="btn btn-primary btn-block">
                                                    <i class="fas fa-bookmark"></i> Borrow Book
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/reservations/reserve" method="post">
                                                <input type="hidden" name="bookId" value="${book.id}">
                                                <button type="submit" class="btn btn-warning btn-block">
                                                    <i class="fas fa-clock"></i> Reserve Book
                                                </button>
                                            </form>
                                            <p style="font-size: 12px; color: var(--gray-600); text-align: center; margin: 0;">All copies currently borrowed</p>
                                        </c:otherwise>
                                    </c:choose>

                                    <c:if test="${sessionScope.user.role == 'STAFF'}">
                                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-2);">
                                            <a href="${pageContext.request.contextPath}/books/edit/${book.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/books/delete/${book.id}" method="post" style="margin: 0;" onsubmit="return confirm('Are you sure you want to delete this book?');">
                                                <button type="submit" class="btn btn-sm btn-danger btn-block">
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
                <div style="grid-column: 1 / -1;">
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-book-open"></i>
                        </div>
                        <h3 class="empty-state-title">No books found</h3>
                        <p class="empty-state-description">Try a different search or browse all books</p>
                        <c:if test="${not empty searchQuery}">
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">
                                View All Books
                            </a>
                        </c:if>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
