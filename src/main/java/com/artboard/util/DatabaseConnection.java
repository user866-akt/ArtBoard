package com.artboard.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/artboard?useUnicode=true&characterEncoding=UTF-8";
    private static final String USERNAME = "postgres";
    private static final String PASSWORD = "7777";

    static {
        try {
            Class.forName("org.postgresql.Driver");
            System.out.println("✅ PostgreSQL Driver Registered");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("❌ PostgreSQL Driver not found", e);
        }
    }

    public static Connection getConnection() {
        try {
            System.out.println("🔵 Attempting to connect to: " + URL);
            Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            System.out.println("✅ Database connection SUCCESS");
            return conn;
        } catch (SQLException e) {
            System.out.println("❌ Database connection FAILED:");
            System.out.println("   URL: " + URL);
            System.out.println("   User: " + USERNAME);
            System.out.println("   Error: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Database connection failed", e);
        }
    }
}
