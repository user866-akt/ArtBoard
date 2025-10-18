<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Редактирование пина - ArtBoard</title>
</head>
<body>
<h1>Редактирование пина</h1>

<div>
    <a href="${pageContext.request.contextPath}/pins/${pin.id}">← Назад к пину</a>
    <a href="${pageContext.request.contextPath}/pins/">Все пины</a>
</div>

<br>

<% if (request.getAttribute("error") != null) { %>
<p style="color: red;">Ошибка: <%= request.getAttribute("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/pins/${pin.id}/edit" method="post">
    <div>
        <label>Заголовок:</label><br>
        <input type="text" name="title" value="${pin.title}" required style="width: 400px;">
    </div>

    <div>
        <label>Описание:</label><br>
        <textarea name="description" style="width: 400px; height: 100px;">${pin.description}</textarea>
    </div>

    <div>
        <label>Автор произведения:</label><br>
        <input type="text" name="artworkAuthor" value="${pin.artwork_author}" required style="width: 400px;">
    </div>

    <div>
        <label>Категория:</label><br>
        <select name="category">
            <option value="Пейзаж" ${pin.category == 'Пейзаж' ? 'selected' : ''}>Пейзаж</option>
            <option value="Портрет" ${pin.category == 'Портрет' ? 'selected' : ''}>Портрет</option>
            <option value="Абстракция" ${pin.category == 'Абстракция' ? 'selected' : ''}>Абстракция</option>
            <option value="Графика" ${pin.category == 'Графика' ? 'selected' : ''}>Графика</option>
            <option value="Цифровое искусство" ${pin.category == 'Цифровое искусство' ? 'selected' : ''}>Цифровое искусство</option>
        </select>
    </div>

    <br>
    <button type="submit">Сохранить изменения</button>
</form>

<form action="${pageContext.request.contextPath}/pins/${pin.id}/delete" method="post">
    <button type="submit">Удалить пин</button>
</form>

<br>
<img src="${pin.image_url}" width="300">
</body>
</html>