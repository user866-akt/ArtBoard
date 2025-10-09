<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Пины - ArtBoard</title>
</head>
<body>
<h1>Все пины</h1>

<a href="${pageContext.request.contextPath}/index.jsp">На главную</a>
<a href="${pageContext.request.contextPath}/create-pin.jsp">Создать пин</a>

<br><br>

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

<!-- Отображение пинов -->
<c:forEach items="${pins}" var="pin">
    <div>
        <img src="${pin.image_url}" width="200">
        <h3>${pin.title}</h3>
        <p>${pin.description}</p>
        <p>Категория: ${pin.category}</p>
        <hr>
    </div>
</c:forEach>

<c:if test="${empty pins}">
    <p>Пинов не найдено</p>
</c:if>
</body>
</html>