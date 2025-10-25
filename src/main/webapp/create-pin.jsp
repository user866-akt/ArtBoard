<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Создать пин - ArtBoard</title>
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
            max-width: 600px;
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

        .create-section {
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

        .error-message {
            background: #ffebee;
            color: var(--error);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            border-left: 4px solid var(--error);
            text-align: center;
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
            min-height: 120px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
        }

        .form-hint {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
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

            .create-section {
                padding: 30px 20px;
            }

            .form-actions {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 200px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 10px;
            }

            .create-section {
                padding: 25px 15px;
            }

            .page-title {
                font-size: 24px;
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
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">На главную</a>
            <a href="${pageContext.request.contextPath}/pins/" class="btn btn-outline">Все пины</a>
        </div>
    </div>

    <!-- Создание пина -->
    <div class="create-section">
        <h1 class="page-title">Создать пин</h1>

        <% if (request.getParameter("error") != null) { %>
        <div class="error-message">
            Ошибка: <%= request.getParameter("error") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/pins/create" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label class="form-label" for="title">Название:</label>
                <input type="text" id="title" name="title"
                       class="form-input" required placeholder="Введите название пина">
            </div>

            <div class="form-group">
                <label class="form-label" for="artwork_author">Автор произведения:</label>
                <input type="text" id="artwork_author" name="artwork_author"
                       class="form-input" required placeholder="Укажите автора произведения">
            </div>

            <div class="form-group">
                <label class="form-label" for="description">Описание:</label>
                <textarea id="description" name="description"
                          class="form-textarea" placeholder="Опишите ваш пин..."></textarea>
            </div>

            <div class="form-group">
                <label class="form-label" for="imageFile">Изображение:</label>
                <input type="file" id="imageFile" name="imageFile"
                       class="form-input" accept="image/*" required>
                <div class="form-hint">Выберите изображение для загрузки (JPG, PNG, GIF)</div>
            </div>

            <div class="form-group">
                <label class="form-label" for="category">Категория:</label>
                <select id="category" name="category" class="form-select">
                    <option value="Пейзаж">Пейзаж</option>
                    <option value="Портрет">Портрет</option>
                    <option value="Абстракция">Абстракция</option>
                    <option value="Графика">Графика</option>
                    <option value="Цифровое искусство">Цифровое искусство</option>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Создать пин</button>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">Отмена</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>