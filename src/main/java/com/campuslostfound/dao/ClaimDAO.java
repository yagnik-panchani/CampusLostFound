package com.campuslostfound.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.campuslostfound.model.Claim;
import com.campuslostfound.util.DBConnection;

public class ClaimDAO {

    public boolean addClaim(Claim claim) {

        String sql =
            "INSERT INTO claims " +
            "(found_item_id, claimant_user_id, " +
            "claim_description, status) " +
            "VALUES (?, ?, ?, ?)";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(
                1,
                claim.getFoundItemId()
            );

            statement.setInt(
                2,
                claim.getClaimantUserId()
            );

            statement.setString(
                3,
                claim.getClaimDescription()
            );

            statement.setString(
                4,
                "PENDING"
            );

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public List<Claim> getClaimsByUser(int userId) {

        List<Claim> claims = new ArrayList<>();

        String sql =
            "SELECT c.* " +
            "FROM claims c " +
            "WHERE c.claimant_user_id = ? " +
            "ORDER BY c.created_at DESC";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            ResultSet rs =
                statement.executeQuery();

            while (rs.next()) {

                Claim claim = new Claim();

                claim.setClaimId(
                    rs.getInt("claim_id")
                );

                claim.setFoundItemId(
                    rs.getInt("found_item_id")
                );

                claim.setClaimantUserId(
                    rs.getInt("claimant_user_id")
                );

                claim.setClaimDescription(
                    rs.getString("claim_description")
                );

                claim.setStatus(
                    rs.getString("status")
                );

                claim.setAdminRemark(
                    rs.getString("admin_remark")
                );

                claim.setCreatedAt(
                    rs.getTimestamp("created_at")
                );

                claim.setUpdatedAt(
                    rs.getTimestamp("updated_at")
                );

                claims.add(claim);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return claims;
    }


    public List<Claim> getPendingClaims() {

        List<Claim> claims = new ArrayList<>();

        String sql =
            "SELECT c.* " +
            "FROM claims c " +
            "WHERE c.status = 'PENDING' " +
            "ORDER BY c.created_at ASC";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            ResultSet rs =
                statement.executeQuery();

            while (rs.next()) {

                Claim claim = new Claim();

                claim.setClaimId(
                    rs.getInt("claim_id")
                );

                claim.setFoundItemId(
                    rs.getInt("found_item_id")
                );

                claim.setClaimantUserId(
                    rs.getInt("claimant_user_id")
                );

                claim.setClaimDescription(
                    rs.getString("claim_description")
                );

                claim.setStatus(
                    rs.getString("status")
                );

                claim.setAdminRemark(
                    rs.getString("admin_remark")
                );

                claim.setCreatedAt(
                    rs.getTimestamp("created_at")
                );

                claim.setUpdatedAt(
                    rs.getTimestamp("updated_at")
                );

                claims.add(claim);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return claims;
    }


    public Claim getClaimById(int claimId) {

        String sql =
            "SELECT * FROM claims " +
            "WHERE claim_id = ?";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(1, claimId);

            ResultSet rs =
                statement.executeQuery();

            if (rs.next()) {

                Claim claim = new Claim();

                claim.setClaimId(
                    rs.getInt("claim_id")
                );

                claim.setFoundItemId(
                    rs.getInt("found_item_id")
                );

                claim.setClaimantUserId(
                    rs.getInt("claimant_user_id")
                );

                claim.setClaimDescription(
                    rs.getString("claim_description")
                );

                claim.setStatus(
                    rs.getString("status")
                );

                claim.setAdminRemark(
                    rs.getString("admin_remark")
                );

                claim.setCreatedAt(
                    rs.getTimestamp("created_at")
                );

                claim.setUpdatedAt(
                    rs.getTimestamp("updated_at")
                );

                return claim;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    public boolean hasExistingClaim(
            int foundItemId,
            int userId) {

        String sql =
            "SELECT claim_id " +
            "FROM claims " +
            "WHERE found_item_id = ? " +
            "AND claimant_user_id = ? " +
            "AND status = 'PENDING'";

        try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement statement =
                connection.prepareStatement(sql)
        ) {

            statement.setInt(1, foundItemId);
            statement.setInt(2, userId);

            ResultSet rs =
                statement.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    /*
     * Approve or reject a claim.
     *
     * APPROVE:
     * 1. Claim becomes APPROVED
     * 2. Found item becomes CLAIMED
     *
     * REJECT:
     * 1. Claim becomes REJECTED
     * 2. Found item remains FOUND
     *
     * Both database operations are handled
     * inside one transaction.
     */
    public boolean reviewClaim(
            int claimId,
            String action,
            String adminRemark) {

        String claimSql =
            "UPDATE claims " +
            "SET status = ?, " +
            "admin_remark = ?, " +
            "updated_at = CURRENT_TIMESTAMP " +
            "WHERE claim_id = ? " +
            "AND status = 'PENDING'";

        String itemSql =
            "UPDATE found_items " +
            "SET status = 'CLAIMED' " +
            "WHERE found_item_id = (" +
            "SELECT found_item_id " +
            "FROM claims " +
            "WHERE claim_id = ?" +
            ")";

        try (
            Connection connection =
                DBConnection.getConnection();
            PreparedStatement claimStatement =
                connection.prepareStatement(claimSql);
            PreparedStatement itemStatement =
                connection.prepareStatement(itemSql)
        ) {

            connection.setAutoCommit(false);

            String newStatus;

            if ("APPROVE".equalsIgnoreCase(action)) {

                newStatus = "APPROVED";

            } else if ("REJECT".equalsIgnoreCase(action)) {

                newStatus = "REJECTED";

            } else {

                connection.rollback();
                return false;
            }

            claimStatement.setString(
                1,
                newStatus
            );

            claimStatement.setString(
                2,
                adminRemark
            );

            claimStatement.setInt(
                3,
                claimId
            );

            int claimRows =
                claimStatement.executeUpdate();

            if (claimRows == 0) {

                connection.rollback();
                return false;
            }

            /*
             * Only APPROVED claims change
             * the found item status.
             */
            if ("APPROVE".equalsIgnoreCase(action)) {

                itemStatement.setInt(
                    1,
                    claimId
                );

                int itemRows =
                    itemStatement.executeUpdate();

                if (itemRows == 0) {

                    connection.rollback();
                    return false;
                }
            }

            connection.commit();

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}