<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Редактировать доску - ArtBoard</title>
    <style>
        :root {
            --primary: #8D8741;
            --secondary: #659DBD;
            --accent: #DAAD86;
            --light: #FBEEC1;
            --neutral: #BC986A;
            --error: #c62828;
            --success: #4CAF50;
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

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-success:hover {
            background: #3d8b40;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }

        .btn-danger {
            background: var(--error);
            color: white;
        }

        .btn-danger:hover {
            background: #a51c1c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
        }

        .edit-section {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            padding: 40px;
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 28px;
            color: var(--primary);
            margin-bottom: 30px;
            text-align: center;
        }

        .board-info {
            background: var(--light);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            text-align: center;
        }

        .info-item {
            display: inline-block;
            margin: 0 15px;
            color: var(--primary);
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-weight: 600;
            font-size: 14px;
        }

        .form-input, .form-textarea, .form-select {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-input:focus, .form-textarea:focus, .form-select:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(101, 157, 189, 0.1);
        }

        .form-textarea {
            resize: vertical;
            min-height: 100px;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .checkbox-label {
            color: var(--primary);
            font-weight: 600;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
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

        .pin-actions {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .search-section {
            background: var(--light);
            padding: 25px;
            border-radius: 10px;
            margin: 30px 0;
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: end;
            flex-wrap: wrap;
        }

        .search-group {
            flex: 1;
            min-width: 300px;
        }

        .search-results {
            margin-top: 15px;
            color: var(--secondary);
            font-weight: 500;
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

        .delete-section {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
            text-align: center;
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
            max-width: 400px;
            width: 90%;
        }

        .modal-title {
            color: var(--error);
            font-size: 20px;
            margin-bottom: 15px;
        }

        .modal-text {
            color: #666;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .modal-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
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

            .edit-section {
                padding: 30px 20px;
            }

            .search-form {
                flex-direction: column;
            }

            .search-group {
                min-width: 100%;
            }

            .form-actions {
                flex-direction: column;
                align-items: center;
            }

            .modal-actions {
                flex-direction: column;
            }

            .btn {
                width: 200px;
            }

            .pins-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 10px;
            }

            .edit-section {
                padding: 25px 15px;
            }

            .page-title {
                font-size: 24px;
            }

            .pins-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Шапка -->
    <div class="header">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">ArtBoard</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/boards/${board.id}" class="btn btn-outline">Назад к доске</a>
            <a href="${pageContext.request.contextPath}/boards/" class="btn btn-outline">Все доски</a>
        </div>
    </div>

    <!-- Редактирование доски -->
    <div class="edit-section">
        <h1 class="page-title">Редактировать доску: ${board.name}</h1>

        <!-- Информация о доске -->
        <div class="board-info">
            <span class="info-item">ID доски: ${board.id}</span>
            <span class="info-item">Пинов в доске: ${pins.size()}</span>
        </div>

        <!-- Форма редактирования -->
        <form action="${pageContext.request.contextPath}/boards/${board.id}/edit" method="post">
            <div class="form-group">
                <label class="form-label" for="name">Название:</label>
                <input type="text" id="name" name="name" value="${board.name}"
                       class="form-input" required placeholder="Введите название доски">
            </div>

            <div class="form-group">
                <label class="form-label" for="description">Описание:</label>
                <textarea id="description" name="description"
                          class="form-textarea" placeholder="Опишите вашу доску...">${board.description}</textarea>
            </div>

            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="is_private" name="is_private" ${board.is_private ? 'checked' : ''}>
                    <label class="checkbox-label" for="is_private">Приватная доска</label>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Сохранить изменения</button>
                <a href="${pageContext.request.contextPath}/boards/${board.id}" class="btn btn-outline">Отмена</a>
            </div>
        </form>

        <!-- Пины в доске -->
        <h2 class="section-title">Пины в доске</h2>
        <c:choose>
            <c:when test="${not empty pins}">
                <div class="pins-grid">
                    <c:forEach items="${pins}" var="pin">
                        <div class="pin-card">
                            <img src="${pin.image_url}" alt="${pin.title}" class="pin-image"
                                 onerror="this.src='https://via.placeholder.com/200x150?text=No+Image'">
                            <div class="pin-content">
                                <h3 class="pin-title">${pin.title}</h3>
                                <div class="pin-actions">
                                    <form action="${pageContext.request.contextPath}/boards/${board.id}/remove-pin" method="post">
                                        <input type="hidden" name="pinId" value="${pin.id}">
                                        <button type="submit" class="btn btn-danger">Удалить из доски</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>В доске нет пинов</h3>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Поиск пинов для добавления -->
        <div class="search-section">
            <h2 class="section-title">Добавить пины в доску</h2>
            <form action="${pageContext.request.contextPath}/boards/${board.id}/edit" method="get" class="search-form">
                <div class="search-group">
                    <label class="form-label">Поиск пинов для добавления:</label>
                    <input type="text" name="q" value="${searchQuery}"
                           class="form-input" placeholder="Введите название, описание или автора...">
                </div>
                <button type="submit" class="btn btn-primary">Найти</button>
                <c:if test="${not empty searchQuery}">
                    <a href="${pageContext.request.contextPath}/boards/${board.id}/edit" class="btn btn-outline">Показать все</a>
                </c:if>
            </form>

            <!-- Информация о результатах поиска -->
            <c:if test="${not empty searchQuery}">
                <div class="search-results">
                    <strong>Результаты поиска: "${searchQuery}"</strong>
                    <c:if test="${not empty pinsToAdd}">
                        (найдено: ${pinsToAdd.size()})
                    </c:if>
                </div>
            </c:if>
        </div>

        <!-- Результаты поиска -->
        <c:choose>
            <c:when test="${not empty pinsToAdd}">
                <div class="pins-grid">
                    <c:forEach items="${pinsToAdd}" var="pin">
                        <div class="pin-card">
                            <img src="${pin.image_url}" alt="${pin.title}" class="pin-image"
                                 onerror="this.src='https://via.placeholder.com/200x150?text=No+Image'">
                            <div class="pin-content">
                                <h3 class="pin-title">${pin.title}</h3>
                                <div class="pin-actions">
                                    <form action="${pageContext.request.contextPath}/boards/${board.id}/add-pin" method="post">
                                        <input type="hidden" name="pinId" value="${pin.id}">
                                        <button type="submit" class="btn btn-success">Добавить в доску</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <h3>
                        <c:choose>
                            <c:when test="${not empty searchQuery}">
                                По запросу "${searchQuery}" пинов не найдено
                            </c:when>
                            <c:otherwise>
                                Нет доступных пинов для добавления
                            </c:otherwise>
                        </c:choose>
                    </h3>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Удаление доски -->
        <div class="delete-section">
            <button type="button" onclick="showDeleteModal()" class="btn btn-danger">Удалить доску</button>
            <form id="delete-board-form" action="${pageContext.request.contextPath}/boards/${board.id}/delete" method="post" style="display: none;"></form>
        </div>
    </div>
</div>

<!-- Модальное окно удаления -->
<div id="delete-modal" class="modal">
    <div class="modal-title">Удалить доску?</div>
    <p class="modal-text">Доска "${board.name}" будет удалена. Все пины будут удалены из доски. Это действие нельзя отменить.</p>
    <div class="modal-actions">
        <button onclick="confirmDelete()" class="btn btn-danger">Да, удалить</button>
        <button onclick="closeDeleteModal()" class="btn btn-outline">Отмена</button>
    </div>
</div>
<div id="overlay" class="overlay"></div>

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
        document.getElementById('delete-board-form').submit();
    }
</script>
</body>
</html>