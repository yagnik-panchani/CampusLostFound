<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>

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
    // GET USER'S FOUND ITEMS
    // ==========================================

    FoundItemDAO dao =
            new FoundItemDAO();

    List<FoundItem> foundItems =
            dao.getFoundItemsByUser(
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
        My Found Items - Campus Lost &amp; Found
    </title>


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

            max-width: 1100px;

            margin: 40px auto;

            padding: 0 25px;
        }


        .page-title {

            margin-bottom: 25px;
        }


        .page-title h1 {

            margin: 0 0 8px 0;

            color: #111827;
        }


        .page-title p {

            margin: 0;

            color: #6b7280;
        }


        /* =====================================
           ALERTS
           ===================================== */

        .alert {

            padding: 14px 18px;

            border-radius: 10px;

            margin-bottom: 25px;

            font-weight: bold;
        }


        .success-message {

            background: #dcfce7;

            color: #166534;

            border: 1px solid #86efac;
        }


        .error-message {

            background: #fee2e2;

            color: #b91c1c;

            border: 1px solid #fecaca;
        }


        /* =====================================
           EMPTY STATE
           ===================================== */

        .empty-box {

            background: white;

            padding: 50px 25px;

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

            margin-bottom: 25px;
        }


        .report-btn {

            display: inline-block;

            text-decoration: none;

            background: #059669;

            color: white;

            padding: 12px 20px;

            border-radius: 8px;

            font-weight: bold;
        }


        .report-btn:hover {

            background: #047857;
        }


        /* =====================================
           ITEM GRID
           ===================================== */

        .items-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 22px;
        }


        /* =====================================
           ITEM CARD
           ===================================== */

        .item-card {

            background: white;

            border-radius: 15px;

            overflow: hidden;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);

            transition: 0.3s;
        }


        .item-card:hover {

            transform:
                translateY(-5px);

            box-shadow:
                0 10px 25px
                rgba(0,0,0,0.10);
        }


        /* =====================================
           IMAGE
           ===================================== */

        .item-image {

            width: 100%;

            height: 210px;

            object-fit: cover;

            display: block;
        }


        .no-image {

            width: 100%;

            height: 210px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #f3f4f6;

            color: #9ca3af;

            font-size: 16px;
        }


        /* =====================================
           ITEM CONTENT
           ===================================== */

        .item-content {

            padding: 20px;
        }


        .item-content h3 {

            margin-top: 0;

            margin-bottom: 10px;

            color: #111827;

            font-size: 21px;
        }


        .item-content p {

            margin: 8px 0;

            line-height: 1.5;

            color: #6b7280;
        }


        .item-content strong {

            color: #374151;
        }


        /* =====================================
           STATUS
           ===================================== */

        .status {

            display: inline-block;

            margin-top: 10px;

            padding: 6px 12px;

            border-radius: 20px;

            background: #dcfce7;

            color: #166534;

            font-size: 13px;

            font-weight: bold;
        }


        .status-claimed {

            background: #dbeafe;

            color: #1d4ed8;
        }


        /* =====================================
           ACTION BUTTONS
           ===================================== */

        .actions {

            display: flex;

            gap: 10px;

            margin-top: 20px;
        }


        .edit-btn,
        .delete-btn {

            flex: 1;

            padding: 10px;

            border-radius: 8px;

            font-size: 14px;

            font-weight: bold;

            text-align: center;

            cursor: pointer;

            text-decoration: none;

            border: none;
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
        }


        .delete-btn:hover {

            background: #fecaca;
        }


        .disabled-btn {

            background: #f3f4f6;

            color: #9ca3af;

            cursor: not-allowed;

            border-radius: 8px;

            padding: 10px;

            flex: 1;

            text-align: center;

            font-size: 14px;

            font-weight: bold;
        }


        /* =====================================
           RESPONSIVE
           ===================================== */

        @media (max-width: 900px) {

            .items-grid {

                grid-template-columns:
                    repeat(2, 1fr);
            }
        }


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


            .items-grid {

                grid-template-columns: 1fr;
            }


            .actions {

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
            Campus Lost &amp; Found
        </h2>


        <a
            href="student-dashboard.jsp"
            class="back-btn">

            Dashboard

        </a>

    </div>



    <!-- =====================================
         MAIN CONTAINER
         ===================================== -->

    <div class="container">


        <!-- PAGE TITLE -->

        <div class="page-title">

            <h1>
                My Found Items
            </h1>

            <p>
                Items that you have reported as found.
            </p>

        </div>



        <!-- =================================
             SUCCESS MESSAGES
             ================================= -->

        <% if ("added".equals(success)) { %>

            <div class="alert success-message">

                Found item reported successfully.

            </div>

        <% } %>


        <% if ("updated".equals(success)) { %>

            <div class="alert success-message">

                Found item updated successfully.

            </div>

        <% } %>


        <% if ("deleted".equals(success)) { %>

            <div class="alert success-message">

                Found item deleted successfully.

            </div>

        <% } %>



        <!-- =================================
             ERROR MESSAGES
             ================================= -->

        <% if ("notfound".equals(error)) { %>

            <div class="alert error-message">

                The requested found item could not be found.

            </div>

        <% } %>


        <% if ("invalid".equals(error)) { %>

            <div class="alert error-message">

                Invalid item information.

            </div>

        <% } %>


        <% if ("update".equals(error)) { %>

            <div class="alert error-message">

                The found item could not be updated.

            </div>

        <% } %>


        <% if ("delete".equals(error)) { %>

            <div class="alert error-message">

                The found item could not be deleted.

            </div>

        <% } %>


        <% if ("claimed".equals(error)) { %>

            <div class="alert error-message">

                This item has already been claimed and
                cannot be deleted.

            </div>

        <% } %>



        <!-- =================================
             CHECK ITEMS
             ================================= -->

        <% if (foundItems == null ||
               foundItems.isEmpty()) { %>


            <!-- EMPTY STATE -->

            <div class="empty-box">

                <h2>
                    No Found Items Yet
                </h2>

                <p>
                    You have not reported any found
                    items yet.
                </p>

                <a
                    href="report-found.jsp"
                    class="report-btn">

                    Report Found Item

                </a>

            </div>


        <% } else { %>


            <!-- =================================
                 ITEMS GRID
                 ================================= -->

            <div class="items-grid">


                <% for (FoundItem item :
                        foundItems) { %>


                    <div class="item-card">


                        <!-- IMAGE -->

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

                                imageUrl =
                                    "found-image?name="

                                    +

                                    java.net.URLEncoder.encode(
                                        item.getImageName(),
                                        "UTF-8"
                                    );
                            }

                        %>


                        <% if (imageUrl != null) { %>

                            <img
                                src="<%= imageUrl %>"
                                class="item-image"
                                alt="Found Item Image">

                        <% } else { %>

                            <div class="no-image">

                                No Image

                            </div>

                        <% } %>



                        <!-- ITEM INFORMATION -->

                        <div class="item-content">


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
                                    Location:
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



                            <!-- STATUS -->

                            <%

                                String statusClass = "";

                                if ("CLAIMED".equalsIgnoreCase(
                                        item.getStatus())) {

                                    statusClass =
                                        "status-claimed";
                                }

                            %>


                            <span
                                class="status <%= statusClass %>">

                                <%= item.getStatus() %>

                            </span>



                            <!-- =================================
                                 ACTION BUTTONS
                                 ================================= -->

                            <div class="actions">


                                <% if ("CLAIMED".equalsIgnoreCase(
                                        item.getStatus())) { %>


                                    <!-- CLAIMED ITEMS CANNOT BE EDITED -->

                                    <div class="disabled-btn">

                                        Claimed

                                    </div>


                                    <div class="disabled-btn">

                                        Claimed

                                    </div>


                                <% } else { %>


                                    <!-- EDIT -->

                                    <a
                                        href="edit-found.jsp?foundItemId=<%= item.getFoundItemId() %>"
                                        class="edit-btn">

                                        Edit

                                    </a>



                                    <!-- DELETE -->

                                    <form
                                        action="found-item"
                                        method="post"
                                        style="flex:1;"
                                        onsubmit="return confirm('Are you sure you want to delete this found item?');">


                                        <input
                                            type="hidden"
                                            name="action"
                                            value="DELETE">


                                        <input
                                            type="hidden"
                                            name="foundItemId"
                                            value="<%= item.getFoundItemId() %>">


                                        <button
                                            type="submit"
                                            class="delete-btn"
                                            style="width:100%;">

                                            Delete

                                        </button>


                                    </form>


                                <% } %>


                            </div>


                        </div>

                    </div>


                <% } %>


            </div>


        <% } %>


    </div>


</body>

</html>