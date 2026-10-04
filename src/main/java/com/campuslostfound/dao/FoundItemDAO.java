package com.campuslostfound.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.campuslostfound.model.FoundItem;
import com.campuslostfound.util.DBConnection;

public class FoundItemDAO {

    // ==========================================
    // 1. ADD FOUND ITEM
    // ==========================================

    public boolean addFoundItem(FoundItem item) {

        String sql =
            "INSERT INTO found_items " +
            "(user_id, item_name, category, description, " +
            "location_found, date_found, image_name, status) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(
                1,
                item.getUserId()
            );

            statement.setString(
                2,
                item.getItemName()
            );

            statement.setString(
                3,
                item.getCategory()
            );

            statement.setString(
                4,
                item.getDescription()
            );

            statement.setString(
                5,
                item.getLocationFound()
            );

            statement.setDate(
                6,
                item.getDateFound()
            );

            statement.setString(
                7,
                item.getImageName()
            );

            statement.setString(
                8,
                item.getStatus()
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 2. GET FOUND ITEMS BY USER
    // ==========================================

    public List<FoundItem> getFoundItemsByUser(
            int userId) {

        List<FoundItem> items =
                new ArrayList<>();

        String sql =
            "SELECT * FROM found_items " +
            "WHERE user_id = ? " +
            "ORDER BY created_at DESC";

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

            while (rs.next()) {

                FoundItem item =
                        new FoundItem();

                item.setFoundItemId(
                    rs.getInt("found_item_id")
                );

                item.setUserId(
                    rs.getInt("user_id")
                );

                item.setItemName(
                    rs.getString("item_name")
                );

                item.setCategory(
                    rs.getString("category")
                );

                item.setDescription(
                    rs.getString("description")
                );

                item.setLocationFound(
                    rs.getString("location_found")
                );

                item.setDateFound(
                    rs.getDate("date_found")
                );

                item.setImageName(
                    rs.getString("image_name")
                );

                item.setStatus(
                    rs.getString("status")
                );

                items.add(item);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return items;
    }


    // ==========================================
    // 3. GET ALL FOUND ITEMS
    // ==========================================

    public List<FoundItem> getAllFoundItems() {

        List<FoundItem> items =
                new ArrayList<>();

        String sql =
            "SELECT * FROM found_items " +
            "ORDER BY created_at DESC";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            ResultSet rs =
                    statement.executeQuery();

            while (rs.next()) {

                FoundItem item =
                        new FoundItem();

                item.setFoundItemId(
                    rs.getInt("found_item_id")
                );

                item.setUserId(
                    rs.getInt("user_id")
                );

                item.setItemName(
                    rs.getString("item_name")
                );

                item.setCategory(
                    rs.getString("category")
                );

                item.setDescription(
                    rs.getString("description")
                );

                item.setLocationFound(
                    rs.getString("location_found")
                );

                item.setDateFound(
                    rs.getDate("date_found")
                );

                item.setImageName(
                    rs.getString("image_name")
                );

                item.setStatus(
                    rs.getString("status")
                );

                items.add(item);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return items;
    }


    // ==========================================
    // 4. GET ONE FOUND ITEM BY ID
    // ==========================================

    public FoundItem getFoundItemById(
            int foundItemId) {

        String sql =
            "SELECT * FROM found_items " +
            "WHERE found_item_id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(
                1,
                foundItemId
            );

            ResultSet rs =
                    statement.executeQuery();

            if (rs.next()) {

                FoundItem item =
                        new FoundItem();

                item.setFoundItemId(
                    rs.getInt("found_item_id")
                );

                item.setUserId(
                    rs.getInt("user_id")
                );

                item.setItemName(
                    rs.getString("item_name")
                );

                item.setCategory(
                    rs.getString("category")
                );

                item.setDescription(
                    rs.getString("description")
                );

                item.setLocationFound(
                    rs.getString("location_found")
                );

                item.setDateFound(
                    rs.getDate("date_found")
                );

                item.setImageName(
                    rs.getString("image_name")
                );

                item.setStatus(
                    rs.getString("status")
                );

                return item;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }


    // ==========================================
    // 5. UPDATE FOUND ITEM
    // ==========================================

    public boolean updateFoundItem(
            FoundItem item) {

        String sql =
            "UPDATE found_items SET " +
            "item_name = ?, " +
            "category = ?, " +
            "description = ?, " +
            "location_found = ?, " +
            "date_found = ?, " +
            "image_name = ? " +
            "WHERE found_item_id = ? " +
            "AND user_id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setString(
                1,
                item.getItemName()
            );

            statement.setString(
                2,
                item.getCategory()
            );

            statement.setString(
                3,
                item.getDescription()
            );

            statement.setString(
                4,
                item.getLocationFound()
            );

            statement.setDate(
                5,
                item.getDateFound()
            );

            statement.setString(
                6,
                item.getImageName()
            );

            statement.setInt(
                7,
                item.getFoundItemId()
            );

            statement.setInt(
                8,
                item.getUserId()
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 6. DELETE FOUND ITEM
    // ==========================================

    public boolean deleteFoundItem(
            int foundItemId,
            int userId) {

        String sql =
            "DELETE FROM found_items " +
            "WHERE found_item_id = ? " +
            "AND user_id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(
                1,
                foundItemId
            );

            statement.setInt(
                2,
                userId
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}