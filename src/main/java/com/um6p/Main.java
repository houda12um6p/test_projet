package com.um6p;

import com.um6p.util.DatabaseConnection;

public class Main {

    public static void main(String[] args) {
        System.out.println("UM6P Learning Center Management System");
        System.out.println("==========================================");

        // Test database connection on startup
        if (DatabaseConnection.testConnection()) {
            System.out.println(" Database connection: SUCCESS");
        } else {
            System.out.println("Database connection: FAILED");
            System.exit(1);
        }

        System.out.println("Application initialized successfully");
        System.out.println(" Server: Apache Tomcat 9.x");
        System.out.println("Database: MySQL 8.0");
        System.out.println("Backend: Java Servlets");
        System.out.println("Frontend: HTML/CSS/JavaScript + Bootstrap");
    }
}