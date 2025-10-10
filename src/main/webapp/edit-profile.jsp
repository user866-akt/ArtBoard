<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Редактирование профиля - ArtBoard</title>
</head>
<body>
<h1>Редактирование профиля</h1>

<a href="${pageContext.request.contextPath}/profile">← Назад к профилю</a>

<br><br>

<% if (request.getAttribute("error") != null) { %>
<p style="color: red;">Ошибка: <%= request.getAttribute("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/profile/edit" method="post">
    <div>
        <label>Имя пользователя:</label>
        <input type="text" name="username" value="${user.username}" required>
    </div>

    <div>
        <label>Email:</label>
        <input type="email" name="email" value="${user.email}" required>
    </div>

    <br>
    <button type="submit">Сохранить изменения</button>
</form>

<br>
<a href="${pageContext.request.contextPath}/profile/password">Сменить пароль</a>
</body>
</html>