<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.campuslostfound.model.User" %>
<%@ page import="com.campuslostfound.model.Claim" %>
<%@ page import="com.campuslostfound.model.FoundItem" %>
<%@ page import="com.campuslostfound.dao.ClaimDAO" %>
<%@ page import="com.campuslostfound.dao.FoundItemDAO" %>

<%
    /*
     * Check login
     */
    User user =
            (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    /*
     * Get current user's claims
     */
    ClaimDAO claimDAO =
            new ClaimDAO();

    FoundItemDAO foundItemDAO =
            new FoundItemDAO();

    List<Claim> claims =
            claimDAO.getClaimsByUser(
                user.getUserId()
            );

    String success =
            request.getParameter("success");

    String error =
            request.getParameter("error");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Claims - Campus Lost & Found</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    color: #374151;
}

/* ================= HEADER ================= */

.header {
    background: linear-gradient(
        135deg,
        #4f46e5,
        #2563eb
    );

    color: white;

    padding: 18px 40px;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header-left h2 {
    margin: 0;
    font-size: 23px;
}

.header-left p {
    margin: 5px 0 0;
    font-size: 13px;
    opacity: 0.85;
}

.header-right {
    display: flex;
    gap: 10px;
    align-items: center;
}

.dashboard-btn,
.logout-btn {
    text-decoration: none;
    color: white;

    padding: 9px 15px;

    border-radius: 8px;

    font-size: 14px;

    border: 1px solid
        rgba(255,255,255,0.4);
}

.dashboard-btn:hover,
.logout-btn:hover {
    background: rgba(255,255,255,0.15);
}

/* ================= CONTAINER ================= */

.container {
    max-width: 1150px;
    margin: 35px auto;
    padding: 0 20px;
}

/* ================= PAGE TITLE ================= */

.page-title {
    margin-bottom: 25px;
}

.page-title h1 {
    margin: 0 0 8px;

    color: #111827;

    font-size: 30px;
}

.page-title p {
    margin: 0;

    color: #6b7280;

    line-height: 1.6;
}

/* ================= ALERTS ================= */

.alert {
    padding: 14px 18px;

    border-radius: 10px;

    margin-bottom: 20px;

    font-size: 14px;
}

.success {
    background: #ecfdf5;
    color: #047857;
    border: 1px solid #a7f3d0;
}

.error {
    background: #fef2f2;
    color: #b91c1c;
    border: 1px solid #fecaca;
}

/* ================= EMPTY STATE ================= */

.empty {
    background: white;

    border-radius: 16px;

    padding: 55px 30px;

    text-align: center;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.06);
}

.empty h2 {
    margin-top: 0;

    color: #111827;
}

.empty p {
    color: #6b7280;

    margin-bottom: 25px;
}

.browse-btn {
    display: inline-block;

    text-decoration: none;

    background: #4f46e5;

    color: white;

    padding: 11px 20px;

    border-radius: 8px;

    font-weight: bold;
}

.browse-btn:hover {
    background: #4338ca;
}

/* ================= CLAIM CARD ================= */

.claim-card {
    background: white;

    border-radius: 16px;

    margin-bottom: 25px;

    overflow: hidden;

    box-shadow:
        0 5px 20px rgba(0,0,0,0.06);

    border: 1px solid #e5e7eb;
}

/* ================= CARD HEADER ================= */

.claim-header {
    padding: 18px 22px;

    background: #f8fafc;

    border-bottom: 1px solid #e5e7eb;

    display: flex;

    justify-content: space-between;

    align-items: center;
}

.claim-id {
    color: #111827;

    font-weight: bold;

    font-size: 16px;
}

/* ================= STATUS ================= */

.status {
    display: inline-block;

    padding: 6px 12px;

    border-radius: 20px;

    font-size: 12px;

    font-weight: bold;

    text-transform: uppercase;
}

.status-pending {
    background: #fff7ed;
    color: #c2410c;
}

.status-approved {
    background: #ecfdf5;
    color: #047857;
}

.status-rejected {
    background: #fef2f2;
    color: #b91c1c;
}

/* ================= CARD BODY ================= */

.claim-body {
    padding: 22px;
}

.item-section {
    margin-bottom: 22px;
}

.item-section h3 {
    margin: 0 0 15px;

    color: #111827;

    font-size: 20px;
}

.item-grid {
    display: grid;

    grid-template-columns:
        repeat(3, 1fr);

    gap: 15px;
}

.info-box {
    background: #f8fafc;

    padding: 13px 15px;

    border-radius: 9px;

    border: 1px solid #e5e7eb;
}

.info-label {
    display: block;

    color: #6b7280;

    font-size: 12px;

    margin-bottom: 5px;

    text-transform: uppercase;

    letter-spacing: 0.4px;
}

.info-value {
    color: #111827;

    font-size: 14px;

    font-weight: 600;
}

/* ================= DESCRIPTION ================= */

.section {
    margin-top: 20px;
}

.section-title {
    font-size: 15px;

    font-weight: bold;

    color: #111827;

    margin-bottom: 8px;
}

.description-box {
    background: #f8fafc;

    border: 1px solid #e5e7eb;

    border-radius: 9px;

    padding: 14px;

    color: #4b5563;

    line-height: 1.6;

    white-space: pre-wrap;
}

/* ================= ADMIN REMARK ================= */

.admin-box {
    margin-top: 20px;

    padding: 16px;

    border-radius: 10px;

    border: 1px solid #dbeafe;

    background: #eff6ff;
}

.admin-box .section-title {
    color: #1d4ed8;
}

.admin-box p {
    margin: 0;

    color: #374151;

    line-height: 1.6;
}

.no-remark {
    color: #6b7280;
    font-style: italic;
}

/* ================= FOOTER INFO ================= */

.claim-footer {
    padding: 14px 22px;

    background: #fafafa;

    border-top: 1px solid #e5e7eb;

    color: #6b7280;

    font-size: 13px;
}

/* ================= RESPONSIVE ================= */

@media (max-width: 850px) {

    .item-grid {
        grid-template-columns:
            repeat(2, 1fr);
    }

}

@media (max-width: 600px) {

    .header {
        padding: 16px 20px;
    }

    .header-left h2 {
        font-size: 19px;
    }

    .header-right {
        gap: 5px;
    }

    .dashboard-btn,
    .logout-btn {
        padding: 7px 10px;
        font-size: 12px;
    }

    .container {
        margin: 25px auto;
        padding: 0 15px;
    }

    .page-title h1 {
        font-size: 25px;
    }

    .item-grid {
        grid-template-columns: 1fr;
    }

    .claim-header {
        align-items: flex-start;
        gap: 10px;
        flex-direction: column;
    }

}

</style>

</head>

<body>

<!-- ================= HEADER ================= -->

<div class="header">

    <div class="header-left">

        <h2>Campus Lost &amp; Found</h2>

        <p>Track your submitted claims</p>

    </div>

    <div class="header-right">

        <a
            href="student-dashboard.jsp"
            class="dashboard-btn">
            Dashboard
        </a>

        <a
            href="logout"
            class="logout-btn">
            Logout
        </a>

    </div>

</div>


<!-- ================= MAIN ================= -->

<div class="container">

    <div class="page-title">

        <h1>My Claims</h1>

        <p>
            View the status of items you have claimed
            and any remarks provided by the administrator.
        </p>

    </div>


    <!-- ================= SUCCESS MESSAGES ================= -->

    <% if ("added".equals(success)) { %>

        <div class="alert success">
            Your claim has been submitted successfully.
        </div>

    <% } %>


    <!-- ================= ERROR MESSAGES ================= -->

    <% if ("duplicate".equals(error)) { %>

        <div class="alert error">
            You have already submitted a pending claim
            for this item.
        </div>

    <% } %>


    <% if ("failed".equals(error)) { %>

        <div class="alert error">
            Your claim could not be processed.
            Please try again.
        </div>

    <% } %>


    <!-- ================= NO CLAIMS ================= -->

    <% if (claims == null || claims.isEmpty()) { %>

        <div class="empty">

            <h2>No Claims Yet</h2>

            <p>
                You have not submitted any claims.
                Browse found items to see if your lost item
                has been reported.
            </p>

            <a
                href="browse-found-items.jsp"
                class="browse-btn">
                Browse Found Items
            </a>

        </div>

    <% } else { %>


        <!-- ================= CLAIM LIST ================= -->

        <% for (Claim claim : claims) {

            FoundItem foundItem =
                foundItemDAO.getFoundItemById(
                    claim.getFoundItemId()
                );

            String status =
                claim.getStatus();

            String statusClass =
                "status-pending";

            if ("APPROVED".equalsIgnoreCase(status)) {

                statusClass =
                    "status-approved";

            } else if ("REJECTED".equalsIgnoreCase(status)) {

                statusClass =
                    "status-rejected";
            }
        %>


        <div class="claim-card">

            <!-- CLAIM HEADER -->

            <div class="claim-header">

                <div class="claim-id">

                    Claim #<%= claim.getClaimId() %>

                </div>

                <div>

                    <span
                        class="status <%= statusClass %>">

                        <%= status %>

                    </span>

                </div>

            </div>


            <!-- CLAIM BODY -->

            <div class="claim-body">


                <% if (foundItem != null) { %>

                    <!-- ITEM INFORMATION -->

                    <div class="item-section">

                        <h3>
                            <%= foundItem.getItemName() %>
                        </h3>


                        <div class="item-grid">

                            <div class="info-box">

                                <span class="info-label">
                                    Category
                                </span>

                                <span class="info-value">
                                    <%= foundItem.getCategory() %>
                                </span>

                            </div>


                            <div class="info-box">

                                <span class="info-label">
                                    Location Found
                                </span>

                                <span class="info-value">
                                    <%= foundItem.getLocationFound() %>
                                </span>

                            </div>


                            <div class="info-box">

                                <span class="info-label">
                                    Date Found
                                </span>

                                <span class="info-value">
                                    <%= foundItem.getDateFound() %>
                                </span>

                            </div>

                        </div>

                    </div>


                    <!-- ITEM DESCRIPTION -->

                    <% if (foundItem.getDescription() != null &&
                           !foundItem.getDescription().trim().isEmpty()) {
                    %>

                        <div class="section">

                            <div class="section-title">
                                Item Description
                            </div>

                            <div class="description-box">

                                <%= foundItem.getDescription() %>

                            </div>

                        </div>

                    <% } %>

                <% } else { %>

                    <div class="alert error">

                        The found item associated with this
                        claim could not be found.

                    </div>

                <% } %>


                <!-- CLAIM EXPLANATION -->

                <div class="section">

                    <div class="section-title">
                        Your Claim Explanation
                    </div>

                    <div class="description-box">

                        <%= claim.getClaimDescription() %>

                    </div>

                </div>


                <!-- ADMIN REMARK -->

                <div class="admin-box">

                    <div class="section-title">
                        Admin Remark
                    </div>

                    <% if (claim.getAdminRemark() != null &&
                           !claim.getAdminRemark().trim().isEmpty()) {
                    %>

                        <p>
                            <%= claim.getAdminRemark() %>
                        </p>

                    <% } else { %>

                        <p class="no-remark">
                            No admin remark has been added yet.
                        </p>

                    <% } %>

                </div>

            </div>


            <!-- CLAIM FOOTER -->

            <div class="claim-footer">

                Claim submitted:

                <strong>
                    <%= claim.getCreatedAt() %>
                </strong>

                <% if (claim.getUpdatedAt() != null) { %>

                    &nbsp; | &nbsp;

                    Last updated:

                    <strong>
                        <%= claim.getUpdatedAt() %>
                    </strong>

                <% } %>

            </div>

        </div>


        <% } %>

    <% } %>

</div>

</body>

</html>