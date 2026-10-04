<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.campuslostfound.model.User" %>
<%@ page import="com.campuslostfound.model.LostItem" %>
<%@ page import="com.campuslostfound.dao.LostItemDAO" %>

<%
    User user =
            (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idString =
            request.getParameter("lostItemId");

    if (idString == null ||
        idString.trim().isEmpty()) {

        response.sendRedirect(
            "my-lost-items.jsp"
        );

        return;
    }

    int lostItemId;

    try {

        lostItemId =
                Integer.parseInt(idString);

    } catch (NumberFormatException e) {

        response.sendRedirect(
            "my-lost-items.jsp"
        );

        return;
    }

    LostItemDAO dao =
            new LostItemDAO();

    LostItem item = null;

    for (LostItem current :
            dao.getLostItemsByUser(
                user.getUserId()
            )) {

        if (current.getLostItemId()
                == lostItemId) {

            item = current;
            break;
        }
    }

    if (item == null) {

        response.sendRedirect(
            "my-lost-items.jsp?error=notfound"
        );

        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Edit Lost Item</title>

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
        #4f46e5,
        #2563eb
    );

    color: white;

    padding: 18px 40px;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header h2 {
    margin: 0;
}

.header a {
    color: white;
    text-decoration: none;
    border: 1px solid
        rgba(255,255,255,0.5);
    padding: 8px 14px;
    border-radius: 8px;
}

.container {
    max-width: 700px;
    margin: 40px auto;
    padding: 0 20px;
}

.form-card {
    background: white;
    padding: 32px;
    border-radius: 16px;
    box-shadow:
        0 5px 20px rgba(0,0,0,0.06);
}

.form-card h1 {
    margin-top: 0;
    color: #111827;
}

.form-card p {
    color: #6b7280;
}

.form-group {
    margin-bottom: 18px;
}

label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
    color: #374151;
}

input,
select,
textarea {
    width: 100%;
    padding: 11px 12px;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    font-size: 14px;
    font-family: Arial, sans-serif;
}

textarea {
    min-height: 120px;
    resize: vertical;
}

input:focus,
select:focus,
textarea:focus {
    outline: none;
    border-color: #4f46e5;
}

.current-image {
    margin-top: 10px;
    padding: 10px;
    background: #f8fafc;
    border-radius: 8px;
    color: #6b7280;
    font-size: 13px;
}

.buttons {
    display: flex;
    gap: 12px;
    margin-top: 25px;
}

.save-btn,
.cancel-btn {
    border: none;
    text-decoration: none;
    padding: 11px 20px;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
}

.save-btn {
    background: #4f46e5;
    color: white;
}

.cancel-btn {
    background: #e5e7eb;
    color: #374151;
}

.save-btn:hover {
    background: #4338ca;
}

.cancel-btn:hover {
    background: #d1d5db;
}

</style>

</head>

<body>

<div class="header">

    <h2>Campus Lost &amp; Found</h2>

    <a href="student-dashboard.jsp">
        Dashboard
    </a>

</div>


<div class="container">

    <div class="form-card">

        <h1>Edit Lost Item</h1>

        <p>
            Update the details of your lost item.
        </p>


        <form
            action="lost-item"
            method="post"
            enctype="multipart/form-data">

            <input
                type="hidden"
                name="action"
                value="UPDATE">

            <input
                type="hidden"
                name="lostItemId"
                value="<%= item.getLostItemId() %>">


            <div class="form-group">

                <label for="itemName">
                    Item Name
                </label>

                <input
                    type="text"
                    id="itemName"
                    name="itemName"
                    value="<%= item.getItemName() %>"
                    required>

            </div>


            <div class="form-group">

                <label for="category">
                    Category
                </label>

                <select
                    id="category"
                    name="category"
                    required>

                    <option value="">
                        Select Category
                    </option>

                    <option value="Electronics"
                        <%= "Electronics".equals(
                            item.getCategory())
                            ? "selected" : "" %>>
                        Electronics
                    </option>

                    <option value="Documents"
                        <%= "Documents".equals(
                            item.getCategory())
                            ? "selected" : "" %>>
                        Documents
                    </option>

                    <option value="Wallet"
                        <%= "Wallet".equals(
                            item.getCategory())
                            ? "selected" : "" %>>
                        Wallet
                    </option>

                    <option value="Keys"
                        <%= "Keys".equals(
                            item.getCategory())
                            ? "selected" : "" %>>
                        Keys
                    </option>

                    <option value="Bag"
                        <%= "Bag".equals(
                            item.getCategory())
                            ? "selected" : "" %>>
                        Bag
                    </option>

                    <option value="Clothing"
                        <%= "Clothing".equals(
                            item.getCategory())
                            ? "selected" : "" %>>
                        Clothing
                    </option>

                    <option value="Other"
                        <%= "Other".equals(
                            item.getCategory())
                            ? "selected" : "" %>>
                        Other
                    </option>

                </select>

            </div>


            <div class="form-group">

                <label for="description">
                    Description
                </label>

                <textarea
                    id="description"
                    name="description"><%= item.getDescription() == null
                        ? ""
                        : item.getDescription() %></textarea>

            </div>


            <div class="form-group">

                <label for="locationLost">
                    Location Lost
                </label>

                <input
                    type="text"
                    id="locationLost"
                    name="locationLost"
                    value="<%= item.getLocationLost() %>"
                    required>

            </div>


            <div class="form-group">

                <label for="dateLost">
                    Date Lost
                </label>

                <input
                    type="date"
                    id="dateLost"
                    name="dateLost"
                    value="<%= item.getDateLost() %>"
                    required>

            </div>


            <div class="form-group">

                <label for="image">
                    Replace Image
                </label>

                <input
                    type="file"
                    id="image"
                    name="image"
                    accept="image/*">

                <% if (item.getImageName() != null &&
                       !item.getImageName().trim().isEmpty()) {
                %>

                    <div class="current-image">
                        Current image exists.
                        Leave this field empty
                        to keep the current image.
                    </div>

                <% } %>

            </div>


            <div class="buttons">

                <button
                    type="submit"
                    class="save-btn">
                    Update Lost Item
                </button>

                <a
                    href="my-lost-items.jsp"
                    class="cancel-btn">
                    Cancel
                </a>

            </div>

        </form>

    </div>

</div>

</body>

</html>