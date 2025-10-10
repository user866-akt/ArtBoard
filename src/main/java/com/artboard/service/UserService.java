package com.artboard.service;

import com.artboard.model.Pin;
import com.artboard.model.User;

import java.util.List;

public interface UserService {

    User getUserById(Integer id);

    List<Pin> getUserPins(Integer id);

    void update(User user);
}
