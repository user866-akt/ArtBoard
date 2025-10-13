package com.artboard.dao.impl;

import com.artboard.dao.PinDao;
import com.artboard.model.Pin;
import com.artboard.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class PinDaoImpl implements PinDao {

    Connection connection = DatabaseConnection.getConnection();

    @Override
    public Pin save(Pin pin) {
        String sql = "insert into pins (title, description, image_url, user_id, category) values (?, ?, ?, ?, ?) returning id, created_at";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, pin.getTitle());
            statement.setString(2, pin.getDescription());
            statement.setString(3, pin.getImage_url());
            statement.setInt(4, pin.getUser_id());
            statement.setString(5, pin.getCategory());
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    pin.setId(resultSet.getInt("id"));
                    pin.setCreated_at(resultSet.getTimestamp("created_at").toLocalDateTime());
                }
            }
            return pin;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Pin> findAll() {
        String sql = "select * from pins order by created_at desc";
        List<Pin> pins = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                pins.add(mapResultSetToPin(resultSet));
            }
            return pins;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Pin> findByUserId(Integer userId) {
        String sql = "select * from pins where user_id = ? order by created_at desc";
        List<Pin> pins = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
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
    public List<Pin> findByCategory(String category) {
        String sql = "select * from pins where category = ? order by created_at desc";
        List<Pin> pins = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, category);
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
    public List<Pin> findBySearchQuery(String searchQuery) {
        String sql = "select * from pins where title ilike ? or description ilike ? order by created_at desc";
        List<Pin> pins = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            String likepattern = "%" + searchQuery + "%";
            statement.setString(1, likepattern);
            statement.setString(2, likepattern);
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
    public Optional<Pin> findById(Integer id) {
        String sql = "select * from pins where id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return Optional.of(mapResultSetToPin(resultSet));
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
        String sql = "delete from pins where id = ?";
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
    public void update(Pin pin) {
        String sql = "update pins set title = ?, description = ?, image_url = ?, category = ? where id = ? returning id, created_at";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, pin.getTitle());
            statement.setString(2, pin.getDescription());
            statement.setString(3, pin.getImage_url());
            statement.setString(4, pin.getCategory());
            statement.setInt(5, pin.getId());
            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next()) {
                    throw new RuntimeException("Pin not found with id: " + pin.getId());
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
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

        return pin;
    }
}
