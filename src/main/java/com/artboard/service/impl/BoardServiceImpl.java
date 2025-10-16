package com.artboard.service.impl;

import com.artboard.dao.BoardDao;
import com.artboard.dao.PinDao;
import com.artboard.dao.UserDao;
import com.artboard.model.Board;
import com.artboard.model.Pin;
import com.artboard.service.BoardService;

import java.util.List;
import java.util.Optional;

public class BoardServiceImpl implements BoardService {

    private final BoardDao boardDao;
    private final PinDao pinDao;
    private final UserDao userDao;

    public BoardServiceImpl(BoardDao boardDao, PinDao pinDao, UserDao userDao) {
        this.boardDao = boardDao;
        this.pinDao = pinDao;
        this.userDao = userDao;
    }

    @Override
    public Board createBoard(String name, String description, Integer userId, Boolean isPrivate) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Название доски не может быть пустым");
        }
        if (userDao.findById(userId).isEmpty()) {
            throw new IllegalArgumentException("Пользователь не найден");
        }
        Board board = new Board();
        board.setName(name.trim());
        board.setDescription(description != null ? description.trim() : null);
        board.setUser_id(userId);
        board.setIs_private(isPrivate != null ? isPrivate : false);

        return boardDao.save(board);
    }

    @Override
    public List<Board> getUserBoards(Integer userId) {
        if (userDao.findById(userId).isEmpty()) {
            throw new IllegalArgumentException("Пользователь не найден");
        }
        return boardDao.findByUserId(userId);
    }

    @Override
    public List<Board> getPublicBoards() {
        return boardDao.findAll();
    }

    @Override
    public Optional<Board> getBoardById(Integer boardId) {
        return boardDao.findById(boardId);
    }

    @Override
    public List<Pin> getBoardPins(Integer boardId) {
        if (boardDao.findById(boardId).isEmpty()) {
            throw new IllegalArgumentException("Доска не найдена");
        }
        return boardDao.findPinsByBoardId(boardId);
    }

//    @Override
//    public void addPinToBoard(Integer boardId, Integer pinId, Integer userId) {
//        Board board = boardDao.findById(boardId).orElseThrow(() -> new IllegalArgumentException("Доска не найдена"));
//        if (!board.getUser_id().equals(userId)) {
//            throw new IllegalArgumentException("Вы не можете добавлять пины в эту доску");
//        }
//        if (pinDao.findById(pinId).isEmpty()) {
//            throw new IllegalArgumentException("Пин не найден");
//        }
//        if (boardDao.isPinInBoard(boardId, pinId)) {
//            throw new IllegalArgumentException("Пин уже добавлен в эту доску");
//        }
//
//        boardDao.addPinToBoard(boardId, pinId);
//    }

    @Override
    public void addPinToBoard(Integer boardId, Integer pinId, Integer userId) {
        System.out.println("=== BoardServiceImpl.addPinToBoard ===");
        System.out.println("Board ID: " + boardId);
        System.out.println("Pin ID: " + pinId);
        System.out.println("User ID: " + userId);

        try {
            // Минимальная проверка - только что доска существует
            Board board = boardDao.findById(boardId)
                    .orElseThrow(() -> {
                        System.out.println("ERROR: Board not found");
                        return new IllegalArgumentException("Доска не найдена");
                    });
            System.out.println("Board found: " + board.getName());

            // Прямой вызов без лишних проверок
            System.out.println("Calling boardDao.addPinToBoard...");
            boardDao.addPinToBoard(boardId, pinId);
            System.out.println("SUCCESS: Pin added to board in service");

        } catch (Exception e) {
            System.out.println("ERROR in service: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removePinFromBoard(Integer boardId, Integer pinId, Integer userId) {
        Board board = boardDao.findById(boardId).orElseThrow(() -> new IllegalArgumentException("Доска не найдена"));
        if (!board.getUser_id().equals(userId)) {
            throw new IllegalArgumentException("Вы не можете удалять пины из этой доски");
        }
        if (!boardDao.isPinInBoard(boardId, pinId)) {
            throw new IllegalArgumentException("Пин не найден в этой доске");
        }

        boardDao.removePinFromBoard(boardId, pinId);
    }

    @Override
    public void updateBoard(Integer boardId, Integer userId, String name, String description, Boolean isPrivate) {
        Board board = boardDao.findById(boardId).orElseThrow(() -> new IllegalArgumentException("Доска не найдена"));
        if (!board.getUser_id().equals(userId)) {
            throw new IllegalArgumentException("Вы не можете редактировать эту доску");
        }
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Название доски не может быть пустым");
        }
        board.setName(name.trim());
        board.setDescription(description != null ? description.trim() : null);
        board.setIs_private(isPrivate != null ? isPrivate : board.getIs_private());

        boardDao.update(board);
    }

    @Override
    public void deleteBoard(Integer boardId, Integer userId) {
        Board board = boardDao.findById(boardId).orElseThrow(() -> new IllegalArgumentException("Доска не найдена"));
        if (!board.getUser_id().equals(userId)) {
            throw new IllegalArgumentException("Вы не можете удалить эту доску");
        }

        boardDao.delete(boardId);
    }

    @Override
    public List<Board> searchBoards(String searchQuery) {
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            return getPublicBoards();
        }
        return boardDao.findBySearchQuery(searchQuery.trim());
    }

    @Override
    public boolean isBoardOwner(Integer boardId, Integer userId) {
        Optional<Board> board = boardDao.findById(boardId);
        return board.isPresent() && board.get().getUser_id().equals(userId);
    }

    @Override
    public List<Board> getBoardsByPinId(Integer pinId) {
        if (pinDao.findById(pinId).isEmpty()) {
            throw new IllegalArgumentException("Пин не найден");
        }
        return boardDao.findBoardsByPinId(pinId);
    }
}
