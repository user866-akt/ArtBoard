package com.artboard.servlet;

import com.artboard.dao.BoardDao;
import com.artboard.dao.PinDao;
import com.artboard.dao.UserDao;
import com.artboard.dao.impl.BoardDaoImpl;
import com.artboard.dao.impl.PinDaoImpl;
import com.artboard.dao.impl.UserDaoImpl;
import com.artboard.model.Board;
import com.artboard.model.Pin;
import com.artboard.model.User;
import com.artboard.service.BoardService;
import com.artboard.service.PinService;
import com.artboard.service.impl.BoardServiceImpl;
import com.artboard.service.impl.PinServiceImpl;
import com.artboard.util.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@WebServlet("/boards/*")
public class BoardServlet extends HttpServlet {
    private BoardService boardService;
    private PinService pinService;

    public void init() {
        Connection connection = DatabaseConnection.getConnection();
        BoardDao boardDao = new BoardDaoImpl(connection);
        PinDao pinDao = new PinDaoImpl();
        UserDao userDao = new UserDaoImpl();
        this.boardService = new BoardServiceImpl(boardDao, pinDao, userDao);
        this.pinService = new PinServiceImpl(pinDao, userDao);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if (path == null || "/".equals(path)) {
            showAllBoards(req, resp);
        } else if ("/search".equals(path)) {
            searchBoards(req, resp);
        } else if (path.matches("/\\d+")) {
            showBoardDetails(req, resp, Integer.parseInt(path.substring(1)));
        } else if (path.matches("/\\d+/edit")) {
            showEditBoardForm(req, resp, Integer.parseInt(path.split("/")[1]));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if ("/create".equals(path)) {
            createBoard(req, resp);
        } else if (path.matches("/\\d+/edit")) {
            updateBoard(req, resp, Integer.parseInt(path.split("/")[1]));
        } else if (path.matches("/\\d+/add-pin")) {
            addPinToBoard(req, resp, Integer.parseInt(path.split("/")[1]));
        } else if (path.matches("/\\d+/remove-pin")) {
            removePinFromBoard(req, resp, Integer.parseInt(path.split("/")[1]));
        }
    }

    private void showAllBoards(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Board> boards = boardService.getPublicBoards();
            req.setAttribute("boards", boards);
            req.getRequestDispatcher("/boards.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendError(500, "Ошибка сервера");
        }
    }

    private void showBoardDetails(HttpServletRequest req, HttpServletResponse resp, Integer boardId)
            throws ServletException, IOException {
        try {
            Optional<Board> board = boardService.getBoardById(boardId);
            if (board.isPresent()) {
                List<Pin> pins = boardService.getBoardPins(boardId);
                req.setAttribute("board", board.get());
                req.setAttribute("pins", pins);
                req.setAttribute("boardService", boardService);
                req.getRequestDispatcher("/board-details.jsp").forward(req, resp);
            } else {
                resp.sendError(404, "Доска не найдена");
            }
        } catch (Exception e) {
            resp.sendError(500, "Ошибка сервера");
        }
    }

    private void showEditBoardForm(HttpServletRequest req, HttpServletResponse resp, Integer boardId) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            Optional<Board> board = boardService.getBoardById(boardId);
            if (board.isPresent()) {
                if (!board.get().getUser_id().equals(user.getId())) {
                    resp.sendError(403, "Вы не можете редактировать эту доску");
                    return;
                }
                List<Pin> pinsInBoard = boardService.getBoardPins(boardId);
                List<Pin> allAvailablePins = pinService.getFeedPins();
                List<Pin> pinsToAdd = allAvailablePins.stream()
                        .filter(pin -> pinsInBoard.stream().noneMatch(boardPin -> boardPin.getId().equals(pin.getId())))
                        .collect(Collectors.toList());
                req.setAttribute("board", board.get());
                req.setAttribute("pins", pinsInBoard);
                req.setAttribute("pinsToAdd", pinsToAdd);
                req.getRequestDispatcher("/edit-board-simple.jsp").forward(req, resp);
            } else {
                resp.sendError(404, "Доска не найдена");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500, "Ошибка сервера: " + e.getMessage());
        }
    }

    private void searchBoards(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchQuery = req.getParameter("q");
        try {
            List<Board> boards = boardService.searchBoards(searchQuery);
            req.setAttribute("boards", boards);
            req.setAttribute("searchQuery", searchQuery);
            req.getRequestDispatcher("/boards.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendError(500, "Ошибка сервера");
        }
    }

    private void createBoard(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String isPrivate = req.getParameter("is_private");
        try {
            Board board = boardService.createBoard(name, description, user.getId(), "on".equals(isPrivate));
            resp.sendRedirect(req.getContextPath() + "/boards/" + board.getId());
        } catch (IllegalArgumentException e) {
            resp.sendRedirect(req.getContextPath() + "/create-board.jsp?error=" + e.getMessage());
        }
    }

    private void updateBoard(HttpServletRequest req, HttpServletResponse resp, Integer boardId) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
        }
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String isPrivate = req.getParameter("is_private");
        try {
            boardService.updateBoard(boardId, user.getId(), name, description, "on".equals(isPrivate));
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId);
        } catch (IllegalArgumentException e) {
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId + "/edit?error=" + e.getMessage());
        }
    }

    private void addPinToBoard(HttpServletRequest req, HttpServletResponse resp, Integer boardId) throws IOException {
        System.out.println("=== Servlet.addPinToBoard ===");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            System.out.println("ERROR: User not found in session");
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String pinIdParam = req.getParameter("pinId");
        System.out.println("Raw pinId parameter: '" + pinIdParam + "'");

        try {
            Integer pinId = Integer.parseInt(pinIdParam);
            System.out.println("Parsed pinId: " + pinId);
            System.out.println("Calling boardService.addPinToBoard...");

            boardService.addPinToBoard(boardId, pinId, user.getId());

            System.out.println("SUCCESS: Redirecting to edit page");
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId + "/edit?success=true");

        } catch (NumberFormatException e) {
            System.out.println("ERROR: Invalid pinId format: " + pinIdParam);
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId + "/edit?error=Неверный+ID+пина");
        } catch (IllegalArgumentException e) {
            System.out.println("ERROR: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId + "/edit?error=" + e.getMessage());
        } catch (Exception e) {
            System.out.println("UNEXPECTED ERROR: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId + "/edit?error=Ошибка+сервера");
        }
    }

    private void removePinFromBoard(HttpServletRequest req, HttpServletResponse resp, Integer boardId) throws IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        String pinIdParam = req.getParameter("pinId");
        try {
            Integer pinId = Integer.parseInt(pinIdParam);
            boardService.removePinFromBoard(boardId, pinId, user.getId());
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId + "/edit?success=true");
        } catch (IllegalArgumentException e) {
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId + "/edit?error=" + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/boards/" + boardId + "/edit?error=Ошибка сервера");
        }
    }
}
