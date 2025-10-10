package com.artboard.servlet;

import com.artboard.dao.PinDao;
import com.artboard.dao.UserDao;
import com.artboard.dao.impl.PinDaoImpl;
import com.artboard.dao.impl.UserDaoImpl;
import com.artboard.model.Pin;
import com.artboard.model.User;
import com.artboard.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/profile/*")
public class ProfileServlet extends HttpServlet {

    private UserServiceImpl userService;

    public void init() {
        PinDao pinDao = new PinDaoImpl();
        UserDao userDao = new UserDaoImpl();
        this.userService = new UserServiceImpl(pinDao, userDao);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if (path == null || "/".equals(path)) {
            showProfile(req, resp);
        } else if ("/edit".equals(path)) {
            showEditForm(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if ("/edit".equals(path)) {
            updateProfile(req, resp);
        }
    }

    private void showProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
        try {
            User fullUser = userService.getUserById(user.getId());
            List<Pin> userPins = userService.getUserPins(fullUser.getId());
            req.setAttribute("user", fullUser);
            req.setAttribute("pins", userPins);
            req.getRequestDispatcher("/profile.jsp").forward(req, resp);
        } catch (IllegalArgumentException e) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp?error=User+not+found");
        }
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }

        User fullUser = userService.getUserById(user.getId());
        req.setAttribute("user", fullUser);
        req.getRequestDispatcher("/edit-profile.jsp").forward(req, resp);
    }

    private void updateProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("user");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        try {
            User updatedUser = new User();
            updatedUser.setId(currentUser.getId());
            updatedUser.setUsername(username);
            updatedUser.setEmail(email);
            updatedUser.setPasswordHash(currentUser.getPasswordHash());
            userService.update(updatedUser);
            session.setAttribute("user", updatedUser);
            resp.sendRedirect(req.getContextPath() + "/profile");
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/edit-profile.jsp").forward(req, resp);
        }
    }
}
