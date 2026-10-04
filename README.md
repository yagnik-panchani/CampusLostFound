# 🎓 Campus Lost & Found Management System

A web-based **Campus Lost & Found Management System** developed to help students report lost and found items and allow administrators to manage item claims efficiently.

The system provides separate functionality for **Students** and **Administrators**, with database-backed authentication and item/claim management.

---

## 🚀 Features

### 👨‍🎓 Student Features

- Student Registration
- Student Login
- Report Lost Items
- Report Found Items
- Browse Found Items
- View My Lost Items
- View My Found Items
- Submit Claim for Found Items
- View My Claims
- Edit Lost Item Details
- View item images
- Session-based authentication

### 👨‍💼 Admin Features

- Admin Login
- Admin Dashboard
- View Student Accounts
- View Found Item Claims
- View Claim Details
- Approve Claims
- Reject Claims
- Manage the Lost & Found workflow

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| **Java** | Backend programming |
| **JSP** | Dynamic web pages |
| **Servlets** | Request handling and controllers |
| **JDBC** | Database connectivity |
| **MySQL** | Database |
| **HTML5** | Page structure |
| **CSS3** | User interface |
| **Apache Tomcat** | Web application server |
| **Eclipse** | Development environment |
| **Git & GitHub** | Version control |

---

## 🏗️ Project Architecture

The project follows an MVC-style structure:

```text
CampusLostFound
│
├── src/main/java
│   │
│   └── com.campuslostfound
│       │
│       ├── controller
│       │   ├── LoginServlet.java
│       │   ├── LogoutServlet.java
│       │   ├── RegisterServlet.java
│       │   ├── LostItemServlet.java
│       │   ├── FoundItemServlet.java
│       │   ├── ClaimServlet.java
│       │   └── ...
│       │
│       ├── dao
│       │   ├── UserDAO.java
│       │   ├── LostItemDAO.java
│       │   ├── FoundItemDAO.java
│       │   └── ClaimDAO.java
│       │
│       ├── model
│       │   ├── User.java
│       │   ├── LostItem.java
│       │   ├── FoundItem.java
│       │   └── Claim.java
│       │
│       └── util
│           ├── DBConnection.java
│           └── PasswordUtil.java
│
└── src/main/webapp
    │
    ├── index.jsp
    ├── login.jsp
    ├── register.jsp
    ├── student-dashboard.jsp
    ├── admin-dashboard.jsp
    ├── report-lost.jsp
    ├── report-found.jsp
    ├── browse-found-items.jsp
    ├── claim-item.jsp
    └── ...
```

---

## 🔄 System Workflow

### Student Workflow

```text
Register
   ↓
Login
   ↓
Student Dashboard
   ↓
Report Lost / Found Item
   ↓
Browse Found Items
   ↓
Submit Claim
   ↓
View Claim Status
```

### Admin Workflow

```text
Admin Login
   ↓
Admin Dashboard
   ↓
View Student Accounts
   ↓
View Claims
   ↓
View Claim Details
   ↓
Approve / Reject Claim
```

---

## 🗄️ Database

The application uses **MySQL** as its database.

The Java application communicates with MySQL using **JDBC**.

Database connectivity is handled through:

```text
DBConnection.java
```

Data-access operations are handled through DAO classes:

```text
UserDAO
LostItemDAO
FoundItemDAO
ClaimDAO
```

---

## 🔐 Security

The application includes:

- Login authentication
- Session-based user management
- Role-based access for Student and Admin
- Password utility
- Prepared Statements for database operations
- Admin authorization checks

---

## ▶️ How to Run the Project

### 1. Requirements

Install:

- Java JDK
- Eclipse
- Apache Tomcat
- MySQL
- MySQL Connector/J

### 2. Clone the Repository

```bash
git clone https://github.com/yagnik-panchani/CampusLostFound.git
```

### 3. Import into Eclipse

Import the project into Eclipse as a Java/Web project.

### 4. Configure MySQL

Create the required MySQL database and tables.

Update the database configuration in:

```text
DBConnection.java
```

with your own MySQL username, password and database details.

### 5. Configure Apache Tomcat

Add the project to Apache Tomcat in Eclipse.

### 6. Start MySQL and Tomcat

Start:

```text
MySQL
Apache Tomcat
```

### 7. Open the Application

```text
http://localhost:8080/CampusLostFound/
```

---

## 📸 Main Modules

The project contains the following major modules:

- Home Page
- Student Registration
- Student Login
- Student Dashboard
- Lost Item Management
- Found Item Management
- Found Item Browsing
- Claim Management
- Admin Dashboard
- Student Account Management
- Admin Claim Management

---

## 🎯 Project Objective

The main objective of this project is to provide a centralized digital platform for managing lost and found items within a campus.

Instead of relying on manual announcements or physical notice boards, students can report items, search for found items and submit claims through the web application.

---

## 👨‍💻 Author

**Yagnik Panchani**

B.Tech Computer Science & Engineering

---

## 📌 Project Status

**Completed**

The core Lost & Found workflow, student functionality, admin functionality, authentication and claim management have been implemented.

---

## 📄 License

This project was developed as an academic/educational project.
