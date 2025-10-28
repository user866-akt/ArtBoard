<%@ page import="com.artboard.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${board.name} - ArtBoard</title>
    <style>
        :root {
            --primary: #8D8741;
            --secondary: #659DBD;
            --accent: #DAAD86;
            --light: #FBEEC1;
            --neutral: #BC986A;
            --error: #c62828;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background:
                    linear-gradient(135deg, rgba(251, 238, 193, 0.9) 0%, rgba(255, 255, 255, 0.9) 100%),
                    url('${pageContext.request.contextPath}/images/background.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px 0;
        }

        .logo {
            font-size: 36px;
            font-weight: bold;
            color: var(--primary);
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            text-align: center;
            font-size: 14px;
        }

        .btn-primary {
            background: var(--secondary);
            color: white;
        }

        .btn-primary:hover {
            background: #4a87a5;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(101, 157, 189, 0.3);
        }

        .btn-outline {
            background: transparent;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .btn-outline:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(141, 135, 65, 0.3);
        }

        .board-section {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            padding: 40px;
            margin-bottom: 30px;
        }

        .board-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .board-icon {
            font-size: 48px;
            margin-bottom: 15px;
            color: var(--primary);
        }

        .board-title {
            font-size: 32px;
            color: var(--primary);
            margin-bottom: 15px;
        }

        .board-description {
            font-size: 18px;
            color: #666;
            line-height: 1.5;
            margin-bottom: 25px;
        }

        .board-details {
            background: var(--light);
            padding: 20px;
            border-radius: 10px;
            display: inline-block;
        }

        .detail-item {
            display: flex;
            gap: 10px;
            align-items: center;
            margin-bottom: 8px;
        }

        .detail-item:last-child {
            margin-bottom: 0;
        }

        .detail-label {
            font-weight: 600;
            color: var(--primary);
        }

        .detail-value {
            color: #666;
        }

        .private-badge {
            background: var(--accent);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .public-badge {
            background: var(--secondary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .owner-actions {
            margin-top: 25px;
            text-align: center;
        }

        .section-title {
            font-size: 24px;
            color: var(--primary);
            margin: 40px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--light);
        }

        .pins-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }

        .pin-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border: 1px solid #f0f0f0;
        }

        .pin-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.12);
        }

        .pin-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .pin-content {
            padding: 15px;
        }

        .pin-title {
            font-size: 16px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .pin-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12px;
            color: #888;
            padding-top: 10px;
            border-top: 1px solid #f0f0f0;
        }

        .comments-section {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            padding: 30px;
            margin-bottom: 30px;
        }

        .comment-form {
            margin-bottom: 30px;
        }

        .form-textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
            resize: vertical;
            min-height: 80px;
        }

        .form-textarea:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(101, 157, 189, 0.1);
        }

        .comment-item {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 4px solid var(--secondary);
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .comment-user {
            font-weight: 600;
            color: var(--primary);
        }

        .comment-actions {
            display: flex;
            gap: 10px;
        }

        .comment-action {
            background: none;
            border: none;
            color: var(--secondary);
            cursor: pointer;
            font-size: 12px;
            text-decoration: underline;
        }

        .comment-action:hover {
            color: var(--primary);
        }

        .comment-text {
            color: #333;
            line-height: 1.5;
            margin-bottom: 10px;
        }

        .comment-date {
            font-size: 12px;
            color: #888;
        }

        .edit-form {
            margin-top: 10px;
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #666;
            background: var(--light);
            border-radius: 10px;
        }

        .empty-state h3 {
            color: var(--primary);
            margin-bottom: 10px;
        }

        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            z-index: 1000;
            text-align: center;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--secondary);
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: var(--primary);
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }

            .board-section {
                padding: 30px 20px;
            }

            .pins-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }

            .comment-header {
                flex-direction: column;
                align-items: start;
                gap: 10px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 10px;
            }

            .board-section {
                padding: 25px 15px;
            }

            .pins-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">ArtBoard</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/boards/" class="btn btn-outline">Все доски</a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">Главная</a>
        </div>
    </div>

    <div class="board-section">
        <div class="board-header">
            <div class="board-icon">📋</div>
            <h1 class="board-title">${board.name}</h1>
            <p class="board-description">${board.description}</p>

            <div class="board-details">
                <div class="detail-item">
                    <span class="detail-label">Приватная:</span>
                    <span class="${board.is_private ? 'private-badge' : 'public-badge'}">
                        ${board.is_private ? 'Да' : 'Нет'}
                    </span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Создано:</span>
                    <span class="detail-value">${board.created_at}</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">Создатель:</span>
                    <span class="detail-value">пользователь ID ${board.user_id}</span>
                </div>
            </div>

            <%
                Object userObj = session.getAttribute("user");
                boolean isLoggedIn = (userObj != null);
                Integer userId = null;
                if (isLoggedIn) {
                    userId = ((com.artboard.model.User)userObj).getId();
                }
                pageContext.setAttribute("userId", userId);
            %>
            <c:if test="${not empty userId and userId eq board.user_id}">
                <div class="owner-actions">
                    <a href="${pageContext.request.contextPath}/boards/${board.id}/edit" class="btn btn-primary">Редактировать доску</a>
                </div>
            </c:if>
        </div>

        <h2 class="section-title">Пины в доске (${pins.size()})</h2>

        <c:choose>
            <c:when test="${not empty pins}">
                <div class="pins-grid">
                    <c:forEach items="${pins}" var="pin">
                        <a href="${pageContext.request.contextPath}/pins/${pin.id}" style="text-decoration: none;">
                            <div class="pin-card">
                                <img src="${pin.image_url}" alt="${pin.title}" class="pin-image">
                                <div class="pin-content">
                                    <h3 class="pin-title">${pin.title}</h3>
                                    <div class="pin-meta">
                                        <span>${pin.artwork_author}</span>
                                        <span>${pin.category}</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>В этой доске пока нет пинов</h3>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="comments-section">
        <h2 class="section-title">Комментарии (${comments.size()})</h2>

        <% if (isLoggedIn) { %>
        <form action="${pageContext.request.contextPath}/boards/${board.id}/comments/create" method="post" class="comment-form">
            <textarea name="commentText" class="form-textarea" placeholder="Оставьте комментарий..." required></textarea>
            <br>
            <button type="submit" class="btn btn-primary">Добавить комментарий</button>
        </form>
        <% } else { %>
        <p style="text-align: center; color: #666;">
            <a href="${pageContext.request.contextPath}/login.jsp" style="color: var(--secondary);">Войдите</a>, чтобы оставить комментарий
        </p>
        <% } %>

        <c:forEach items="${comments}" var="comment">
            <div class="comment-item" id="comment-${comment.id}">
                <div class="comment-header">
                    <div class="comment-user">Пользователь ID: ${comment.userId}</div>
                    <c:if test="${userId eq comment.userId}">
                        <div class="comment-actions">
                            <button onclick="startEdit(${comment.id})" class="comment-action" id="edit-btn-${comment.id}">ред.</button>
                            <form action="${pageContext.request.contextPath}/boards/${board.id}/comments/${comment.id}/delete"
                                  method="post" style="display: inline;" id="delete-form-${comment.id}">
                                <button type="button" onclick="confirmDelete(${comment.id})" class="comment-action">
                                    уд.
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>

                <div id="comment-text-${comment.id}" class="comment-text">${comment.commentText}</div>

                <div id="edit-form-${comment.id}" class="edit-form" style="display: none;">
                    <textarea id="edit-textarea-${comment.id}" class="form-textarea">${comment.commentText}</textarea>
                    <br>
                    <button onclick="saveEdit(${comment.id}, ${board.id})" class="btn btn-primary">Сохранить</button>
                    <button onclick="cancelEdit(${comment.id})" class="btn btn-outline">Отмена</button>
                </div>

                <div class="comment-date">${comment.createdAt}</div>
            </div>
        </c:forEach>
    </div>

    <a href="${pageContext.request.contextPath}/boards/" class="back-link">
        ← Вернуться ко всем доскам
    </a>
</div>

<div id="delete-modal" class="modal">
    <p>Удалить комментарий?</p>
    <div style="margin-top: 20px; display: flex; gap: 10px; justify-content: center;">
        <button id="confirm-delete" class="btn btn-primary">Да, удалить</button>
        <button onclick="closeDeleteModal()" class="btn btn-outline">Отмена</button>
    </div>
</div>
<div id="overlay" class="overlay"></div>

<script>
    let currentCommentIdToDelete = null;

    function startEdit(commentId) {
        document.getElementById('comment-text-' + commentId).style.display = 'none';
        document.getElementById('edit-btn-' + commentId).style.display = 'none';
        document.getElementById('edit-form-' + commentId).style.display = 'block';
    }

    function cancelEdit(commentId) {
        document.getElementById('comment-text-' + commentId).style.display = 'block';
        document.getElementById('edit-btn-' + commentId).style.display = 'inline';
        document.getElementById('edit-form-' + commentId).style.display = 'none';
    }

    function saveEdit(commentId, boardId) {
        const newText = document.getElementById('edit-textarea-' + commentId).value;
        if (newText.trim() === '') {
            alert('Комментарий не может быть пустым');
            return;
        }
        const form = document.createElement('form');
        form.method = 'post';
        form.action = '${pageContext.request.contextPath}/boards/' + boardId + '/comments/' + commentId + '/edit';

        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'commentText';
        input.value = newText;

        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }

    function confirmDelete(commentId) {
        currentCommentIdToDelete = commentId;
        document.getElementById('delete-modal').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    function closeDeleteModal() {
        document.getElementById('delete-modal').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
        currentCommentIdToDelete = null;
    }

    document.getElementById('confirm-delete').addEventListener('click', function() {
        if (currentCommentIdToDelete) {
            document.getElementById('delete-form-' + currentCommentIdToDelete).submit();
        }
    });
</script>
</body>
</html>