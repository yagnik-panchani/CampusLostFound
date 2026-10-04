package com.campuslostfound.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.campuslostfound.dao.ClaimDAO;
import com.campuslostfound.model.Claim;
import com.campuslostfound.model.User;

@WebServlet("/admin-claim-action")
public class AdminClaimActionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Check login
         */
        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        /*
         * Get logged-in user
         */
        User user =
                (User) session.getAttribute("user");

        /*
         * Only ADMIN can review claims
         */
        if (!"ADMIN".equalsIgnoreCase(
                user.getRole())) {

            response.sendRedirect(
                "student-dashboard.jsp"
            );

            return;
        }

        /*
         * Get form values
         */
        String claimIdString =
                request.getParameter("claimId");

        String action =
                request.getParameter("action");

        String adminRemark =
                request.getParameter("adminRemark");

        /*
         * Validate claim ID
         */
        if (claimIdString == null ||
            claimIdString.trim().isEmpty()) {

            response.sendRedirect(
                "admin-claims.jsp?error=invalid"
            );

            return;
        }

        /*
         * Validate action
         */
        if (action == null ||
            (!"APPROVE".equalsIgnoreCase(action) &&
             !"REJECT".equalsIgnoreCase(action))) {

            response.sendRedirect(
                "admin-claims.jsp?error=invalid"
            );

            return;
        }

        int claimId;

        try {

            claimId =
                Integer.parseInt(
                    claimIdString
                );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                "admin-claims.jsp?error=invalid"
            );

            return;
        }

        /*
         * Load claim
         */
        ClaimDAO claimDAO =
                new ClaimDAO();

        Claim claim =
                claimDAO.getClaimById(claimId);

        if (claim == null) {

            response.sendRedirect(
                "admin-claims.jsp?error=notfound"
            );

            return;
        }

        /*
         * Only PENDING claims can be reviewed.
         */
        if (!"PENDING".equalsIgnoreCase(
                claim.getStatus())) {

            response.sendRedirect(
                "admin-claims.jsp?error=alreadyreviewed"
            );

            return;
        }

        /*
         * If admin did not enter a remark,
         * save an empty string.
         */
        if (adminRemark == null) {
            adminRemark = "";
        }

        adminRemark =
                adminRemark.trim();

        /*
         * Review claim
         */
        boolean success =
                claimDAO.reviewClaim(
                    claimId,
                    action,
                    adminRemark
                );

        /*
         * Redirect after action
         */
        if (success) {

            if ("APPROVE".equalsIgnoreCase(action)) {

                response.sendRedirect(
                    "admin-claims.jsp?success=approved"
                );

            } else {

                response.sendRedirect(
                    "admin-claims.jsp?success=rejected"
                );
            }

        } else {

            response.sendRedirect(
                "admin-claim-details.jsp?claimId="
                + claimId
                + "&error=failed"
            );
        }
    }
}