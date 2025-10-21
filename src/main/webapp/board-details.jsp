<%@ page import="com.artboard.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${board.name} - ArtBoard</title>
    <style>
        .pins-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }
        .pin-item {
            border: 1px solid #ccc;
            padding: 15px;
        }
    </style>
</head>
<body>

<%
    Object userObj = session.getAttribute("user");
    boolean isLoggedIn = (userObj != null);
    Integer userId = null;
    if (isLoggedIn) {
        userId = ((com.artboard.model.User)userObj).getId();
    }
    pageContext.setAttribute("userId", userId);
%>

<h1>${board.name}</h1>

<%-- Кнопка редактирования для владельца доски --%>
<c:if test="${not empty userId and userId eq board.user_id}">
    <div style="margin-top: 20px;">
        <a href="${pageContext.request.contextPath}/boards/${board.id}/edit">Редактировать доску</a>
    </div>
</c:if>

<div>
    <a href="${pageContext.request.contextPath}/boards/">← Все доски</a>
    <a href="${pageContext.request.contextPath}/index.jsp">Главная</a>
</div>

<br>

<div>
    <h2>${board.name}</h2>
    <p>${board.description}</p>

    <p><strong>Приватная:</strong> ${board.is_private ? 'Да' : 'Нет'}</p>
    <p><strong>Создано:</strong> ${board.created_at}</p>
    <p><strong>Создатель:</strong> пользователь ID ${board.user_id}</p>
</div>

<br>
<hr>

<h2>Пины в доске (${pins.size()})</h2>

<div class="pins-container">
    <c:forEach items="${pins}" var="pin">
        <a href="${pageContext.request.contextPath}/pins/${pin.id}" style="text-decoration: none; color: inherit;">
            <div class="pin-item">
                <img src="${pin.image_url}" width="200">
                <h3>${pin.title}</h3>
                <p>${pin.description}</p>
                <p><strong>Автор:</strong> ${pin.artwork_author}</p>
                <p><strong>Категория:</strong> ${pin.category}</p>
            </div>
        </a>
    </c:forEach>
</div>

<c:if test="${empty pins}">
    <p>В этой доске пока нет пинов</p>
</c:if>

<hr>

<h2>Комментарии (${comments.size()})</h2>
<% if (isLoggedIn) { %>
<form action="${pageContext.request.contextPath}/boards/${board.id}/comments/create" method="post">
    <textarea name="commentText" rows="3" cols="50" placeholder="Оставьте комментарий..." required></textarea>
    <br>
    <button type="submit">Добавить комментарий</button>
</form>
<% } else { %>
<p><a href="${pageContext.request.contextPath}/login.jsp">Войдите</a>, чтобы оставить комментарий</p>
<% } %>
<%--<c:if test="${isLoggedIn}">--%>
<%--    <form action="${pageContext.request.contextPath}/boards/${board.id}/comments/create" method="post">--%>
<%--        <textarea name="commentText" rows="3" cols="50" placeholder="Оставьте комментарий..." required></textarea>--%>
<%--        <br>--%>
<%--        <button type="submit">Добавить комментарий</button>--%>
<%--    </form>--%>
<%--</c:if>--%>

<%--<c:if test="${not isLoggedIn}">--%>
<%--    <p><a href="${pageContext.request.contextPath}/login.jsp">Войдите</a>, чтобы оставить комментарий</p>--%>
<%--</c:if>--%>

<br>

<c:forEach items="${comments}" var="comment">
    <div style="border: 1px solid #eee; padding: 10px; margin: 10px 0;">
        <div style="font-weight: bold;">
            Пользователь ID: ${comment.userId}
            <c:if test="${userId eq comment.userId}">
                <small style="margin-left: 10px;">
                    <a href="#" onclick="editComment(${comment.id}, '${comment.commentText}')">[ред.]</a>
                    <form action="${pageContext.request.contextPath}/boards/${board.id}/comments/${comment.id}/delete"
                          method="post" style="display: inline;">
                        <button type="submit" onclick="return confirm('Удалить комментарий?')"
                                style="background: none; border: none; color: blue; text-decoration: underline; cursor: pointer;">
                            [уд.]
                        </button>
                </small>
            </c:if>
        </div>
        <div id="comment-text-${comment.id}">${comment.commentText}</div>
        <div style="font-size: 12px; color: #666;">
                ${comment.createdAt}
        </div>
    </div>
</c:forEach>

<c:if test="${empty comments}">
    <p>Комментариев пока нет</p>
</c:if>

<script>
    function editComment(commentId, currentText) {
        const newText = prompt('Редактировать комментарий:', currentText);
        if (newText !== null && newText.trim() !== '') {
            const form = document.createElement('form');
            form.method = 'post';
            form.action = '${pageContext.request.contextPath}/boards/${board.id}/comments/' + commentId + '/edit';

            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'commentText';
            input.value = newText;

            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>

</body>
</html>