<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ArtBoard - Главная</title>
</head>
<body>
<h1>Добро пожаловать в ArtBoard!</h1>

<%
    Object user = session.getAttribute("user");
    if (user != null) {
%>
<p>Привет, ${user.username}!</p>
<a href="${pageContext.request.contextPath}/profile">Мой профиль</a> |
<a href="${pageContext.request.contextPath}/pins/">Смотреть все пины</a> |
<a href="create-pin.jsp">Создать пин</a>|
<a href="${pageContext.request.contextPath}/auth/logout">Выйти</a>
<%
} else {
%>
<a href="${pageContext.request.contextPath}/pins/">Смотреть все пины</a> |
<a href="login.jsp">Войти</a> |
<a href="register.jsp">Регистрация</a>
<%
    }
%>
</body>
</html>
