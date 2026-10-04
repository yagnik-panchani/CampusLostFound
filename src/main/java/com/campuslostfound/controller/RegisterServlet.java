
package com.campuslostfound.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.campuslostfound.dao.UserDAO;
import com.campuslostfound.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // ==========================================
        // GET REGISTRATION FORM DATA
        // ==========================================

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");


        // ==========================================
        // CREATE USER OBJECT
        // ==========================================

        User user = new User(
                name,
                email,
                password,
                phone
        );


        // ==========================================
        // REGISTER USER
        // ==========================================

        UserDAO userDAO = new UserDAO();

        boolean success = userDAO.registerUser(user);


        // ==========================================
        // REGISTRATION SUCCESS
        // ==========================================

        if (success) {

            response.sendRedirect("login.jsp");

        }


        // ==========================================
        // REGISTRATION FAILED
        // ==========================================

        else {

            response.sendRedirect(
                    "register.jsp?error=registration"
            );
        }
    }
}

