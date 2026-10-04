<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>

<%@ page import="com.campuslostfound.model.User" %>
<%@ page import="com.campuslostfound.model.LostItem" %>
<%@ page import="com.campuslostfound.dao.LostItemDAO" %>

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
    // GET USER'S LOST ITEMS
    // ==========================================

    LostItemDAO dao =
        new LostItemDAO();

    List<LostItem> items =
        dao.getLostItemsByUser(
            user.getUserId()
        );


    // ==========================================
    // MESSAGES
    // ==========================================

    String success =
        request.getParameter("success");

    String error =
        request.getParameter("error");
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>
        My Lost Items - Campus Lost &amp; Found
    </title>


    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }


        body {
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f7fb;
            color: #172033;
            min-height: 100vh;
        }


        /* ================================
           HEADER
           ================================ */

        .header {
            background: linear-gradient(
                135deg,
                #4f46e5,
                #2563eb
            );

            color: white;

            padding: 20px 45px;

            display: flex;
            justify-content: space-between;
            align-items: center;
        }


        .logo {
            font-size: 28px;
            font-weight: bold;
        }


        .back-link {
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;

            padding: 10px 18px;

            border: 1px solid
                rgba(255,255,255,0.6);

            border-radius: 8px;

            transition: 0.2s;
        }


        .back-link:hover {
            background: rgba(255,255,255,0.15);
        }


        /* ================================
           CONTAINER
           ================================ */

        .container {
            max-width: 1200px;

            margin: 45px auto;

            padding: 0 25px;
        }


        /* ================================
           PAGE TITLE
           ================================ */

        .page-title {
            margin-bottom: 25px;
        }


        .page-title h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }


        .page-title p {
            color: #6b7280;
            font-size: 17px;
        }


        /* ================================
           ALERTS
           ================================ */

        .alert {
            padding: 14px 18px;

            border-radius: 10px;

            margin-bottom: 25px;

            font-size: 14px;

            font-weight: 600;
        }


        .success-alert {
            background: #ecfdf5;
            color: #047857;
            border: 1px solid #a7f3d0;
        }


        .error-alert {
            background: #fef2f2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }


        /* ================================
           ITEMS GRID
           ================================ */

        .items-grid {
            display: grid;

            grid-template-columns:
                repeat(
                    auto-fit,
                    minmax(320px, 1fr)
                );

            gap: 28px;
        }


        /* ================================
           ITEM CARD
           ================================ */

        .item-card {
            background: white;

            border-radius: 18px;

            overflow: hidden;

            box-shadow:
                0 8px 25px
                rgba(0,0,0,0.08);

            transition: 0.25s;
        }


        .item-card:hover {
            transform: translateY(-4px);

            box-shadow:
                0 12px 30px
                rgba(0,0,0,0.12);
        }


        /* ================================
           IMAGE
           ================================ */

        .item-image {
            width: 100%;

            height: 230px;

            object-fit: cover;

            display: block;

            background: #eef2ff;
        }


        /* ================================
           NO IMAGE
           ================================ */

        .no-image {
            width: 100%;

            height: 230px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #eef2ff;

            color: #6366f1;

            font-size: 18px;

            font-weight: bold;
        }


        /* ================================
           CONTENT
           ================================ */

        .item-content {
            padding: 24px;
        }


        .item-content h2 {
            font-size: 24px;

            margin-bottom: 18px;
        }


        /* ================================
           INFORMATION
           ================================ */

        .info {
            margin-bottom: 10px;

            color: #4b5563;

            font-size: 15px;

            line-height: 1.5;
        }


        .info strong {
            color: #172033;
        }


        /* ================================
           STATUS
           ================================ */

        .status {
            display: inline-block;

            margin-left: 5px;

            padding: 5px 12px;

            border-radius: 20px;

            background: #fee2e2;

            color: #b91c1c;

            font-size: 13px;

            font-weight: bold;
        }


        /* ================================
           DESCRIPTION
           ================================ */

        .description {
            margin-top: 18px;

            padding-top: 15px;

            border-top: 1px solid #e5e7eb;

            color: #6b7280;

            line-height: 1.6;

            font-size: 15px;
        }


        .description strong {
            color: #172033;
        }


        /* ================================
           BUTTONS
           ================================ */

        .actions {
            display: flex;

            gap: 12px;

            margin-top: 22px;
        }


        .btn {
            display: inline-block;

            text-decoration: none;

            padding: 10px 20px;

            border-radius: 8px;

            font-size: 14px;

            font-weight: bold;

            transition: 0.2s;
        }


        .edit-btn {
            background: #eef2ff;

            color: #4f46e5;
        }


        .edit-btn:hover {
            background: #e0e7ff;
        }


        .delete-btn {
            background: #fee2e2;

            color: #dc2626;

            border: none;

            cursor: pointer;
        }


        .delete-btn:hover {
            background: #fecaca;
        }


        /* ================================
           EMPTY STATE
           ================================ */

        .empty {
            background: white;

            border-radius: 18px;

            padding: 70px 30px;

            text-align: center;

            box-shadow:
                0 8px 25px
                rgba(0,0,0,0.06);
        }


        .empty h2 {
            font-size: 28px;

            margin-bottom: 12px;
        }


        .empty p {
            color: #6b7280;

            font-size: 17px;

            margin-bottom: 25px;
        }


        .report-btn {
            display: inline-block;

            background: #4f46e5;

            color: white;

            text-decoration: none;

            padding: 12px 24px;

            border-radius: 8px;

            font-weight: bold;
        }


        .report-btn:hover {
            background: #4338ca;
        }


        /* ================================
           MOBILE
           ================================ */

        @media (max-width: 600px) {

            .header {
                padding: 18px 20px;
            }


            .logo {
                font-size: 21px;
            }


            .back-link {
                font-size: 14px;

                padding: 8px 12px;
            }


            .container {
                margin: 30px auto;

                padding: 0 15px;
            }


            .page-title h1 {
                font-size: 28px;
            }


            .items-grid {
                grid-template-columns: 1fr;
            }


            .actions {
                flex-direction: column;
            }


            .btn {
                text-align: center;
            }

        }

    </style>

</head>


<body>


    <!-- ======================================
         HEADER
         ====================================== -->

    <header class="header">

        <div class="logo">
            Campus Lost &amp; Found
        </div>


        <a
            href="student-dashboard.jsp"
            class="back-link">

            Back to Dashboard

        </a>

    </header>



    <!-- ======================================
         MAIN CONTENT
         ====================================== -->

    <main class="container">


        <!-- PAGE TITLE -->

        <div class="page-title">

            <h1>
                My Lost Items
            </h1>

            <p>
                View and manage the items you
                have reported as lost.
            </p>

        </div>



        <!-- ======================================
             SUCCESS / ERROR MESSAGES
             ====================================== -->

        <% if ("added".equals(success)) { %>

            <div class="alert success-alert">
                Lost item reported successfully.
            </div>

        <% } %>


        <% if ("updated".equals(success)) { %>

            <div class="alert success-alert">
                Lost item updated successfully.
            </div>

        <% } %>


        <% if ("deleted".equals(success)) { %>

            <div class="alert success-alert">
                Lost item deleted successfully.
            </div>

        <% } %>


        <% if ("required".equals(error)) { %>

            <div class="alert error-alert">
                Please fill in all required fields.
            </div>

        <% } %>


        <% if ("notfound".equals(error)) { %>

            <div class="alert error-alert">
                The requested lost item was not found.
            </div>

        <% } %>


        <% if ("invalid".equals(error)) { %>

            <div class="alert error-alert">
                Invalid item information.
            </div>

        <% } %>


        <% if ("update".equals(error)) { %>

            <div class="alert error-alert">
                The lost item could not be updated.
            </div>

        <% } %>


        <% if ("delete".equals(error)) { %>

            <div class="alert error-alert">
                The lost item could not be deleted.
            </div>

        <% } %>



        <!-- ======================================
             CHECK ITEMS
             ====================================== -->

        <% if (items == null ||
               items.isEmpty()) { %>


            <div class="empty">

                <h2>
                    No Lost Items Found
                </h2>

                <p>
                    You have not reported any
                    lost items yet.
                </p>

                <a
                    href="report-lost.jsp"
                    class="report-btn">

                    Report Lost Item

                </a>

            </div>


        <% } else { %>


            <!-- ======================================
                 ITEMS GRID
                 ====================================== -->

            <div class="items-grid">


                <% for (LostItem item : items) { %>


                    <div class="item-card">


                        <!-- =================================
                             IMAGE
                             ================================= -->

                        <%

                            String imageUrl =
                                null;

                            if (
                                item.getImageName()
                                    != null

                                &&

                                !item.getImageName()
                                    .isEmpty()
                            ) {

                                String encodedFileName =
                                    URLEncoder.encode(
                                        item.getImageName(),
                                        "UTF-8"
                                    );

                                imageUrl =
                                    "lost-image?name="
                                    + encodedFileName;
                            }

                        %>


                        <% if (imageUrl != null) { %>


                            <img
                                src="<%= imageUrl %>"
                                class="item-image"
                                alt="Lost Item Image">


                        <% } else { %>


                            <div class="no-image">

                                No Image

                            </div>


                        <% } %>



                        <!-- =================================
                             ITEM INFORMATION
                             ================================= -->

                        <div class="item-content">


                            <h2>

                                <%= item.getItemName() %>

                            </h2>


                            <div class="info">

                                <strong>
                                    Category:
                                </strong>

                                <%= item.getCategory() %>

                            </div>


                            <div class="info">

                                <strong>
                                    Location:
                                </strong>

                                <%= item.getLocationLost() %>

                            </div>


                            <div class="info">

                                <strong>
                                    Date Lost:
                                </strong>

                                <%= item.getDateLost() %>

                            </div>


                            <div class="info">

                                <strong>
                                    Status:
                                </strong>


                                <span class="status">

                                    <%= item.getStatus() %>

                                </span>

                            </div>



                            <!-- DESCRIPTION -->

                            <div class="description">

                                <strong>
                                    Description:
                                </strong>

                                <br>

                                <%= item.getDescription() %>

                            </div>



                            <!-- =================================
                                 ACTION BUTTONS
                                 ================================= -->

                            <div class="actions">


                                <!-- EDIT -->

                                <a
                                    href="edit-lost.jsp?lostItemId=<%= item.getLostItemId() %>"
                                    class="btn edit-btn">

                                    Edit

                                </a>



                                <!-- DELETE -->

                                <form
                                    action="lost-item"
                                    method="post"
                                    style="display:inline;"
                                    onsubmit="return confirm('Are you sure you want to delete this lost item?');">

                                    <input
                                        type="hidden"
                                        name="action"
                                        value="DELETE">


                                    <input
                                        type="hidden"
                                        name="lostItemId"
                                        value="<%= item.getLostItemId() %>">


                                    <button
                                        type="submit"
                                        class="btn delete-btn">

                                        Delete

                                    </button>

                                </form>


                            </div>


                        </div>

                    </div>


                <% } %>


            </div>


        <% } %>


    </main>


</body>

</html>