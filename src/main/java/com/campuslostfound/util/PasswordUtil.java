
package com.campuslostfound.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

public class PasswordUtil {

    // =========================================================
    // HASH PASSWORD
    // =========================================================

    public static String hashPassword(
            String password) {

        try {

            MessageDigest md =
                    MessageDigest.getInstance("SHA-256");

            byte[] hash =
                    md.digest(
                            password.getBytes(
                                    StandardCharsets.UTF_8
                            )
                    );

            StringBuilder hex =
                    new StringBuilder();

            for (byte b : hash) {

                String value =
                        Integer.toHexString(
                                0xff & b
                        );

                if (value.length() == 1) {

                    hex.append('0');
                }

                hex.append(value);
            }

            return hex.toString();

        } catch (Exception e) {

            throw new RuntimeException(
                    "Password hashing failed",
                    e
            );
        }
    }


    // =========================================================
    // CHECK PASSWORD
    // =========================================================

    public static boolean checkPassword(
            String plainPassword,
            String hashedPassword) {

        if (plainPassword == null ||
                hashedPassword == null) {

            return false;
        }

        String hashedInput =
                hashPassword(plainPassword);

        return hashedInput.equals(
                hashedPassword
        );
    }
}

