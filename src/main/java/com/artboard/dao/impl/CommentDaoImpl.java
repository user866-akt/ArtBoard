package com.artboard.dao.impl;

import com.artboard.dao.CommentDao;
import com.artboard.model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class CommentDaoImpl implements CommentDao {

    private final Connection connection;

    public CommentDaoImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public Comment save(Comment comment) {
        String sql = "insert into comments (user_id, comment_text) values (?, ?) returning id, created_at";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, comment.getUserId());
            statement.setString(2, comment.getCommentText());
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    comment.setId(resultSet.getInt("id"));
                    comment.setCreatedAt(resultSet.getTimestamp("created_at").toLocalDateTime());
                }
            }
            return comment;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Comment> findByBoardId(Integer boardId) {
        String sql = "select c.* from comments c join comment_board cb on c.id = cb.id where cb.board_id = ? order by created_at desc";
        List<Comment> comments = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, boardId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    comments.add(mapResultSetToComment(resultSet));
                }
                return comments;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Optional<Comment> findById(Integer id) {
        String sql = "select * from comments where id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return Optional.of(mapResultSetToComment(resultSet));
                } else {
                    return Optional.empty();
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(Integer id) {
        String sql1 = "delete from comment_board where comment_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql1)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        String sql = "delete from comments where id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            int affected = statement.executeUpdate();
            if (affected == 0) {
                throw new RuntimeException("Comment not found with id: " + id);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void update(Comment comment) {
        String sql = "update comments set comment_text = ? where id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, comment.getCommentText());
            statement.setInt(2, comment.getId());
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addCommentToBoard(Integer commentId, Integer boardId) {
        String sql = "insert into comment_board (comment_id, board_id) values (?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, commentId);
            statement.setInt(2, boardId);
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private Comment mapResultSetToComment(ResultSet resultSet) throws SQLException {
        Comment comment = new Comment();

        comment.setId(resultSet.getInt("id"));
        comment.setUserId(resultSet.getInt("user_id"));
        comment.setCommentText(resultSet.getString("comment_text"));
        comment.setCreatedAt(resultSet.getTimestamp("created_at").toLocalDateTime());

        return comment;
    }
}
