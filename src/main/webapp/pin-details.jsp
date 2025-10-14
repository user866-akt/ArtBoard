<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${pin.title} - ArtBoard</title>
</head>
<body>
<h1>${pin.title}</h1>

<div style="margin-top: 20px;">
    <a href="${pageContext.request.contextPath}/pins/${pin.id}/edit">✏️ Редактировать пин</a>
</div>

<div>
    <a href="${pageContext.request.contextPath}/pins/">← Все пины</a>
    <a href="${pageContext.request.contextPath}/index.jsp">Главная</a>
</div>

<br>

<div>
    <img src="${pin.image_url}" style="max-width: 800px;">
</div>

<div>
    <h2>${pin.title}</h2>
    <p>${pin.description}</p>

    <p><strong>Автор произведения:</strong> ${pin.artwork_author}</p>
    <p><strong>Категория:</strong> ${pin.category}</p>
    <p><strong>Добавлено:</strong> пользователем ID ${pin.user_id}</p>

</div>

</body>
</html>
