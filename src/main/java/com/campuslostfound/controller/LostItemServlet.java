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

import com.campuslostfound.dao.LostItemDAO;
import com.campuslostfound.model.LostItem;
import com.campuslostfound.model.User;

@WebServlet("/lost-item")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 5 * 1024 * 1024,
    maxRequestSize = 10 * 1024 * 1024
)
public class LostItemServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String UPLOAD_DIRECTORY =
            "C:/CampusLostFoundUploads/lost-items";


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Check login
         */
        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        User user =
                (User) session.getAttribute("user");


        /*
         * Get action
         *
         * ADD
         * UPDATE
         * DELETE
         */
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

            deleteLostItem(
                request,
                response,
                user
            );

            return;
        }


        /*
         * Get form data
         */
        String itemIdString =
                request.getParameter("lostItemId");

        String itemName =
                request.getParameter("itemName");

        String category =
                request.getParameter("category");

        String description =
                request.getParameter("description");

        String locationLost =
                request.getParameter("locationLost");

        String dateLostString =
                request.getParameter("dateLost");


        /*
         * Validate required fields
         */
        if (itemName == null ||
            itemName.trim().isEmpty() ||
            category == null ||
            category.trim().isEmpty() ||
            locationLost == null ||
            locationLost.trim().isEmpty() ||
            dateLostString == null ||
            dateLostString.trim().isEmpty()) {

            response.sendRedirect(
                "report-lost.jsp?error=required"
            );

            return;
        }


        /*
         * Parse date
         */
        Date dateLost;

        try {

            dateLost =
                Date.valueOf(dateLostString);

        } catch (IllegalArgumentException e) {

            response.sendRedirect(
                "report-lost.jsp?error=date"
            );

            return;
        }


        /*
         * ==========================
         * ADD / UPDATE
         * ==========================
         */

        Part imagePart =
                request.getPart("image");


        String imageName = null;


        /*
         * For UPDATE:
         * keep old image if no new image
         * is selected.
         */
        if ("UPDATE".equalsIgnoreCase(action)) {

            if (itemIdString == null ||
                itemIdString.trim().isEmpty()) {

                response.sendRedirect(
                    "my-lost-items.jsp?error=invalid"
                );

                return;
            }

            try {

                int itemId =
                    Integer.parseInt(itemIdString);

                LostItemDAO dao =
                    new LostItemDAO();

                LostItem existingItem =
                    getUserLostItem(
                        dao,
                        itemId,
                        user.getUserId()
                    );

                if (existingItem == null) {

                    response.sendRedirect(
                        "my-lost-items.jsp?error=notfound"
                    );

                    return;
                }

                imageName =
                    existingItem.getImageName();

            } catch (NumberFormatException e) {

                response.sendRedirect(
                    "my-lost-items.jsp?error=invalid"
                );

                return;
            }
        }


        /*
         * Upload new image if selected
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
         * Create LostItem object
         */
        LostItem item =
                new LostItem();

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

        item.setLocationLost(
            locationLost.trim()
        );

        item.setDateLost(
            dateLost
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
                    "my-lost-items.jsp?error=invalid"
                );

                return;
            }


            item.setLostItemId(
                itemId
            );


            /*
             * Keep existing status
             */
            LostItemDAO dao =
                    new LostItemDAO();

            LostItem existingItem =
                    getUserLostItem(
                        dao,
                        itemId,
                        user.getUserId()
                    );


            if (existingItem == null) {

                response.sendRedirect(
                    "my-lost-items.jsp?error=notfound"
                );

                return;
            }


            item.setStatus(
                existingItem.getStatus()
            );


            boolean success =
                    dao.updateLostItem(
                        item
                    );


            if (success) {

                response.sendRedirect(
                    "my-lost-items.jsp?success=updated"
                );

            } else {

                response.sendRedirect(
                    "my-lost-items.jsp?error=update"
                );
            }


            return;
        }


        /*
         * ==========================
         * ADD
         * ==========================
         */

        item.setStatus("LOST");


        LostItemDAO dao =
                new LostItemDAO();


        boolean success =
                dao.addLostItem(item);


        if (success) {

            response.sendRedirect(
                "my-lost-items.jsp?success=added"
            );

        } else {

            response.sendRedirect(
                "report-lost.jsp?error=failed"
            );
        }
    }


    /*
     * ==========================
     * DELETE LOST ITEM
     * ==========================
     */
    private void deleteLostItem(
            HttpServletRequest request,
            HttpServletResponse response,
            User user)
            throws IOException {

        String itemIdString =
                request.getParameter(
                    "lostItemId"
                );


        if (itemIdString == null ||
            itemIdString.trim().isEmpty()) {

            response.sendRedirect(
                "my-lost-items.jsp?error=invalid"
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
                "my-lost-items.jsp?error=invalid"
            );

            return;
        }


        LostItemDAO dao =
                new LostItemDAO();


        /*
         * Get item first so we can
         * remove its image if needed.
         */
        LostItem existingItem =
                getUserLostItem(
                    dao,
                    itemId,
                    user.getUserId()
                );


        if (existingItem == null) {

            response.sendRedirect(
                "my-lost-items.jsp?error=notfound"
            );

            return;
        }


        boolean success =
                dao.deleteLostItem(
                    itemId,
                    user.getUserId()
                );


        if (success) {

            /*
             * Delete uploaded image
             * from the server.
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
                "my-lost-items.jsp?success=deleted"
            );

        } else {

            response.sendRedirect(
                "my-lost-items.jsp?error=delete"
            );
        }
    }


    /*
     * ==========================
     * GET USER'S LOST ITEM
     * ==========================
     */
    private LostItem getUserLostItem(
            LostItemDAO dao,
            int itemId,
            int userId) {

        ListHelper helper =
                new ListHelper();

        return helper.getItem(
            dao,
            itemId,
            userId
        );
    }


    /*
     * Small helper class used to find
     * an item belonging to the current user.
     */
    private static class ListHelper {

        public LostItem getItem(
                LostItemDAO dao,
                int itemId,
                int userId) {

            for (LostItem item :
                    dao.getLostItemsByUser(userId)) {

                if (item.getLostItemId()
                        == itemId) {

                    return item;
                }
            }

            return null;
        }
    }
}