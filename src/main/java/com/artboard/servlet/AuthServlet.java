package com.artboard.servlet;

import com.artboard.dao.UserDao;
import com.artboard.dao.impl.UserDaoImpl;
import com.artboard.model.User;
import com.artboard.service.AuthenticationService;
import com.artboard.service.impl.AuthenticationServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {
    private AuthenticationService authenticationService;

    public void init() {
        UserDao userDao = new UserDaoImpl();
        this.authenticationService = new AuthenticationServiceImpl(userDao);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getPathInfo();

        switch (path) {
            case "/register":
                register(request, response);
                break;
            case "/login":
                login(request, response);
                break;
            case "/logout":
                logout(request, response);
                break;
            default:
                response.sendError(404);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();

        if ("/logout".equals(path)) {
            logout(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    private void register (HttpServletRequest request, HttpServletResponse response) throws IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String username = request.getParameter("username");

        try {
            User user = new User(email, password, username);
            User registeredUser = authenticationService.register(user);

            HttpSession session = request.getSession();
            session.setAttribute("user", registeredUser);

            Cookie userCookie = new Cookie("username", registeredUser.getUsername());
            userCookie.setMaxAge(24 * 60 * 60);
            response.addCookie(userCookie);

            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/register.jsp?error=" + e.getMessage());
        }
    }

    private void login (HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = new User();
            user.setEmail(email);
            user.setPasswordHash(password);

            User loggedInUser = authenticationService.login(user);

            HttpSession session = request.getSession();
            session.setAttribute("user", loggedInUser);

            Cookie userCookie = new Cookie("username", loggedInUser.getUsername());
            userCookie.setMaxAge(24 * 60 * 60);
            response.addCookie(userCookie);

            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=" + e.getMessage());
        }
    }

    private void logout (HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        Cookie userCookie = new Cookie("username", "");
        userCookie.setMaxAge(0);
        response.addCookie(userCookie);

        authenticationService.logout();

        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
