package com.um6p.controller;

import com.um6p.dao.BookDAO;
import com.um6p.model.Book;
import com.um6p.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/books/*")
public class BookController extends HttpServlet {

    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // List all books
            listBooks(request, response);
        } else if (pathInfo.equals("/search")) {
            // Search books
            searchBooks(request, response);
        } else if (pathInfo.startsWith("/view/")) {
            // View specific book
            viewBook(request, response);
        } else if (pathInfo.equals("/add")) {
            // Show add book form (staff only)
            request.getRequestDispatcher("/staff/addBook.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            // Show edit book form (staff only)
            editBookForm(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        } else if (pathInfo.equals("/add")) {
            // Add new book (staff only)
            addBook(request, response);
        } else if (pathInfo.startsWith("/update/")) {
            // Update book (staff only)
            updateBook(request, response);
        } else if (pathInfo.startsWith("/delete/")) {
            // Delete book (staff only)
            deleteBook(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Book> books = bookDAO.getAllBooks();
        request.setAttribute("books", books);
        request.getRequestDispatcher("/books.jsp").forward(request, response);
    }

    private void searchBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchType = request.getParameter("searchType");
        String query = request.getParameter("query");

        List<Book> books;

        if ("title".equals(searchType)) {
            books = bookDAO.searchBooksByTitle(query);
        } else if ("author".equals(searchType)) {
            books = bookDAO.searchBooksByAuthor(query);
        } else if ("genre".equals(searchType)) {
            books = bookDAO.getBooksByGenre(query);
        } else {
            books = bookDAO.getAllBooks();
        }

        request.setAttribute("books", books);
        request.setAttribute("searchQuery", query);
        request.getRequestDispatcher("/books.jsp").forward(request, response);
    }

    private void viewBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int bookId = Integer.parseInt(pathInfo.substring(6)); // Remove "/view/"

        Book book = bookDAO.getBookById(bookId);

        if (book != null) {
            request.setAttribute("book", book);
            request.getRequestDispatcher("/bookDetails.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
        }
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String genre = request.getParameter("genre");
        int totalCopies = Integer.parseInt(request.getParameter("totalCopies"));
        String location = request.getParameter("location");

        // Validation
        if (!ValidationUtil.isValidISBN(isbn)) {
            request.setAttribute("error", "Invalid ISBN format. Must be in format: 978-XXXXXXXXXX");
            request.getRequestDispatcher("/staff/addBook.jsp").forward(request, response);
            return;
        }

        Book book = new Book();
        book.setTitle(title);
        book.setAuthor(author);
        book.setIsbn(isbn);
        book.setGenre(genre);
        book.setTotalCopies(totalCopies);
        book.setAvailableCopies(totalCopies);
        book.setLocation(location);
        book.setStatus("available");

        boolean created = bookDAO.createBook(book);

        if (created) {
            response.sendRedirect(request.getContextPath() + "/books?success=Book added successfully");
        } else {
            request.setAttribute("error", "Failed to add book. Please try again.");
            request.getRequestDispatcher("/staff/addBook.jsp").forward(request, response);
        }
    }

    private void editBookForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int bookId = Integer.parseInt(pathInfo.substring(6)); // Remove "/edit/"

        Book book = bookDAO.getBookById(bookId);

        if (book != null) {
            request.setAttribute("book", book);
            request.getRequestDispatcher("/staff/editBook.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int bookId = Integer.parseInt(pathInfo.substring(8)); // Remove "/update/"

        Book book = bookDAO.getBookById(bookId);

        if (book == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Book not found");
            return;
        }

        book.setTitle(request.getParameter("title"));
        book.setAuthor(request.getParameter("author"));
        book.setGenre(request.getParameter("genre"));
        book.setTotalCopies(Integer.parseInt(request.getParameter("totalCopies")));
        book.setLocation(request.getParameter("location"));
        book.setStatus(request.getParameter("status"));

        boolean updated = bookDAO.updateBook(book);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/books?success=Book updated successfully");
        } else {
            request.setAttribute("error", "Failed to update book.");
            request.setAttribute("book", book);
            request.getRequestDispatcher("/staff/editBook.jsp").forward(request, response);
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        int bookId = Integer.parseInt(pathInfo.substring(8)); // Remove "/delete/"

        boolean deleted = bookDAO.deleteBook(bookId);

        if (deleted) {
            response.sendRedirect(request.getContextPath() + "/books?success=Book deleted successfully");
        } else {
            response.sendRedirect(request.getContextPath() + "/books?error=Failed to delete book");
        }
    }
}