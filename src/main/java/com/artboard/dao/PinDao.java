package com.artboard.dao;

import com.artboard.model.Pin;

import java.util.List;
import java.util.Optional;

public interface PinDao {

    Pin save(Pin pin);

    List<Pin> findAll();

    List<Pin> findByUserId(Integer userId);

    List<Pin> findByCategory(String category);

    Optional<Pin> findById(Integer id);

    void delete(Integer id);
}
