<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Giới thiệu - Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .policy-wrapper {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .policy-card {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            line-height: 1.8;
            color: #333;
        }
        .policy-card h1 {
            color: #ff1493;
            text-align: center;
            text-transform: uppercase;
            margin-bottom: 30px;
            font-weight: 800;
        }
        .intro-text {
            font-size: 1.1rem;
            text-align: center;
            margin-bottom: 30px;
            padding: 25px;
            background: #fffafa;
            border-radius: 12px;
            border: 1px solid #ffe4ed;
        }
        .section-title {
            color: #d81b60;
            font-size: 1.3rem;
            margin-top: 30px;
            border-bottom: 2px solid #fce4ec;
            display: inline-block;
            margin-bottom: 15px;
            font-weight: bold;
        }
        .info-list {
            list-style: none;
            padding-left: 0;
        }
        .info-list li {
            padding: 10px 0;
            border-bottom: 1px dashed #eee;
        }
        .info-list b { color: #555; width: 220px; display: inline-block; }

        /* Style Box Liên hệ nền hồng viền đứt đoạn */
        .pink-contact-box {
            background-color: #fff0f5;
            border: 2px dashed #ff69b4;
            border-radius: 10px;
            padding: 25px;
            margin-top: 40px;
        }
        .pink-contact-box strong {
            display: block;
            margin-bottom: 15px;
            font-size: 1.1rem;
            text-transform: uppercase;
            color: #333;
        }
        .social-link {
            display: block;
            margin-bottom: 12px;
            text-decoration: none;
            color: #333;
            transition: 0.3s;
        }
        .social-link:hover { color: #ff1493; transform: translateX(5px); }
        .social-link i {
            width: 30px;
            font-size: 1.3rem;
        }
        .fa-facebook { color: #1877F2; }
        .fa-youtube { color: #FF0000; }
        .fa-instagram { color: #E4405F; }
        .fa-globe { color: #ff1493; }

        .contact-details {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #ffc1e3;
        }

    </style>
</head>
<body>

<header>
    <div class="top-bar">
        <%
            TaiKhoan user = (TaiKhoan) session.getAttribute("user");
            if (user == null) {
        %>
        <a class="btn login" href="/view/dang-nhap.jsp">Đăng nhập</a>
        <a class="btn register" href="/view/dang-ky.jsp">Đăng ký</a>
        <%
        } else {
        %>
        <span>Xin chào, <b><%= user.getUsername() %></b></span>
        <a class="btn logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a> <%
        }
    %>
    </div>
    <nav class="navbar">
        <div class="logo">
            <img src="/images/logo/Screenshot 2026-03-19 014252.png" style="border-radius: 20px;" width="20%"
                 alt="Logo">
            <h1>Medi Den</h1>
        </div>
        <ul class="nav-links">
            <!-- Giày Thể Thao -->
            <li class="dropdown">
                <a href="#">Giày Thể Thao <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="#">Nike Running</a></li>
                    <li><a href="#">Adidas Running</a></li>
                    <li><a href="#">Training</a></li>
                    <li><a href="#">Basketball</a></li>
                </ul>
            </li>

            <!-- Giày Thời Trang -->
            <li class="dropdown">
                <a href="#">Giày Thời Trang <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="#">Air Force 1</a></li>
                    <li><a href="#">Jordan</a></li>
                    <li><a href="#">Stan Smith</a></li>
                    <li><a href="#">Superstar</a></li>
                    <li><a href="#">Vans Old Skool</a></li>
                </ul>
            </li>

            <!-- Giày Theo Hãng -->
            <li class="dropdown">
                <a href="#">Giày Theo Hãng <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Nike">Nike</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Adidas">Adidas</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Puma">Puma</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=New+Balance">New Balance</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Converse">Converse</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Vans">Vans</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Clarks">Clarks</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Balenciaga">Balenciaga</a></li>
                </ul>
            </li>

            <!-- Giày Công Sở -->
            <li class="dropdown">
                <a href="#">Giày Công Sở <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="#">Giày da nam</a></li>
                    <li><a href="#">Giày lười</a></li>
                    <li><a href="#">Giày Oxford</a></li>
                    <li><a href="#">Giày Loafer</a></li>
                </ul>
            </li>

            <!-- Giày Cao cấp -->
            <li class="dropdown">
                <a href="#">Giày Cao cấp <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="#">Giày da nam</a></li>
                    <li><a href="#">Giày lười</a></li>
                    <li><a href="#">Giày Oxford</a></li>
                    <li><a href="#">Giày Loafer</a></li>
                </ul>
            </li>
        </ul>
        <div class="search-box">
            <input type="text" name="search" placeholder="Tìm kiếm...">
            <button><i class="fas fa-search"></i></button>
        </div>
    </nav>

</header>

<main class="policy-wrapper">
    <div class="policy-card">
        <h1>Giới thiệu về Medi Den</h1>

        <div class="intro-text">
            <p>Chào mừng bạn đến với <strong>Medi Den</strong> - Website cung cấp các dòng giày Sneaker chính hãng hàng đầu.</p>
            <p>Hiện tại, chúng mình <strong>chỉ nhận đơn hàng trực tiếp trên website</strong> chính thức này. Mọi thông tin ưu đãi, khuyến mãi sẽ được thông báo công khai trên các kênh truyền thông duy nhất của shop.</p>
            <p><em>Medi Den rất hân hạnh được phục vụ và đồng hành cùng phong cách của bạn!</em></p>
        </div>

        <h2 class="section-title">Thông tin hộ kinh doanh</h2>
        <ul class="info-list">
            <li><b>1.1. Tên hộ kinh doanh:</b> Hộ kinh doanh Medi Den - Đặng Hùng Anh</li>
            <li><b>1.2. Địa chỉ trụ sở:</b> 118 Đ. Phương Canh, Nam Từ Liêm, Hà Nội, Việt Nam</li>
            <li><b>1.3. Số điện thoại liên hệ:</b> 08 2222 1992</li>
            <li><b>1.4. Mã số hộ kinh doanh:</b> 2392170447</li>
            <li><b>1.5. Mã số đăng kí kinh doanh:</b> 81A8029459</li>
        </ul>

        <!-- Box liên hệ & Mạng xã hội nền hồng viền đứt đoạn -->
        <div class="pink-contact-box">
            <strong>Kênh thông tin CHÍNH THỨC VÀ DUY NHẤT:</strong>

            <a href="http://localhost:8080/giay/hien-thi" class="social-link">
                <i class="fas fa-globe"></i> <b>Website:</b> Medi Den Online
            </a>

            <a href="https://www.facebook.com/dang.hung.anh.887452" class="social-link" target="_blank">
                <i class="fab fa-facebook"></i> <b>Facebook:</b> Medi Den - Đặng Hùng Anh
            </a>

            <a href="https://www.youtube.com/@nercatto-w6n" class="social-link" target="_blank">
                <i class="fab fa-youtube"></i> <b>YouTube:</b> Medi Den Official
            </a>

            <a href="https://www.instagram.com/noobbon3793/" class="social-link" target="_blank">
                <i class="fab fa-instagram"></i> <b>Instagram:</b> Medi Den Sneaker
            </a>

            <div class="contact-details">
                <p><i class="fas fa-envelope" style="color: #ff1493;"></i> <b>Email:</b> MediDen8888@gmail.com</p>
                <p><i class="fas fa-headset" style="color: #ff1493;"></i> <b>Hotline hỗ trợ:</b> 08 2222 1992</p>
            </div>
        </div>
    </div>
</main>

<footer>
    <div class="footer-brands">
        <div class="brand-item"><img src="https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_NIKE.svg"
                                     alt="Nike"></div>
        <div class="brand-item"><img src="https://upload.wikimedia.org/wikipedia/commons/2/20/Adidas_Logo.svg"
                                     alt="Adidas"></div>
        <div class="brand-item"><img src="https://upload.wikimedia.org/wikipedia/en/3/37/Jumpman_logo.svg"
                                     alt="Jordan"></div>
        <div class="brand-item"><img
                src="https://upload.wikimedia.org/wikipedia/commons/8/88/Puma_complete_logo.svg" alt="Puma"></div>
        <div class="brand-item"><img src="https://upload.wikimedia.org/wikipedia/commons/5/53/New_Balance_logo.svg"
                                     alt="NB"></div>
    </div>

    <hr class="footer-divider">

    <div class="footer-container">
        <!-- Cột 1: Liên hệ -->
        <div class="footer-col">
            <div class="info-item">
                <i class="fas fa-map-marker-alt"></i>
                <p>Địa chỉ: 118 Đ.Phương Canh,Nam Từ Liêm, Hà Nội.</p>
            </div>
            <div class="info-item">
                <i class="fas fa-phone-alt"></i>
                <p>Hotline: 08 2222 1992</p>
            </div>
            <div class="info-item">
                <i class="fas fa-envelope"></i>
                <p>Email: MediDen8888@gmail.com</p>
            </div>
        </div>

        <!-- Cột 2: Chính sách -->
        <div class="footer-col">
            <h4>CHÍNH SÁCH</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/giay/hien-thi">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/view/gioi-thieu.jsp">Giới thiệu</a></li>
                <li><a href="${pageContext.request.contextPath}/view/chinh-sach-bao-mat.jsp">Chính sách bảo mật</a></li>

            </ul>
        </div>

        <!-- Cột 3: Hỗ trợ -->
        <div class="footer-col">
            <h4>HỖ TRỢ KHÁCH HÀNG</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/view/dieu-khoan-dich-vu.jsp">Điều khoản dịch vụ</a></li>
                <li><a href="${pageContext.request.contextPath}/view/chinh-sach-giao-nhan.jsp">Chính sách giao nhận</a></li>
                <li><a href="${pageContext.request.contextPath}/view/chinh-sach-doi-tra.jsp">Chính sách đổi trả</a></li>
                <li><a href="${pageContext.request.contextPath}/view/chinh-sach-thanh-toan.jsp">Chính sách thanh toán</a></li>
            </ul>
        </div>

        <!-- Cột 4: Đăng ký -->
        <div class="footer-col">
            <h4>ĐĂNG KÝ NHẬN TIN</h4>
            <div class="subscribe-form">
                <input type="email" placeholder="Nhập địa chỉ email">
                <button>Đăng ký</button>
            </div>
            <div class="social-icons">
                <a href="https://www.facebook.com/dang.hung.anh.887452"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.instagram.com/accounts/login/?next=%2Fnoobbon3793%2F&source=omni_redirect"><i
                        class="fab fa-instagram"></i></a>
                <a href="https://www.youtube.com/@nercatto-w6n"><i class="fa-brands fa-youtube"></i>
                </a>

            </div>
        </div>
    </div>
</footer>

</body>
</html>