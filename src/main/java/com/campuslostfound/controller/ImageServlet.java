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

@WebServlet("/lost-image")
public class ImageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Same folder used by LostItemServlet
    private static final String IMAGE_DIRECTORY =
            "C:/CampusLostFoundUploads/lost-items";


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get filename from URL
        String imageName =
                request.getParameter("name");


        // Check filename
        if (imageName == null ||
            imageName.trim().isEmpty()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Image name is required."
            );

            return;
        }


        /*
         * Get only the filename.
         * This prevents someone from supplying
         * a path such as ../../some-file.
         */
        String safeFileName =
                Paths.get(imageName)
                     .getFileName()
                     .toString();


        // Build image path
        Path imagePath =
                Paths.get(IMAGE_DIRECTORY)
                     .resolve(safeFileName)
                     .normalize();


        // Check that the file exists
        if (!Files.exists(imagePath) ||
            !Files.isRegularFile(imagePath)) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Image not found."
            );

            return;
        }


        // Detect image content type
        String contentType =
                Files.probeContentType(imagePath);


        if (contentType == null) {

            String lowerName =
                    safeFileName.toLowerCase();

            if (lowerName.endsWith(".png")) {

                contentType = "image/png";

            } else if (lowerName.endsWith(".jpg") ||
                       lowerName.endsWith(".jpeg")) {

                contentType = "image/jpeg";

            } else if (lowerName.endsWith(".gif")) {

                contentType = "image/gif";

            } else if (lowerName.endsWith(".webp")) {

                contentType = "image/webp";

            } else {

                contentType = "application/octet-stream";
            }
        }


        // Tell browser this is an image
        response.setContentType(contentType);

        response.setContentLengthLong(
                Files.size(imagePath)
        );


        // Send image to browser
        try (
            InputStream inputStream =
                    Files.newInputStream(imagePath);

            OutputStream outputStream =
                    response.getOutputStream()
        ) {

            byte[] buffer =
                    new byte[8192];

            int bytesRead;

            while ((bytesRead =
                    inputStream.read(buffer)) != -1) {

                outputStream.write(
                        buffer,
                        0,
                        bytesRead
                );
            }
        }
    }
}