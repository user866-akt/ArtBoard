<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Редактирование пина - ArtBoard</title>
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
            max-width: 800px;
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

        .btn-danger {
            background: var(--error);
            color: white;
        }

        .btn-danger:hover {
            background: #a51c1c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
        }

        .edit-section {
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

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--secondary);
            text-decoration: none;
            margin-bottom: 20px;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: var(--primary);
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

        .image-preview {
            text-align: center;
            margin: 30px 0;
            padding: 20px;
            background: var(--light);
            border-radius: 10px;
        }

        .preview-title {
            font-size: 18px;
            color: var(--primary);
            margin-bottom: 15px;
            font-weight: 600;
        }

        .preview-image {
            max-width: 100%;
            max-height: 300px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .delete-section {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #f0f0f0;
            text-align: center;
        }

        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            z-index: 1000;
            text-align: center;
            max-width: 400px;
            width: 90%;
        }

        .modal-title {
            color: var(--error);
            font-size: 20px;
            margin-bottom: 15px;
        }

        .modal-text {
            color: #666;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .modal-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
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

            .edit-section {
                padding: 30px 20px;
            }

            .form-actions {
                flex-direction: column;
                align-items: center;
            }

            .modal-actions {
                flex-direction: column;
            }

            .btn {
                width: 200px;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 0 10px;
            }

            .edit-section {
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
            <a href="${pageContext.request.contextPath}/pins/${pin.id}" class="btn btn-outline">Назад к пину</a>
            <a href="${pageContext.request.contextPath}/pins/" class="btn btn-outline">Все пины</a>
        </div>
    </div>

    <!-- Редактирование пина -->
    <div class="edit-section">
        <a href="${pageContext.request.contextPath}/pins/${pin.id}" class="back-link">
            ← Назад к пину
        </a>

        <h1 class="page-title">Редактирование пина</h1>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error-message">
            Ошибка: <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <!-- Предпросмотр изображения -->
        <div class="image-preview">
            <div class="preview-title">Текущее изображение</div>
            <img src="${pin.image_url}" alt="${pin.title}" class="preview-image">
        </div>

        <form action="${pageContext.request.contextPath}/pins/${pin.id}/edit" method="post">
            <div class="form-group">
                <label class="form-label" for="title">Заголовок:</label>
                <input type="text" id="title" name="title" value="${pin.title}"
                       class="form-input" required placeholder="Введите заголовок пина">
            </div>

            <div class="form-group">
                <label class="form-label" for="description">Описание:</label>
                <textarea id="description" name="description"
                          class="form-textarea" placeholder="Опишите ваш пин...">${pin.description}</textarea>
            </div>

            <div class="form-group">
                <label class="form-label" for="artworkAuthor">Автор произведения:</label>
                <input type="text" id="artworkAuthor" name="artworkAuthor" value="${pin.artwork_author}"
                       class="form-input" required placeholder="Укажите автора произведения">
            </div>

            <div class="form-group">
                <label class="form-label" for="category">Категория:</label>
                <select id="category" name="category" class="form-select">
                    <option value="Пейзаж" ${pin.category == 'Пейзаж' ? 'selected' : ''}>Пейзаж</option>
                    <option value="Портрет" ${pin.category == 'Портрет' ? 'selected' : ''}>Портрет</option>
                    <option value="Абстракция" ${pin.category == 'Абстракция' ? 'selected' : ''}>Абстракция</option>
                    <option value="Графика" ${pin.category == 'Графика' ? 'selected' : ''}>Графика</option>
                    <option value="Цифровое искусство" ${pin.category == 'Цифровое искусство' ? 'selected' : ''}>Цифровое искусство</option>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Сохранить изменения</button>
                <a href="${pageContext.request.contextPath}/pins/${pin.id}" class="btn btn-outline">Отмена</a>
            </div>
        </form>

        <!-- Кнопка удаления -->
        <div class="delete-section">
            <button type="button" onclick="showDeleteModal()" class="btn btn-danger">Удалить пин</button>
            <form id="delete-form" action="${pageContext.request.contextPath}/pins/${pin.id}/delete" method="post" style="display: none;"></form>
        </div>
    </div>
</div>

<!-- Модальное окно удаления -->
<div id="delete-modal" class="modal">
    <div class="modal-title">Удалить пин?</div>
    <p class="modal-text">Пин "${pin.title}" будет удален безвозвратно. Это действие нельзя отменить.</p>
    <div class="modal-actions">
        <button onclick="confirmDelete()" class="btn btn-danger">Да, удалить</button>
        <button onclick="closeDeleteModal()" class="btn btn-outline">Отмена</button>
    </div>
</div>
<div id="overlay" class="overlay"></div>

<script>
    function showDeleteModal() {
        document.getElementById('delete-modal').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    function closeDeleteModal() {
        document.getElementById('delete-modal').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
    }

    function confirmDelete() {
        document.getElementById('delete-form').submit();
    }
</script>
</body>
</html>