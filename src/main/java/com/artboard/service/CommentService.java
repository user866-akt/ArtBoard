package com.artboard.service;

import com.artboard.model.Comment;
import com.artboard.model.Pin;

import java.util.List;
import java.util.Optional;

public interface CommentService {

    Comment createComment(Integer userId, String commentText);

    Optional<Comment> getCommentById(Integer id);

    List<Comment> getBoardComments(Integer boardId);

    void addCommentToBoard(Integer boardId, Integer commentId);

    Comment update(Integer commentId,  Integer userId, String commentText);

    void delete(Integer id);

}
