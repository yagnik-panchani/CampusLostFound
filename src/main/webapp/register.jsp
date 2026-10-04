<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Campus Lost & Found - Register</title>


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


        /* MAIN CARD */

        .page {

            width: 100%;

            max-width: 1100px;

            min-height: 650px;

            background: white;

            border-radius: 28px;

            overflow: hidden;

            display: flex;

            box-shadow:
                0 25px 60px rgba(31, 41, 55, 0.15);
        }


        /* LEFT SECTION */

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


        /* DECORATIVE CIRCLES */

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


        /* LOGO */

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

            max-width: 440px;

            margin-bottom: 35px;
        }


        /* FEATURES */

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

            font-size: 13px;

            font-weight: 700;

            letter-spacing: 0.5px;
        }


        /* RIGHT SECTION */

        .right-section {

            width: 55%;

            padding: 55px 65px;

            display: flex;

            flex-direction: column;

            justify-content: center;
        }


        .form-header {

            margin-bottom: 30px;
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

            max-width: 650px;
        }


        /* FORM */

        .form-group {

            margin-bottom: 18px;
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

            font-size: 0;
        }


        /* Different simple icon shapes */

        .user-icon {

            border-radius: 50%;

            width: 16px;

            height: 16px;

            border-width: 2px;
        }


        .mail-icon {

            border-radius: 4px;
        }


        .lock-icon {

            width: 16px;

            height: 15px;

            border-radius: 3px;
        }


        .phone-icon {

            border-radius: 50%;
        }


        .form-group input {

            width: 100%;

            height: 50px;

            border: 1px solid #e5e7eb;

            border-radius: 12px;

            padding: 0 48px;

            outline: none;

            font-size: 14px;

            color: #111827;

            background: #f9fafb;

            transition: 0.25s;
        }


        .form-group input:focus {

            border-color: #4f46e5;

            background: white;

            box-shadow:
                0 0 0 4px rgba(79,70,229,0.10);
        }


        .form-group input::placeholder {

            color: #9ca3af;
        }


        /* PASSWORD EYE */

        .show-password {

            position: absolute;

            right: 14px;

            top: 50%;

            transform: translateY(-50%);

            width: 30px;

            height: 30px;

            border: none;

            background: transparent;

            cursor: pointer;

            color: #6b7280;

            font-size: 12px;

            font-weight: 600;
        }


        /* EYE USING CSS */

        .eye {

            width: 18px;

            height: 11px;

            border: 2px solid #6b7280;

            border-radius: 70% 20%;

            transform: rotate(45deg);

            display: inline-block;
        }


        /* BUTTON */

        .register-btn {

            width: 100%;

            height: 52px;

            border: none;

            border-radius: 12px;

            margin-top: 8px;

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


        .register-btn:hover {

            transform: translateY(-2px);

            box-shadow:
                0 12px 25px rgba(37,99,235,0.35);
        }


        /* LOGIN */

        .login-text {

            text-align: center;

            margin-top: 22px;

            font-size: 14px;

            color: #6b7280;
        }


        .login-text a {

            color: #4f46e5;

            font-weight: 600;

            text-decoration: none;
        }


        .login-text a:hover {

            text-decoration: underline;
        }


        /* FOOTER */

        .footer {

            text-align: center;

            margin-top: 25px;

            font-size: 12px;

            color: #9ca3af;
        }


        /* MOBILE */

        @media (max-width: 850px) {

            body {

                padding: 15px;
            }

            .page {

                flex-direction: column;
            }

            .left-section {

                width: 100%;

                padding: 40px;
            }

            .right-section {

                width: 100%;

                padding: 40px;
            }
        }


        @media (max-width: 500px) {

            .left-section {

                padding: 30px;
            }

            .right-section {

                padding: 30px 22px;
            }

            .form-header h1 {

                font-size: 26px;
            }
        }

    </style>

</head>


<body>


<div class="page">


    <!-- LEFT SIDE -->

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

            A simple way for students to report
            lost belongings, discover found items
            and help return them to their rightful
            owners.

        </div>


        <div class="feature">

            <div class="feature-icon">
                LOST
            </div>

            <span>
                Report lost or found items
            </span>

        </div>


        <div class="feature">

            <div class="feature-icon">
                IMG
            </div>

            <span>
                Upload item photos
            </span>

        </div>


        <div class="feature">

            <div class="feature-icon">
                FIND
            </div>

            <span>
                Find matching items
            </span>

        </div>


        <div class="feature">

            <div class="feature-icon">
                HELP
            </div>

            <span>
                Help return items to students
            </span>

        </div>

    </div>



    <!-- RIGHT SIDE -->

    <div class="right-section">


        <div class="form-header">

            <h1>
                Create your account
            </h1>

            <p>

                Join your campus community and help
                reconnect lost belongings with their owners.

            </p>

        </div>



        <form action="register" method="post">


            <!-- NAME -->

            <div class="form-group">

                <label>
                    Full Name
                </label>

                <div class="input-wrapper">

                    <span class="input-icon user-icon"></span>

                    <input
                        type="text"
                        name="name"
                        placeholder="Enter your full name"
                        required
                    >

                </div>

            </div>



            <!-- EMAIL -->

            <div class="form-group">

                <label>
                    Email Address
                </label>

                <div class="input-wrapper">

                    <span class="input-icon mail-icon"></span>

                    <input
                        type="email"
                        name="email"
                        placeholder="student@example.com"
                        required
                    >

                </div>

            </div>



            <!-- PASSWORD -->

            <div class="form-group">

                <label>
                    Password
                </label>

                <div class="input-wrapper">

                    <span class="input-icon lock-icon"></span>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Create a password"
                        required
                    >

                    <button
                        type="button"
                        class="show-password"
                        onclick="togglePassword()">

                        <span class="eye"></span>

                    </button>

                </div>

            </div>



            <!-- PHONE -->

            <div class="form-group">

                <label>
                    Phone Number
                </label>

                <div class="input-wrapper">

                    <span class="input-icon phone-icon"></span>

                    <input
                        type="tel"
                        name="phone"
                        placeholder="Enter your phone number"
                        pattern="[0-9]{10}"
                        maxlength="10"
                        required
                    >

                </div>

            </div>



            <!-- REGISTER -->

            <button
                type="submit"
                class="register-btn">

                Create Account &nbsp; →

            </button>


        </form>



        <div class="login-text">

            Already have an account?

            <a href="login.jsp">
                Sign in
            </a>

        </div>


        <div class="footer">

            Copyright 2026 Campus Lost & Found Network

        </div>


    </div>


</div>



<script>

function togglePassword() {

    const password =
        document.getElementById("password");

    if (password.type === "password") {

        password.type = "text";

    } else {

        password.type = "password";

    }

}

</script>


</body>

</html>