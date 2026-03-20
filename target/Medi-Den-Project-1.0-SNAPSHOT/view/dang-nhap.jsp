<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sneaker Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            height: 100vh;
            background: #0f0f0f;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }

        .login-box {
            background: #1a1a1a;
            padding: 35px;
            border-radius: 12px;
            width: 340px;
            box-shadow: 0 0 20px rgba(0,0,0,0.8);
            border: 1px solid #2a2a2a;
        }

        .login-box h2 {
            text-align: center;
            margin-bottom: 25px;
            letter-spacing: 2px;
            font-weight: bold;
        }

        .brand {
            text-align: center;
            margin-bottom: 10px;
            color: #00ffcc;
            font-size: 14px;
            letter-spacing: 3px;
        }

        .input-group {
            margin-bottom: 18px;
        }

        .input-group input {
            width: 100%;
            padding: 12px;
            background: #111;
            border: 1px solid #333;
            border-radius: 6px;
            color: white;
            outline: none;
            transition: 0.3s;
        }

        .input-group input:focus {
            border-color: #00ffcc;
            box-shadow: 0 0 8px #00ffcc;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: #00ffcc;
            border: none;
            border-radius: 6px;
            color: black;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-login:hover {
            background: #00ddb3;
            transform: scale(1.03);
        }

        .extra {
            text-align: center;
            margin-top: 15px;
            font-size: 13px;
            color: #aaa;
        }

        .extra a {
            color: #00ffcc;
            text-decoration: none;
        }

        .extra a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="login-box">
    <div class="brand">SNEAKER STORE</div>
    <h2>LOGIN</h2>

    <form action="/login" method="post">
        <div class="input-group">
            <input type="text" name="username" placeholder="Username" required>
        </div>

        <div class="input-group">
            <input type="password" name="password" placeholder="Password" required>
        </div>

        <button class="btn-login">SIGN IN</button>
    </form>

    <div class="extra">
        Chưa có tài khoản? <a href="/register">Đăng ký</a>
    </div>

    <p>${message}</p>
</div>

</body>
</html>