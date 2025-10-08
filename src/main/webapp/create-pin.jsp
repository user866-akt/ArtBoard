<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Создать пин</title>
</head>
<body>
<h1>Создать пин</h1>

<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Ошибка: <%= request.getParameter("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/pins/create" method="post">
    Название: <input type="text" name="title" required><br><br>
    Описание: <textarea name="description"></textarea><br><br>
    URL картинки: <input type="url" name="imageUrl" required><br><br>
    Категория:
    <select name="category">
        <option value="Пейзаж">Пейзаж</option>
        <option value="Портрет">Портрет</option>
        <option value="Абстракция">Абстракция</option>
    </select><br><br>
    <button type="submit">Создать</button>
</form>

<br>
<a href="index.jsp">На главную</a>
</body>
</html>
