package com.um6p.model;

import java.time.LocalDateTime;
import java.util.Objects;

public class Book {
    // Status constants for better maintainability
    public static final String STATUS_AVAILABLE = "available";
    public static final String STATUS_UNAVAILABLE = "unavailable";
    public static final String STATUS_MAINTENANCE = "maintenance";

    private int id;
    private String title;
    private String author;
    private String isbn;
    private String genre;
    private int totalCopies;
    private int availableCopies;
    private String location;
    private String status;
    private LocalDateTime addedDate; // CHANGED from String to LocalDateTime

    // Default Constructor
    public Book() {
    }

    // Parameterized Constructor for existing books
    public Book(int id, String title, String author, String isbn, String genre,
                int totalCopies, int availableCopies, String location, String status) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.genre = genre;
        this.totalCopies = totalCopies;
        this.availableCopies = availableCopies;
        this.location = location;
        this.status = status;
    }

    // Constructor for adding new books
    public Book(String title, String author, String isbn, String genre,
                int totalCopies, String location) {
        this.title = title;
        this.author = author;
        this.isbn = isbn;
        this.genre = genre;
        this.totalCopies = totalCopies;
        this.availableCopies = totalCopies; // New books start with all copies available
        this.location = location;
        this.status = STATUS_AVAILABLE;
    }

    // Getters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public String getIsbn() { return isbn; }
    public String getGenre() { return genre; }
    public int getTotalCopies() { return totalCopies; }
    public int getAvailableCopies() { return availableCopies; }
    public String getLocation() { return location; }
    public String getStatus() { return status; }
    public LocalDateTime getAddedDate() { return addedDate; } // CHANGED return type

    // Setters with validation
    public void setId(int id) { this.id = id; }

    public void setTitle(String title) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be null or empty");
        }
        this.title = title;
    }

    public void setAuthor(String author) {
        if (author == null || author.trim().isEmpty()) {
            throw new IllegalArgumentException("Author cannot be null or empty");
        }
        this.author = author;
    }

    public void setIsbn(String isbn) { this.isbn = isbn; }
    public void setGenre(String genre) { this.genre = genre; }

    public void setTotalCopies(int totalCopies) {
        if (totalCopies < 0) {
            throw new IllegalArgumentException("Total copies cannot be negative");
        }
        this.totalCopies = totalCopies;
    }

    public void setAvailableCopies(int availableCopies) {
        if (availableCopies < 0) {
            throw new IllegalArgumentException("Available copies cannot be negative");
        }
        if (availableCopies > totalCopies) {
            throw new IllegalArgumentException("Available copies cannot exceed total copies");
        }
        this.availableCopies = availableCopies;
    }

    public void setLocation(String location) { this.location = location; }

    public void setStatus(String status) {
        if (!isValidStatus(status)) {
            throw new IllegalArgumentException("Invalid book status: " + status);
        }
        this.status = status;
    }

    public void setAddedDate(LocalDateTime addedDate) { this.addedDate = addedDate; } // CHANGED parameter type

    // Convenience method for string dates (for database compatibility)
    public void setDateAdded(String dateAdded) {
        if (dateAdded != null && !dateAdded.trim().isEmpty()) {
            this.addedDate = LocalDateTime.parse(dateAdded);
        }
    }

    // Business logic methods
    public boolean isAvailable() {
        return STATUS_AVAILABLE.equals(status) && availableCopies > 0;
    }

    public boolean canBorrow() {
        return isAvailable() && availableCopies > 0;
    }

    public void borrowCopy() {
        if (availableCopies > 0) {
            availableCopies--;
            if (availableCopies == 0) {
                status = STATUS_UNAVAILABLE;
            }
        }
    }

    public void returnCopy() {
        if (availableCopies < totalCopies) {
            availableCopies++;
            if (STATUS_UNAVAILABLE.equals(status) && availableCopies > 0) {
                status = STATUS_AVAILABLE;
            }
        }
    }

    public int getBorrowedCopies() {
        return totalCopies - availableCopies;
    }

    // Validation helper
    private boolean isValidStatus(String status) {
        return STATUS_AVAILABLE.equals(status) ||
                STATUS_UNAVAILABLE.equals(status) ||
                STATUS_MAINTENANCE.equals(status);
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", isbn='" + isbn + '\'' +
                ", availableCopies=" + availableCopies +
                ", totalCopies=" + totalCopies +
                ", status='" + status + '\'' +
                '}';
    }

    // Equals and hashCode for proper object comparison
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Book book = (Book) o;
        return id == book.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}