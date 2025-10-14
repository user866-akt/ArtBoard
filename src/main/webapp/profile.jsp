<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Мой профиль - ArtBoard</title>
</head>
<body>
<h1>Мой профиль</h1>

<a href="${pageContext.request.contextPath}/index.jsp">На главную</a>
<a href="${pageContext.request.contextPath}/pins/">Все пины</a>
<a href="${pageContext.request.contextPath}/create-pin.jsp">Создать пин</a>

<br><br>

<!-- Информация пользователя -->
<h2>Информация</h2>
<p><strong>Имя:</strong> ${user.username}</p>
<p><strong>Email:</strong> ${user.email}</p>

<a href="${pageContext.request.contextPath}/profile/edit">Редактировать профиль</a>

<br><hr>

<!-- Пины пользователя -->
<h2>Мои пины (${pins.size()})</h2>

<c:forEach items="${pins}" var="pin">
    <a href="${pageContext.request.contextPath}/pins/${pin.id}" style="text-decoration: none; color: inherit;">
        <div style="border: 1px solid #ccc; padding: 15px; margin: 10px;">
            <img src="${pin.image_url}" width="200">
            <h3>${pin.title}</h3>
            <p>${pin.description}</p>
            <p><strong>Автор:</strong> ${pin.artwork_author}</p>
            <p><strong>Категория:</strong> ${pin.category}</p>
        </div>
    </a>
</c:forEach>

<c:if test="${empty pins}">
    <p>У вас пока нет пинов. <a href="${pageContext.request.contextPath}/create-pin.jsp">Создайте первый!</a></p>
</c:if>
</body>
</html>
