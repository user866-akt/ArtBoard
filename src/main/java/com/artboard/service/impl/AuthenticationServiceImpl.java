package com.artboard.service.impl;

import com.artboard.dao.UserDao;
import com.artboard.model.User;
import com.artboard.service.AuthenticationService;
import com.artboard.util.PasswordHasher;

public class AuthenticationServiceImpl implements AuthenticationService {

    private final UserDao userDao;

    public AuthenticationServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public User register(User user) {
        if (userDao.findByEmail(user.getEmail()).isPresent()) {
            throw new IllegalArgumentException("Email уже используется");
        }
        String password = user.getPasswordHash();
        if (password == null || password.length() < 6) {
            throw new IllegalArgumentException("Пароль должен быть не менее 6 символов");
        }
        String passwordHash = PasswordHasher.encrypt(password);
        user.setPasswordHash(passwordHash);
        return userDao.save(user);
    }

    @Override
    public User login(User user) {
        User foundUser = userDao.findByEmail(user.getEmail()).orElseThrow(() -> new IllegalArgumentException("Пользователь на найден"));
        String inputPasswordHash = PasswordHasher.encrypt(user.getPasswordHash());
        if (!inputPasswordHash.equals(foundUser.getPasswordHash())) {
            throw new IllegalArgumentException("Неверный пароль");
        }
        return foundUser;
    }

    @Override
    public void logout() {

    }
}
