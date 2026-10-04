<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String name = (String) request.getAttribute("registeredName");


if (name == null || name.trim().isEmpty()) {
    name = "Student";
}


%>

<!DOCTYPE html>

<html>

<head>

```
<meta charset="UTF-8">

<title>
    Registration Successful - Campus Lost &amp; Found
</title>

<style>

    * {
        box-sizing: border-box;
    }

    body {
        margin: 0;

        font-family:
            Arial,
            sans-serif;

        background: #f5f7fb;

        color: #374151;
    }

    .header {
        background:
            linear-gradient(
                135deg,
                #4f46e5,
                #2563eb
            );

        color: white;

        padding: 20px 40px;
    }

    .header h2 {
        margin: 0;

        font-size: 24px;
    }

    .main {
        min-height:
            calc(100vh - 72px);

        display: flex;

        justify-content: center;

        align-items: center;

        padding: 40px 20px;
    }

    .success-card {
        width: 100%;

        max-width: 600px;

        background: white;

        padding: 45px 40px;

        border-radius: 20px;

        box-shadow:
            0 10px 35px
            rgba(0, 0, 0, 0.08);

        text-align: center;
    }

    .success-icon {
        width: 80px;

        height: 80px;

        margin:
            0 auto 25px;

        border-radius: 50%;

        background: #dcfce7;

        color: #16a34a;

        display: flex;

        justify-content: center;

        align-items: center;

        font-size: 42px;

        font-weight: bold;
    }

    .success-card h1 {
        margin:
            0 0 15px;

        color: #111827;

        font-size: 34px;
    }

    .welcome {
        font-size: 20px;

        color: #374151;

        margin-bottom: 10px;
    }

    .welcome strong {
        color: #4f46e5;
    }

    .message {
        color: #6b7280;

        font-size: 16px;

        line-height: 1.6;

        margin-bottom: 30px;
    }

    .button-container {
        display: flex;

        flex-direction: column;

        gap: 12px;
    }

    .btn {
        display: block;

        width: 100%;

        padding: 14px 20px;

        border-radius: 10px;

        text-decoration: none;

        font-size: 16px;

        font-weight: bold;

        transition: 0.2s;
    }

    .btn-primary {
        background: #4f46e5;

        color: white;
    }

    .btn-primary:hover {
        background: #4338ca;
    }

    .btn-secondary {
        background: #eef2ff;

        color: #4338ca;
    }

    .btn-secondary:hover {
        background: #e0e7ff;
    }

    .btn-outline {
        background: white;

        color: #374151;

        border:
            1px solid #d1d5db;
    }

    .btn-outline:hover {
        background: #f9fafb;
    }

    .footer-text {
        margin-top: 25px;

        color: #9ca3af;

        font-size: 13px;
    }

    @media (max-width: 600px) {

        .header {
            padding:
                18px 20px;
        }

        .header h2 {
            font-size: 20px;
        }

        .main {
            padding:
                25px 15px;
        }

        .success-card {
            padding:
                35px 25px;
        }

        .success-card h1 {
            font-size: 28px;
        }

    }

</style>
```

</head>

<body>

```
<div class="header">

    <h2>
        Campus Lost &amp; Found
    </h2>

</div>


<div class="main">

    <div class="success-card">

        <div class="success-icon">
            ✓
        </div>

        <h1>
            Registration Successful!
        </h1>

        <div class="welcome">

            Welcome,

            <strong>
                <%= name %>
            </strong>

        </div>

        <p class="message">

            Your student account has been created
            successfully.

            You can now log in and start using
            the Campus Lost &amp; Found system.

        </p>

        <div class="button-container">

            <a
                href="login.jsp"
                class="btn btn-primary">

                Go to Login →

            </a>

            <a
                href="register.jsp"
                class="btn btn-secondary">

                Register Another Student

            </a>

            <a
                href="index.jsp"
                class="btn btn-outline">

                Back to Home

            </a>

        </div>

        <div class="footer-text">

            Campus Lost &amp; Found System

        </div>

    </div>

</div>
```

</body>

</html>
