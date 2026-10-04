
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.campuslostfound.model.User" %>
<%@ page import="com.campuslostfound.dao.UserDAO" %>

<%
    // =========================================================
    // CHECK LOGIN
    // =========================================================

    User admin =
        (User) session.getAttribute("user");

    if (admin == null) {

        response.sendRedirect("login.jsp");
        return;
    }


    // =========================================================
    // CHECK ADMIN ROLE
    // =========================================================

    if (!"ADMIN".equalsIgnoreCase(
            admin.getRole())) {

        response.sendRedirect(
            "student-dashboard.jsp"
        );

        return;
    }


    // =========================================================
    // GET ALL STUDENTS
    // =========================================================

    UserDAO userDAO =
        new UserDAO();

    List<User> students =
        userDAO.getAllStudents();
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
        Student Accounts - Admin
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

            justify-content: space-between;

            align-items: center;
        }


        .header h2 {

            margin: 0;

            font-size: 24px;
        }


        .header-actions {

            display: flex;

            gap: 10px;
        }


        .header-btn {

            color: white;

            text-decoration: none;

            border:
                1px solid
                rgba(255,255,255,0.5);

            padding: 9px 15px;

            border-radius: 8px;

            font-size: 14px;
        }


        .header-btn:hover {

            background:
                rgba(255,255,255,0.12);
        }


        /* =====================================================
           CONTAINER
           ===================================================== */

        .container {

            max-width: 1200px;

            margin: 40px auto;

            padding: 0 25px;
        }


        /* =====================================================
           PAGE HEADER
           ===================================================== */

        .page-header {

            background: white;

            padding: 25px;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);

            margin-bottom: 25px;
        }


        .page-header h1 {

            margin: 0 0 8px;

            color: #111827;

            font-size: 30px;
        }


        .page-header p {

            margin: 0;

            color: #6b7280;

            font-size: 16px;
        }


        /* =====================================================
           SUMMARY
           ===================================================== */

        .summary {

            display: inline-block;

            margin-top: 18px;

            padding: 10px 16px;

            background: #eef2ff;

            color: #4338ca;

            border-radius: 8px;

            font-weight: bold;
        }


        /* =====================================================
           TABLE CARD
           ===================================================== */

        .table-card {

            background: white;

            border-radius: 15px;

            box-shadow:
                0 5px 20px
                rgba(0,0,0,0.06);

            overflow: hidden;
        }


        .table-wrapper {

            overflow-x: auto;
        }


        table {

            width: 100%;

            border-collapse: collapse;

            min-width: 750px;
        }


        thead {

            background: #f8fafc;
        }


        th {

            text-align: left;

            padding: 16px 18px;

            font-size: 13px;

            color: #6b7280;

            text-transform: uppercase;

            letter-spacing: 0.4px;

            border-bottom:
                1px solid #e5e7eb;
        }


        td {

            padding: 17px 18px;

            border-bottom:
                1px solid #f0f0f0;

            font-size: 14px;

            color: #374151;
        }


        tbody tr:hover {

            background: #f9fafb;
        }


        tbody tr:last-child td {

            border-bottom: none;
        }


        /* =====================================================
           USER ID
           ===================================================== */

        .user-id {

            color: #6b7280;

            font-weight: bold;
        }


        /* =====================================================
           NAME
           ===================================================== */

        .student-name {

            color: #111827;

            font-weight: bold;
        }


        /* =====================================================
           EMAIL
           ===================================================== */

        .email {

            color: #2563eb;
        }


        /* =====================================================
           PHONE
           ===================================================== */

        .phone {

            color: #374151;
        }


        .not-provided {

            color: #9ca3af;

            font-style: italic;
        }


        /* =====================================================
           ROLE BADGE
           ===================================================== */

        .role-badge {

            display: inline-block;

            padding: 6px 10px;

            border-radius: 20px;

            background: #dcfce7;

            color: #166534;

            font-size: 12px;

            font-weight: bold;
        }


        /* =====================================================
           EMPTY STATE
           ===================================================== */

        .empty {

            text-align: center;

            padding: 60px 20px;
        }


        .empty h2 {

            margin:
                0 0 10px;

            color: #111827;
        }


        .empty p {

            margin: 0;

            color: #6b7280;
        }


        /* =====================================================
           RESPONSIVE
           ===================================================== */

        @media (max-width: 600px) {

            .header {

                padding: 18px 20px;

                flex-direction: column;

                align-items: flex-start;

                gap: 15px;
            }


            .header h2 {

                font-size: 20px;
            }


            .header-actions {

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


            .page-header h1 {

                font-size: 25px;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     HEADER
     ========================================================= -->

<div class="header">

    <h2>
        Campus Lost &amp; Found
    </h2>


    <div class="header-actions">

        <a
            href="admin-dashboard.jsp"
            class="header-btn"
        >
            Dashboard
        </a>


        <a
            href="logout"
            class="header-btn"
        >
            Logout
        </a>

    </div>

</div>


<!-- =========================================================
     MAIN
     ========================================================= -->

<div class="container">


    <!-- =====================================================
         PAGE HEADER
         ===================================================== -->

    <div class="page-header">

        <h1>
            Student Accounts
        </h1>

        <p>
            View all registered students
            in the Campus Lost &amp; Found system.
        </p>


        <div class="summary">

            Total Students:

            <%= students.size() %>

        </div>

    </div>


    <!-- =====================================================
         STUDENT TABLE
         ===================================================== -->

    <div class="table-card">


        <% if (students == null || students.isEmpty()) { %>


            <!-- EMPTY STATE -->

            <div class="empty">

                <h2>
                    No Student Accounts
                </h2>

                <p>
                    No student accounts have been
                    registered yet.
                </p>

            </div>


        <% } else { %>


            <!-- STUDENT TABLE -->

            <div class="table-wrapper">

                <table>

                    <thead>

                        <tr>

                            <th>
                                ID
                            </th>

                            <th>
                                Student Name
                            </th>

                            <th>
                                Email
                            </th>

                            <th>
                                Phone
                            </th>

                            <th>
                                Role
                            </th>

                        </tr>

                    </thead>


                    <tbody>


                    <% for (User student : students) { %>


                        <tr>


                            <!-- USER ID -->

                            <td class="user-id">

                                #<%= student.getUserId() %>

                            </td>


                            <!-- STUDENT NAME -->

                            <td class="student-name">

                                <%= student.getName() %>

                            </td>


                            <!-- EMAIL -->

                            <td class="email">

                                <%= student.getEmail() %>

                            </td>


                            <!-- PHONE -->

                            <td class="phone">

                                <%
                                    String phone =
                                        student.getPhone();

                                    if (
                                        phone != null &&
                                        !phone.trim().isEmpty()
                                    ) {
                                %>

                                    <%= phone %>

                                <%
                                    } else {
                                %>

                                    <span class="not-provided">
                                        Not provided
                                    </span>

                                <%
                                    }
                                %>

                            </td>


                            <!-- ROLE -->

                            <td>

                                <span class="role-badge">

                                    <%= student.getRole() %>

                                </span>

                            </td>


                        </tr>


                    <% } %>


                    </tbody>

                </table>

            </div>


        <% } %>


    </div>


</div>


</body>

</html>
