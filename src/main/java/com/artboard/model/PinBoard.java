package com.artboard.model;

public class PinBoard {

    private Integer id;
    private Integer pin_id;
    private Integer board_id;

    public PinBoard() {}

    public PinBoard(Integer pin_id, Integer board_id) {
        this.pin_id = pin_id;
        this.board_id = board_id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPin_id() {
        return pin_id;
    }

    public void setPin_id(Integer pin_id) {
        this.pin_id = pin_id;
    }

    public Integer getBoard_id() {
        return board_id;
    }

    public void setBoard_id(Integer board_id) {
        this.board_id = board_id;
    }
}
