package com.artboard.dao;

import com.artboard.model.Board;
import com.artboard.model.Pin;

import java.util.List;
import java.util.Optional;

public interface BoardDao {

    Board save(Board board);

    List<Board> findAll();

    List<Board> findByUserId(Integer userId);

    List<Board> findBySearchQuery(String searchQuery);

    Optional<Board> findById(Integer id);

    void delete(Integer id);

    void update(Board board);

    void addPinToBoard(Integer boardId, Integer pinId);

    void removePinFromBoard(Integer boardId, Integer pinId);

    List<Pin> findPinsByBoardId(Integer boardId);

    boolean isPinInBoard(Integer boardId, Integer pinId);

    List<Board> findBoardsByPinId(Integer pinId);

    int getPinCount(Integer boardId);
}
