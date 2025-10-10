package com.artboard.service.impl;

import com.artboard.dao.PinDao;
import com.artboard.dao.UserDao;
import com.artboard.model.Pin;
import com.artboard.model.User;
import com.artboard.service.UserService;

import java.util.List;
import java.util.Optional;

public class UserServiceImpl implements UserService {

    private final UserDao userDao;
    private final PinDao pinDao;

    public UserServiceImpl(PinDao pinDao, UserDao userDao) {
        this.userDao = userDao;
        this.pinDao = pinDao;
    }

    @Override
    public User getUserById(Integer id) {
        Optional<User> user = userDao.findById(id);
        if (user.isPresent()) {
            return user.get();
        } else {
            throw new IllegalArgumentException("Пользователя с таким id нет");
        }
    }

    @Override
    public List<Pin> getUserPins(Integer id) {
        return pinDao.findByUserId(id);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }
}
