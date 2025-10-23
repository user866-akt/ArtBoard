<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Пины - ArtBoard</title>
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

        .filters-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .filter-row {
            display: flex;
            gap: 20px;
            align-items: end;
            flex-wrap: wrap;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary);
            font-weight: 600;
            font-size: 14px;
        }

        .form-input, .form-select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-input:focus, .form-select:focus {
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

        .pins-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin: 30px 0;
        }

        .pin-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .pin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .pin-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            display: block;
        }

        .pin-content {
            padding: 20px;
        }

        .pin-title {
            font-size: 18px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 10px;
            line-height: 1.3;
        }

        .pin-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #f0f0f0;
        }

        .pin-author {
            color: var(--secondary);
            font-weight: 500;
            font-size: 14px;
        }

        .pin-category {
            background: var(--light);
            color: var(--primary);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
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

            .filter-row {
                flex-direction: column;
            }

            .filter-group {
                min-width: 100%;
            }

            .pins-container {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
            }
        }

        @media (max-width: 480px) {
            .pins-container {
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
            <a href="${pageContext.request.contextPath}/create-pin.jsp" class="btn btn-primary">Создать пин</a>
            <% } else { %>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">Войдите чтобы создать пин</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">На главную</a>
        </div>
    </div>

    <div class="filters-section">
        <div class="filter-row">
            <div class="filter-group">
                <form action="${pageContext.request.contextPath}/pins/search" method="get" style="margin: 0;">
                    <label class="filter-label">Поиск по названию</label>
                    <input type="text" name="q" value="${param.q}"
                           class="form-input" placeholder="Введите название...">
                </form>
            </div>

            <div class="filter-group">
                <form action="${pageContext.request.contextPath}/pins/by-category" method="get" style="margin: 0;">
                    <label class="filter-label">Категория</label>
                    <select name="category" class="form-select" onchange="this.form.submit()">
                        <option value="">Все категории</option>
                        <option value="Пейзаж" ${param.category == 'Пейзаж' ? 'selected' : ''}>Пейзаж</option>
                        <option value="Портрет" ${param.category == 'Портрет' ? 'selected' : ''}>Портрет</option>
                        <option value="Абстракция" ${param.category == 'Абстракция' ? 'selected' : ''}>Абстракция</option>
                        <option value="Графика" ${param.category == 'Графика' ? 'selected' : ''}>Графика</option>
                        <option value="Цифровое искусство" ${param.category == 'Цифровое искусство' ? 'selected' : ''}>Цифровое искусство</option>
                    </select>
                </form>
            </div>

            <div class="filter-group">
                <a href="${pageContext.request.contextPath}/pins/" class="btn btn-outline" style="display: block;">Сбросить фильтры</a>
            </div>
        </div>
    </div>

    <h1 class="page-title">
        <c:choose>
            <c:when test="${not empty param.category}">
                Пины: <span class="search-title">${param.category}</span>
            </c:when>
            <c:when test="${not empty param.q}">
                Результаты поиска: <span class="search-title">"${param.q}"</span>
            </c:when>
            <c:otherwise>
                Все пины
            </c:otherwise>
        </c:choose>
    </h1>

    <!-- Сетка пинов -->
    <c:choose>
        <c:when test="${not empty pins}">
            <div class="pins-container">
                <c:forEach items="${pins}" var="pin">
                    <a href="${pageContext.request.contextPath}/pins/${pin.id}" style="text-decoration: none;">
                        <div class="pin-card">
                            <img src="${pin.image_url}" alt="${pin.title}" class="pin-image">
                            <div class="pin-content">
                                <h3 class="pin-title">${pin.title}</h3>
                                <div class="pin-meta">
                                    <span class="pin-author">${pin.artwork_author}</span>
                                    <span class="pin-category">${pin.category}</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <h3>Пинов не найдено</h3>
                <p>Попробуйте изменить параметры поиска или создать новый пин</p>
                <% if (isLoggedIn) { %>
                <a href="${pageContext.request.contextPath}/create-pin.jsp" class="btn btn-primary" style="margin-top: 15px;">Создать первый пин</a>
                <% } %>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    document.querySelector('input[name="q"]').addEventListener('input', function(e) {
        clearTimeout(this.searchTimeout);
        this.searchTimeout = setTimeout(() => {
            this.form.submit();
        }, 500);
    });
</script>
</body>
</html>