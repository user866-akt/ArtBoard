package com.artboard.model;

import java.time.LocalDateTime;

public class Comment {

    private Integer id;
    private Integer userId;
    private String commentText;
    private LocalDateTime createdAt;

    public Comment() {}

    public Comment(Integer id, Integer userId, String commentText, LocalDateTime createdAt) {
        this.id = id;
        this.userId = userId;
        this.commentText = commentText;
        this.createdAt = createdAt;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getCommentText() {
        return commentText;
    }

    public void setCommentText(String commentText) {
        this.commentText = commentText;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
