
package com.campuslostfound.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.campuslostfound.model.User;
import com.campuslostfound.util.DBConnection;
import com.campuslostfound.util.PasswordUtil;

public class UserDAO {

    // =========================================================
    // 1. REGISTER USER
    // =========================================================

    public boolean registerUser(User user) {

        String sql =
                "INSERT INTO users " +
                "(name, email, password, phone, role) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    user.getName()
            );

            statement.setString(
                    2,
                    user.getEmail()
            );

            /*
             * Password is hashed before storing.
             */
            statement.setString(
                    3,
                    PasswordUtil.hashPassword(
                            user.getPassword()
                    )
            );

            statement.setString(
                    4,
                    user.getPhone()
            );

            /*
             * Every registration from register.jsp
             * creates a STUDENT account.
             */
            statement.setString(
                    5,
                    "STUDENT"
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // 2. GET USER BY EMAIL
    // =========================================================

    public User getUserByEmail(String email) {

        String sql =
                "SELECT * FROM users " +
                "WHERE email = ?";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    email
            );

            ResultSet rs =
                    statement.executeQuery();

            if (rs.next()) {

                return createUserFromResultSet(rs);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // 3. LOGIN / AUTHENTICATE USER
    // =========================================================

    public User loginUser(
            String email,
            String password) {

        User user =
                getUserByEmail(email);

        if (user == null) {

            return null;
        }

        try {

            boolean valid =
                    PasswordUtil.checkPassword(
                            password,
                            user.getPassword()
                    );

            if (valid) {

                return user;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // 4. GET ALL STUDENTS
    // =========================================================

    public List<User> getAllStudents() {

        List<User> students =
                new ArrayList<>();

        String sql =
                "SELECT * FROM users " +
                "WHERE role = 'STUDENT' " +
                "ORDER BY user_id DESC";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        statement.executeQuery()
        ) {

            while (rs.next()) {

                User student =
                        createUserFromResultSet(rs);

                students.add(student);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return students;
    }


    // =========================================================
    // 5. GET TOTAL STUDENTS
    // =========================================================

    public int getTotalStudents() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM users " +
                "WHERE role = 'STUDENT'";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        statement.executeQuery()
        ) {

            if (rs.next()) {

                return rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return 0;
    }


    // =========================================================
    // 6. GET USER BY ID
    // =========================================================

    public User getUserById(int userId) {

        String sql =
                "SELECT * FROM users " +
                "WHERE user_id = ?";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    userId
            );

            ResultSet rs =
                    statement.executeQuery();

            if (rs.next()) {

                return createUserFromResultSet(rs);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // 7. CHECK WHETHER EMAIL ALREADY EXISTS
    // =========================================================

    public boolean emailExists(String email) {

        String sql =
                "SELECT user_id " +
                "FROM users " +
                "WHERE email = ?";

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(
                    1,
                    email
            );

            ResultSet rs =
                    statement.executeQuery();

            return rs.next();

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // 8. CREATE USER OBJECT FROM RESULTSET
    // =========================================================

    private User createUserFromResultSet(
            ResultSet rs) throws Exception {

        User user =
                new User();

        user.setUserId(
                rs.getInt("user_id")
        );

        user.setName(
                rs.getString("name")
        );

        user.setEmail(
                rs.getString("email")
        );

        user.setPassword(
                rs.getString("password")
        );

        user.setPhone(
                rs.getString("phone")
        );

        user.setRole(
                rs.getString("role")
        );

        return user;
    }
}

