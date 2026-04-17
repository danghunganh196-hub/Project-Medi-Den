<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Medi Den - Quên mật khẩu</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&family=Oswald:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            height: 100vh;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)),
            url('https://images.unsplash.com/photo-1552346154-21d32810aba3?q=80&w=2070&auto=format&fit=crop') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Montserrat', sans-serif;
            color: white;
        }

        .login-box {
            background: rgba(255,255,255,0.07);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            padding: 60px 40px;
            border-radius: 40px;
            width: 420px;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.15);
            box-shadow: 0 25px 50px rgba(0,0,0,0.3);
        }

        .brand-name {
            font-family: 'Oswald', sans-serif;
            font-size: 42px;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 5px;
            background: linear-gradient(to bottom, #ffffff, #ffb3c1);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .login-box h2 {
            font-size: 13px;
            font-weight: 300;
            letter-spacing: 8px;
            text-transform: uppercase;
            margin-bottom: 40px;
            color: rgba(255,255,255,0.6);
        }

        .input-group {
            margin-bottom: 25px;
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-group i {
            position: absolute;
            left: 20px;
            color: #ff2d55;
            font-size: 20px;
            z-index: 2;
        }

        .input-group input {
            width: 100%;
            padding: 18px 20px 18px 55px;
            background: rgba(255,255,255,0.9);
            border: none;
            border-radius: 15px;
            color: #333;
            font-size: 16px;
            font-weight: 500;
            outline: none;
            transition: 0.3s all ease;
        }

        .input-group input:focus {
            background: #fff;
            box-shadow: 0 0 20px rgba(255,45,85,0.3);
            transform: scale(1.02);
        }

        .input-group input::placeholder { color: #999; font-weight: 400; }

        .btn-submit {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #ff2d55 0%, #b00020 100%);
            border: none;
            border-radius: 15px;
            color: white;
            font-size: 18px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            transition: 0.4s;
            margin-top: 15px;
            box-shadow: 0 10px 20px rgba(176,0,32,0.3);
        }

        .btn-submit:hover {
            box-shadow: 0 15px 30px rgba(176,0,32,0.5);
            transform: translateY(-3px);
            filter: brightness(1.1);
        }

        .extra {
            margin-top: 35px;
            font-size: 14px;
            color: rgba(255,255,255,0.7);
        }

        .extra a {
            color: #ff4d79;
            text-decoration: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .extra a:hover { color: #fff; text-decoration: underline; }

        .message {
            margin-top: 20px;
            color: #ffb3b3;
            font-size: 14px;
            font-weight: 500;
            background: rgba(255,0,0,0.1);
            padding: 10px;
            border-radius: 8px;
            display: ${empty message ? 'none' : 'block'};
        }
    </style>
</head>
<body>

<div class="login-box">
    <div class="brand-name">Medi Den</div>
    <h2>RESET PASSWORD</h2>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        <div class="input-group">
            <i class="fa-solid fa-user"></i>
            <input type="text" name="username" placeholder="Username" required>
        </div>
        <div class="input-group">
            <i class="fa-solid fa-lock"></i>
            <input type="password" name="newPassword" placeholder="Mật khẩu mới" required>
        </div>
        <div class="input-group">
            <i class="fa-solid fa-lock-open"></i>
            <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
        </div>

        <button type="submit" class="btn-submit">Xác nhận</button>
    </form>

    <div class="extra">
        Nhớ mật khẩu rồi? <a href="/login">Đăng nhập</a>
    </div>

    <div class="message">${message}</div>
</div>

<script>
    document.querySelector('form').addEventListener('submit', function(e) {
        const newPass     = document.querySelector('[name=newPassword]').value;
        const confirmPass = document.querySelector('[name=confirmPassword]').value;
        if (newPass !== confirmPass) {
            e.preventDefault();
            const msg = document.querySelector('.message');
            msg.textContent = 'Mật khẩu nhập lại không khớp!';
            msg.style.display = 'block';
        }
    });
</script>

</body>
</html>
