<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Medi's Sneakers - Register</title>
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
            margin-bottom: 15px;
        }

        .input-group input {
            width: 100%;
            padding: 12px;
            background: #111;
            border: 1px solid #333;
            border-radius: 6px;
            color: white;
            outline: none;
        }

        .input-group input:focus {
            border-color: #00ffcc;
            box-shadow: 0 0 8px #00ffcc;
        }

        .radio-group {
            margin-bottom: 15px;
            font-size: 14px;
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
        }

        .btn-login:hover {
            background: #00ddb3;
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
    </style>
</head>
<body>

<div class="login-box">
    <div class="brand">SNEAKER STORE</div>
    <h2>REGISTER</h2>

    <form action="/register" method="post">

        <div class="input-group">
            <input type="text" name="username" placeholder="Username" required>
        </div>

        <div class="input-group">
            <input type="password" name="password" placeholder="Password" required>
        </div>

        <div class="radio-group">
            Giới tính:
            <input type="radio" name="gioiTinh" value="true"> Nam
            <input type="radio" name="gioiTinh" value="false"> Nữ
        </div>

        <div class="input-group">
            <input type="number" name="tuoi" placeholder="Tuổi">
        </div>

        <div class="input-group">
            <input type="text" name="diaChi" placeholder="Địa chỉ">
        </div>

        <div class="input-group">
            <input type="email" name="email" placeholder="Email">
        </div>

        <button class="btn-login">Đăng ký</button>
    </form>

    <div class="extra">
        Đã có tài khoản? <a href="/login">Đăng nhập</a>
    </div>

    <p>${message}</p>
</div>

</body>
</html>