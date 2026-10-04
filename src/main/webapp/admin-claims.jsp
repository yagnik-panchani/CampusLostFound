<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>

<%@ page import="com.campuslostfound.model.User" %>
<%@ page import="com.campuslostfound.model.Claim" %>
<%@ page import="com.campuslostfound.model.FoundItem" %>

<%@ page import="com.campuslostfound.dao.ClaimDAO" %>
<%@ page import="com.campuslostfound.dao.FoundItemDAO" %>


<%
    // ==========================================
    // CHECK LOGIN
    // ==========================================

    User user =
            (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    // ==========================================
    // CHECK ADMIN ROLE
    // ==========================================

    if (!"ADMIN".equalsIgnoreCase(
            user.getRole())) {

        response.sendRedirect(
            "student-dashboard.jsp"
        );

        return;
    }


    // ==========================================
    // GET PENDING CLAIMS
    // ==========================================

    ClaimDAO claimDAO =
            new ClaimDAO();

    List<Claim> claims =
            claimDAO.getPendingClaims();


    FoundItemDAO foundItemDAO =
            new FoundItemDAO();

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Pending Claims</title>


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


        /* =====================================
           HEADER
           ===================================== */

        .header {

            background: linear-gradient(
                135deg,
                #111827,
                #374151
            );

            color: white;

            padding: 20px 40px;

            display: flex;

            justify-content: space-between;

            align-items: center;
        }


        .header h2 {

            margin: 0;

            font-size: 24px;
        }


        .back-btn {

            color: white;

            text-decoration: none;

            border: 1px solid
                    rgba(255,255,255,0.6);

            padding: 8px 15px;

            border-radius: 8px;
        }


        .back-btn:hover {

            background:
                rgba(255,255,255,0.15);
        }


        /* =====================================
           CONTAINER
           ===================================== */

        .container {

            max-width: 1100px;

            margin: 40px auto;

            padding: 0 25px;
        }


        .page-title {

            margin-bottom: 30px;
        }


        .page-title h1 {

            margin: 0 0 8px 0;

            color: #111827;

            font-size: 34px;
        }


        .page-title p {

            margin: 0;

            color: #6b7280;

            font-size: 17px;
        }


        /* =====================================
           CLAIM CARD
           ===================================== */

        .claim-card {

            background: white;

            padding: 25px;

            border-radius: 15px;

            margin-bottom: 22px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);
        }


        .claim-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 15px;

            margin-bottom: 20px;
        }


        .claim-header h2 {

            margin: 0;

            color: #111827;

            font-size: 23px;
        }


        .claim-id {

            color: #6b7280;

            font-size: 14px;

            margin-top: 5px;

            display: block;
        }


        /* =====================================
           STATUS
           ===================================== */

        .status {

            display: inline-block;

            padding: 7px 14px;

            border-radius: 20px;

            background: #fef3c7;

            color: #92400e;

            font-size: 13px;

            font-weight: bold;
        }


        /* =====================================
           ITEM INFO
           ===================================== */

        .item-info {

            background: #f0fdf4;

            border: 1px solid #bbf7d0;

            padding: 18px;

            border-radius: 10px;

            margin-bottom: 20px;
        }


        .item-info h3 {

            margin-top: 0;

            color: #166534;
        }


        .item-info p {

            margin: 8px 0;

            line-height: 1.5;

            color: #4b5563;
        }


        .item-info strong {

            color: #374151;
        }


        /* =====================================
           CLAIM DESCRIPTION
           ===================================== */

        .claim-description {

            margin-bottom: 20px;
        }


        .claim-description h3 {

            margin-bottom: 10px;

            color: #374151;
        }


        .claim-description p {

            background: #f9fafb;

            border: 1px solid #e5e7eb;

            padding: 15px;

            border-radius: 8px;

            line-height: 1.6;

            white-space: pre-wrap;
        }


        /* =====================================
           CLAIMANT
           ===================================== */

        .claimant {

            margin-bottom: 20px;

            color: #6b7280;
        }


        .claimant strong {

            color: #374151;
        }


        /* =====================================
           ACTION
           ===================================== */

        .action-area {

            border-top: 1px solid #e5e7eb;

            padding-top: 20px;
        }


        .review-btn {

            display: inline-block;

            padding: 11px 20px;

            background: #4f46e5;

            color: white;

            text-decoration: none;

            border-radius: 8px;

            font-weight: bold;
        }


        .review-btn:hover {

            background: #4338ca;
        }


        /* =====================================
           EMPTY
           ===================================== */

        .empty-box {

            background: white;

            padding: 60px 25px;

            text-align: center;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);
        }


        .empty-box h2 {

            margin-top: 0;

            color: #111827;
        }


        .empty-box p {

            color: #6b7280;
        }


        /* =====================================
           RESPONSIVE
           ===================================== */

        @media (max-width: 600px) {

            .header {

                padding: 18px 20px;
            }


            .header h2 {

                font-size: 20px;
            }


            .container {

                margin: 25px auto;

                padding: 0 15px;
            }


            .claim-header {

                flex-direction: column;

                align-items: flex-start;
            }
        }

    </style>

</head>


<body>


    <!-- =====================================
         HEADER
         ===================================== -->

    <div class="header">

        <h2>
            Campus Lost &amp; Found - Admin
        </h2>


        <a
            href="admin-dashboard.jsp"
            class="back-btn"
        >
            Admin Dashboard
        </a>

    </div>


    <!-- =====================================
         MAIN
         ===================================== -->

    <div class="container">


        <div class="page-title">

            <h1>
                Pending Claims
            </h1>


            <p>
                Review claims submitted by students
                before approving or rejecting them.
            </p>

        </div>


        <% if (claims.isEmpty()) { %>


            <!-- EMPTY -->

            <div class="empty-box">

                <h2>
                    No Pending Claims
                </h2>


                <p>
                    There are currently no claims
                    waiting for verification.
                </p>

            </div>


        <% } else { %>


            <!-- =================================
                 CLAIM LIST
                 ================================= -->

            <% for (Claim claim : claims) { %>


                <%
                    FoundItem foundItem =
                        foundItemDAO.getFoundItemById(
                            claim.getFoundItemId()
                        );
                %>


                <div class="claim-card">


                    <!-- CLAIM HEADER -->

                    <div class="claim-header">

                        <div>

                            <h2>

                                <% if (foundItem != null) { %>

                                    <%= foundItem.getItemName() %>

                                <% } else { %>

                                    Found Item

                                <% } %>

                            </h2>


                            <span class="claim-id">

                                Claim ID:
                                #<%= claim.getClaimId() %>

                            </span>

                        </div>


                        <span class="status">

                            <%= claim.getStatus() %>

                        </span>

                    </div>


                    <!-- ITEM INFORMATION -->

                    <% if (foundItem != null) { %>

                        <div class="item-info">

                            <h3>
                                Found Item Details
                            </h3>


                            <p>

                                <strong>
                                    Category:
                                </strong>

                                <%= foundItem.getCategory() %>

                            </p>


                            <p>

                                <strong>
                                    Location Found:
                                </strong>

                                <%= foundItem.getLocationFound() %>

                            </p>


                            <p>

                                <strong>
                                    Date Found:
                                </strong>

                                <%= foundItem.getDateFound() %>

                            </p>


                            <p>

                                <strong>
                                    Description:
                                </strong>

                                <%= foundItem.getDescription() %>

                            </p>

                        </div>

                    <% } %>


                    <!-- CLAIMANT -->

                    <div class="claimant">

                        <strong>
                            Claimant User ID:
                        </strong>

                        <%= claim.getClaimantUserId() %>

                    </div>


                    <!-- CLAIM DESCRIPTION -->

                    <div class="claim-description">

                        <h3>
                            Student's Claim
                        </h3>


                        <p>
                            <%= claim.getClaimDescription() %>
                        </p>

                    </div>


                    <!-- ACTION -->

                    <div class="action-area">

                        <a
                            href="admin-claim-details.jsp?claimId=<%= claim.getClaimId() %>"
                            class="review-btn"
                        >
                            Review Claim &rarr;
                        </a>

                    </div>


                </div>


            <% } %>


        <% } %>


    </div>


</body>

</html>