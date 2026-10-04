package com.campuslostfound.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/found-image")
public class FoundImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /*
     * Location where found-item images are stored.
     */
    private static final String IMAGE_DIRECTORY =
            "C:/CampusLostFoundUploads/found-items";


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // ==========================================
        // 1. GET IMAGE NAME
        // ==========================================

        String imageName =
                request.getParameter("name");


        // ==========================================
        // 2. CHECK IMAGE NAME
        // ==========================================

        if (imageName == null ||
            imageName.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Image name is required."
            );

            return;
        }


        // ==========================================
        // 3. MAKE FILE NAME SAFE
        // ==========================================

        String safeFileName =
                Paths.get(imageName)
                     .getFileName()
                     .toString();


        // ==========================================
        // 4. CREATE IMAGE PATH
        // ==========================================

        Path imagePath =
                Paths.get(IMAGE_DIRECTORY)
                     .resolve(safeFileName)
                     .normalize();


        // ==========================================
        // 5. CHECK FILE
        // ==========================================

        if (!Files.exists(imagePath) ||
            !Files.isRegularFile(imagePath)) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Image not found."
            );

            return;
        }


        // ==========================================
        // 6. DETERMINE CONTENT TYPE
        // ==========================================

        String contentType =
                Files.probeContentType(imagePath);


        if (contentType == null) {

            String lowerName =
                    safeFileName.toLowerCase();


            if (lowerName.endsWith(".png")) {

                contentType =
                        "image/png";

            } else if (
                    lowerName.endsWith(".jpg") ||
                    lowerName.endsWith(".jpeg")) {

                contentType =
                        "image/jpeg";

            } else if (
                    lowerName.endsWith(".gif")) {

                contentType =
                        "image/gif";

            } else if (
                    lowerName.endsWith(".webp")) {

                contentType =
                        "image/webp";

            } else {

                contentType =
                        "application/octet-stream";
            }
        }


        // ==========================================
        // 7. SET RESPONSE TYPE
        // ==========================================

        response.setContentType(
                contentType
        );


        response.setContentLengthLong(
                Files.size(imagePath)
        );


        // ==========================================
        // 8. SEND IMAGE TO BROWSER
        // ==========================================

        try (
            InputStream inputStream =
                    Files.newInputStream(imagePath);

            OutputStream outputStream =
                    response.getOutputStream()
        ) {

            byte[] buffer =
                    new byte[8192];

            int bytesRead;


            while (
                (bytesRead =
                    inputStream.read(buffer))
                    != -1
            ) {

                outputStream.write(
                    buffer,
                    0,
                    bytesRead
                );
            }
        }
    }
}