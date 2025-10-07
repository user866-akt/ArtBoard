package com.artboard.servlet;

import com.artboard.util.DatabaseConnection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/test")
public class TestServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().println("TEST SERVLET WORKS!");
        try {
            Connection conn = DatabaseConnection.getConnection();
            response.getWriter().println("✅ Database connection OK");
            conn.close();
        } catch (SQLException e) {
            response.getWriter().println("❌ Database error: " + e.getMessage());
        }
    }
}
