<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Регистрация - ArtBoard</title>
    <style>
        :root {
            --primary: #8D8741;
            --secondary: #659DBD;
            --accent: #DAAD86;
            --light: #FBEEC1;
            --neutral: #BC986A;
            --success: #4CAF50;
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
            color: var(--error);
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
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
            font-weight: 500;
        }

        .status-success {
            color: var(--success);
        }

        .status-error {
            color: var(--error);
        }

        .status-checking {
            color: var(--neutral);
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

        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
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

    <h1 class="page-title">Регистрация</h1>

    <% if (request.getParameter("error") != null) { %>
    <div class="error-message">
        Ошибка: <%= request.getParameter("error") %>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/auth/register" method="post" onsubmit="return validateForm()">
        <div class="form-group">
            <label class="form-label" for="email">Email:</label>
            <input class="form-input" type="email" name="email" id="email" required
                   onblur="checkField('email', '/auth/check-email?email=', 'email-status', 'email')"
                   placeholder="Введите ваш email">
            <span class="status-message" id="email-status"></span>
        </div>

        <div class="form-group">
            <label class="form-label" for="username">Имя пользователя:</label>
            <input class="form-input" type="text" name="username" id="username" required
                   onblur="checkField('username', '/auth/check-username?username=', 'username-status', 'username')"
                   placeholder="Придумайте имя пользователя">
            <span class="status-message" id="username-status"></span>
        </div>

        <div class="form-group">
            <label class="form-label" for="password">Пароль:</label>
            <input class="form-input" type="password" name="password" id="password" required
                   oninput="checkPassword()" onblur="checkPassword()"
                   placeholder="Придумайте пароль">
            <span class="status-message" id="password-status"></span>
            <div class="password-requirements">Пароль должен быть не менее 6 символов</div>
        </div>

        <button class="btn btn-primary" type="submit" id="submit-btn" disabled>Зарегистрироваться</button>
    </form>

    <div class="links">
        <a href="index.jsp">На главную</a>
        <a href="login.jsp">Уже есть аккаунт?</a>
    </div>
</div>

<script>
    var emailValid = false;
    var usernameValid = false;
    var passwordValid = false;

    function checkField(field, url, statusId, type) {
        var value = document.getElementById(field).value;
        var status = document.getElementById(statusId);

        if (!value) {
            status.innerHTML = '';
            status.className = 'status-message';
            updateButton();
            return;
        }

        status.innerHTML = '';
        status.className = 'status-message status-checking';

        fetch('${pageContext.request.contextPath}' + url + value)
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.available) {
                    status.innerHTML = '✓';
                    status.className = 'status-message status-success';
                    if (type === 'email') emailValid = true;
                    if (type === 'username') usernameValid = true;
                } else {
                    status.innerHTML = '✗ Занято';
                    status.className = 'status-message status-error';
                    if (type === 'email') emailValid = false;
                    if (type === 'username') usernameValid = false;
                }
                updateButton();
            })
            .catch(function(error) {
                status.innerHTML = '✗ Ошибка проверки';
                status.className = 'status-message status-error';
                if (type === 'email') emailValid = false;
                if (type === 'username') usernameValid = false;
                updateButton();
            });
    }

    function checkPassword() {
        var password = document.getElementById('password').value;
        var passwordStatus = document.getElementById('password-status');

        if (!password) {
            passwordStatus.innerHTML = '';
            passwordStatus.className = 'status-message';
            passwordValid = false;
            updateButton();
            return;
        }

        if (password.length < 6) {
            passwordStatus.innerHTML = '✗ Слишком короткий';
            passwordStatus.className = 'status-message status-error';
            passwordValid = false;
        } else {
            passwordStatus.innerHTML = '✓';
            passwordStatus.className = 'status-message status-success';
            passwordValid = true;
        }
        updateButton();
    }

    function updateButton() {
        var button = document.getElementById('submit-btn');
        button.disabled = !(emailValid && usernameValid && passwordValid);
    }

    function validateForm() {
        var password = document.getElementById('password').value;
        if (password.length < 6) {
            alert('Пароль должен быть не менее 6 символов');
            return false;
        }
        return true;
    }
</script>
</body>
</html>