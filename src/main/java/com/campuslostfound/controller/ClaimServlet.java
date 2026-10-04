package com.campuslostfound.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.campuslostfound.dao.ClaimDAO;
import com.campuslostfound.dao.FoundItemDAO;
import com.campuslostfound.model.Claim;
import com.campuslostfound.model.FoundItem;
import com.campuslostfound.model.User;

@WebServlet("/claim-item")
public class ClaimServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // ==========================================
        // 1. CHECK LOGIN
        // ==========================================

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");


        // ==========================================
        // 2. GET FORM DATA
        // ==========================================

        String foundItemIdString =
                request.getParameter("foundItemId");

        String claimDescription =
                request.getParameter("claimDescription");


        // ==========================================
        // 3. VALIDATE FORM DATA
        // ==========================================

        if (foundItemIdString == null ||
            foundItemIdString.trim().isEmpty() ||
            claimDescription == null ||
            claimDescription.trim().isEmpty()) {

            response.sendRedirect(
                "browse-found-items.jsp"
            );

            return;
        }


        // ==========================================
        // 4. CONVERT ITEM ID
        // ==========================================

        int foundItemId;

        try {

            foundItemId =
                    Integer.parseInt(
                        foundItemIdString
                    );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                "browse-found-items.jsp"
            );

            return;
        }


        // ==========================================
        // 5. GET FOUND ITEM
        // ==========================================

        FoundItemDAO foundItemDAO =
                new FoundItemDAO();

        FoundItem foundItem =
                foundItemDAO.getFoundItemById(
                    foundItemId
                );


        if (foundItem == null) {

            response.sendRedirect(
                "browse-found-items.jsp"
            );

            return;
        }


        // ==========================================
        // 6. PREVENT SELF CLAIM
        // ==========================================

        if (foundItem.getUserId()
                == user.getUserId()) {

            response.sendRedirect(
                "browse-found-items.jsp?error=selfclaim"
            );

            return;
        }


        // ==========================================
        // 7. CHECK ITEM STATUS
        // ==========================================

        if (!"FOUND".equalsIgnoreCase(
                foundItem.getStatus())) {

            response.sendRedirect(
                "browse-found-items.jsp?error=unavailable"
            );

            return;
        }


        // ==========================================
        // 8. CHECK DUPLICATE CLAIM
        // ==========================================

        ClaimDAO claimDAO =
                new ClaimDAO();

        boolean existingClaim =
                claimDAO.hasExistingClaim(
                    foundItemId,
                    user.getUserId()
                );


        if (existingClaim) {

            response.sendRedirect(
                "my-claims.jsp?error=duplicate"
            );

            return;
        }


        // ==========================================
        // 9. CREATE CLAIM OBJECT
        // ==========================================

        Claim claim =
                new Claim();

        claim.setFoundItemId(
            foundItemId
        );

        claim.setClaimantUserId(
            user.getUserId()
        );

        claim.setClaimDescription(
            claimDescription.trim()
        );

        claim.setStatus(
            "PENDING"
        );


        // ==========================================
        // 10. SAVE CLAIM
        // ==========================================

        boolean success =
                claimDAO.addClaim(
                    claim
                );


        // ==========================================
        // 11. REDIRECT
        // ==========================================

        if (success) {

            response.sendRedirect(
                "my-claims.jsp?success=added"
            );

        } else {

            response.sendRedirect(
                "claim-item.jsp?foundItemId="
                + foundItemId
                + "&error=failed"
            );
        }
    }
}