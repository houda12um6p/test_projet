package com.um6p.util;

import java.util.regex.Pattern;

public class ValidationUtil {

    // Pre-compiled patterns for better performance
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final Pattern UM6P_EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@um6p\\.ma$", Pattern.CASE_INSENSITIVE);
    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z\\s.'-]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[+]?[0-9\\s-()]{10,15}$");
    private static final Pattern STUDENT_ID_PATTERN = Pattern.compile("^[0-9]{8,10}$");
    private static final Pattern ISBN_PATTERN = Pattern.compile("^(97[89])-?[0-9]{1,5}-?[0-9]{1,7}-?[0-9]{1,7}-?[0-9]$");
    private static final Pattern DATE_PATTERN = Pattern.compile("^\\d{4}-\\d{2}-\\d{2}$");

    // Email validation
    public static boolean isUM6PEmail(String email) {
        return email != null && UM6P_EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    // Name validation
    public static boolean isValidName(String name) {
        return name != null &&
                NAME_PATTERN.matcher(name.trim()).matches() &&
                name.trim().length() >= 2 &&
                name.trim().length() <= 100;
    }

    // Phone validation (international format support)
    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        String cleanPhone = phone.replaceAll("[\\s-()]", "");
        return PHONE_PATTERN.matcher(phone).matches() && cleanPhone.length() >= 10;
    }

    // Student ID validation (more flexible format)
    public static boolean isValidStudentId(String studentId) {
        return studentId != null && STUDENT_ID_PATTERN.matcher(studentId.trim()).matches();
    }

    // ISBN validation (supports multiple formats)
    public static boolean isValidISBN(String isbn) {
        if (isbn == null) return false;
        String cleanIsbn = isbn.replaceAll("-", "");
        return ISBN_PATTERN.matcher(isbn).matches() ||
                (cleanIsbn.length() == 13 && cleanIsbn.matches("^97[89][0-9]{10}$"));
    }

    // Date validation
    public static boolean isValidDate(String date) {
        return date != null && DATE_PATTERN.matcher(date.trim()).matches();
    }

    // Text validation for descriptions, comments, etc.
    public static boolean isValidText(String text, int maxLength) {
        return text != null &&
                !text.trim().isEmpty() &&
                text.trim().length() <= maxLength;
    }

    public static boolean isValidText(String text) {
        return isValidText(text, 1000); // Default max length
    }

    // Number validation
    public static boolean isValidPositiveNumber(Integer number) {
        return number != null && number > 0;
    }

    public static boolean isValidPositiveNumber(Double number) {
        return number != null && number > 0;
    }

    // URL validation
    public static boolean isValidURL(String url) {
        if (url == null || url.trim().isEmpty()) return false;
        try {
            new java.net.URL(url.trim());
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // Bulk validation method
    public static String validateRegistrationData(String email, String name, String phone, String password) {
        if (!isUM6PEmail(email)) {
            return "Invalid UM6P email address";
        }
        if (!isValidName(name)) {
            return "Name must contain only letters and be 2-100 characters long";
        }
        if (!isValidPhone(phone)) {
            return "Invalid phone number format";
        }
        if (!PasswordUtil.isStrongPassword(password)) {
            return PasswordUtil.getPasswordStrengthMessage(password);
        }
        return null; // No errors
    }

    // Sanitization methods
    public static String sanitizeInput(String input) {
        if (input == null) return null;
        return input.trim()
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll("\"", "&quot;")
                .replaceAll("'", "&#x27;");
    }

    public static String sanitizeHTML(String input) {
        if (input == null) return null;
        return input.replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;");
    }
}