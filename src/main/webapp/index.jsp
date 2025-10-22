<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ArtBoard - Платформа для творческих людей</title>
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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            color: #333;
        }

        .main-container {
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 40px;
        }

        .logo {
            font-size: 48px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 10px;
            text-align: center;
        }

        .tagline {
            color: var(--secondary);
            font-size: 18px;
            margin-bottom: 40px;
            font-weight: 500;
            text-align: center;
        }

        .welcome-text {
            font-size: 24px;
            margin-bottom: 30px;
            color: var(--primary);
            text-align: center;
        }

        .user-info {
            background: var(--light);
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: left;
            border-left: 5px solid var(--secondary);
        }

        .username {
            color: var(--secondary);
            font-weight: bold;
            font-size: 22px;
            font-style: italic;
        }

        .actions-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-top: 30px;
        }

        .main-actions {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .user-actions {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .section-title {
            font-size: 16px;
            color: var(--primary);
            margin-bottom: 15px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn {
            display: block;
            padding: 15px 20px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
        }

        .btn-large {
            padding: 18px 25px;
            font-size: 18px;
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

        .btn-secondary {
            background: var(--accent);
            color: white;
        }

        .btn-secondary:hover {
            background: #c9956f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(218, 173, 134, 0.3);
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

        .guest-message {
            font-size: 18px;
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
            text-align: center;
        }

        .guest-actions {
            display: flex;
            flex-direction: column;
            gap: 15px;
            max-width: 400px;
            margin: 0 auto;
        }

        @media (max-width: 768px) {
            .actions-layout {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .main-container {
                padding: 30px 20px;
            }

            .logo {
                font-size: 36px;
            }

            .welcome-text {
                font-size: 20px;
            }

            .btn {
                padding: 12px 20px;
                font-size: 14px;
            }

            .btn-large {
                padding: 15px 20px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="logo">ArtBoard</div>
    <div class="tagline">Платформа для творчества</div>

    <h1 class="welcome-text">Добро пожаловать в ArtBoard!</h1>

    <%
        Object user = session.getAttribute("user");
        if (user != null) {
    %>
    <div class="user-info">
        <span class="username">${user.username}</span>
    </div>

    <div class="actions-layout">
        <div class="main-actions">
            <div class="section-title">Творчество</div>
            <a href="${pageContext.request.contextPath}/pins/" class="btn btn-primary btn-large">Пины</a>
            <a href="${pageContext.request.contextPath}/boards/" class="btn btn-secondary btn-large">Доски</a>
        </div>

        <div class="user-actions">
            <div class="section-title">Аккаунт</div>
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline">Мой профиль</a>
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline">Выйти</a>
        </div>
    </div>
    <%
    } else {
    %>
    <p class="guest-message">
        Присоединяйтесь к творческому сообществу!<br>
        Делитесь своими работами, находите вдохновение и создавайте коллекции.
    </p>
    <div class="guest-actions">
        <a href="${pageContext.request.contextPath}/pins/" class="btn btn-primary btn-large">Смотреть все пины</a>
        <a href="login.jsp" class="btn btn-secondary">Войти</a>
        <a href="register.jsp" class="btn btn-outline">Регистрация</a>
    </div>
    <%
        }
    %>
</div>
</body>
</html>