package com.artboard.dao.impl;

import com.artboard.dao.BoardDao;
import com.artboard.model.Board;
import com.artboard.model.Pin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class BoardDaoImpl implements BoardDao {

    private final Connection connection;

    public BoardDaoImpl(Connection connection) {
        this.connection = connection;
    }

    @Override
    public Board save(Board board) {
        String sql = "insert into boards (name, description, user_id, is_private) values (?, ?, ?, ?) returning id, created_at";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, board.getName());
            statement.setString(2, board.getDescription());
            statement.setInt(3, board.getUser_id());
            statement.setBoolean(4, board.getIs_private());
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    board.setId(resultSet.getInt("id"));
                    board.setCreated_at(resultSet.getTimestamp("created_at").toLocalDateTime());
                }
            }
            return board;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> findAll() {
        String sql = "select * from boards where is_private = false order by created_at desc";
        List<Board> boards = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                boards.add(mapResultSetToBoard(resultSet));
            }
            return boards;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> findByUserId(Integer userId) {
        String sql = "select * from boards where user_id = ? order by created_at desc";
        List<Board> boards = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    boards.add(mapResultSetToBoard(resultSet));
                }
                return boards;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> findBySearchQuery(String searchQuery) {
        String sql = "select * from boards where name ilike ? or description ilike ?";
        List<Board> boards = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            String likepattern = "%" + searchQuery + "%";
            statement.setString(1, likepattern);
            statement.setString(2, likepattern);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    boards.add(mapResultSetToBoard(resultSet));
                }
                return boards;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Optional<Board> findById(Integer id) {
        String sql = "select * from boards where id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return Optional.of(mapResultSetToBoard(resultSet));
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
        String sql = "delete from boards where id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            int affected = statement.executeUpdate();
            if (affected == 0) {
                throw new RuntimeException("Pin not found with id: " + id);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void update(Board board) {
        String sql = "update boards set name = ?, description = ?, is_private = ? where id = ? returning id, created_at";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, board.getName());
            statement.setString(2, board.getDescription());
            statement.setBoolean(3, board.getIs_private());
            statement.setInt(4, board.getId());
            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    throw new RuntimeException("Pin not found with id: " + board.getId());
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void addPinToBoard(Integer boardId, Integer pinId) {
        String sql = "INSERT INTO pin_board (pin_id, board_id) VALUES (?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pinId);
            stmt.setInt(2, boardId);
            int rowsAffected = stmt.executeUpdate();

        } catch (SQLException e) {
            System.out.println("SQL ERROR: " + e.getMessage());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
    }

    @Override
    public void removePinFromBoard(Integer boardId, Integer pinId) {
        String sql = "delete from pin_board where board_id = ? and pin_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, boardId);
            statement.setInt(2, pinId);
            int affected = statement.executeUpdate();
            if (affected == 0) {
                throw new RuntimeException("Pin not found in board");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Pin> findPinsByBoardId(Integer boardId) {
        String sql = "select p.* from pins p join pin_board pb on p.id = pb.pin_id where pb.board_id = ? order by p.created_at";
        List<Pin> pins = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, boardId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    pins.add(mapResultSetToPin(resultSet));
                }
                return pins;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean isPinInBoard(Integer boardId, Integer pinId) {
        String sql = "SELECT 1 FROM pin_board WHERE board_id = ? AND pin_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, boardId);
            statement.setInt(2, pinId);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> findBoardsByPinId(Integer pinId) {
        String sql = "select b.* from boards b join pin_boards pb on b.id = pb.board_id where pb.pin_id = ? order by created_at desc";
        List<Board> boards = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, pinId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    boards.add(mapResultSetToBoard(resultSet));
                }
                return boards;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int getPinCount(Integer boardId) {
        String sql = "SELECT COUNT(*) FROM pin_board WHERE board_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, boardId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
                return 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private Board mapResultSetToBoard(ResultSet resultSet) throws SQLException {
        Board board = new Board();

        board.setId(resultSet.getInt("id"));
        board.setName(resultSet.getString("name"));
        board.setDescription(resultSet.getString("description"));
        board.setUser_id(resultSet.getInt("user_id"));
        board.setCreated_at(resultSet.getTimestamp("created_at").toLocalDateTime());

        return board;
    }

    private Pin mapResultSetToPin(ResultSet resultSet) throws SQLException {
        Pin pin = new Pin();

        pin.setId(resultSet.getInt("id"));
        pin.setTitle(resultSet.getString("title"));
        pin.setDescription(resultSet.getString("description"));
        pin.setImage_url(resultSet.getString("image_url"));
        pin.setUser_id(resultSet.getInt("user_id"));
        pin.setCreated_at(resultSet.getTimestamp("created_at").toLocalDateTime());
        pin.setCategory(resultSet.getString("category"));
        pin.setArtwork_author(resultSet.getString("artwork_author"));

        return pin;
    }
}
