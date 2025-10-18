<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Редактировать доску</title>
    <style>
        .pins-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }
        .pin-item {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        .search-form {
            margin: 15px 0;
            padding: 15px;
            background: #f5f5f5;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<h1>Редактировать доску: ${board.name}</h1>

<p>ID доски: ${board.id}</p>
<p>Пинов в доске: ${pins.size()}</p>

<form action="${pageContext.request.contextPath}/boards/${board.id}/edit" method="post">
    <div>
        <label>Название:</label>
        <input type="text" name="name" value="${board.name}" required>
    </div>

    <div>
        <label>Описание:</label>
        <textarea name="description">${board.description}</textarea>
    </div>

    <div>
        <input type="checkbox" name="is_private" ${board.is_private ? 'checked' : ''}>
        <label>Приватная</label>
    </div>

    <button type="submit">Сохранить</button>
    <a href="${pageContext.request.contextPath}/boards/${board.id}">Отмена</a>
</form>

<hr>

<h2>Пины в доске</h2>
<div class="pins-container">
    <c:forEach items="${pins}" var="pin">
        <div class="pin-item">
            <h3>${pin.title}</h3>
            <img src="${pin.image_url}" width="200"
                 onerror="this.src='https://via.placeholder.com/200x150?text=No+Image'">
            <br>
            <form action="${pageContext.request.contextPath}/boards/${board.id}/remove-pin" method="post" style="display:inline;">
                <input type="hidden" name="pinId" value="${pin.id}">
                <button type="submit">Удалить</button>
            </form>
        </div>
    </c:forEach>
</div>

<c:if test="${empty pins}">
    <p>В доске нет пинов</p>
</c:if>

<hr>

<form action="${pageContext.request.contextPath}/boards/${board.id}/delete" method="post">
    <button type="submit">Удалить доску</button>
</form>

<hr>

<h2>Добавить пины в доску</h2>

<!-- Форма поиска пинов -->
<div class="search-form">
    <form action="${pageContext.request.contextPath}/boards/${board.id}/edit" method="get">
        Поиск пинов для добавления:
        <input type="text" name="q" value="${searchQuery}" placeholder="Введите название, описание или автора...">
        <button type="submit">Найти</button>
        <c:if test="${not empty searchQuery}">
            <a href="${pageContext.request.contextPath}/boards/${board.id}/edit">Показать все</a>
        </c:if>
    </form>
</div>

<!-- Информация о результатах поиска -->
<c:if test="${not empty searchQuery}">
    <p>
        <strong>Результаты поиска: "${searchQuery}"</strong>
        <c:if test="${not empty pinsToAdd}">
            (найдено: ${pinsToAdd.size()})
        </c:if>
    </p>
</c:if>

<div class="pins-container">
    <c:forEach items="${pinsToAdd}" var="pin">
        <div class="pin-item">
            <h3>${pin.title}</h3>
            <img src="${pin.image_url}" width="200"
                 onerror="this.src='https://via.placeholder.com/200x150?text=No+Image'">
            <br>
            <form action="${pageContext.request.contextPath}/boards/${board.id}/add-pin" method="post" style="display:inline;">
                <input type="hidden" name="pinId" value="${pin.id}">
                <button type="submit" style="color: green;">Добавить в доску</button>
            </form>
        </div>
    </c:forEach>
</div>

<c:if test="${empty pinsToAdd}">
    <p>
        <c:choose>
            <c:when test="${not empty searchQuery}">
                По запросу "${searchQuery}" пинов не найдено
            </c:when>
            <c:otherwise>
                Нет доступных пинов для добавления
            </c:otherwise>
        </c:choose>
    </p>
</c:if>

</body>
</html>