package com.um6p.controller;

import com.um6p.dao.EventDAO;
import com.um6p.dao.RegistrationDAO;
import com.um6p.model.Event;
import com.um6p.model.Registration;
import com.um6p.model.User;
import com.um6p.model.Registration.RegistrationStatus;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;

@WebServlet("/events/*")
public class EventController extends HttpServlet {

    private EventDAO eventDAO;
    private RegistrationDAO registrationDAO;
    private static final DateTimeFormatter EVENT_DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
    private static final DateTimeFormatter DISPLAY_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        registrationDAO = new RegistrationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            listEvents(request, response);
        } else if (pathInfo.equals("/upcoming")) {
            listUpcomingEvents(request, response);
        } else if (pathInfo.startsWith("/view/")) {
            viewEvent(request, response);
        } else if (pathInfo.equals("/add")) {
            request.getRequestDispatcher("/staff/addEvent.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            editEventForm(request, response);
        } else if (pathInfo.equals("/my-registrations")) {
            listMyRegistrations(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } else if (pathInfo.equals("/add")) {
            addEvent(request, response);
        } else if (pathInfo.startsWith("/update/")) {
            updateEvent(request, response);
        } else if (pathInfo.startsWith("/delete/")) {
            deleteEvent(request, response);
        } else if (pathInfo.equals("/register")) {
            registerForEvent(request, response);
        } else if (pathInfo.startsWith("/cancel/")) {
            cancelRegistration(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listEvents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Event> events = eventDAO.getAllEvents();
        request.setAttribute("events", events);
        request.getRequestDispatcher("/events.jsp").forward(request, response);
    }

    private void listUpcomingEvents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Event> events = eventDAO.getEventsByStatus("active");
        request.setAttribute("events", events);
        request.setAttribute("upcomingView", true);
        request.getRequestDispatcher("/events.jsp").forward(request, response);
    }

    private void viewEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int eventId = Integer.parseInt(pathInfo.substring(6));

        Event event = eventDAO.getEventById(eventId);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (event != null) {
            boolean isRegistered = false;
            if (user != null) {
                isRegistered = registrationDAO.isUserRegistered(user.getId(), eventId);
            }
            boolean hasCapacity = eventDAO.hasCapacity(eventId);

            // FIX FOR LINE 117: Use proper String formatting
            String formattedDate = event.getEventDate(); // Already a String from database
            request.setAttribute("formattedEventDate", formattedDate);

            request.setAttribute("event", event);
            request.setAttribute("isRegistered", isRegistered);
            request.setAttribute("hasCapacity", hasCapacity);
            request.getRequestDispatcher("/eventDetails.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
        }
    }

    private void addEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"STAFF".equals(user.getRole().name())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String eventDateStr = request.getParameter("eventDate");
        String location = request.getParameter("location");
        String category = request.getParameter("category");

        int capacity = 0;

        try {
            capacity = Integer.parseInt(request.getParameter("capacity"));
            // FIX FOR LINE 165: Just use the String directly since Event expects String
            // No need to parse to LocalDateTime if Event model stores dates as String
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid capacity value. Must be a number.");
            request.getRequestDispatcher("/staff/addEvent.jsp").forward(request, response);
            return;
        }

        Event event = new Event();
        event.setTitle(title);
        event.setDescription(description);
        // FIX: Use the date string directly (Event expects String)
        event.setEventDate(eventDateStr);
        event.setLocation(location);
        event.setCapacity(capacity);
        event.setCategory(category);
        event.setStatus("active");
        event.setCreatedBy(user.getId());

        boolean created = eventDAO.createEvent(event);

        if (created) {
            response.sendRedirect(request.getContextPath() + "/events?success=Event added successfully");
        } else {
            request.setAttribute("error", "Failed to add event. Please try again.");
            request.getRequestDispatcher("/staff/addEvent.jsp").forward(request, response);
        }
    }

    private void editEventForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int eventId = Integer.parseInt(pathInfo.substring(6));

        Event event = eventDAO.getEventById(eventId);

        if (event != null) {
            // FIX FOR LINE 192: Just use the existing date string
            String formattedDate = event.getEventDate(); // Already a String
            request.setAttribute("formattedEventDate", formattedDate);

            request.setAttribute("event", event);
            request.getRequestDispatcher("/staff/editEvent.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
        }
    }

    private void updateEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int eventId = Integer.parseInt(pathInfo.substring(8));

        Event event = eventDAO.getEventById(eventId);

        if (event == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
            return;
        }

        String eventDateStr = request.getParameter("eventDate");

        try {
            event.setCapacity(Integer.parseInt(request.getParameter("capacity")));
            // FIX FOR LINE 220: Use the date string directly
            event.setEventDate(eventDateStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid capacity value. Must be a number.");
            request.setAttribute("event", event);
            request.getRequestDispatcher("/staff/editEvent.jsp").forward(request, response);
            return;
        }

        event.setTitle(request.getParameter("title"));
        event.setDescription(request.getParameter("description"));
        event.setLocation(request.getParameter("location"));
        event.setCategory(request.getParameter("category"));
        event.setStatus(request.getParameter("status"));

        boolean updated = eventDAO.updateEvent(event);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/events?success=Event updated successfully");
        } else {
            request.setAttribute("error", "Failed to update event.");
            request.setAttribute("event", event);
            request.getRequestDispatcher("/staff/editEvent.jsp").forward(request, response);
        }
    }

    private void deleteEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int eventId = Integer.parseInt(pathInfo.substring(8));

        boolean deleted = eventDAO.deleteEvent(eventId);

        if (deleted) {
            response.sendRedirect(request.getContextPath() + "/events?success=Event deleted successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/events?error=Failed to delete event");
        }
    }

    private void registerForEvent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int eventId = 0;
        try {
            eventId = Integer.parseInt(request.getParameter("eventId"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID");
            return;
        }

        if (!eventDAO.hasCapacity(eventId)) {
            response.sendRedirect(request.getContextPath() + "/events/view/" + eventId + "?error=Event is full");
            return;
        }

        if (registrationDAO.isUserRegistered(user.getId(), eventId)) {
            response.sendRedirect(request.getContextPath() + "/events/view/" + eventId + "?error=Already registered");
            return;
        }

        Registration registration = new Registration();
        registration.setUserId(user.getId());
        registration.setEventId(eventId);
        registration.setRegistrationDate(LocalDateTime.now());
        registration.setStatus(RegistrationStatus.CONFIRMED);

        boolean registered = registrationDAO.createRegistration(registration);

        if (registered) {
            eventDAO.incrementAttendees(eventId);
            response.sendRedirect(request.getContextPath() + "/events/my-registrations?success=Registered successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/events/view/" + eventId + "?error=Registration failed");
        }
    }

    private void cancelRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int registrationId = 0;
        try {
            registrationId = Integer.parseInt(pathInfo.substring(8));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid registration ID format");
            return;
        }

        boolean cancelled = registrationDAO.cancelRegistration(registrationId);

        if (cancelled) {
            response.sendRedirect(request.getContextPath() + "/events/my-registrations?success=Registration cancelled");
        } else {
            response.sendRedirect(request.getContextPath() + "/events/my-registrations?error=Cancellation failed");
        }
    }

    private void listMyRegistrations(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Registration> registrations = registrationDAO.getRegistrationsByUser(user.getId());
        request.setAttribute("registrations", registrations);
        request.getRequestDispatcher("/student/myRegistrations.jsp").forward(request, response);
    }
}