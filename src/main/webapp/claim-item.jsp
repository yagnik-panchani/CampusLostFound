<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.campuslostfound.model.User" %>
<%@ page import="com.campuslostfound.model.FoundItem" %>
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
    // GET FOUND ITEM ID
    // ==========================================

    String foundItemIdString =
            request.getParameter("foundItemId");


    if (foundItemIdString == null ||
        foundItemIdString.trim().isEmpty()) {

        response.sendRedirect(
            "browse-found-items.jsp"
        );

        return;
    }


    // ==========================================
    // CONVERT ID TO INTEGER
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
    // GET FOUND ITEM FROM DATABASE
    // ==========================================

    FoundItemDAO dao =
            new FoundItemDAO();


    FoundItem item =
            dao.getFoundItemById(
                foundItemId
            );


    // ==========================================
    // ITEM NOT FOUND
    // ==========================================

    if (item == null) {

        response.sendRedirect(
            "browse-found-items.jsp"
        );

        return;
    }


    // ==========================================
    // PREVENT OWNER FROM CLAIMING OWN ITEM
    // ==========================================

    if (item.getUserId() == user.getUserId()) {

        response.sendRedirect(
            "browse-found-items.jsp?error=selfclaim"
        );

        return;
    }


    // ==========================================
    // CHECK ITEM STATUS
    // ==========================================

    if (!"FOUND".equalsIgnoreCase(
            item.getStatus())) {

        response.sendRedirect(
            "browse-found-items.jsp?error=unavailable"
        );

        return;
    }


    // ==========================================
    // ERROR MESSAGE
    // ==========================================

    String error =
            request.getParameter("error");

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Claim Found Item</title>


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
                #059669,
                #047857
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

            max-width: 750px;

            margin: 40px auto;

            padding: 0 25px;
        }


        /* =====================================
           CARD
           ===================================== */

        .form-card {

            background: white;

            padding: 30px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);
        }


        .form-card h1 {

            margin-top: 0;

            color: #111827;

            margin-bottom: 10px;
        }


        .intro {

            color: #6b7280;

            line-height: 1.6;

            margin-bottom: 25px;
        }


        /* =====================================
           ITEM SUMMARY
           ===================================== */

        .item-summary {

            background: #f0fdf4;

            border: 1px solid #bbf7d0;

            padding: 20px;

            border-radius: 10px;

            margin-bottom: 28px;
        }


        .item-summary h3 {

            margin-top: 0;

            margin-bottom: 15px;

            color: #166534;

            font-size: 22px;
        }


        .item-summary p {

            margin: 8px 0;

            color: #4b5563;

            line-height: 1.5;
        }


        .item-summary strong {

            color: #374151;
        }


        /* =====================================
           ERROR
           ===================================== */

        .error-message {

            background: #fee2e2;

            color: #991b1b;

            border: 1px solid #fecaca;

            padding: 14px 16px;

            border-radius: 8px;

            margin-bottom: 20px;

            font-weight: bold;
        }


        /* =====================================
           FORM
           ===================================== */

        .form-group {

            margin-bottom: 20px;
        }


        label {

            display: block;

            margin-bottom: 8px;

            font-weight: bold;

            color: #374151;
        }


        textarea {

            width: 100%;

            min-height: 170px;

            padding: 13px;

            border: 1px solid #d1d5db;

            border-radius: 8px;

            font-family: Arial, sans-serif;

            font-size: 15px;

            line-height: 1.5;

            resize: vertical;
        }


        textarea:focus {

            outline: none;

            border-color: #059669;

            box-shadow:
                0 0 0 3px
                rgba(5,150,105,0.10);
        }


        .help-text {

            margin-top: 8px;

            color: #6b7280;

            font-size: 14px;

            line-height: 1.5;
        }


        /* =====================================
           BUTTON
           ===================================== */

        .submit-btn {

            width: 100%;

            margin-top: 5px;

            padding: 14px;

            border: none;

            border-radius: 8px;

            background: #059669;

            color: white;

            font-size: 16px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.3s;
        }


        .submit-btn:hover {

            background: #047857;
        }


        .cancel-btn {

            display: block;

            text-align: center;

            margin-top: 15px;

            color: #6b7280;

            text-decoration: none;
        }


        .cancel-btn:hover {

            text-decoration: underline;
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


            .form-card {

                padding: 22px;
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
            Campus Lost &amp; Found
        </h2>


        <a
            href="browse-found-items.jsp"
            class="back-btn"
        >
            Back to Found Items
        </a>

    </div>


    <!-- =====================================
         MAIN CONTAINER
         ===================================== -->

    <div class="container">


        <div class="form-card">


            <h1>
                Claim Found Item
            </h1>


            <p class="intro">

                Please provide information that can
                help verify that this item belongs to you.

            </p>


            <!-- =================================
                 ERROR MESSAGE
                 ================================= -->

            <% if ("failed".equals(error)) { %>

                <div class="error-message">

                    Your claim could not be submitted.
                    Please try again.

                </div>

            <% } %>


            <!-- =================================
                 ITEM INFORMATION
                 ================================= -->

            <div class="item-summary">


                <h3>
                    <%= item.getItemName() %>
                </h3>


                <p>

                    <strong>
                        Category:
                    </strong>

                    <%= item.getCategory() %>

                </p>


                <p>

                    <strong>
                        Location Found:
                    </strong>

                    <%= item.getLocationFound() %>

                </p>


                <p>

                    <strong>
                        Date Found:
                    </strong>

                    <%= item.getDateFound() %>

                </p>


                <p>

                    <strong>
                        Description:
                    </strong>

                    <%= item.getDescription() %>

                </p>


            </div>


            <!-- =================================
                 CLAIM FORM
                 ================================= -->

            <form
                action="claim-item"
                method="post"
            >


                <!-- FOUND ITEM ID -->

                <input
                    type="hidden"
                    name="foundItemId"
                    value="<%= item.getFoundItemId() %>"
                >


                <!-- CLAIM DESCRIPTION -->

                <div class="form-group">


                    <label for="claimDescription">

                        Why do you believe this item
                        belongs to you?

                    </label>


                    <textarea
                        id="claimDescription"
                        name="claimDescription"
                        placeholder="Describe where you lost the item, unique marks, contents, serial number, identifying details, or other information that can help verify your ownership."
                        required
                    ></textarea>


                    <p class="help-text">

                        Provide specific information.
                        The administrator will use your
                        description to verify the claim.

                    </p>


                </div>


                <!-- SUBMIT -->

                <button
                    type="submit"
                    class="submit-btn"
                >
                    Submit Claim
                </button>


                <!-- CANCEL -->

                <a
                    href="browse-found-items.jsp"
                    class="cancel-btn"
                >
                    Cancel
                </a>


            </form>


        </div>


    </div>


</body>

</html>