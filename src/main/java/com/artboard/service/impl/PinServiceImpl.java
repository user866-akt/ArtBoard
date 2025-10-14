package com.artboard.service.impl;

import com.artboard.dao.PinDao;
import com.artboard.dao.UserDao;
import com.artboard.dao.impl.UserDaoImpl;
import com.artboard.model.Pin;
import com.artboard.model.User;
import com.artboard.service.PinService;

import java.util.List;
import java.util.Optional;

public class PinServiceImpl implements PinService {

    private final PinDao pinDao;
    private final UserDao userDao;

    public PinServiceImpl(PinDao pinDao, UserDao userDao) {
        this.pinDao = pinDao;
        this.userDao = userDao;
    }

    @Override
    public Pin createPin(String title, String description, String imageUrl, Integer userId, String category, String artwork_author) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Заголовок не может быть пустым");
        }
        if (imageUrl == null || !isValidImageUrl(imageUrl)) {
            throw new IllegalArgumentException("Некорректный URL изображения");
        }
        if (userDao.findById(userId).isEmpty()) {
            throw new IllegalArgumentException("Пользователь не найден");
        }
        Pin pin = new Pin();
        pin.setTitle(title);
        pin.setDescription(description);
        pin.setImage_url(imageUrl);
        pin.setUser_id(userId);
        pin.setCategory(category);
        pin.setArtwork_author(artwork_author);
        return pinDao.save(pin);
    }

    @Override
    public List<Pin> getFeedPins() {
        return pinDao.findAll();
    }

    @Override
    public List<Pin> getUserPins(Integer userId) {
        return pinDao.findByUserId(userId);
    }

    @Override
    public List<Pin> getPinsByCategory(String category) {
        if (category == null || category.trim().isEmpty()) {
            return getFeedPins();
        }
        return pinDao.findByCategory(category);
    }

    @Override
    public List<Pin> searchPins(String searchQuery) {
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            return getFeedPins();
        }
        return pinDao.findBySearchQuery(searchQuery.trim());
    }

    @Override
    public Optional<Pin> getPinById(Integer id) {
        return pinDao.findById(id);
    }

    @Override
    public Pin update(Integer pinId, Integer userId, String title, String description, String category, String artworkAuthor) {
        Pin pin = pinDao.findById(pinId).orElseThrow(() -> new IllegalArgumentException("Пин не найден"));
        if (!pin.getUser_id().equals(userId)) {
            throw new IllegalArgumentException("Вы не можете редактировать этот пин");
        }
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Заголовок не может быть пустым");
        }
        if (artworkAuthor == null || artworkAuthor.trim().isEmpty()) {
            throw new IllegalArgumentException("Автор произведения не может быть пустым");
        }
        pin.setTitle(title.trim());
        pin.setDescription(description != null ? description.trim() : null);
        pin.setCategory(category);
        pin.setArtwork_author(artworkAuthor.trim());
        pinDao.update(pin);
        return pin;
    }

    @Override
    public void delete(Integer pinId) {
        pinDao.delete(pinId);
    }

    @Override
    public boolean isPinOwner(Integer pinId, Integer userId) {
        return false;
    }

    private boolean isValidImageUrl(String url) {
        return url != null &&
                (url.startsWith("http://") || url.startsWith("https://")) &&
                (url.endsWith(".jpg") || url.endsWith(".jpeg") ||
                        url.endsWith(".png") || url.endsWith(".gif"));
    }
}
