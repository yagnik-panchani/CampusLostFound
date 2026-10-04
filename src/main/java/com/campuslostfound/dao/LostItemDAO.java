package com.campuslostfound.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.campuslostfound.model.LostItem;
import com.campuslostfound.util.DBConnection;

public class LostItemDAO {

    // ==========================================
    // 1. ADD LOST ITEM
    // ==========================================

    public boolean addLostItem(LostItem item) {

        String sql =
            "INSERT INTO lost_items " +
            "(user_id, item_name, category, description, " +
            "location_lost, date_lost, image_name, status) " +
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
                item.getLocationLost()
            );

            statement.setDate(
                6,
                item.getDateLost()
            );

            statement.setString(
                7,
                item.getImageName()
            );

            statement.setString(
                8,
                item.getStatus()
            );

            int rows =
                statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 2. GET LOST ITEMS BY USER
    // ==========================================

    public List<LostItem> getLostItemsByUser(
            int userId) {

        List<LostItem> items =
            new ArrayList<>();

        String sql =
            "SELECT * FROM lost_items " +
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

                LostItem item =
                    new LostItem();


                item.setLostItemId(
                    rs.getInt(
                        "lost_item_id"
                    )
                );


                item.setUserId(
                    rs.getInt(
                        "user_id"
                    )
                );


                item.setItemName(
                    rs.getString(
                        "item_name"
                    )
                );


                item.setCategory(
                    rs.getString(
                        "category"
                    )
                );


                item.setDescription(
                    rs.getString(
                        "description"
                    )
                );


                item.setLocationLost(
                    rs.getString(
                        "location_lost"
                    )
                );


                item.setDateLost(
                    rs.getDate(
                        "date_lost"
                    )
                );


                item.setImageName(
                    rs.getString(
                        "image_name"
                    )
                );


                item.setStatus(
                    rs.getString(
                        "status"
                    )
                );


                items.add(item);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return items;
    }


    // ==========================================
    // 3. UPDATE LOST ITEM
    // ==========================================

    public boolean updateLostItem(
            LostItem item) {

        String sql =
            "UPDATE lost_items SET " +
            "item_name = ?, " +
            "category = ?, " +
            "description = ?, " +
            "location_lost = ?, " +
            "date_lost = ?, " +
            "image_name = ? " +
            "WHERE lost_item_id = ? " +
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
                item.getLocationLost()
            );

            statement.setDate(
                5,
                item.getDateLost()
            );

            statement.setString(
                6,
                item.getImageName()
            );

            statement.setInt(
                7,
                item.getLostItemId()
            );

            statement.setInt(
                8,
                item.getUserId()
            );


            int rows =
                statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 4. DELETE LOST ITEM
    // ==========================================

    public boolean deleteLostItem(
            int lostItemId,
            int userId) {

        String sql =
            "DELETE FROM lost_items " +
            "WHERE lost_item_id = ? " +
            "AND user_id = ?";

        try (
            Connection connection =
                DBConnection.getConnection();

            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(
                1,
                lostItemId
            );

            statement.setInt(
                2,
                userId
            );


            int rows =
                statement.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // ==========================================
    // 5. GET TOTAL LOST ITEMS
    // ==========================================

    public int getTotalLostItems() {

        String sql =
            "SELECT COUNT(*) " +
            "FROM lost_items";

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
}