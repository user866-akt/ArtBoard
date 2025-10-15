package com.artboard.service;

import com.artboard.model.Board;
import com.artboard.model.Pin;

import java.util.List;
import java.util.Optional;

public interface BoardService {

    Board createBoard(String name, String description, Integer userId, Boolean isPrivate);

    List<Board> getUserBoards(Integer userId);

    List<Board> getPublicBoards();

    Optional<Board> getBoardById(Integer boardId);

    List<Pin> getBoardPins(Integer boardId);

    void addPinToBoard(Integer boardId, Integer pinId, Integer userId);

    void removePinFromBoard(Integer boardId, Integer pinId, Integer userId);

    void updateBoard(Integer boardId, Integer userId, String name, String description, Boolean isPrivate);

    void deleteBoard(Integer boardId, Integer userId);

    List<Board> searchBoards(String searchQuery);

    boolean isBoardOwner(Integer boardId, Integer userId);

    List<Board> getBoardsByPinId(Integer pinId);

}
