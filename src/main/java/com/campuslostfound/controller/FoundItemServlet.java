package com.campuslostfound.controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.campuslostfound.dao.FoundItemDAO;
import com.campuslostfound.model.FoundItem;
import com.campuslostfound.model.User;

@WebServlet("/found-item")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class FoundItemServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIRECTORY =
            "C:/CampusLostFoundUploads/found-items";


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");

        String action =
                request.getParameter("action");


        if (action == null ||
            action.trim().isEmpty()) {

            action = "ADD";
        }


        /*
         * ==========================
         * DELETE
         * ==========================
         */

        if ("DELETE".equalsIgnoreCase(action)) {

            deleteFoundItem(
                request,
                response,
                user
            );

            return;
        }


        /*
         * ==========================
         * GET FORM DATA
         * ==========================
         */

        String itemIdString =
                request.getParameter("foundItemId");

        String itemName =
                request.getParameter("itemName");

        String category =
                request.getParameter("category");

        String description =
                request.getParameter("description");

        String locationFound =
                request.getParameter("locationFound");

        String dateFoundString =
                request.getParameter("dateFound");


        /*
         * ==========================
         * VALIDATION
         * ==========================
         */

        if (itemName == null ||
            itemName.trim().isEmpty() ||
            category == null ||
            category.trim().isEmpty() ||
            locationFound == null ||
            locationFound.trim().isEmpty() ||
            dateFoundString == null ||
            dateFoundString.trim().isEmpty()) {

            response.sendRedirect(
                "report-found.jsp?error=required"
            );

            return;
        }


        Date dateFound;

        try {

            dateFound =
                Date.valueOf(dateFoundString);

        } catch (IllegalArgumentException e) {

            response.sendRedirect(
                "report-found.jsp?error=date"
            );

            return;
        }


        /*
         * ==========================
         * IMAGE
         * ==========================
         */

        Part imagePart =
                request.getPart("image");

        String imageName = null;


        /*
         * During UPDATE, keep old image
         * if no new image is selected.
         */

        if ("UPDATE".equalsIgnoreCase(action)) {

            if (itemIdString == null ||
                itemIdString.trim().isEmpty()) {

                response.sendRedirect(
                    "my-found-items.jsp?error=invalid"
                );

                return;
            }


            try {

                int itemId =
                    Integer.parseInt(
                        itemIdString
                    );

                FoundItemDAO dao =
                    new FoundItemDAO();

                FoundItem existingItem =
                    getUserFoundItem(
                        dao,
                        itemId,
                        user.getUserId()
                    );

                if (existingItem == null) {

                    response.sendRedirect(
                        "my-found-items.jsp?error=notfound"
                    );

                    return;
                }

                imageName =
                    existingItem.getImageName();

            } catch (NumberFormatException e) {

                response.sendRedirect(
                    "my-found-items.jsp?error=invalid"
                );

                return;
            }
        }


        /*
         * ==========================
         * UPLOAD NEW IMAGE
         * ==========================
         */

        if (imagePart != null &&
            imagePart.getSize() > 0) {

            String originalFileName =
                    Paths.get(
                        imagePart.getSubmittedFileName()
                    )
                    .getFileName()
                    .toString();


            String extension = "";

            int dotIndex =
                    originalFileName.lastIndexOf(".");


            if (dotIndex >= 0) {

                extension =
                    originalFileName.substring(
                        dotIndex
                    );
            }


            imageName =
                    UUID.randomUUID()
                    .toString()
                    + extension;


            Path uploadDirectory =
                    Paths.get(
                        UPLOAD_DIRECTORY
                    );


            Files.createDirectories(
                uploadDirectory
            );


            Path imagePath =
                    uploadDirectory.resolve(
                        imageName
                    );


            try (
                InputStream inputStream =
                    imagePart.getInputStream()
            ) {

                Files.copy(
                    inputStream,
                    imagePath,
                    StandardCopyOption
                        .REPLACE_EXISTING
                );
            }
        }


        /*
         * ==========================
         * CREATE OBJECT
         * ==========================
         */

        FoundItem item =
                new FoundItem();

        item.setUserId(
            user.getUserId()
        );

        item.setItemName(
            itemName.trim()
        );

        item.setCategory(
            category.trim()
        );

        item.setDescription(
            description == null
                ? ""
                : description.trim()
        );

        item.setLocationFound(
            locationFound.trim()
        );

        item.setDateFound(
            dateFound
        );

        item.setImageName(
            imageName
        );


        /*
         * ==========================
         * UPDATE
         * ==========================
         */

        if ("UPDATE".equalsIgnoreCase(action)) {

            int itemId;

            try {

                itemId =
                    Integer.parseInt(
                        itemIdString
                    );

            } catch (NumberFormatException e) {

                response.sendRedirect(
                    "my-found-items.jsp?error=invalid"
                );

                return;
            }


            item.setFoundItemId(
                itemId
            );


            FoundItemDAO dao =
                    new FoundItemDAO();


            FoundItem existingItem =
                    getUserFoundItem(
                        dao,
                        itemId,
                        user.getUserId()
                    );


            if (existingItem == null) {

                response.sendRedirect(
                    "my-found-items.jsp?error=notfound"
                );

                return;
            }


            /*
             * Keep current status.
             *
             * Important:
             * If an approved claim already exists,
             * editing the item must not reset
             * its status.
             */

            item.setStatus(
                existingItem.getStatus()
            );


            boolean success =
                    dao.updateFoundItem(
                        item
                    );


            if (success) {

                response.sendRedirect(
                    "my-found-items.jsp?success=updated"
                );

            } else {

                response.sendRedirect(
                    "my-found-items.jsp?error=update"
                );
            }

            return;
        }


        /*
         * ==========================
         * ADD
         * ==========================
         */

        item.setStatus("FOUND");


        FoundItemDAO dao =
                new FoundItemDAO();


        boolean success =
                dao.addFoundItem(item);


        if (success) {

            response.sendRedirect(
                "my-found-items.jsp?success=added"
            );

        } else {

            response.sendRedirect(
                "report-found.jsp?error=failed"
            );
        }
    }


    /*
     * ==========================
     * DELETE FOUND ITEM
     * ==========================
     */

    private void deleteFoundItem(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws IOException {

        String itemIdString =
                request.getParameter(
                    "foundItemId"
                );


        if (itemIdString == null ||
            itemIdString.trim().isEmpty()) {

            response.sendRedirect(
                "my-found-items.jsp?error=invalid"
            );

            return;
        }


        int itemId;

        try {

            itemId =
                Integer.parseInt(
                    itemIdString
                );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                "my-found-items.jsp?error=invalid"
            );

            return;
        }


        FoundItemDAO dao =
                new FoundItemDAO();


        FoundItem existingItem =
                getUserFoundItem(
                    dao,
                    itemId,
                    user.getUserId()
                );


        if (existingItem == null) {

            response.sendRedirect(
                "my-found-items.jsp?error=notfound"
            );

            return;
        }


        /*
         * Do not allow deletion of an item
         * that has already been claimed.
         */

        if ("CLAIMED".equalsIgnoreCase(
                existingItem.getStatus())) {

            response.sendRedirect(
                "my-found-items.jsp?error=claimed"
            );

            return;
        }


        boolean success =
                dao.deleteFoundItem(
                    itemId,
                    user.getUserId()
                );


        if (success) {

            /*
             * Delete image from server.
             */

            if (existingItem.getImageName() != null &&
                !existingItem.getImageName()
                    .trim()
                    .isEmpty()) {

                try {

                    Path imagePath =
                        Paths.get(
                            UPLOAD_DIRECTORY,
                            existingItem.getImageName()
                        );

                    Files.deleteIfExists(
                        imagePath
                    );

                } catch (Exception e) {

                    e.printStackTrace();
                }
            }


            response.sendRedirect(
                "my-found-items.jsp?success=deleted"
            );

        } else {

            response.sendRedirect(
                "my-found-items.jsp?error=delete"
            );
        }
    }


    /*
     * ==========================
     * GET USER FOUND ITEM
     * ==========================
     */

    private FoundItem getUserFoundItem(
            FoundItemDAO dao,
            int itemId,
            int userId) {

        for (FoundItem item :
                dao.getFoundItemsByUser(userId)) {

            if (item.getFoundItemId()
                    == itemId) {

                return item;
            }
        }

        return null;
    }
}