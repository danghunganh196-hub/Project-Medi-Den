<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Medi Den - Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&family=Oswald:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            /* Dùng chung ảnh nền với trang Login để tạo sự đồng bộ */
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
            url('https://images.unsplash.com/photo-1552346154-21d32810aba3?q=80&w=2070&auto=format&fit=crop') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Montserrat', sans-serif;
            padding: 20px;
        }

        .register-box {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);

            /* 1. Tăng mạnh padding-top để tạo không gian cho đường cong bo tròn */
            padding: 80px 40px 40px 40px;

            /* 2. Đảm bảo bo tròn đều 4 góc (30px hoặc 40px tùy độ cong bạn muốn) */
            border-radius: 40px;

            width: 450px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.15);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);

            /* 3. QUAN TRỌNG: Đảm bảo nội dung không đè lên đường bo góc */
            overflow: hidden;
            position: relative;
        }

        .brand-name {
            font-family: 'Oswald', sans-serif;
            font-size: 40px;
            color: white;
            text-transform: uppercase;
            letter-spacing: 2px;

            /* 4. Đảm bảo tiêu đề có vị trí hợp lý dưới đường bo */
            margin-bottom: 10px;
            line-height: 1.2;
            display: block;
        }
        .register-box h2 {
            font-size: 13px;
            font-weight: 300;
            letter-spacing: 5px;
            text-transform: uppercase;
            margin-bottom: 30px;
            color: rgba(255, 255, 255, 0.7);
        }

        .input-group {
            margin-bottom: 15px;
            position: relative;
        }

        /* Icon tĩnh màu xám đậm để nổi bật trên nền trắng */
        .input-group i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
            font-size: 16px;
            transition: 0.3s;
            z-index: 5;
        }

        .input-group input {
            width: 100%;
            padding: 14px 15px 14px 50px;
            background: rgba(255, 255, 255, 0.95);
            border: 2px solid transparent;
            border-radius: 12px;
            color: #333;
            font-size: 14px;
            outline: none;
            transition: 0.3s;
        }

        /* Hiệu ứng Focus đồng bộ với Login */
        .input-group input:focus {
            background: #fff;
            border-color: #ff2d55;
            box-shadow: 0 0 15px rgba(255, 45, 85, 0.3);
        }

        .input-group input:focus + i {
            color: #ff2d55;
        }

        /* Style riêng cho phần chọn giới tính */
        .radio-group {
            margin: 20px 0;
            text-align: left;
            padding-left: 10px;
            font-size: 14px;
            color: white;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .radio-group input[type="radio"] {
            accent-color: #ff2d55; /* Đổi màu nút radio thành hồng */
            cursor: pointer;
        }

        .btn-register {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #ff2d55 0%, #b00020 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            cursor: pointer;
            transition: 0.4s;
            margin-top: 10px;
        }

        .btn-register:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(176, 0, 32, 0.4);
            filter: brightness(1.1);
        }

        .extra {
            margin-top: 25px;
            font-size: 13px;
            color: rgba(255, 255, 255, 0.7);
        }

        .extra a {
            color: #ff4d79;
            text-decoration: none;
            font-weight: 600;
        }

        .extra a:hover {
            text-decoration: underline;
        }

        /* Ẩn mũi tên tăng giảm của input number cho đẹp */
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
</head>
<body>

<div class="register-box">
    <div class="brand-name">Medi Den</div>
    <h2>REGISTER</h2>

    <form action="/register" method="post">

        <div class="input-group">
            <input type="text" name="ten" placeholder="Họ và Tên" required>
            <i class="fa-solid fa-address-card"></i>
        </div>

        <div class="input-group">
            <input type="text" name="username" placeholder="Username" required>
            <i class="fa-solid fa-user"></i>
        </div>

        <div class="input-group">
            <input type="password" name="password" placeholder="Password" required>
            <i class="fa-solid fa-lock"></i>
        </div>

        <div class="radio-group">
            <span>Giới tính:</span>
            <label><input type="radio" name="gioiTinh" value="true" checked> Nam</label>
            <label><input type="radio" name="gioiTinh" value="false"> Nữ</label>
        </div>

        <div class="input-group">
            <input type="number" name="tuoi" placeholder="Tuổi">
            <i class="fa-solid fa-cake-candles"></i>
        </div>

        <div class="input-group">
            <input type="text" name="diaChi" placeholder="Địa chỉ">
            <i class="fa-solid fa-location-dot"></i>
        </div>

        <div class="input-group">
            <input type="email" name="email" placeholder="Email">
            <i class="fa-solid fa-envelope"></i>
        </div>

        <button type="submit" class="btn-register">Đăng ký ngay</button>
    </form>

    <div class="extra">
        Đã có tài khoản? <a href="/login">Đăng nhập</a>
    </div>

    <p style="margin-top:15px; font-size:12px; color:#ffb3b3;">${message}</p>
</div>

</body>
</html>