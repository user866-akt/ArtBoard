<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Доски - ArtBoard</title>
    <style>
        .boards-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .board-item {
            border: 1px solid #ccc;
            padding: 15px;
        }
    </style>
</head>
<body>

<%
    Object user = session.getAttribute("user");
    boolean isLoggedIn = (user != null);
%>

<a href="${pageContext.request.contextPath}/index.jsp">На главную</a>
<% if (isLoggedIn) { %>
<a href="${pageContext.request.contextPath}/create-board.jsp">Создать доску</a>
<% } else { %>
<a href="${pageContext.request.contextPath}/login.jsp">Войдите чтобы создать доску</a>
<% } %>

<br><br>

<!-- Форма для поиска -->
<form action="${pageContext.request.contextPath}/boards/search" method="get">
    Поиск досок:
    <input type="text" name="q" value="${param.q}" placeholder="Введите название или описание...">
    <button type="submit">Найти</button>
</form>

<br><hr>

<h1>
    <c:choose>
        <c:when test="${not empty param.q}">
            Результаты поиска: "${param.q}"
        </c:when>
        <c:otherwise>
            Все доски
        </c:otherwise>
    </c:choose>
</h1>

<br><br>

<!-- Сетка досок -->
<div class="boards-container">
    <c:forEach items="${boards}" var="board">
        <a href="${pageContext.request.contextPath}/boards/${board.id}" style="text-decoration: none; color: inherit;">
            <div class="board-item">
                <h3>${board.name}</h3>
                <p>${board.description}</p>
                <p><strong>Создано:</strong> ${board.created_at}</p>
            </div>
        </a>
    </c:forEach>
</div>

<c:if test="${empty boards}">
    <p>Досок не найдено</p>
</c:if>

</body>
</html>