package com.um6p.dao;

import com.um6p.model.Book;
import com.um6p.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    // Constants for better maintainability
    private static final String BOOKS_TABLE = "books";
    private static final String STATUS_AVAILABLE = "available";

    public boolean createBook(Book book) {
        String sql = "INSERT INTO " + BOOKS_TABLE + " (title, author, isbn, genre, total_copies, available_copies, location, status, date_added) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getIsbn());
            stmt.setString(4, book.getGenre());
            stmt.setInt(5, book.getTotalCopies());
            stmt.setInt(6, book.getAvailableCopies());
            stmt.setString(7, book.getLocation());
            stmt.setString(8, book.getStatus());
            stmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));

            int rowsInserted = stmt.executeUpdate();

            // Set the generated ID back to the book object
            if (rowsInserted > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        book.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Error creating book: " + e.getMessage());
            return false;
        }
    }

    public Book getBookById(int id) {
        String sql = "SELECT * FROM " + BOOKS_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToBook(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting book by ID " + id + ": " + e.getMessage());
        }
        return null;
    }

    public boolean updateBook(Book book) {
        String sql = "UPDATE " + BOOKS_TABLE + " SET title=?, author=?, isbn=?, genre=?, total_copies=?, available_copies=?, location=?, status=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getIsbn());
            stmt.setString(4, book.getGenre());
            stmt.setInt(5, book.getTotalCopies());
            stmt.setInt(6, book.getAvailableCopies());
            stmt.setString(7, book.getLocation());
            stmt.setString(8, book.getStatus());
            stmt.setInt(9, book.getId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error updating book ID " + book.getId() + ": " + e.getMessage());
            return false;
        }
    }

    public boolean deleteBook(int id) {
        String sql = "DELETE FROM " + BOOKS_TABLE + " WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting book ID " + id + ": " + e.getMessage());
            return false;
        }
    }

    public List<Book> getAllBooks() {
        return getAllBooks(false); // Default: only available books
    }

    public List<Book> getAllBooks(boolean includeAllStatus) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM " + BOOKS_TABLE;

        if (!includeAllStatus) {
            sql += " WHERE status = ?";
        }

        sql += " ORDER BY title ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (!includeAllStatus) {
                stmt.setString(1, STATUS_AVAILABLE);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all books: " + e.getMessage());
        }
        return books;
    }

    public List<Book> searchBooksByTitle(String title) {
        return searchBooks(title, null, null, false);
    }

    public List<Book> searchBooksByAuthor(String author) {
        return searchBooks(null, author, null, false);
    }

    public List<Book> getBooksByGenre(String genre) {
        return searchBooks(null, null, genre, false);
    }

    public List<Book> searchBooks(String title, String author, String genre, boolean includeAllStatus) {
        List<Book> books = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM " + BOOKS_TABLE + " WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        if (title != null && !title.trim().isEmpty()) {
            sql.append(" AND title LIKE ?");
            parameters.add("%" + title.trim() + "%");
        }
        if (author != null && !author.trim().isEmpty()) {
            sql.append(" AND author LIKE ?");
            parameters.add("%" + author.trim() + "%");
        }
        if (genre != null && !genre.trim().isEmpty()) {
            sql.append(" AND genre = ?");
            parameters.add(genre.trim());
        }
        if (!includeAllStatus) {
            sql.append(" AND status = ?");
            parameters.add(STATUS_AVAILABLE);
        }

        sql.append(" ORDER BY title ASC");

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error searching books: " + e.getMessage());
        }
        return books;
    }

    public boolean isBookAvailable(int bookId) {
        String sql = "SELECT available_copies FROM " + BOOKS_TABLE + " WHERE id = ? AND status = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            stmt.setString(2, STATUS_AVAILABLE);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("available_copies") > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking book availability ID " + bookId + ": " + e.getMessage());
        }
        return false;
    }

    public boolean isbnExists(String isbn) {
        String sql = "SELECT COUNT(*) FROM " + BOOKS_TABLE + " WHERE isbn = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, isbn);
            ResultSet rs = stmt.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            System.err.println("Error checking ISBN existence: " + e.getMessage());
            return false;
        }
    }

    /**
     * Atomically decrement available copies using a transaction with row locking
     * This prevents race conditions when multiple users try to borrow the same book
     */
    public boolean decrementAvailableCopiesAtomic(int bookId) throws SQLException {
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement updateStmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            // Lock the row for update
            String checkSql = "SELECT available_copies FROM " + BOOKS_TABLE +
                            " WHERE id = ? FOR UPDATE";
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, bookId);
            ResultSet rs = checkStmt.executeQuery();

            if (!rs.next() || rs.getInt("available_copies") <= 0) {
                conn.rollback();
                return false;
            }

            // Decrement the count
            String updateSql = "UPDATE " + BOOKS_TABLE +
                             " SET available_copies = available_copies - 1 WHERE id = ?";
            updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setInt(1, bookId);
            int rowsUpdated = updateStmt.executeUpdate();

            conn.commit();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    System.err.println("Error rolling back transaction: " + rollbackEx.getMessage());
                }
            }
            throw e;
        } finally {
            if (checkStmt != null) checkStmt.close();
            if (updateStmt != null) updateStmt.close();
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public boolean decrementAvailableCopies(int bookId) {
        try {
            return decrementAvailableCopiesAtomic(bookId);
        } catch (SQLException e) {
            System.err.println("Error decrementing copies for book ID " + bookId + ": " + e.getMessage());
            return false;
        }
    }

    public boolean incrementAvailableCopies(int bookId) {
        String sql = "UPDATE " + BOOKS_TABLE + " SET available_copies = available_copies + 1 WHERE id = ? AND available_copies < total_copies";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Error incrementing copies for book ID " + bookId + ": " + e.getMessage());
            return false;
        }
    }

    public List<String> getAllGenres() {
        List<String> genres = new ArrayList<>();
        String sql = "SELECT DISTINCT genre FROM " + BOOKS_TABLE + " WHERE genre IS NOT NULL ORDER BY genre";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                genres.add(rs.getString("genre"));
            }
        } catch (SQLException e) {
            System.err.println("Error getting genres: " + e.getMessage());
        }
        return genres;
    }

    public int getTotalBookCount() {
        String sql = "SELECT COUNT(*) FROM " + BOOKS_TABLE;
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting total book count: " + e.getMessage());
        }
        return 0;
    }

    public int getAvailableBookCount() {
        String sql = "SELECT COUNT(*) FROM " + BOOKS_TABLE + " WHERE status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, STATUS_AVAILABLE);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting available book count: " + e.getMessage());
        }
        return 0;
    }

    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setAuthor(rs.getString("author"));
        book.setIsbn(rs.getString("isbn"));
        book.setGenre(rs.getString("genre"));
        book.setTotalCopies(rs.getInt("total_copies"));
        book.setAvailableCopies(rs.getInt("available_copies"));
        book.setLocation(rs.getString("location"));
        book.setStatus(rs.getString("status"));

        // Handle date conversion safely
        Timestamp dateAdded = rs.getTimestamp("date_added");
        if (dateAdded != null) {
            book.setDateAdded(dateAdded.toString());
        }

        return book;
    }
}