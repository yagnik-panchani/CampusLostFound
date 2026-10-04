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

    <title>Report Found Item - Campus Lost &amp; Found</title>


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


        /* ======================================
           HEADER
           ====================================== */

        .header {

            background: linear-gradient(
                135deg,
                #059669,
                #047857
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

            padding: 10px 18px;

            border: 1px solid rgba(255,255,255,0.6);

            border-radius: 8px;

            font-weight: 600;

            transition: 0.2s;
        }


        .back-link:hover {

            background: rgba(255,255,255,0.15);
        }


        /* ======================================
           MAIN
           ====================================== */

        .container {

            max-width: 850px;

            margin: 45px auto;

            padding: 0 20px;
        }


        .form-card {

            background: white;

            border-radius: 20px;

            padding: 40px;

            box-shadow:
                0 10px 30px rgba(0,0,0,0.08);
        }


        .title {

            text-align: center;

            margin-bottom: 35px;
        }


        .title h1 {

            font-size: 32px;

            margin-bottom: 10px;
        }


        .title p {

            color: #6b7280;

            font-size: 16px;
        }


        /* ======================================
           FORM
           ====================================== */

        .form-group {

            margin-bottom: 22px;
        }


        .form-group label {

            display: block;

            margin-bottom: 8px;

            font-weight: 600;

            color: #172033;
        }


        .required {

            color: #dc2626;
        }


        input,
        select,
        textarea {

            width: 100%;

            padding: 13px 14px;

            border: 1px solid #d1d5db;

            border-radius: 9px;

            font-size: 15px;

            font-family: Arial, Helvetica, sans-serif;

            outline: none;

            transition: 0.2s;
        }


        input:focus,
        select:focus,
        textarea:focus {

            border-color: #059669;

            box-shadow:
                0 0 0 3px rgba(5,150,105,0.10);
        }


        textarea {

            min-height: 130px;

            resize: vertical;
        }


        .two-column {

            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 20px;
        }


        /* ======================================
           IMAGE UPLOAD
           ====================================== */

        .image-box {

            border: 2px dashed #a7f3d0;

            background: #ecfdf5;

            padding: 25px;

            border-radius: 12px;

            text-align: center;
        }


        .image-box p {

            color: #047857;

            margin-bottom: 12px;

            font-weight: 600;
        }


        .image-box input {

            border: none;

            padding: 5px;

            background: transparent;
        }


        /* ======================================
           BUTTON
           ====================================== */

        .submit-btn {

            width: 100%;

            padding: 14px;

            border: none;

            border-radius: 10px;

            background: linear-gradient(
                135deg,
                #059669,
                #047857
            );

            color: white;

            font-size: 16px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.2s;
        }


        .submit-btn:hover {

            transform: translateY(-1px);

            box-shadow:
                0 8px 18px rgba(5,150,105,0.25);
        }


        .note {

            margin-top: 18px;

            padding: 12px 15px;

            background: #f0fdf4;

            border-left: 4px solid #059669;

            color: #166534;

            font-size: 14px;

            line-height: 1.5;
        }


        /* ======================================
           MOBILE
           ====================================== */

        @media (max-width: 650px) {

            .header {

                padding: 18px 20px;
            }


            .logo {

                font-size: 21px;
            }


            .form-card {

                padding: 25px 20px;
            }


            .two-column {

                grid-template-columns: 1fr;
            }


            .title h1 {

                font-size: 27px;
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
         FORM
         ====================================== -->

    <main class="container">

        <div class="form-card">


            <div class="title">

                <h1>
                    Report a Found Item
                </h1>

                <p>
                    Help return an item to its owner.
                </p>

            </div>



            <form
                action="found-item"
                method="post"
                enctype="multipart/form-data">


                <!-- ITEM NAME -->

                <div class="form-group">

                    <label for="itemName">

                        Item Name
                        <span class="required">*</span>

                    </label>

                    <input
                        type="text"
                        id="itemName"
                        name="itemName"
                        placeholder="Example: Black Wallet"
                        required>

                </div>



                <!-- CATEGORY -->

                <div class="form-group">

                    <label for="category">

                        Category
                        <span class="required">*</span>

                    </label>

                    <select
                        id="category"
                        name="category"
                        required>

                        <option value="">
                            Select Category
                        </option>

                        <option value="Electronics">
                            Electronics
                        </option>

                        <option value="Mobile">
                            Mobile
                        </option>

                        <option value="Wallet">
                            Wallet
                        </option>

                        <option value="Books">
                            Books
                        </option>

                        <option value="ID Card">
                            ID Card
                        </option>

                        <option value="Bag">
                            Bag
                        </option>

                        <option value="Keys">
                            Keys
                        </option>

                        <option value="Other">
                            Other
                        </option>

                    </select>

                </div>



                <!-- DATE + LOCATION -->

                <div class="two-column">


                    <div class="form-group">

                        <label for="dateFound">

                            Date Found
                            <span class="required">*</span>

                        </label>

                        <input
                            type="date"
                            id="dateFound"
                            name="dateFound"
                            required>

                    </div>



                    <div class="form-group">

                        <label for="locationFound">

                            Location Found
                            <span class="required">*</span>

                        </label>

                        <input
                            type="text"
                            id="locationFound"
                            name="locationFound"
                            placeholder="Example: College Library"
                            required>

                    </div>

                </div>



                <!-- DESCRIPTION -->

                <div class="form-group">

                    <label for="description">

                        Description

                    </label>

                    <textarea
                        id="description"
                        name="description"
                        placeholder="Describe the item, color, identifying marks, etc."></textarea>

                </div>



                <!-- IMAGE -->

                <div class="form-group">

                    <label>

                        Item Image

                    </label>


                    <div class="image-box">

                        <p>
                            Upload a clear photo of the found item
                        </p>

                        <input
                            type="file"
                            name="image"
                            accept="image/*">

                    </div>

                </div>



                <!-- NOTE -->

                <div class="note">

                    Please do not include sensitive personal information
                    in the item description.

                </div>


                <br>


                <!-- SUBMIT -->

                <button
                    type="submit"
                    class="submit-btn">

                    Report Found Item

                </button>


            </form>

        </div>

    </main>


</body>

</html>