package com.artboard.service;

import com.artboard.model.User;

public interface AuthenticationService {

    User register(User user);

    User login(User user);

    void logout();

    boolean isEmailAvailable(String email);

    boolean isUsernameAvailable(String username);
}
