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
import java.util.Optional;

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
        } else if ("/search".equals(path)) {
            searchPins(req, resp);
        } else if (path.matches("/\\d+")) {
            showPinDetails(req, resp, Integer.parseInt(path.substring(1)));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/create".equals(path)) {
            createPin(req, resp);
        }
    }

    private void showPinDetails(HttpServletRequest request, HttpServletResponse response, Integer pinId)
            throws ServletException, IOException {
        try {
            Optional<Pin> pin = pinService.getPinById(pinId);
            if (pin.isPresent()) {
                request.setAttribute("pin", pin.get());
                request.getRequestDispatcher("/pin-details.jsp").forward(request, response);
            } else {
                response.sendError(404, "Пин не найден");
            }
        } catch (Exception e) {
            response.sendError(500, "Ошибка сервера");
        }
    }

    private void createPin(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String category = request.getParameter("category");
        String artwork_author = request.getParameter("artwork_author");

        try {
            Pin pin = pinService.createPin(title, description, imageUrl, user.getId(), category, artwork_author);

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

    private void searchPins(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("q");
        List<Pin> pins = pinService.searchPins(searchQuery);
        request.setAttribute("pins", pins);
        request.getRequestDispatcher("/pins.jsp").forward(request, response);
    }
}
