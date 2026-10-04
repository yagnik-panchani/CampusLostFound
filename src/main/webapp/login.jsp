<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Campus Lost & Found - Login</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {

            font-family: "Segoe UI", Arial, sans-serif;

            min-height: 100vh;

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #f8faff,
                    #e0f2fe
                );

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 30px;
        }


        .page {

            width: 100%;

            max-width: 1050px;

            min-height: 620px;

            background: white;

            border-radius: 28px;

            overflow: hidden;

            display: flex;

            box-shadow:
                0 25px 60px rgba(31, 41, 55, 0.15);
        }


        /* LEFT */

        .left-section {

            width: 45%;

            padding: 60px;

            color: white;

            background:
                linear-gradient(
                    145deg,
                    #4f46e5,
                    #2563eb,
                    #0891b2
                );

            position: relative;

            overflow: hidden;

            display: flex;

            flex-direction: column;

            justify-content: center;
        }


        .circle-one {

            position: absolute;

            width: 280px;

            height: 280px;

            border-radius: 50%;

            background: rgba(255,255,255,0.08);

            top: -110px;

            right: -100px;
        }


        .circle-two {

            position: absolute;

            width: 220px;

            height: 220px;

            border-radius: 50%;

            background: rgba(255,255,255,0.06);

            bottom: -100px;

            left: -80px;
        }


        .logo {

            position: relative;

            z-index: 2;

            width: 65px;

            height: 65px;

            border-radius: 18px;

            background: rgba(255,255,255,0.15);

            display: flex;

            align-items: center;

            justify-content: center;

            margin-bottom: 25px;
        }


        .logo-symbol {

            width: 27px;

            height: 27px;

            border: 4px solid white;

            border-radius: 50%;

            position: relative;
        }


        .logo-symbol::after {

            content: "";

            position: absolute;

            width: 13px;

            height: 4px;

            background: white;

            right: -10px;

            bottom: -5px;

            transform: rotate(45deg);

            border-radius: 5px;
        }


        .brand {

            position: relative;

            z-index: 2;

            font-size: 30px;

            font-weight: 700;

            margin-bottom: 18px;
        }


        .tagline {

            position: relative;

            z-index: 2;

            font-size: 16px;

            line-height: 1.7;

            color: rgba(255,255,255,0.88);

            margin-bottom: 35px;
        }


        .feature {

            position: relative;

            z-index: 2;

            display: flex;

            align-items: center;

            gap: 14px;

            margin: 15px 0;

            font-size: 15px;
        }


        .feature-icon {

            width: 42px;

            height: 42px;

            border-radius: 12px;

            background: rgba(255,255,255,0.15);

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 11px;

            font-weight: 700;
        }


        /* RIGHT */

        .right-section {

            width: 55%;

            padding: 55px 65px;

            display: flex;

            flex-direction: column;

            justify-content: center;
        }


        .form-header {

            margin-bottom: 32px;
        }


        .form-header h1 {

            font-size: 32px;

            color: #111827;

            margin-bottom: 10px;
        }


        .form-header p {

            color: #6b7280;

            font-size: 15px;

            line-height: 1.6;
        }


        /* INPUT */

        .form-group {

            margin-bottom: 20px;
        }


        .form-group label {

            display: block;

            font-size: 13px;

            font-weight: 600;

            color: #374151;

            margin-bottom: 7px;
        }


        .input-wrapper {

            position: relative;
        }


        .input-icon {

            position: absolute;

            left: 15px;

            top: 50%;

            transform: translateY(-50%);

            width: 18px;

            height: 18px;

            border: 2px solid #9ca3af;

            border-radius: 5px;
        }


        .email-icon {

            border-radius: 4px;
        }


        .password-icon {

            width: 16px;

            height: 15px;

            border-radius: 3px;
        }


        input {

            width: 100%;

            height: 50px;

            border: 1px solid #e5e7eb;

            border-radius: 12px;

            padding: 0 48px;

            outline: none;

            font-size: 14px;

            background: #f9fafb;

            transition: 0.25s;
        }


        input:focus {

            border-color: #4f46e5;

            background: white;

            box-shadow:
                0 0 0 4px rgba(79,70,229,0.10);
        }


        input::placeholder {

            color: #9ca3af;
        }


        /* BUTTON */

        .login-btn {

            width: 100%;

            height: 52px;

            border: none;

            border-radius: 12px;

            color: white;

            font-size: 15px;

            font-weight: 600;

            cursor: pointer;

            background:
                linear-gradient(
                    135deg,
                    #4f46e5,
                    #2563eb
                );

            box-shadow:
                0 8px 20px rgba(37,99,235,0.25);

            transition: 0.25s;
        }


        .login-btn:hover {

            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(37,99,235,0.35);
        }


        .register-text {

            text-align: center;

            margin-top: 25px;

            font-size: 14px;

            color: #6b7280;
        }


        .register-text a {

            color: #4f46e5;

            font-weight: 600;

            text-decoration: none;
        }


        .footer {

            text-align: center;

            margin-top: 28px;

            font-size: 12px;

            color: #9ca3af;
        }


        @media (max-width: 850px) {

            .page {
                flex-direction: column;
            }

            .left-section,
            .right-section {
                width: 100%;
            }

            .left-section {
                padding: 40px;
            }

            .right-section {
                padding: 40px;
            }
        }

    </style>

</head>


<body>


<div class="page">


    <!-- LEFT -->

    <div class="left-section">

        <div class="circle-one"></div>

        <div class="circle-two"></div>


        <div class="logo">

            <div class="logo-symbol"></div>

        </div>


        <div class="brand">

            Campus Lost & Found

        </div>


        <div class="tagline">

            Welcome back. Sign in to manage
            your lost and found items and help
            reconnect belongings with students.

        </div>


        <div class="feature">

            <div class="feature-icon">
                LOST
            </div>

            <span>
                Report something you lost
            </span>

        </div>


        <div class="feature">

            <div class="feature-icon">
                FIND
            </div>

            <span>
                Discover found belongings
            </span>

        </div>


        <div class="feature">

            <div class="feature-icon">
                CLAIM
            </div>

            <span>
                Manage your item claims
            </span>

        </div>


    </div>


    <!-- RIGHT -->

    <div class="right-section">


        <div class="form-header">

            <h1>
                Welcome back
            </h1>

            <p>
                Sign in to continue to your Campus Lost & Found account.
            </p>

        </div>


        <form action="login" method="post">


            <div class="form-group">

                <label>
                    Email Address
                </label>

                <div class="input-wrapper">

                    <span class="input-icon email-icon"></span>

                    <input
                        type="email"
                        name="email"
                        placeholder="student@example.com"
                        required
                    >

                </div>

            </div>


            <div class="form-group">

                <label>
                    Password
                </label>

                <div class="input-wrapper">

                    <span class="input-icon password-icon"></span>

                    <input
                        type="password"
                        name="password"
                        placeholder="Enter your password"
                        required
                    >

                </div>

            </div>


            <button
                type="submit"
                class="login-btn">

                Sign In &nbsp; →

            </button>


        </form>


        <div class="register-text">

            Don't have an account?

            <a href="register.jsp">
                Create an account
            </a>

        </div>


        <div class="footer">

            Copyright 2026 Campus Lost & Found Network

        </div>


    </div>


</div>


</body>

</html>