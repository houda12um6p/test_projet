<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="title" value="Events - UM6P Learning Center" />
    <jsp:param name="active" value="events" />
</jsp:include>

<div class="container">
    <!-- Page Header -->
    <div class="mb-8">
        <h1 style="font-size: 40px; font-weight: 800; color: var(--gray-900); margin-bottom: var(--space-3);">
            <i class="fas fa-calendar-alt" style="margin-right: var(--space-3); color: var(--orange-primary);"></i>
            Events & Workshops
        </h1>
        <p style="font-size: 18px; color: var(--gray-600);">Register for upcoming seminars, workshops, and training sessions</p>
    </div>

    <!-- Filter and Actions -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: var(--space-8); flex-wrap: wrap; gap: var(--space-4);">
        <div style="display: flex; gap: var(--space-2);">
            <a href="${pageContext.request.contextPath}/events" class="btn btn-outline-primary">
                <i class="fas fa-list"></i> All Events
            </a>
            <a href="${pageContext.request.contextPath}/events/upcoming" class="btn btn-outline-primary">
                <i class="fas fa-clock"></i> Upcoming
            </a>
            <a href="${pageContext.request.contextPath}/events/my-registrations" class="btn btn-outline-primary">
                <i class="fas fa-user-check"></i> My Registrations
            </a>
        </div>
        <c:if test="${sessionScope.user.role == 'STAFF'}">
            <a href="${pageContext.request.contextPath}/events/add" class="btn btn-success">
                <i class="fas fa-plus"></i> Create Event
            </a>
        </c:if>
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

    <!-- Events List -->
    <div class="grid grid-cols-2 gap-6">
        <c:choose>
            <c:when test="${not empty events}">
                <c:forEach var="event" items="${events}">
                    <div class="card card-hover" style="display: flex; flex-direction: column;">
                        <div class="card-body" style="display: flex; flex-direction: column; flex: 1;">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: var(--space-4);">
                                <h3 style="font-size: 20px; font-weight: 700; color: var(--gray-900); margin: 0; flex: 1;">${event.title}</h3>
                                <c:choose>
                                    <c:when test="${event.status == 'active'}">
                                        <span class="badge badge-success">Active</span>
                                    </c:when>
                                    <c:when test="${event.status == 'cancelled'}">
                                        <span class="badge badge-danger">Cancelled</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-gray">Completed</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <p style="color: var(--gray-600); margin-bottom: var(--space-4); line-height: 1.6;">${event.description}</p>

                            <div style="margin-bottom: var(--space-4); color: var(--gray-700); font-size: 14px;">
                                <div style="display: flex; align-items: center; gap: var(--space-2); margin-bottom: var(--space-2);">
                                    <i class="fas fa-calendar" style="color: var(--orange-primary);"></i>
                                    <span><strong>Date:</strong> ${event.eventDate}</span>
                                </div>
                                <div style="display: flex; align-items: center; gap: var(--space-2); margin-bottom: var(--space-2);">
                                    <i class="fas fa-map-marker-alt" style="color: var(--error);"></i>
                                    <span><strong>Location:</strong> ${event.location}</span>
                                </div>
                                <div style="display: flex; align-items: center; gap: var(--space-2);">
                                    <i class="fas fa-tag" style="color: var(--success);"></i>
                                    <span><strong>Category:</strong> <span class="badge badge-gray">${event.category}</span></span>
                                </div>
                            </div>

                            <div style="margin-bottom: var(--space-4);">
                                <c:set var="percentage" value="${(event.currentAttendees * 100) / event.capacity}" />
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: var(--space-2);">
                                    <span style="font-size: 12px; font-weight: 600; color: var(--gray-700); text-transform: uppercase;">Capacity</span>
                                    <span style="font-size: 14px; font-weight: 600; color: var(--gray-900);">${event.currentAttendees} / ${event.capacity}</span>
                                </div>
                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar ${percentage >= 90 ? 'progress-bar-danger' : percentage >= 70 ? 'progress-bar-warning' : 'progress-bar-success'}"
                                         style="width: ${percentage}%">
                                    </div>
                                </div>
                                <c:if test="${event.currentAttendees >= event.capacity}">
                                    <p style="font-size: 12px; color: var(--error); margin-top: var(--space-2); margin-bottom: 0;">
                                        <i class="fas fa-exclamation-triangle"></i> Event is full
                                    </p>
                                </c:if>
                                <c:if test="${event.currentAttendees < event.capacity}">
                                    <p style="font-size: 12px; color: var(--success); margin-top: var(--space-2); margin-bottom: 0;">
                                        <i class="fas fa-check-circle"></i> ${event.capacity - event.currentAttendees} spots available
                                    </p>
                                </c:if>
                            </div>

                            <div style="margin-top: auto; display: flex; flex-direction: column; gap: var(--space-3);">
                                <c:choose>
                                    <c:when test="${event.status == 'active' && event.currentAttendees < event.capacity}">
                                        <form action="${pageContext.request.contextPath}/events/register" method="post">
                                            <input type="hidden" name="eventId" value="${event.id}">
                                            <button type="submit" class="btn btn-primary btn-block">
                                                <i class="fas fa-calendar-check"></i> Register for Event
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:when test="${event.currentAttendees >= event.capacity}">
                                        <button class="btn btn-block" style="background-color: var(--gray-300); color: var(--gray-700); cursor: not-allowed;" disabled>
                                            <i class="fas fa-times"></i> Event Full
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-block" style="background-color: var(--gray-300); color: var(--gray-700); cursor: not-allowed;" disabled>
                                            <i class="fas fa-ban"></i> ${event.status == 'cancelled' ? 'Cancelled' : 'Completed'}
                                        </button>
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${sessionScope.user.role == 'STAFF'}">
                                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-2);">
                                        <a href="${pageContext.request.contextPath}/events/edit/${event.id}" class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <form action="${pageContext.request.contextPath}/events/delete/${event.id}" method="post" style="margin: 0;" onsubmit="return confirm('Are you sure you want to delete this event?');">
                                            <button type="submit" class="btn btn-sm btn-danger btn-block">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </form>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="grid-column: 1 / -1;">
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-calendar-times"></i>
                        </div>
                        <h3 class="empty-state-title">No events found</h3>
                        <p class="empty-state-description">Check back later for upcoming events</p>
                        <c:if test="${sessionScope.user.role == 'STAFF'}">
                            <a href="${pageContext.request.contextPath}/events/add" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Create New Event
                            </a>
                        </c:if>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
