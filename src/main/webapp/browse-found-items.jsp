<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>

<%@ page import="com.campuslostfound.model.User" %>
<%@ page import="com.campuslostfound.model.FoundItem" %>
<%@ page import="com.campuslostfound.dao.FoundItemDAO" %>

<%
    User user =
            (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }


    FoundItemDAO dao =
            new FoundItemDAO();

    List<FoundItem> foundItems =
            dao.getAllFoundItems();
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Browse Found Items</title>

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

        .dashboard-btn {
            color: white;
            text-decoration: none;

            border: 1px solid
                rgba(255,255,255,0.6);

            padding: 8px 15px;

            border-radius: 8px;
        }

        .dashboard-btn:hover {
            background:
                rgba(255,255,255,0.15);
        }

        .container {
            max-width: 1150px;

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

        .items-grid {
            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 22px;
        }

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
            transform: translateY(-5px);

            box-shadow:
                0 10px 25px
                rgba(0,0,0,0.10);
        }

        .item-image {
            width: 100%;

            height: 220px;

            object-fit: cover;

            display: block;
        }

        .no-image {
            width: 100%;

            height: 220px;

            display: flex;

            align-items: center;

            justify-content: center;

            background: #f3f4f6;

            color: #9ca3af;
        }

        .item-content {
            padding: 20px;
        }

        .item-content h3 {
            margin: 0 0 12px 0;

            color: #111827;

            font-size: 22px;
        }

        .item-content p {
            margin: 8px 0;

            line-height: 1.5;

            color: #6b7280;
        }

        .item-content strong {
            color: #374151;
        }

        .status {
            display: inline-block;

            margin-top: 8px;

            padding: 6px 12px;

            border-radius: 20px;

            background: #dcfce7;

            color: #166534;

            font-size: 13px;

            font-weight: bold;
        }

        .claim-btn {
            display: block;

            width: 100%;

            margin-top: 18px;

            padding: 12px;

            text-align: center;

            text-decoration: none;

            background: #059669;

            color: white;

            border-radius: 8px;

            font-weight: bold;
        }

        .claim-btn:hover {
            background: #047857;
        }

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
        }

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
        }

    </style>

</head>


<body>


<div class="header">

    <h2>
        Campus Lost &amp; Found
    </h2>

    <a
        href="student-dashboard.jsp"
        class="dashboard-btn"
    >
        Dashboard
    </a>

</div>


<div class="container">


    <div class="page-title">

        <h1>
            Browse Found Items
        </h1>

        <p>
            View items reported as found by students
            on campus.
        </p>

    </div>


    <% if (foundItems.isEmpty()) { %>

        <div class="empty-box">

            <h2>
                No Found Items
            </h2>

            <p>
                There are currently no found items
                reported on the network.
            </p>

        </div>

    <% } else { %>


        <div class="items-grid">


            <% for (FoundItem item : foundItems) { %>


                <div class="item-card">


                    <%
                        String imageUrl = null;

                        if (item.getImageName() != null
                                && !item.getImageName().isEmpty()) {

                            String encodedFileName =
                                URLEncoder.encode(
                                    item.getImageName(),
                                    "UTF-8"
                                );

                            imageUrl =
                                "found-image?name="
                                + encodedFileName;
                        }
                    %>


                    <% if (imageUrl != null) { %>

                        <img
                            src="<%= imageUrl %>"
                            class="item-image"
                            alt="Found Item Image"
                        >

                    <% } else { %>

                        <div class="no-image">
                            No Image
                        </div>

                    <% } %>


                    <div class="item-content">

                        <h3>
                            <%= item.getItemName() %>
                        </h3>


                        <p>
                            <strong>Category:</strong>
                            <%= item.getCategory() %>
                        </p>


                        <p>
                            <strong>Location:</strong>
                            <%= item.getLocationFound() %>
                        </p>


                        <p>
                            <strong>Date Found:</strong>
                            <%= item.getDateFound() %>
                        </p>


                        <p>
                            <strong>Description:</strong>
                            <%= item.getDescription() %>
                        </p>


                        <span class="status">
                            <%= item.getStatus() %>
                        </span>


                        <a
                            href="claim-item.jsp?foundItemId=<%= item.getFoundItemId() %>"
                            class="claim-btn"
                        >
                            Claim This Item
                        </a>

                    </div>

                </div>


            <% } %>


        </div>


    <% } %>


</div>


</body>

</html>