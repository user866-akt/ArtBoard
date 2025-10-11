package com.artboard.dao;

import com.artboard.model.User;

import java.util.Optional;

public interface UserDao {

    Optional<User> findByEmail(String email);

    User save(User user);

    Optional<User> findById(Integer id);

    Optional<User> findByUsername(String username);

    void update(User user);
}
