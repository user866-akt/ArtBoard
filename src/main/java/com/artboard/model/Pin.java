package com.artboard.model;

import java.time.LocalDateTime;

public class Pin {

    private Integer id;
    private String title;
    private String description;
    private String image_url;
    private Integer user_id;
    private String category;
    private LocalDateTime created_at;
    private String artwork_author;

    public Pin() {}

    public Pin(Integer id, String title, String description, String image_url, Integer user_id, String category, LocalDateTime created_at, String artwork_author) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.image_url = image_url;
        this.user_id = user_id;
        this.category = category;
        this.created_at = created_at;
        this.artwork_author = artwork_author;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public String getArtwork_author() {
        return artwork_author;
    }

    public void setArtwork_author(String artwork_author) {
        this.artwork_author = artwork_author;
    }
}
