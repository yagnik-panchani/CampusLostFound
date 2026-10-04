package com.campuslostfound.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.campuslostfound.dao.UserDAO;
import com.campuslostfound.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // ==========================================
        // GET LOGIN DATA
        // ==========================================

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        // ==========================================
        // LOGIN
        // ==========================================

        UserDAO userDAO =
                new UserDAO();

        User user =
                userDAO.loginUser(
                    email,
                    password
                );


        // ==========================================
        // CHECK LOGIN RESULT
        // ==========================================

        if (user != null) {


            // Create session

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                "user",
                user
            );


            // ======================================
            // ROLE BASED REDIRECT
            // ======================================

            if ("ADMIN".equalsIgnoreCase(
                    user.getRole())) {

                response.sendRedirect(
                    "admin-dashboard.jsp"
                );

            } else {

                response.sendRedirect(
                    "student-dashboard.jsp"
                );
            }


        } else {


            // Login failed

            response.sendRedirect(
                "login.jsp?error=invalid"
            );
        }
    }
}