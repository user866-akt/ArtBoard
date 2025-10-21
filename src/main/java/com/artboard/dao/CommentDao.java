package com.artboard.dao;

import com.artboard.model.Comment;

import java.util.List;
import java.util.Optional;

public interface CommentDao {

    Comment save(Comment comment);

    List<Comment> findByBoardId(Integer boardId);

    Optional<Comment> findById(Integer id);

    void delete(Integer id);

    void update(Comment comment);

    void addCommentToBoard(Integer commentId, Integer boardId);
}
