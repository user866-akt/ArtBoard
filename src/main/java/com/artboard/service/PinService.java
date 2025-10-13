package com.artboard.service;

import com.artboard.model.Pin;

import java.util.List;
import java.util.Optional;

public interface PinService {

    Pin createPin(String title, String description, String imageUrl, Integer userId, String category);

    List<Pin> getFeedPins();

    List<Pin> getUserPins(Integer userId);

    List<Pin> getPinsByCategory(String category);

    List<Pin> searchPins(String searchQuery);

    Pin getPinById(Integer id);

    void update(Pin pin);

    void delete(Integer pinId);

    boolean isPinOwner(Integer pinId, Integer userId);
}