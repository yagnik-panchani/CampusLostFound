<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="com.campuslostfound.model.User" %>

<%
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

<title>Report Lost Item</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: "Segoe UI", Arial, sans-serif;
    background: #f4f7fb;
}

.header {
    background: linear-gradient(
        135deg,
        #4f46e5,
        #2563eb
    );

    color: white;

    padding: 20px 50px;

    display: flex;

    justify-content: space-between;

    align-items: center;
}

.header h2 {
    margin: 0;
}

.back {
    color: white;
    text-decoration: none;
}

.container {
    max-width: 850px;
    margin: 45px auto;
    padding: 0 20px;
}

.form-card {
    background: white;
    padding: 40px;
    border-radius: 20px;

    box-shadow:
        0 10px 35px rgba(0,0,0,0.08);
}

.form-card h1 {
    margin-top: 0;
    color: #111827;
}

.subtitle {
    color: #6b7280;
    margin-bottom: 30px;
}

.form-group {
    margin-bottom: 20px;
}

label {
    display: block;
    font-weight: 600;
    color: #374151;
    margin-bottom: 8px;
}

input,
select,
textarea {
    width: 100%;

    padding: 13px;

    border: 1px solid #dfe3ea;

    border-radius: 10px;

    font-size: 14px;

    outline: none;
}

input:focus,
select:focus,
textarea:focus {
    border-color: #4f46e5;

    box-shadow:
        0 0 0 3px rgba(79,70,229,0.10);
}

textarea {
    min-height: 120px;
    resize: vertical;
}

.row {
    display: grid;

    grid-template-columns:
        1fr 1fr;

    gap: 20px;
}

.file-box {
    border: 2px dashed #cbd5e1;

    padding: 25px;

    text-align: center;

    border-radius: 12px;

    background: #f8fafc;
}

.submit-btn {
    width: 100%;

    padding: 14px;

    border: none;

    border-radius: 10px;

    background:
        linear-gradient(
            135deg,
            #4f46e5,
            #2563eb
        );

    color: white;

    font-size: 15px;

    font-weight: 600;

    cursor: pointer;
}

.submit-btn:hover {
    transform: translateY(-1px);
}

@media(max-width:700px) {

    .row {
        grid-template-columns: 1fr;
    }

    .form-card {
        padding: 25px;
    }

}

</style>

</head>

<body>


<div class="header">

    <h2>
        Campus Lost & Found
    </h2>

    <a class="back"
       href="student-dashboard.jsp">

        Back to Dashboard

    </a>

</div>


<div class="container">


<div class="form-card">

    <h1>
        Report a Lost Item
    </h1>

    <p class="subtitle">
        Tell us about the item you lost so
        other students can help you find it.
    </p>


    <form
        action="lost-item"
        method="post"
        enctype="multipart/form-data">


        <div class="form-group">

            <label>
                Item Name
            </label>

            <input
                type="text"
                name="itemName"
                placeholder="Example: HP Laptop"
                required>

        </div>


        <div class="row">


            <div class="form-group">

                <label>
                    Category
                </label>

                <select name="category"
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


            <div class="form-group">

                <label>
                    Date Lost
                </label>

                <input
                    type="date"
                    name="dateLost"
                    required>

            </div>


        </div>


        <div class="form-group">

            <label>
                Location Lost
            </label>

            <input
                type="text"
                name="locationLost"
                placeholder="Example: College Library"
                required>

        </div>


        <div class="form-group">

            <label>
                Description
            </label>

            <textarea
                name="description"
                placeholder="Describe the item, color, marks, stickers, etc."
                required></textarea>

        </div>


        <div class="form-group">

            <label>
                Item Photo
            </label>

            <div class="file-box">

                <input
                    type="file"
                    name="image"
                    accept="image/*">

                <p>
                    Upload a clear photo of the lost item
                </p>

            </div>

        </div>


        <button
            type="submit"
            class="submit-btn">

            Report Lost Item

        </button>


    </form>


</div>


</div>

</body>

</html>