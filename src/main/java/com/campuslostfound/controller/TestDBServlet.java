package com.campuslostfound.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.campuslostfound.util.DBConnection;

@WebServlet("/test-db")
public class TestDBServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        try {

            Connection connection = DBConnection.getConnection();

            out.println("<h1>Database Connection Successful!</h1>");
            out.println("<p>Campus Lost & Found database is connected.</p>");

            connection.close();

        } catch (Exception e) {

            out.println("<h1>Database Connection Failed!</h1>");
            out.println("<p>" + e.getMessage() + "</p>");

            e.printStackTrace();
        }
    }
}