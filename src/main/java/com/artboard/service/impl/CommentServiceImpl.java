package com.artboard.service.impl;

import com.artboard.dao.BoardDao;
import com.artboard.dao.CommentDao;
import com.artboard.dao.PinDao;
import com.artboard.dao.UserDao;
import com.artboard.model.Board;
import com.artboard.model.Comment;
import com.artboard.service.CommentService;

import java.util.List;
import java.util.Optional;

public class CommentServiceImpl implements CommentService {

    private final CommentDao commentDao;
    private final BoardDao boardDao;
    private final UserDao userDao;

    public CommentServiceImpl(CommentDao commentDao, UserDao userDao, BoardDao boardDao) {
        this.commentDao = commentDao;
        this.userDao = userDao;
        this.boardDao = boardDao;
    }

    @Override
    public Comment createComment(Integer userId, String commentText) {
        if (commentText == null || commentText.trim().isEmpty()) {
            throw new IllegalArgumentException("Комментарий не может быть пустым");
        }
        if (userDao.findById(userId).isEmpty()) {
            throw new IllegalArgumentException("Пользователь не найден");
        }
        Comment comment = new Comment();
        comment.setUserId(userId);
        comment.setCommentText(commentText);
        return commentDao.save(comment);
    }

    @Override
    public Optional<Comment> getCommentById(Integer id) {
        return commentDao.findById(id);
    }

    @Override
    public List<Comment> getBoardComments(Integer boardId) {
        if (boardDao.findById(boardId).isEmpty()) {
            throw new IllegalArgumentException("Доска не найдена");
        }
        return commentDao.findByBoardId(boardId);
    }

    @Override
    public void addCommentToBoard(Integer boardId, Integer commentId) {
        commentDao.addCommentToBoard(commentId, boardId);
    }

    @Override
    public Comment update(Integer commentId, Integer userId, String commentText) {
        Comment comment = commentDao.findById(commentId).get();
        if (!comment.getUserId().equals(userId)) {
            throw new IllegalArgumentException("Вы не можете редактировать этот комментарий");
        }
        if (commentText == null || commentText.trim().isEmpty()) {
            throw new IllegalArgumentException("Комментарий не может быть пустым");
        }
        comment.setCommentText(commentText);
        commentDao.update(comment);
        return comment;
    }

    @Override
    public void delete(Integer id) {
        commentDao.delete(id);
    }
}
