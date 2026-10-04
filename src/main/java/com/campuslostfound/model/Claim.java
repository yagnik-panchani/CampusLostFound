package com.campuslostfound.model;

import java.sql.Timestamp;

public class Claim {

    private int claimId;

    private int foundItemId;

    private int claimantUserId;

    private String claimDescription;

    private String status;

    private String adminRemark;

    private Timestamp createdAt;

    private Timestamp updatedAt;


    // ==========================================
    // CONSTRUCTOR
    // ==========================================

    public Claim() {
    }


    // ==========================================
    // CLAIM ID
    // ==========================================

    public int getClaimId() {
        return claimId;
    }

    public void setClaimId(int claimId) {
        this.claimId = claimId;
    }


    // ==========================================
    // FOUND ITEM ID
    // ==========================================

    public int getFoundItemId() {
        return foundItemId;
    }

    public void setFoundItemId(int foundItemId) {
        this.foundItemId = foundItemId;
    }


    // ==========================================
    // CLAIMANT USER ID
    // ==========================================

    public int getClaimantUserId() {
        return claimantUserId;
    }

    public void setClaimantUserId(int claimantUserId) {
        this.claimantUserId = claimantUserId;
    }


    // ==========================================
    // CLAIM DESCRIPTION
    // ==========================================

    public String getClaimDescription() {
        return claimDescription;
    }

    public void setClaimDescription(
            String claimDescription) {

        this.claimDescription =
                claimDescription;
    }


    // ==========================================
    // STATUS
    // ==========================================

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    // ==========================================
    // ADMIN REMARK
    // ==========================================

    public String getAdminRemark() {
        return adminRemark;
    }

    public void setAdminRemark(String adminRemark) {
        this.adminRemark =
                adminRemark;
    }


    // ==========================================
    // CREATED AT
    // ==========================================

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(
            Timestamp createdAt) {

        this.createdAt = createdAt;
    }


    // ==========================================
    // UPDATED AT
    // ==========================================

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(
            Timestamp updatedAt) {

        this.updatedAt = updatedAt;
    }
}