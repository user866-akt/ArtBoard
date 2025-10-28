<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Мой профиль - ArtBoard</title>
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

        .profile-section {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            overflow: hidden;
        }

        .profile-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--neutral) 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .profile-avatar {
            width: 100px;
            height: 100px;
            background: var(--light);
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: var(--primary);
        }

        .profile-name {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .profile-email {
            font-size: 16px;
            opacity: 0.9;
        }

        .profile-content {
            padding: 30px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-card {
            background: var(--light);
            padding: 20px;
            border-radius: 10px;
            text-align: center;
        }

        .info-number {
            font-size: 32px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 5px;
        }

        .info-label {
            color: var(--secondary);
            font-weight: 500;
        }

        .section-title {
            font-size: 24px;
            color: var(--primary);
            margin: 40px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--light);
        }

        .items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }

        .item-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border: 1px solid #f0f0f0;
        }

        .item-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.12);
        }

        .pin-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .board-header {
            background: linear-gradient(135deg, var(--secondary) 0%, #4a87a5 100%);
            color: white;
            padding: 20px;
            text-align: center;
        }

        .board-icon {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .item-content {
            padding: 15px;
        }

        .item-title {
            font-size: 16px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .item-description {
            color: #666;
            font-size: 14px;
            line-height: 1.4;
            margin-bottom: 10px;
        }

        .item-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12px;
            color: #888;
            padding-top: 10px;
            border-top: 1px solid #f0f0f0;
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

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 20px;
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

            .info-grid {
                grid-template-columns: 1fr;
            }

            .items-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 200px;
            }
        }

        @media (max-width: 480px) {
            .items-grid {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 0 10px;
            }

            .profile-header {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">

    <div class="header">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">ArtBoard</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">На главную</a>
            <a href="${pageContext.request.contextPath}/pins/" class="btn btn-outline">Все пины</a>
            <a href="${pageContext.request.contextPath}/create-pin.jsp" class="btn btn-primary">Создать пин</a>
        </div>
    </div>

    <div class="profile-section">
        <div class="profile-header">
            <div class="profile-avatar">👤</div>
            <h1 class="profile-name">${user.username}</h1>
            <p class="profile-email">${user.email}</p>
        </div>

        <div class="profile-content">

            <div class="info-grid">
                <div class="info-card">
                    <div class="info-number">${pins.size()}</div>
                    <div class="info-label">Пинов</div>
                </div>
                <div class="info-card">
                    <div class="info-number">${boards.size()}</div>
                    <div class="info-label">Досок</div>
                </div>
            </div>

            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-primary">Редактировать профиль</a>
            </div>

            <h2 class="section-title">Мои пины</h2>
            <c:choose>
                <c:when test="${not empty pins}">
                    <div class="items-grid">
                        <c:forEach items="${pins}" var="pin">
                            <a href="${pageContext.request.contextPath}/pins/${pin.id}" style="text-decoration: none;">
                                <div class="item-card">
                                    <img src="${pin.image_url}" alt="${pin.title}" class="pin-image">
                                    <div class="item-content">
                                        <h3 class="item-title">${pin.title}</h3>
                                        <div class="item-meta">
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
                        <h3>У вас пока нет пинов</h3>
                        <p>Начните делиться своим творчеством!</p>
                        <a href="${pageContext.request.contextPath}/create-pin.jsp" class="btn btn-primary" style="margin-top: 15px;">Создать первый пин</a>
                    </div>
                </c:otherwise>
            </c:choose>

            <h2 class="section-title">Мои доски</h2>
            <c:choose>
                <c:when test="${not empty boards}">
                    <div class="items-grid">
                        <c:forEach items="${boards}" var="board">
                            <a href="${pageContext.request.contextPath}/boards/${board.id}" style="text-decoration: none;">
                                <div class="item-card">
                                    <div class="board-header">
                                        <div class="board-icon">📋</div>
                                        <h3 class="item-title" style="color: white; margin: 0;">${board.name}</h3>
                                    </div>
                                    <div class="item-content">
                                        <p class="item-description">${board.description}</p>
                                        <div class="item-meta">
                                            <span>Создано: ${board.created_at}</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>У вас пока нет досок</h3>
                        <p>Создайте доску для организации ваших пинов!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>