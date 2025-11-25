package com.um6p.model;

public class Event {
    // Status constants for better maintainability
    public static final String STATUS_ACTIVE = "active";
    public static final String STATUS_CANCELLED = "cancelled";
    public static final String STATUS_COMPLETED = "completed";

    // Category constants (common event types)
    public static final String CATEGORY_WORKSHOP = "workshop";
    public static final String CATEGORY_SEMINAR = "seminar";
    public static final String CATEGORY_TRAINING = "training";
    public static final String CATEGORY_SESSION = "session";

    private int id;
    private String title;
    private String description;
    private String eventDate;
    private String location;
    private int capacity;
    private int currentAttendees;
    private String category;
    private String status;
    private int createdBy;
    private String createdDate;

    // Default Constructor
    public Event() {
    }

    // Parameterized Constructor for existing events
    public Event(int id, String title, String description, String eventDate,
                 String location, int capacity, String category, String status, int createdBy) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.eventDate = eventDate;
        this.location = location;
        this.capacity = capacity;
        this.category = category;
        this.status = status;
        this.createdBy = createdBy;
    }

    // Constructor for creating new events
    public Event(String title, String description, String eventDate,
                 String location, int capacity, String category, int createdBy) {
        this.title = title;
        this.description = description;
        this.eventDate = eventDate;
        this.location = location;
        this.capacity = capacity;
        this.currentAttendees = 0; // New events start with 0 attendees
        this.category = category;
        this.status = STATUS_ACTIVE; // New events are active by default
        this.createdBy = createdBy;
    }

    // Getters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getEventDate() { return eventDate; }
    public String getLocation() { return location; }
    public int getCapacity() { return capacity; }
    public int getCurrentAttendees() { return currentAttendees; }
    public String getCategory() { return category; }
    public String getStatus() { return status; }
    public int getCreatedBy() { return createdBy; }
    public String getCreatedDate() { return createdDate; }

    // Setters with validation
    public void setId(int id) { this.id = id; }

    public void setTitle(String title) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Event title cannot be null or empty");
        }
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setCapacity(int capacity) {
        if (capacity < 1) {
            throw new IllegalArgumentException("Event capacity must be at least 1");
        }
        this.capacity = capacity;
    }

    public void setCurrentAttendees(int currentAttendees) {
        if (currentAttendees < 0) {
            throw new IllegalArgumentException("Current attendees cannot be negative");
        }
        if (currentAttendees > capacity) {
            throw new IllegalArgumentException("Current attendees cannot exceed capacity");
        }
        this.currentAttendees = currentAttendees;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setStatus(String status) {
        if (!isValidStatus(status)) {
            throw new IllegalArgumentException("Invalid event status: " + status);
        }
        this.status = status;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    // Business logic methods
    public boolean hasCapacity() {
        return currentAttendees < capacity;
    }

    public int getAvailableSpots() {
        return capacity - currentAttendees;
    }

    public boolean isFull() {
        return currentAttendees >= capacity;
    }

    public boolean canRegister() {
        return STATUS_ACTIVE.equals(status) && hasCapacity();
    }

    public void addAttendee() {
        if (hasCapacity()) {
            currentAttendees++;
        }
    }

    public void removeAttendee() {
        if (currentAttendees > 0) {
            currentAttendees--;
        }
    }

    public double getAttendancePercentage() {
        if (capacity == 0) return 0.0;
        return (currentAttendees * 100.0) / capacity;
    }

    // Validation helper
    private boolean isValidStatus(String status) {
        return STATUS_ACTIVE.equals(status) ||
                STATUS_CANCELLED.equals(status) ||
                STATUS_COMPLETED.equals(status);
    }

    @Override
    public String toString() {
        return "Event{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", eventDate='" + eventDate + '\'' +
                ", capacity=" + capacity +
                ", currentAttendees=" + currentAttendees +
                ", status='" + status + '\'' +
                '}';
    }

    // Equals and hashCode for proper object comparison
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Event event = (Event) o;
        return id == event.id;
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(id);
    }
}