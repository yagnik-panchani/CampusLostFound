<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
    // GET CLAIM ID
    // ==========================================

    String claimIdString =
            request.getParameter("claimId");


    if (claimIdString == null ||
        claimIdString.trim().isEmpty()) {

        response.sendRedirect(
            "admin-claims.jsp"
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
            "admin-claims.jsp"
        );

        return;
    }


    // ==========================================
    // GET CLAIM
    // ==========================================

    ClaimDAO claimDAO =
            new ClaimDAO();


    Claim claim =
            claimDAO.getClaimById(
                claimId
            );


    if (claim == null) {

        response.sendRedirect(
            "admin-claims.jsp"
        );

        return;
    }


    // ==========================================
    // GET FOUND ITEM
    // ==========================================

    FoundItemDAO foundItemDAO =
            new FoundItemDAO();


    FoundItem foundItem =
            foundItemDAO.getFoundItemById(
                claim.getFoundItemId()
            );


    if (foundItem == null) {

        response.sendRedirect(
            "admin-claims.jsp"
        );

        return;
    }


    // ==========================================
    // MESSAGE
    // ==========================================

    String error =
            request.getParameter("error");

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Review Claim</title>


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

            transition: 0.3s;
        }


        .back-btn:hover {

            background:
                rgba(255,255,255,0.15);
        }


        /* =====================================
           CONTAINER
           ===================================== */

        .container {

            max-width: 900px;

            margin: 40px auto;

            padding: 0 25px;
        }


        /* =====================================
           TITLE
           ===================================== */

        .page-title {

            margin-bottom: 25px;
        }


        .page-title h1 {

            margin: 0 0 8px 0;

            color: #111827;

            font-size: 34px;
        }


        .page-title p {

            margin: 0;

            color: #6b7280;
        }


        /* =====================================
           MAIN CARD
           ===================================== */

        .review-card {

            background: white;

            padding: 30px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);
        }


        /* =====================================
           CLAIM HEADER
           ===================================== */

        .claim-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            gap: 15px;

            padding-bottom: 20px;

            border-bottom: 1px solid #e5e7eb;

            margin-bottom: 25px;
        }


        .claim-header h2 {

            margin: 0;

            color: #111827;

            font-size: 26px;
        }


        .claim-number {

            display: block;

            margin-top: 6px;

            color: #6b7280;

            font-size: 14px;
        }


        /* =====================================
           STATUS
           ===================================== */

        .status {

            display: inline-block;

            padding: 7px 15px;

            border-radius: 20px;

            font-size: 13px;

            font-weight: bold;
        }


        .status-pending {

            background: #fef3c7;

            color: #92400e;
        }


        .status-approved {

            background: #dcfce7;

            color: #166534;
        }


        .status-rejected {

            background: #fee2e2;

            color: #991b1b;
        }


        .status-default {

            background: #e5e7eb;

            color: #374151;
        }


        /* =====================================
           SECTION
           ===================================== */

        .section {

            margin-bottom: 25px;
        }


        .section-title {

            margin: 0 0 15px 0;

            color: #111827;

            font-size: 20px;
        }


        /* =====================================
           ITEM DETAILS
           ===================================== */

        .item-details {

            background: #f0fdf4;

            border: 1px solid #bbf7d0;

            padding: 20px;

            border-radius: 10px;
        }


        .item-details h3 {

            margin-top: 0;

            margin-bottom: 15px;

            color: #166534;

            font-size: 23px;
        }


        .item-details p {

            margin: 8px 0;

            color: #4b5563;

            line-height: 1.5;
        }


        .item-details strong {

            color: #374151;
        }


        /* =====================================
           CLAIMANT
           ===================================== */

        .claimant-box {

            background: #f9fafb;

            border: 1px solid #e5e7eb;

            padding: 18px;

            border-radius: 10px;
        }


        .claimant-box p {

            margin: 8px 0;

            line-height: 1.5;
        }


        /* =====================================
           CLAIM DESCRIPTION
           ===================================== */

        .claim-box {

            background: #f9fafb;

            border: 1px solid #e5e7eb;

            padding: 20px;

            border-radius: 10px;
        }


        .claim-box p {

            margin: 0;

            line-height: 1.7;

            white-space: pre-wrap;
        }


        /* =====================================
           REVIEW FORM
           ===================================== */

        .review-form {

            border-top: 1px solid #e5e7eb;

            padding-top: 25px;

            margin-top: 25px;
        }


        .review-form label {

            display: block;

            margin-bottom: 8px;

            font-weight: bold;

            color: #374151;
        }


        .review-form textarea {

            width: 100%;

            min-height: 130px;

            padding: 13px;

            border: 1px solid #d1d5db;

            border-radius: 8px;

            font-family: Arial, sans-serif;

            font-size: 15px;

            line-height: 1.5;

            resize: vertical;
        }


        .review-form textarea:focus {

            outline: none;

            border-color: #4f46e5;

            box-shadow:
                0 0 0 3px
                rgba(79,70,229,0.10);
        }


        .help-text {

            color: #6b7280;

            font-size: 14px;

            margin-top: 8px;
        }


        /* =====================================
           BUTTONS
           ===================================== */

        .buttons {

            display: flex;

            gap: 15px;

            margin-top: 20px;
        }


        .approve-btn,
        .reject-btn {

            flex: 1;

            padding: 13px;

            border: none;

            border-radius: 8px;

            color: white;

            font-size: 15px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.3s;
        }


        .approve-btn {

            background: #059669;
        }


        .approve-btn:hover {

            background: #047857;
        }


        .reject-btn {

            background: #dc2626;
        }


        .reject-btn:hover {

            background: #b91c1c;
        }


        /* =====================================
           ALREADY REVIEWED
           ===================================== */

        .reviewed-box {

            margin-top: 25px;

            padding: 18px;

            border-radius: 10px;

            background: #eff6ff;

            border: 1px solid #bfdbfe;

            color: #1e3a8a;
        }


        .reviewed-box strong {

            display: block;

            margin-bottom: 8px;
        }


        /* =====================================
           ERROR
           ===================================== */

        .error-message {

            background: #fee2e2;

            border: 1px solid #fecaca;

            color: #991b1b;

            padding: 14px;

            border-radius: 8px;

            margin-bottom: 20px;

            font-weight: bold;
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


            .review-card {

                padding: 22px;
            }


            .claim-header {

                flex-direction: column;

                align-items: flex-start;
            }


            .buttons {

                flex-direction: column;
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
            href="admin-claims.jsp"
            class="back-btn"
        >
            Back to Claims
        </a>

    </div>


    <!-- =====================================
         MAIN CONTAINER
         ===================================== -->

    <div class="container">


        <div class="page-title">

            <h1>
                Review Claim
            </h1>

            <p>
                Verify the student's ownership claim
                before making a decision.
            </p>

        </div>


        <!-- ERROR -->

        <% if ("failed".equals(error)) { %>

            <div class="error-message">

                The claim could not be processed.
                Please try again.

            </div>

        <% } %>


        <div class="review-card">


            <!-- =================================
                 CLAIM HEADER
                 ================================= -->

            <div class="claim-header">


                <div>

                    <h2>
                        <%= foundItem.getItemName() %>
                    </h2>


                    <span class="claim-number">

                        Claim ID:
                        #<%= claim.getClaimId() %>

                    </span>

                </div>


                <%
                    String status =
                            claim.getStatus();

                    String statusClass =
                            "status-default";


                    if ("PENDING".equalsIgnoreCase(
                            status)) {

                        statusClass =
                            "status-pending";

                    } else if ("APPROVED".equalsIgnoreCase(
                            status)) {

                        statusClass =
                            "status-approved";

                    } else if ("REJECTED".equalsIgnoreCase(
                            status)) {

                        statusClass =
                            "status-rejected";
                    }
                %>


                <span
                    class="status <%= statusClass %>"
                >

                    <%= status %>

                </span>


            </div>


            <!-- =================================
                 FOUND ITEM
                 ================================= -->

            <div class="section">


                <h3 class="section-title">
                    Found Item Details
                </h3>


                <div class="item-details">


                    <h3>
                        <%= foundItem.getItemName() %>
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


                    <p>

                        <strong>
                            Found Item ID:
                        </strong>

                        <%= foundItem.getFoundItemId() %>

                    </p>


                </div>

            </div>


            <!-- =================================
                 CLAIMANT
                 ================================= -->

            <div class="section">


                <h3 class="section-title">
                    Claimant Information
                </h3>


                <div class="claimant-box">


                    <p>

                        <strong>
                            User ID:
                        </strong>

                        <%= claim.getClaimantUserId() %>

                    </p>


                    <p>

                        <strong>
                            Claim Submitted:
                        </strong>

                        <%= claim.getCreatedAt() %>

                    </p>


                </div>

            </div>


            <!-- =================================
                 CLAIM DESCRIPTION
                 ================================= -->

            <div class="section">


                <h3 class="section-title">
                    Student's Claim Explanation
                </h3>


                <div class="claim-box">

                    <p>
                        <%= claim.getClaimDescription() %>
                    </p>

                </div>

            </div>


            <!-- =================================
                 ADMIN REVIEW
                 ================================= -->

            <% if ("PENDING".equalsIgnoreCase(
                    claim.getStatus())) { %>


                <form
                    action="admin-claim-action"
                    method="post"
                    class="review-form"
                >


                    <input
                        type="hidden"
                        name="claimId"
                        value="<%= claim.getClaimId() %>"
                    >


                    <label for="adminRemark">

                        Admin Remark

                    </label>


                    <textarea
                        id="adminRemark"
                        name="adminRemark"
                        placeholder="Enter a reason for approving or rejecting this claim."
                    ></textarea>


                    <p class="help-text">

                        This remark will be visible to
                        the student on their My Claims page.

                    </p>


                    <div class="buttons">


                        <button
                            type="submit"
                            name="action"
                            value="APPROVE"
                            class="approve-btn"
                        >
                            Approve Claim
                        </button>


                        <button
                            type="submit"
                            name="action"
                            value="REJECT"
                            class="reject-btn"
                        >
                            Reject Claim
                        </button>


                    </div>


                </form>


            <% } else { %>


                <!-- ALREADY REVIEWED -->

                <div class="reviewed-box">


                    <strong>
                        This claim has already been reviewed.
                    </strong>


                    Current Status:

                    <%= claim.getStatus() %>


                    <% if (claim.getAdminRemark() != null
                            && !claim.getAdminRemark()
                                    .trim()
                                    .isEmpty()) { %>

                        <br><br>

                        <strong>
                            Admin Remark:
                        </strong>

                        <%= claim.getAdminRemark() %>

                    <% } %>


                </div>


            <% } %>


        </div>


    </div>


</body>

</html>