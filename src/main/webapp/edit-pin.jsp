<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Редактирование пина - ArtBoard</title>
    <style>
        #delete-modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border: 1px solid #ccc;
            z-index: 1000;
        }
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }
    </style>
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

<button type="button" onclick="showDeleteModal()">Удалить пин</button>
<form id="delete-form" action="${pageContext.request.contextPath}/pins/${pin.id}/delete" method="post" style="display: none;"></form>

<br>
<img src="${pin.image_url}" width="300">

<div id="delete-modal">
    <p>Удалить пин "${pin.title}"?</p>
    <p>Это действие нельзя отменить.</p>
    <button onclick="confirmDelete()">Да, удалить</button>
    <button onclick="closeDeleteModal()">Отмена</button>
</div>
<div id="overlay"></div>

<script>
    function showDeleteModal() {
        document.getElementById('delete-modal').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    function closeDeleteModal() {
        document.getElementById('delete-modal').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
    }

    function confirmDelete() {
        document.getElementById('delete-form').submit();
    }
</script>
</body>
</html>