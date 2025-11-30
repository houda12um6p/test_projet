package com.um6p.util;

import org.mindrot.jbcrypt.BCrypt;

public class GeneratePasswordHash {
    public static void main(String[] args) {
        String password = "Password123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(12));

        System.out.println("========================================");
        System.out.println("PASSWORD HASH GENERATOR");
        System.out.println("========================================");
        System.out.println();
        System.out.println("Password: " + password);
        System.out.println("Hash: " + hash);
        System.out.println();

        // Test verification
        boolean matches = BCrypt.checkpw(password, hash);
        System.out.println("Verification test: " + (matches ? "SUCCESS" : "FAILED"));
        System.out.println();

        // Test with old hash
        String oldHash = "$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyJgHlqKe/TK";
        boolean oldMatches = BCrypt.checkpw(password, oldHash);
        System.out.println("Old hash verification: " + (oldMatches ? "SUCCESS" : "FAILED"));
        System.out.println();
        System.out.println("========================================");
    }
}
