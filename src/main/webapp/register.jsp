<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Регистрация - ArtBoard</title>
    <script>
        var emailValid = false;
        var usernameValid = false;
        var passwordValid = false;

        function checkField(field, url, statusId, type) {
            var value = document.getElementById(field).value;
            var status = document.getElementById(statusId);

            if (!value) {
                status.innerHTML = '';
                updateButton();
                return;
            }

            status.innerHTML = '';

            fetch('${pageContext.request.contextPath}' + url + value)
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    if (data.available) {
                        status.innerHTML = 'Свободно';
                        status.style.color = 'green';
                        if (type === 'email') emailValid = true;
                        if (type === 'username') usernameValid = true;
                    } else {
                        status.innerHTML = 'Занято';
                        status.style.color = 'red';
                        if (type === 'email') emailValid = false;
                        if (type === 'username') usernameValid = false;
                    }
                    updateButton();
                });
        }

        function checkPassword() {
            var password = document.getElementById('password').value;
            var passwordStatus = document.getElementById('password-status');

            if (!password) {
                passwordStatus.innerHTML = '';
                passwordValid = false;
                updateButton();
                return;
            }

            if (password.length < 6) {
                passwordStatus.innerHTML = 'Пароль должен быть не менее 6 символов';
                passwordStatus.style.color = 'red';
                passwordValid = false;
            } else {
                passwordStatus.innerHTML = '✓';
                passwordStatus.style.color = 'green';
                passwordValid = true;
            }
            updateButton();
        }

        function updateButton() {
            var button = document.getElementById('submit-btn');
            button.disabled = !(emailValid && usernameValid && passwordValid);
        }
    </script>
</head>
<body>
<h1>Регистрация</h1>

<% if (request.getParameter("error") != null) { %>
<p style="color: red;">Ошибка: <%= request.getParameter("error") %></p>
<% } %>

<form action="${pageContext.request.contextPath}/auth/register" method="post" onsubmit="return validateForm()">
    Email: <input type="email" name="email" id="email" required
                  onblur="checkField('email', '/auth/check-email?email=', 'email-status', 'email')"><br>
    <span id="email-status"></span><br><br>

    Имя: <input type="text" name="username" id="username" required
                onblur="checkField('username', '/auth/check-username?username=', 'username-status', 'username')"><br>
    <span id="username-status"></span><br><br>

    Пароль: <input type="password" name="password" id="password" required
                   oninput="checkPassword()" onblur="checkPassword()"><br>
    <span id="password-status"></span><br><br>

    <button type="submit" id="submit-btn" disabled>Зарегистрироваться</button>
</form>

<br>
<a href="index.jsp">На главную</a> |
<a href="login.jsp">Уже есть аккаунт?</a>

<script>
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