<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Вход - ArtBoard</title>
</head>
<body>
<h1>Вход в систему</h1>

<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Ошибка: <%= request.getParameter("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/auth/login" method="post">
    Email: <input type="email" name="email" required><br><br>
    Пароль: <input type="password" name="password" required><br><br>
    <button type="submit">Войти</button>
</form>

<br>
<a href="index.jsp">На главную</a> |
<a href="register.jsp">Создать аккаунт</a>
</body>
</html>
