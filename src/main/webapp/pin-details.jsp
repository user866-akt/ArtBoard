<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${pin.title} - ArtBoard</title>
    <style>
        :root {
            --primary: #8D8741;
            --secondary: #659DBD;
            --accent: #DAAD86;
            --light: #FBEEC1;
            --neutral: #BC986A;
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
            max-width: 1000px;
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

        .pin-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .pin-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0;
        }

        .pin-image-section {
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }

        .pin-image {
            max-width: 100%;
            max-height: 500px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .pin-info-section {
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .pin-title {
            font-size: 28px;
            color: var(--primary);
            margin-bottom: 20px;
            line-height: 1.3;
        }

        .pin-description {
            font-size: 16px;
            line-height: 1.6;
            color: #666;
            margin-bottom: 25px;
        }

        .pin-details {
            background: var(--light);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid rgba(141, 135, 65, 0.1);
        }

        .detail-item:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: var(--primary);
        }

        .detail-value {
            color: #666;
        }

        .category-tag {
            background: var(--secondary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .owner-actions {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
            text-align: center;
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

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.9);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            max-width: 90%;
            max-height: 90%;
            border-radius: 10px;
        }

        .close {
            position: absolute;
            top: 20px;
            right: 30px;
            color: white;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
            z-index: 1001;
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

            .pin-content {
                grid-template-columns: 1fr;
            }

            .pin-image-section {
                padding: 20px;
            }

            .pin-info-section {
                padding: 30px 20px;
            }

            .pin-title {
                font-size: 24px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 10px;
            }

            .pin-info-section {
                padding: 25px 15px;
            }

            .pin-details {
                padding: 15px;
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
            <a href="${pageContext.request.contextPath}/pins/" class="btn btn-outline">Все пины</a>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">Главная</a>
        </div>
    </div>

    <!-- Контент пина -->
    <div class="pin-container">
        <div class="pin-content">
            <!-- Изображение -->
            <div class="pin-image-section">
                <img src="${pin.image_url}" alt="${pin.title}" class="pin-image" onclick="openModal()">
            </div>

            <!-- Информация -->
            <div class="pin-info-section">
                <h1 class="pin-title">${pin.title}</h1>

                <c:if test="${not empty pin.description}">
                    <p class="pin-description">${pin.description}</p>
                </c:if>

                <div class="pin-details">
                    <div class="detail-item">
                        <span class="detail-label">Автор произведения:</span>
                        <span class="detail-value">${pin.artwork_author}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Категория:</span>
                        <span class="category-tag">${pin.category}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Добавлено:</span>
                        <span class="detail-value">пользователем ID ${pin.user_id}</span>
                    </div>
                </div>

                <!-- Кнопки редактирования для владельца -->
                <%
                    Object userObj = session.getAttribute("user");
                    boolean isLoggedIn = (userObj != null);
                    Integer userId = null;
                    if (isLoggedIn) {
                        userId = ((com.artboard.model.User)userObj).getId();
                    }
                    pageContext.setAttribute("userId", userId);
                %>
                <c:if test="${not empty userId and userId eq pin.user_id}">
                    <div class="owner-actions">
                        <a href="${pageContext.request.contextPath}/pins/${pin.id}/edit" class="btn btn-primary">Редактировать пин</a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Назад -->
    <a href="${pageContext.request.contextPath}/pins/" class="back-link">
        ← Вернуться ко всем пинам
    </a>
</div>
<div id="imageModal" class="modal">
    <span class="close" onclick="closeModal()">&times;</span>
    <img class="modal-content" id="modalImage">
</div>
<script>
    function openModal() {
        document.getElementById('imageModal').style.display = 'flex';
        document.getElementById('modalImage').src = '${pin.image_url}';
    }
    function closeModal() {
        document.getElementById('imageModal').style.display = 'none';
    }
    document.getElementById('imageModal').onclick = function(e) {
        if (e.target === this) closeModal();
    }
</script>
</body>
</html>