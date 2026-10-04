package com.campuslostfound.model;

import java.sql.Date;

public class FoundItem {

    private int foundItemId;
    private int userId;

    private String itemName;
    private String category;
    private String description;

    private String locationFound;
    private Date dateFound;

    private String imageName;
    private String status;


    // Default constructor
    public FoundItem() {
    }


    // Getters and Setters

    public int getFoundItemId() {
        return foundItemId;
    }

    public void setFoundItemId(int foundItemId) {
        this.foundItemId = foundItemId;
    }


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }


    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    public String getLocationFound() {
        return locationFound;
    }

    public void setLocationFound(String locationFound) {
        this.locationFound = locationFound;
    }


    public Date getDateFound() {
        return dateFound;
    }

    public void setDateFound(Date dateFound) {
        this.dateFound = dateFound;
    }


    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}