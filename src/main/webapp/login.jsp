<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Вход - ArtBoard</title>
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
            max-width: 500px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 40px;
        }

        .logo {
            font-size: 42px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 10px;
            text-align: center;
        }

        .tagline {
            color: var(--secondary);
            font-size: 16px;
            margin-bottom: 30px;
            font-weight: 500;
            text-align: center;
        }

        .page-title {
            font-size: 28px;
            margin-bottom: 30px;
            color: var(--primary);
            text-align: center;
        }

        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #c62828;
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
        }

        .form-input {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--secondary);
            box-shadow: 0 0 0 3px rgba(101, 157, 189, 0.1);
        }

        .status-message {
            font-size: 14px;
            margin-top: 5px;
            display: block;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 16px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            margin-bottom: 15px;
        }

        .btn-primary {
            background: var(--secondary);
            color: white;
        }

        .btn-primary:hover:not(:disabled) {
            background: #4a87a5;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(101, 157, 189, 0.3);
        }

        .btn-primary:disabled {
            background: #cccccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
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

        .links {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }

        .links a {
            color: var(--secondary);
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .links a:hover {
            color: var(--primary);
            text-decoration: underline;
        }

        @media (max-width: 600px) {
            .main-container {
                padding: 30px 20px;
            }

            .logo {
                font-size: 36px;
            }

            .page-title {
                font-size: 24px;
            }

            .form-input {
                padding: 12px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="logo">ArtBoard</div>
    <div class="tagline">Платформа для творчества</div>

    <h1 class="page-title">Вход в систему</h1>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error-message">
        Ошибка: <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/auth/login" method="post">
        <div class="form-group">
            <label class="form-label" for="email">Email:</label>
            <input class="form-input" type="email" name="email" id="email" required
                   onblur="checkEmail()" placeholder="Введите ваш email">
            <span class="status-message" id="email-status"></span>
        </div>

        <div class="form-group">
            <label class="form-label" for="password">Пароль:</label>
            <input class="form-input" type="password" name="password" id="password" required
                   oninput="updateButton()" placeholder="Введите ваш пароль">
        </div>

        <button class="btn btn-primary" type="submit" id="submit-btn" disabled>Войти</button>
    </form>

    <div class="links">
        <a href="index.jsp">На главную</a>
        <a href="register.jsp">Создать аккаунт</a>
    </div>
</div>

<script>
    var emailValid = false;

    function checkEmail() {
        var email = document.getElementById('email').value;
        var status = document.getElementById('email-status');

        if (!email) {
            status.innerHTML = '';
            emailValid = false;
            updateButton();
            return;
        }

        status.innerHTML = '';
        status.style.color = 'var(--neutral)';

        fetch('${pageContext.request.contextPath}/auth/check-email?email=' + email)
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.available) {
                    status.innerHTML = 'Email не найден';
                    status.style.color = '#c62828';
                    emailValid = false;
                } else {
                    status.innerHTML = '';
                    status.style.color = 'var(--primary)';
                    emailValid = true;
                }
                updateButton();
            })
            .catch(function(error) {
                status.innerHTML = 'Ошибка проверки';
                status.style.color = '#c62828';
                emailValid = false;
                updateButton();
            });
    }

    function updateButton() {
        var button = document.getElementById('submit-btn');
        var password = document.getElementById('password').value;
        button.disabled = !(emailValid && password.length > 0);
    }

    window.onload = function() {
        var savedEmail = '<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>';
        if (savedEmail) {
            document.getElementById('email').value = savedEmail;
            emailValid = true;
            document.getElementById('email-status').innerHTML = 'Email найден';
            document.getElementById('email-status').style.color = 'var(--primary)';
            updateButton();
        }
    }
</script>
</body>
</html>