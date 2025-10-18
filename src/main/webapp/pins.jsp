<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Пины - ArtBoard</title>
    <style>
        .pins-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
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
    Object user = session.getAttribute("user");
    boolean isLoggedIn = (user != null);
%>

<a href="${pageContext.request.contextPath}/index.jsp">На главную</a>
<% if (isLoggedIn) { %>
<a href="${pageContext.request.contextPath}/create-pin.jsp">Создать пин</a>
<% } else { %>
<a href="${pageContext.request.contextPath}/login.jsp">Войдите чтобы создать пин</a>
<% } %>

<br><br>

<!-- Форма для поиска -->
<form action="${pageContext.request.contextPath}/pins/search" method="get">
    Поиск:
    <input type="text" name="q" value="${param.q}" placeholder="Введите название или описание...">
    <button type="submit">Найти</button>
</form>

<!-- Форма для фильтрации по категории -->
<form action="${pageContext.request.contextPath}/pins/by-category" method="get">
    Категория:
    <select name="category">
        <option value="">Все категории</option>
        <option value="Пейзаж" ${param.category == 'Пейзаж' ? 'selected' : ''}>Пейзаж</option>
        <option value="Портрет" ${param.category == 'Портрет' ? 'selected' : ''}>Портрет</option>
        <option value="Абстракция" ${param.category == 'Абстракция' ? 'selected' : ''}>Абстракция</option>
        <option value="Графика" ${param.category == 'Графика' ? 'selected' : ''}>Графика</option>
        <option value="Цифровое искусство" ${param.category == 'Цифровое искусство' ? 'selected' : ''}>Цифровое искусство</option>
    </select>
    <button type="submit">Показать</button>
    <a href="${pageContext.request.contextPath}/pins/">Сбросить</a>
</form>

<br><hr>

<h1>
    <c:choose>
        <c:when test="${not empty param.category}">
            Пины: ${param.category}
        </c:when>
        <c:when test="${not empty param.q}">
            Результаты поиска: "${param.q}"
        </c:when>
        <c:otherwise>
            Все пины
        </c:otherwise>
    </c:choose>
</h1>

<br><br>

<!-- Сетка пинов -->
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
    <p>Пинов не найдено</p>
</c:if>
</body>
</html>