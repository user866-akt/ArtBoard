<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Создать доску</title>
</head>
<body>
<h1>Создать доску</h1>

<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Ошибка: <%= request.getParameter("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/boards/create" method="post">
    Название: <input type="text" name="name" required><br><br>
    Описание: <textarea name="description"></textarea><br><br>
    <input type="checkbox" name="is_private"> Приватная доска<br><br>
    <button type="submit">Создать</button>
</form>

<br>
<a href="index.jsp">На главную</a>
</body>
</html>