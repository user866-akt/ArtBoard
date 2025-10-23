<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Доски - ArtBoard</title>
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
            max-width: 1400px;
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
            gap: 20px;
            align-items: center;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            text-align: center;
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

        .search-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            text-align: center;
        }

        .search-form {
            display: flex;
            gap: 15px;
            justify-content: center;
            align-items: end;
            flex-wrap: wrap;
        }

        .search-group {
            flex: 1;
            min-width: 300px;
            max-width: 500px;
        }

        .search-label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-weight: 600;
            text-align: left;
        }

        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(101, 157, 189, 0.1);
        }

        .page-title {
            font-size: 32px;
            margin-bottom: 30px;
            color: var(--primary);
            text-align: center;
        }

        .search-title {
            color: var(--secondary);
            font-style: italic;
        }

        .boards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin: 30px 0;
        }

        .board-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            cursor: pointer;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .board-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .board-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--neutral) 100%);
            color: white;
            padding: 25px;
            text-align: center;
        }

        .board-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .board-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .board-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .board-description {
            color: #666;
            line-height: 1.5;
            margin-bottom: 15px;
            flex-grow: 1;
        }

        .board-meta {
            margin-top: auto;
            padding-top: 15px;
            border-top: 1px solid #f0f0f0;
            color: #888;
            font-size: 14px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #666;
        }

        .empty-state h3 {
            color: var(--primary);
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .search-form {
                flex-direction: column;
            }

            .search-group {
                min-width: 100%;
            }

            .boards-grid {
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;
            }
        }

        @media (max-width: 480px) {
            .boards-grid {
                grid-template-columns: 1fr;
            }

            .container {
                padding: 0 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">ArtBoard</a>
        <div class="nav-links">
            <%
                Object user = session.getAttribute("user");
                boolean isLoggedIn = (user != null);
            %>
            <% if (isLoggedIn) { %>
            <a href="${pageContext.request.contextPath}/create-board.jsp" class="btn btn-primary">Создать доску</a>
            <% } else { %>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">Войти для создания доски</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">На главную</a>
        </div>
    </div>

    <div class="search-section">
        <form action="${pageContext.request.contextPath}/boards/search" method="get" class="search-form">
            <div class="search-group">
                <label class="search-label">Поиск досок</label>
                <input type="text" name="q" value="${param.q}"
                       class="form-input" placeholder="Введите название или описание...">
            </div>
            <button type="submit" class="btn btn-primary">Найти</button>
            <c:if test="${not empty param.q}">
                <a href="${pageContext.request.contextPath}/boards/" class="btn btn-outline">Сбросить</a>
            </c:if>
        </form>
    </div>

    <h1 class="page-title">
        <%
            String searchQuery = request.getParameter("q");
            if (searchQuery != null && !searchQuery.isEmpty()) {
        %>
        Результаты поиска: <span class="search-title">"<%= searchQuery %>"</span>
        <%
        } else {
        %>
        Все доски
        <%
            }
        %>
    </h1>

    <c:choose>
        <c:when test="${not empty boards}">
            <div class="boards-grid">
                <c:forEach items="${boards}" var="board">
                    <a href="${pageContext.request.contextPath}/boards/${board.id}" style="text-decoration: none;">
                        <div class="board-card">
                            <div class="board-header">
                                <div class="board-icon">📋</div>
                                <h3 class="board-name">${board.name}</h3>
                            </div>
                            <div class="board-content">
                                <p class="board-description">${board.description}</p>
                                <div class="board-meta">
                                    <strong>Создано:</strong> ${board.created_at}
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <h3>Досок не найдено</h3>
                <p>Попробуйте изменить параметры поиска или создать новую доску</p>
                <% if (isLoggedIn) { %>
                <a href="${pageContext.request.contextPath}/create-board.jsp" class="btn btn-primary" style="margin-top: 15px;">Создать первую доску</a>
                <% } %>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>