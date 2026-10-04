
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page import="com.campuslostfound.model.User" %>
<%@ page import="com.campuslostfound.util.DBConnection" %>


<%
    // =========================================================
    // CHECK LOGIN
    // =========================================================

    User user =
        (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("login.jsp");

        return;
    }


    // =========================================================
    // CHECK ADMIN ROLE
    // =========================================================

    if (!"ADMIN".equalsIgnoreCase(user.getRole())) {

        response.sendRedirect(
            "student-dashboard.jsp"
        );

        return;
    }


    // =========================================================
    // DASHBOARD COUNTS
    // =========================================================

    int totalStudents = 0;
    int totalLostItems = 0;
    int totalFoundItems = 0;
    int pendingClaims = 0;
    int approvedClaims = 0;
    int claimedItems = 0;


    // =========================================================
    // GET COUNTS FROM DATABASE
    // =========================================================

    try (
        Connection connection =
            DBConnection.getConnection()
    ) {


        // -----------------------------------------------------
        // 1. TOTAL STUDENTS
        // -----------------------------------------------------

        String studentSql =
            "SELECT COUNT(*) " +
            "FROM users " +
            "WHERE role = 'STUDENT'";

        try (
            PreparedStatement statement =
                connection.prepareStatement(studentSql);

            ResultSet rs =
                statement.executeQuery()
        ) {

            if (rs.next()) {

                totalStudents =
                    rs.getInt(1);
            }
        }


        // -----------------------------------------------------
        // 2. TOTAL LOST ITEMS
        // -----------------------------------------------------

        String lostSql =
            "SELECT COUNT(*) " +
            "FROM lost_items";

        try (
            PreparedStatement statement =
                connection.prepareStatement(lostSql);

            ResultSet rs =
                statement.executeQuery()
        ) {

            if (rs.next()) {

                totalLostItems =
                    rs.getInt(1);
            }
        }


        // -----------------------------------------------------
        // 3. TOTAL FOUND ITEMS
        // -----------------------------------------------------

        String foundSql =
            "SELECT COUNT(*) " +
            "FROM found_items";

        try (
            PreparedStatement statement =
                connection.prepareStatement(foundSql);

            ResultSet rs =
                statement.executeQuery()
        ) {

            if (rs.next()) {

                totalFoundItems =
                    rs.getInt(1);
            }
        }


        // -----------------------------------------------------
        // 4. PENDING CLAIMS
        // -----------------------------------------------------

        String pendingSql =
            "SELECT COUNT(*) " +
            "FROM claims " +
            "WHERE status = 'PENDING'";

        try (
            PreparedStatement statement =
                connection.prepareStatement(pendingSql);

            ResultSet rs =
                statement.executeQuery()
        ) {

            if (rs.next()) {

                pendingClaims =
                    rs.getInt(1);
            }
        }


        // -----------------------------------------------------
        // 5. APPROVED CLAIMS
        // -----------------------------------------------------

        String approvedSql =
            "SELECT COUNT(*) " +
            "FROM claims " +
            "WHERE status = 'APPROVED'";

        try (
            PreparedStatement statement =
                connection.prepareStatement(approvedSql);

            ResultSet rs =
                statement.executeQuery()
        ) {

            if (rs.next()) {

                approvedClaims =
                    rs.getInt(1);
            }
        }


        // -----------------------------------------------------
        // 6. CLAIMED ITEMS
        // -----------------------------------------------------

        String claimedSql =
            "SELECT COUNT(*) " +
            "FROM found_items " +
            "WHERE status = 'CLAIMED'";

        try (
            PreparedStatement statement =
                connection.prepareStatement(claimedSql);

            ResultSet rs =
                statement.executeQuery()
        ) {

            if (rs.next()) {

                claimedItems =
                    rs.getInt(1);
            }
        }


    } catch (Exception e) {

        e.printStackTrace();
    }

%>


<!DOCTYPE html>

<html>

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>
        Admin Dashboard - Campus Lost &amp; Found
    </title>


    <style>

        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            font-family:
                Arial,
                Helvetica,
                sans-serif;

            background: #f5f7fb;

            color: #374151;
        }


        /* =====================================================
           HEADER
           ===================================================== */

        .header {

            background:
                linear-gradient(
                    135deg,
                    #111827,
                    #374151
                );

            color: white;

            padding: 20px 40px;

            display: flex;

            justify-content:
                space-between;

            align-items: center;
        }


        .header-left h2 {

            margin: 0;

            font-size: 24px;

            font-weight: 700;
        }


        .header-left p {

            margin: 5px 0 0;

            font-size: 13px;

            color: #d1d5db;
        }


        .header-right {

            display: flex;

            gap: 10px;

            align-items: center;
        }


        .header-btn {

            display: inline-block;

            color: white;

            text-decoration: none;

            border:
                1px solid
                rgba(255,255,255,0.45);

            padding: 9px 15px;

            border-radius: 8px;

            font-size: 14px;

            transition: 0.25s;
        }


        .header-btn:hover {

            background:
                rgba(255,255,255,0.12);
        }


        /* =====================================================
           MAIN CONTAINER
           ===================================================== */

        .container {

            max-width: 1200px;

            margin: 40px auto;

            padding: 0 25px;
        }


        /* =====================================================
           WELCOME
           ===================================================== */

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

            margin:
                0 0 10px;

            color: #111827;

            font-size: 28px;
        }


        .welcome p {

            margin: 0;

            color: #6b7280;

            font-size: 15px;
        }


        /* =====================================================
           STATISTICS
           ===================================================== */

        .stats-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;

            margin-bottom: 40px;
        }


        .stat-card {

            background: white;

            padding: 25px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);

            border-left:
                5px solid #4f46e5;
        }


        .stat-card.students {

            border-left-color: #4f46e5;
        }


        .stat-card.lost {

            border-left-color: #dc2626;
        }


        .stat-card.found {

            border-left-color: #059669;
        }


        .stat-card.pending {

            border-left-color: #d97706;
        }


        .stat-card.approved {

            border-left-color: #2563eb;
        }


        .stat-card.claimed {

            border-left-color: #7c3aed;
        }


        .stat-title {

            color: #6b7280;

            font-size: 14px;

            font-weight: 600;

            margin-bottom: 10px;
        }


        .stat-number {

            color: #111827;

            font-size: 32px;

            font-weight: 700;
        }


        /* =====================================================
           ADMINISTRATION
           ===================================================== */

        .section-title {

            margin:
                0 0 20px;

            color: #111827;

            font-size: 24px;
        }


        .action-grid {

            display: grid;

            grid-template-columns:
                repeat(3, 1fr);

            gap: 20px;
        }


        .action-card {

            background: white;

            padding: 25px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);
        }


        .action-card h3 {

            margin:
                0 0 10px;

            color: #111827;
        }


        .action-card p {

            color: #6b7280;

            font-size: 14px;

            line-height: 1.6;

            min-height: 65px;

            margin-bottom: 20px;
        }


        .action-btn {

            display: inline-block;

            text-decoration: none;

            background: #4f46e5;

            color: white;

            padding:
                10px 16px;

            border-radius: 8px;

            font-size: 14px;

            font-weight: 600;

            transition: 0.25s;
        }


        .action-btn:hover {

            opacity: 0.9;
        }


        .green-btn {

            background: #059669;
        }


        .orange-btn {

            background: #d97706;
        }


        /* =====================================================
           FOOTER
           ===================================================== */

        .footer {

            text-align: center;

            margin-top: 40px;

            padding: 20px;

            color: #9ca3af;

            font-size: 13px;
        }


        /* =====================================================
           TABLET
           ===================================================== */

        @media (max-width: 900px) {

            .stats-grid {

                grid-template-columns:
                    repeat(2, 1fr);
            }


            .action-grid {

                grid-template-columns:
                    repeat(2, 1fr);
            }
        }


        /* =====================================================
           MOBILE
           ===================================================== */

        @media (max-width: 600px) {

            .header {

                padding: 18px 20px;

                flex-direction: column;

                align-items: flex-start;

                gap: 15px;
            }


            .header-left h2 {

                font-size: 20px;
            }


            .header-right {

                width: 100%;
            }


            .header-btn {

                flex: 1;

                text-align: center;
            }


            .container {

                margin: 25px auto;

                padding: 0 15px;
            }


            .welcome {

                padding: 22px;
            }


            .welcome h1 {

                font-size: 23px;
            }


            .stats-grid {

                grid-template-columns: 1fr;
            }


            .action-grid {

                grid-template-columns: 1fr;
            }
        }

    </style>

</head>


<body>


<!-- =====================================================
     HEADER
     ===================================================== -->

<div class="header">

    <div class="header-left">

        <h2>
            Campus Lost &amp; Found
        </h2>

        <p>
            Administrator Control Panel
        </p>

    </div>


    <div class="header-right">

        <a
            href="student-dashboard.jsp"
            class="header-btn"
        >
            Student View
        </a>


        <a
            href="logout"
            class="header-btn"
        >
            Logout
        </a>

    </div>

</div>


<!-- =====================================================
     MAIN
     ===================================================== -->

<div class="container">


    <!-- =================================================
         WELCOME
         ================================================= -->

    <div class="welcome">

        <h1>
            Welcome, Administrator
        </h1>

        <p>
            Monitor and manage the Campus Lost &amp;
            Found Network from this dashboard.
        </p>

    </div>


    <!-- =================================================
         STATISTICS
         ================================================= -->

    <div class="stats-grid">


        <!-- TOTAL STUDENTS -->

        <div class="stat-card students">

            <div class="stat-title">
                Total Students
            </div>

            <div class="stat-number">
                <%= totalStudents %>
            </div>

        </div>


        <!-- TOTAL LOST ITEMS -->

        <div class="stat-card lost">

            <div class="stat-title">
                Total Lost Items
            </div>

            <div class="stat-number">
                <%= totalLostItems %>
            </div>

        </div>


        <!-- TOTAL FOUND ITEMS -->

        <div class="stat-card found">

            <div class="stat-title">
                Total Found Items
            </div>

            <div class="stat-number">
                <%= totalFoundItems %>
            </div>

        </div>


        <!-- PENDING CLAIMS -->

        <div class="stat-card pending">

            <div class="stat-title">
                Pending Claims
            </div>

            <div class="stat-number">
                <%= pendingClaims %>
            </div>

        </div>


        <!-- APPROVED CLAIMS -->

        <div class="stat-card approved">

            <div class="stat-title">
                Approved Claims
            </div>

            <div class="stat-number">
                <%= approvedClaims %>
            </div>

        </div>


        <!-- CLAIMED ITEMS -->

        <div class="stat-card claimed">

            <div class="stat-title">
                Claimed Items
            </div>

            <div class="stat-number">
                <%= claimedItems %>
            </div>

        </div>

    </div>


    <!-- =================================================
         ADMINISTRATION
         ================================================= -->

    <h2 class="section-title">
        Administration
    </h2>


    <div class="action-grid">


        <!-- MANAGE CLAIMS -->

        <div class="action-card">

            <h3>
                Manage Claims
            </h3>

            <p>
                Review pending student claims
                and approve or reject claim requests.
            </p>

            <a
                href="admin-claims.jsp"
                class="action-btn"
            >
                Review Claims
            </a>

        </div>


        <!-- FOUND ITEMS -->

        <div class="action-card">

            <h3>
                Found Items
            </h3>

            <p>
                Browse all items reported as found
                by students on campus.
            </p>

            <a
                href="browse-found-items.jsp"
                class="action-btn green-btn"
            >
                View Found Items
            </a>

        </div>


        <!-- STUDENT ACCOUNTS -->

        <div class="action-card">

            <h3>
                Student Accounts
            </h3>

            <p>
                View all registered student
                accounts and their basic information.
            </p>

            <a
                href="admin-students.jsp"
                class="action-btn orange-btn"
            >
                View Students
            </a>

        </div>

    </div>


    <!-- =================================================
         FOOTER
         ================================================= -->

    <div class="footer">

        Campus Lost &amp; Found Network

        &nbsp;|&nbsp;

        Administrator Panel

    </div>


</div>


</body>

</html>

