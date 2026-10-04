<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.campuslostfound.model.User" %>

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
%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <title>Student Dashboard</title>


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
                #4f46e5,
                #2563eb
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


        .logout {

            color: white;

            text-decoration: none;

            border: 1px solid
                    rgba(255,255,255,0.5);

            padding: 8px 15px;

            border-radius: 8px;

            transition: 0.3s;
        }


        .logout:hover {

            background:
                rgba(255,255,255,0.15);
        }


        /* =====================================
           MAIN CONTAINER
           ===================================== */

        .container {

            max-width: 1100px;

            margin: 40px auto;

            padding: 0 25px;
        }


        /* =====================================
           WELCOME
           ===================================== */

        .welcome {

            background: white;

            padding: 30px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);

            margin-bottom: 30px;
        }


        .welcome h1 {

            margin-top: 0;

            margin-bottom: 10px;

            color: #111827;
        }


        .welcome p {

            color: #6b7280;

            line-height: 1.6;
        }


        .welcome strong {

            color: #111827;
        }


        /* =====================================
           CARDS
           ===================================== */

        .cards {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;
        }


        .card {

            background: white;

            padding: 25px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);

            transition: 0.3s;
        }


        .card:hover {

            transform:
                translateY(-5px);

            box-shadow:
                0 10px 25px
                rgba(0,0,0,0.10);
        }


        .card h3 {

            margin-top: 0;

            margin-bottom: 12px;

            color: #4f46e5;
        }


        .card p {

            color: #6b7280;

            line-height: 1.5;

            min-height: 48px;
        }


        .card a {

            display: inline-block;

            margin-top: 10px;

            text-decoration: none;

            color: #2563eb;

            font-weight: bold;
        }


        .card a:hover {

            text-decoration: underline;
        }


        /* =====================================
           RESPONSIVE
           ===================================== */

        @media (max-width: 900px) {

            .cards {

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


            .cards {

                grid-template-columns: 1fr;
            }


            .welcome {

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
            class="logout"
            href="logout"
        >
            Logout
        </a>

    </div>


    <!-- =====================================
         MAIN CONTAINER
         ===================================== -->

    <div class="container">


        <!-- =================================
             WELCOME SECTION
             ================================= -->

        <div class="welcome">

            <h1>
                Welcome, <%= user.getName() %>
            </h1>


            <p>
                Manage your lost and found activities
                from your dashboard.
            </p>


            <p>

                Email:

                <strong>
                    <%= user.getEmail() %>
                </strong>

            </p>

        </div>


        <!-- =================================
             DASHBOARD CARDS
             ================================= -->

        <div class="cards">


            <!-- =================================
                 REPORT LOST
                 ================================= -->

            <div class="card">

                <h3>
                    Report Lost
                </h3>


                <p>
                    Report an item you have lost.
                </p>


                <a href="report-lost.jsp">
                    Report Item &rarr;
                </a>

            </div>


            <!-- =================================
                 REPORT FOUND
                 ================================= -->

            <div class="card">

                <h3>
                    Report Found
                </h3>


                <p>
                    Report an item you found.
                </p>


                <a href="report-found.jsp">
                    Report Item &rarr;
                </a>

            </div>


            <!-- =================================
                 BROWSE FOUND ITEMS
                 ================================= -->

            <div class="card">

                <h3>
                    Browse Found
                </h3>


                <p>
                    Search items reported by
                    other students.
                </p>


                <a href="browse-found-items.jsp">
                    Browse Items &rarr;
                </a>

            </div>


            <!-- =================================
                 MY ITEMS
                 ================================= -->

            <div class="card">

                <h3>
                    My Items
                </h3>


                <p>
                    View your reported lost
                    and found items.
                </p>


                <a href="my-lost-items.jsp">
                    Lost Items &rarr;
                </a>


                <br>


                <a href="my-found-items.jsp">
                    Found Items &rarr;
                </a>

            </div>


            <!-- =================================
                 MY CLAIMS
                 ================================= -->

            <div class="card">

                <h3>
                    My Claims
                </h3>


                <p>
                    Track your item claim requests.
                </p>


                <a href="my-claims.jsp">
                    View Claims &rarr;
                </a>

            </div>


        </div>


    </div>


</body>

</html>