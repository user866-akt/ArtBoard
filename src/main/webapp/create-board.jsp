<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Создать доску - ArtBoard</title>
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

        .form-input, .form-textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-input:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(101, 157, 189, 0.1);
        }

        .form-textarea {
            resize: vertical;
            min-height: 120px;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 15px;
            background: var(--light);
            border-radius: 10px;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .checkbox-group:focus-within {
            border-color: var(--secondary);
        }

        .checkbox-label {
            color: var(--primary);
            font-weight: 600;
            cursor: pointer;
        }

        .checkbox-hint {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
            margin-left: 30px;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
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
    <div class="header">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">ArtBoard</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">На главную</a>
            <a href="${pageContext.request.contextPath}/boards/" class="btn btn-outline">Все доски</a>
        </div>
    </div>

    <div class="create-section">
        <h1 class="page-title">Создать доску</h1>

        <% if (request.getParameter("error") != null) { %>
        <div class="error-message">
            Ошибка: <%= request.getParameter("error") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/boards/create" method="post">
            <div class="form-group">
                <label class="form-label" for="name">Название:</label>
                <input type="text" id="name" name="name"
                       class="form-input" required placeholder="Введите название доски">
            </div>

            <div class="form-group">
                <label class="form-label" for="description">Описание:</label>
                <textarea id="description" name="description"
                          class="form-textarea" placeholder="Опишите вашу доску..."></textarea>
            </div>

            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="is_private" name="is_private">
                    <label class="checkbox-label" for="is_private">Приватная доска</label>
                </div>
                <div class="checkbox-hint">
                    Приватные доски видны только вам
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Создать доску</button>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">Отмена</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>