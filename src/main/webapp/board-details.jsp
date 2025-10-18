<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${board.name} - ArtBoard</title>
    <style>
        .pins-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }
        .pin-item {
            border: 1px solid #ccc;
            padding: 15px;
        }
    </style>
</head>
<body>

<%
    Object userObj = session.getAttribute("user");
    boolean isLoggedIn = (userObj != null);
    Integer userId = null;
    if (isLoggedIn) {
        userId = ((com.artboard.model.User)userObj).getId();
    }
    pageContext.setAttribute("userId", userId);
%>

<h1>${board.name}</h1>

<%-- Кнопка редактирования для владельца доски --%>
<c:if test="${not empty userId and userId eq board.user_id}">
    <div style="margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/boards/${board.id}/edit">Редактировать доску</a>
    </div>
</c:if>

<div>
    <a href="${pageContext.request.contextPath}/boards/">← Все доски</a>
    <a href="${pageContext.request.contextPath}/index.jsp">Главная</a>
</div>

<br>

<div>
    <h2>${board.name}</h2>
    <p>${board.description}</p>

    <p><strong>Приватная:</strong> ${board.is_private ? 'Да' : 'Нет'}</p>
    <p><strong>Создано:</strong> ${board.created_at}</p>
    <p><strong>Создатель:</strong> пользователь ID ${board.user_id}</p>
</div>

<br>
<hr>

<h2>Пины в доске (${pins.size()})</h2>

<div class="pins-container">
    <c:forEach items="${pins}" var="pin">
        <a href="${pageContext.request.contextPath}/pins/${pin.id}" style="text-decoration: none; color: inherit;">
            <div class="pin-item">
                <img src="${pin.image_url}" width="200">
                <h3>${pin.title}</h3>
                <p>${pin.description}</p>
                <p><strong>Автор:</strong> ${pin.artwork_author}</p>
                <p><strong>Категория:</strong> ${pin.category}</p>
            </div>
        </a>
    </c:forEach>
</div>

<c:if test="${empty pins}">
    <p>В этой доске пока нет пинов</p>
</c:if>

</body>
</html>