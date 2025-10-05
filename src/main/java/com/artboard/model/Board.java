package com.artboard.model;

import java.time.LocalDateTime;

public class Board {

    private Integer id;
    private String name;
    private String description;
    private Integer user_id;
    private Boolean is_private;
    private LocalDateTime created_at;

    public Board() {}

    public Board(String name, String description, Integer user_id, Boolean is_private) {
        this.name = name;
        this.description = description;
        this.user_id = user_id;
        this.is_private = is_private;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public Boolean getIs_private() {
        return is_private;
    }

    public void setIs_private(Boolean is_private) {
        this.is_private = is_private;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
