package com.artboard.servlet;

import com.artboard.dao.PinDao;
import com.artboard.dao.UserDao;
import com.artboard.dao.impl.PinDaoImpl;
import com.artboard.dao.impl.UserDaoImpl;
import com.artboard.model.Pin;
import com.artboard.model.User;
import com.artboard.service.PinService;
import com.artboard.service.impl.PinServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/pins/*")
public class PinServlet extends HttpServlet {
    private PinService pinService;

    public void init() {
        UserDao userDao = new UserDaoImpl();
        PinDao pinDao = new PinDaoImpl();
        this.pinService = new PinServiceImpl(pinDao, userDao);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if (path == null || "/".equals(path)) {
            showAllPins(req, resp);
        } else if ("/by-category".equals(path)) {
            showPinsByCategory(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/create".equals(path)) {
            createPin(req, resp);
        }
    }

    private void createPin(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String category = request.getParameter("category");

        try {
            Pin pin = pinService.createPin(title, description, imageUrl, user.getId(), category);

            response.sendRedirect(request.getContextPath() + "/index.jsp");

        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/create-pin.jsp?error=" + e.getMessage());
        }
    }

    private void showAllPins(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Pin> pins = pinService.getFeedPins();
        request.setAttribute("pins", pins);
        request.getRequestDispatcher("/pins.jsp").forward(request, response);
    }

    private void showPinsByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Pin> pins = pinService.getPinsByCategory(category);
        request.setAttribute("pins", pins);
        request.getRequestDispatcher("/pins.jsp").forward(request, response);
    }
}
