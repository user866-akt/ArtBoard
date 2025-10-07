<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Регистрация - ArtBoard</title>
</head>
<body>
<h1>Регистрация</h1>

<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Ошибка: <%= request.getParameter("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/auth/register" method="post">
    Email: <input type="email" name="email" required><br><br>
    Имя пользователя: <input type="text" name="username" required><br><br>
    Пароль: <input type="password" name="password" required><br><br>
    <button type="submit">Зарегистрироваться</button>
</form>

<br>
<a href="index.jsp">На главную</a> |
<a href="login.jsp">Уже есть аккаунт?</a>
</body>
</html>
