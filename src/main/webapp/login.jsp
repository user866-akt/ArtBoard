<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Вход - ArtBoard</title>
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

            status.innerHTML = 'Проверка';

            fetch('${pageContext.request.contextPath}/auth/check-email?email=' + email)
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    if (data.available) {
                        status.innerHTML = 'Email не найден';
                        status.style.color = 'red';
                        emailValid = false;
                    } else {
                        status.innerHTML = 'Email найден';
                        status.style.color = 'green';
                        emailValid = true;
                    }
                    updateButton();
                });
        }

        function updateButton() {
            var button = document.getElementById('submit-btn');
            var password = document.getElementById('password').value;
            button.disabled = !(emailValid && password.length > 0);
        }
    </script>
</head>
<body>
<h1>Вход в систему</h1>

<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Ошибка: <%= request.getParameter("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/auth/login" method="post">
    Email: <input type="email" name="email" id="email" required onblur="checkEmail()"><br>
    <span id="email-status"></span><br><br>

    Пароль: <input type="password" name="password" id="password" required
                   oninput="updateButton()"><br><br>

    <button type="submit" id="submit-btn" disabled>Войти</button>
</form>

<br>
<a href="index.jsp">На главную</a> |
<a href="register.jsp">Создать аккаунт</a>
</body>
</html>