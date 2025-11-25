package com.um6p.util;

import org.mindrot.jbcrypt.BCrypt;
import java.util.regex.Pattern;

public class PasswordUtil {

    // Password strength requirements
    private static final int MIN_LENGTH = 8;
    private static final int MAX_LENGTH = 128;
    private static final Pattern UPPERCASE_PATTERN = Pattern.compile(".*[A-Z].*");
    private static final Pattern LOWERCASE_PATTERN = Pattern.compile(".*[a-z].*");
    private static final Pattern DIGIT_PATTERN = Pattern.compile(".*\\d.*");
    private static final Pattern SPECIAL_CHAR_PATTERN = Pattern.compile(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*");

    public static String hashPassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            throw new IllegalArgumentException("Password cannot be null or empty");
        }
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    public static boolean verifyPassword(String password, String hash) {
        if (password == null || hash == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(password, hash);
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isStrongPassword(String password) {
        if (password == null || password.length() < MIN_LENGTH || password.length() > MAX_LENGTH) {
            return false;
        }

        // Check password strength criteria
        boolean hasUpper = UPPERCASE_PATTERN.matcher(password).matches();
        boolean hasLower = LOWERCASE_PATTERN.matcher(password).matches();
        boolean hasDigit = DIGIT_PATTERN.matcher(password).matches();
        boolean hasSpecial = SPECIAL_CHAR_PATTERN.matcher(password).matches();

        // Require at least 3 out of 4 criteria
        int criteriaMet = 0;
        if (hasUpper) criteriaMet++;
        if (hasLower) criteriaMet++;
        if (hasDigit) criteriaMet++;
        if (hasSpecial) criteriaMet++;

        return criteriaMet >= 3;
    }

    public static String getPasswordStrengthMessage(String password) {
        if (password == null) return "Password cannot be null";

        if (password.length() < MIN_LENGTH) {
            return "Password must be at least " + MIN_LENGTH + " characters long";
        }

        if (password.length() > MAX_LENGTH) {
            return "Password cannot exceed " + MAX_LENGTH + " characters";
        }

        StringBuilder message = new StringBuilder();
        if (!UPPERCASE_PATTERN.matcher(password).matches()) {
            message.append("• Include at least one uppercase letter\n");
        }
        if (!LOWERCASE_PATTERN.matcher(password).matches()) {
            message.append("• Include at least one lowercase letter\n");
        }
        if (!DIGIT_PATTERN.matcher(password).matches()) {
            message.append("• Include at least one digit\n");
        }
        if (!SPECIAL_CHAR_PATTERN.matcher(password).matches()) {
            message.append("• Include at least one special character\n");
        }

        return message.length() > 0 ? message.toString() : "Strong password!";
    }

    public static int getPasswordStrengthScore(String password) {
        if (password == null) return 0;

        int score = 0;

        // Length score
        if (password.length() >= MIN_LENGTH) score += 2;
        if (password.length() >= 12) score += 1;

        // Character variety score
        if (UPPERCASE_PATTERN.matcher(password).matches()) score += 1;
        if (LOWERCASE_PATTERN.matcher(password).matches()) score += 1;
        if (DIGIT_PATTERN.matcher(password).matches()) score += 1;
        if (SPECIAL_CHAR_PATTERN.matcher(password).matches()) score += 1;

        return Math.min(score, 5); // Max score 5
    }

    public static String generateTemporaryPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%";
        StringBuilder password = new StringBuilder();

        for (int i = 0; i < 10; i++) {
            int index = (int) (Math.random() * chars.length());
            password.append(chars.charAt(index));
        }

        return password.toString();
    }
}