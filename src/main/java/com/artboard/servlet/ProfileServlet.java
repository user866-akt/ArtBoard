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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserServiceImpl userService;

    public void init() {
        PinDao pinDao = new PinDaoImpl();
        UserDao userDao = new UserDaoImpl();
        this.userService = new UserServiceImpl(pinDao, userDao);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
