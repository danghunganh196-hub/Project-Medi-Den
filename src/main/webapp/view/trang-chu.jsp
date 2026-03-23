<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 3/19/2026
  Time: 10:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Medi Den</title>
    <meta charset="UTF-8">
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header>
    <style>
        /* --- 1. Reset & Cài đặt chung --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f9f9f9;
            color: #333;
            line-height: 1.6;
        }

        /* --- 2. Header & Navigation --- */
        header {
            background-color: #e91e63;
            /* Màu hồng chủ đạo */
            color: white;
            padding: 10px 5%;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .top-bar {
            text-align: right;
            font-size: 13px;
            margin-bottom: 8px;
            opacity: 0.9;
        }

        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            /* Đẩy Logo - Menu - Search ra 3 phần */
            gap: 20px;
        }

        /* Cụm Logo */
        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
            text-decoration: none;
        }

        .logo img {
            height: 90px;
            /* Độ cao logo - bạn có thể tăng lên 120px tùy ý */
            width: auto;
            border-radius: 15px;
            background: white;
            padding: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s;
        }

        .logo img:hover {
            transform: scale(1.05);
        }

        .logo h1 {
            font-size: 30px;
            color: white;
            font-weight: 800;
            letter-spacing: -1px;
        }

        /* Menu chính */
        .nav-links {
            list-style: none;
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            transition: 0.3s;
            padding: 5px 0;
            border-bottom: 2px solid transparent;
        }

        .nav-links a:hover {
            border-bottom: 2px solid white;
        }

        /* Ô tìm kiếm */
        .search-box {
            display: flex;
            background: white;
            border-radius: 25px;
            padding: 4px 4px 4px 15px;
            min-width: 250px;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .search-box input {
            border: none;
            outline: none;
            flex: 1;
            font-size: 14px;
        }

        .search-box button {
            background: #ad1457;
            color: white;
            border: none;
            padding: 8px 18px;
            border-radius: 20px;
            cursor: pointer;
            transition: 0.3s;
        }

        .search-box button:hover {
            background: #333;
        }

        .container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            padding: 40px 5%;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }
        .sidebar {
            display: flex;
            flex-direction: column;
            gap: 25px;

            /* Cấu hình đứng im tuyệt đối */
            position: fixed;
            left: 20px;            /* Cách lề trái màn hình 20px */
            top: 150px;            /* Cách lề trên màn hình 150px (để không đè vào Header) */
            z-index: 100;          /* Đảm bảo nó luôn nằm trên các lớp khác */
        }

        .icon-btn {
            font-size: 26px;
            color: #555;
            cursor: pointer;
            transition: 0.3s;
        }

        .icon-btn:hover {
            color: #e91e63;
            transform: scale(1.2);
        }
        .product-card {
            background: white;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: 0.3s;
            border: 1px solid #eee;
            width: 100%;             /* Luôn rộng bằng ô Grid chứa nó */
        }
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .product-img {
            width: 100%;             /* Khung chứa ảnh rộng 100% card */
            margin-bottom: 15px;
        }

        .product-img img {
            width: 100%;             /* SỬA LỖI: Không để 275px nữa mà để 100% */
            display: block;
            aspect-ratio: 1/1;       /* Giữ ảnh luôn là hình vuông */
            object-fit: cover;
            border-radius: 15px;
        }

        .product-card h3 {
            font-size: 18px;
            color: #222;
            margin-bottom: 10px;
            text-align: center;
        }
        .price {
            color: #e91e63;
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 15px;
        }

        .add-cart {
            background: #333;
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 10px;
            font-weight: 600;
            width: 100%;
            transition: 0.3s;
        }

        .add-cart:hover {
            background: #e91e63;
        }

        /* --- 5. Responsive (Cho điện thoại) --- */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
            }

            .container {
                flex-direction: column;
            }

            .nav-links {
                gap: 10px;
                font-size: 14px;
            }
        }

        .slidechuyen {
            width: 100%;
            height: 450px;
            /* Độ cao của banner */
            margin-top: 10px;
            overflow: hidden;
        }

        .swiper {
            width: 100%;
            height: 100%;
        }

        .swiper-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            /* Giúp ảnh phủ kín khung mà không bị móp */
        }

        /* Tùy chỉnh màu sắc nút điều hướng theo tone hồng của bạn */
        .swiper-button-next,
        .swiper-button-prev {
            color: #e91e63 !important;
            padding: 30px;
            border-radius: 15px;
        }

        .swiper-button-next:hover,
        .swiper-button-prev:hover {
            transition: all 0.3s ease;
            background-color: rgb(83, 82, 82);
        }

        .swiper-pagination-bullet-active {
            background: #e91e63 !important;
        }
        /* Container bao ngoài */
        .services-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 30px 5%;
            background-color: #fff;
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
            margin: 20px 0;
            flex-wrap: wrap; /* Tự xuống hàng nếu màn hình nhỏ */
            gap: 20px;
        }

        /* Từng mục nhỏ */
        .service-item {
            display: flex;
            align-items: center;
            gap: 15px;
            flex: 1; /* Chia đều chiều rộng cho 4 cột */
            min-width: 200px;
        }

        /* Vòng tròn chứa icon */
        .service-icon {
            width: 55px;
            height: 55px;
            border: 1.5px solid #91b3d1; /* Màu xanh nhạt như hình */
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 22px;
            color: #91b3d1;
            flex-shrink: 0; /* Không cho vòng tròn bị bóp méo */
        }

        /* Phần chữ */
        .service-text h3 {
            font-size: 15px;
            font-weight: 600;
            color: #333;
            margin-bottom: 4px;
        }

        .service-text p {
            font-size: 13px;
            color: #777;
            margin: 0;
        }
        .title{
            text-align: center;
        }
        /* Responsive cho điện thoại */
        @media (max-width: 768px) {
            .services-container {
                display: grid;
                grid-template-columns: 1fr 1fr; /* Chia 2 cột trên mobile */
            }
        }
        footer {
            background-color: #e91e63; /* Màu hồng chủ đạo */
            color: white;
            padding: 60px 5% 40px;
            width: 100%;
            margin-top: 50px;
        }

        /* Dàn hàng ngang logo các hãng */
        .footer-brands {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 60px; /* Khoảng cách giữa các logo */
            padding-bottom: 30px;
            flex-wrap: wrap;
        }

        .brand-item img {
            height: 35px;
            width: auto;
            /* Biến logo gốc thành màu trắng cho sang trên nền hồng */
            filter: brightness(0) invert(1);
            opacity: 0.8;
            transition: 0.3s;
        }

        .brand-item img:hover {
            opacity: 1;
            transform: scale(1.1);
        }

        .footer-divider {
            border: 0;
            height: 1px;
            background: rgba(255, 255, 255, 0.2);
            margin-bottom: 40px;
        }

        /* Bố cục 4 cột */
        .footer-container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 30px;
        }

        .footer-col {
            flex: 1;
            min-width: 250px;
        }

        .footer-col h4 {
            margin-bottom: 25px;
            font-size: 16px;
            font-weight: bold;
        }

        .footer-col ul {
            list-style: none;
            padding: 0;
        }

        .footer-col ul li {
            margin-bottom: 12px;
        }

        .footer-col ul li a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: 0.3s;
        }

        .footer-col ul li a:hover {
            color: white;
            padding-left: 5px;
        }

        /* Form đăng ký nhận tin */
        .subscribe-form {
            display: flex;
            background: white;
            border-radius: 25px;
            padding: 3px;
            margin-bottom: 20px;
        }

        .subscribe-form input {
            border: none;
            outline: none;
            padding: 10px 15px;
            flex: 1;
            border-radius: 25px;
        }

        .subscribe-form button {
            background: #333;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-weight: bold;
        }

        /* Icon MXH */
        .social-icons {
            display: flex;
            gap: 15px;
        }

        .social-icons a {
            width: 35px;
            height: 35px;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            color: white;
            text-decoration: none;
            transition: 0.3s;
        }

        .social-icons a:hover {
            background: white;
            color: #e91e63;
        }
    </style>

    <script>
        function openModal(name, price, img, desc) {
            document.getElementById("modalName").innerText = name;
            document.getElementById("modalPrice").innerText = price;
            document.getElementById("modalImg").src = img;
            document.getElementById("modalDesc").innerText = desc;
            document.getElementById("productModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("productModal").style.display = "none";
        }

        // Đóng modal khi click ra ngoài vùng trắng
        window.onclick = function(event) {
            let modal = document.getElementById("productModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        document.addEventListener("DOMContentLoaded", function () {
            const swiper = new Swiper('.swiper', {
                loop: true,
                effect: 'fade',
                autoplay: {
                    delay: 3000,
                    disableOnInteraction: false,
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
            });
        });    </script>
    <div class="top-bar">Đăng nhập | Đăng ký</div>
    <nav class="navbar">
        <div class="logo">

            <img src="/images/logo/Screenshot 2026-03-19 014252.png" style="border-radius: 20px;" width="20%"
                 alt="Logo">
            <h1>Medi Den</h1>
        </div>
        <ul class="nav-links">
            <li><a href="#">Giày Thể Thao</a></li>
            <li><a href="#">Giày Thời Trang</a></li>
            <li><a href="#">Giày Thể Thao</a></li>
            <li><a href="#">Giày Thời Trang</a></li>

        </ul>
        <div class="search-box">
            <input type="text" placeholder="Tìm kiếm...">
            <button><i class="fas fa-search"></i></button>
        </div>
    </nav>

</header>
<div class="slidechuyen">
    <div class="swiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide"><img src="https://images.unsplash.com/photo-1552346154-21d32810aba3"
                                           alt="Banner 1"></div>
            <div class="swiper-slide"><img src="https://www.elleman.vn/app/uploads/2018/08/13/gi%C3%A0y-sneakers-2-elle-man-8.jpg" alt="Banner 2"></div>
            <div class="swiper-slide"><img src="https://png.pngtree.com/thumb_back/fh260/background/20220929/pngtree-shoes-promotion-banner-background-image_1466238.jpg"
                                           alt="Banner 3"></div>
        </div>
        <div class="swiper-pagination"></div>

        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
    </div>
</div>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<aside class="sidebar">
    <div class="icon-btn"><i class="fas fa-shopping-cart"></i></div>
    <div class="icon-btn"><i class="fas fa-cog"></i></div>
</aside>
<div class="content">
    <div class="services-container">
        <!-- Mục 1 -->
        <div class="service-item">
            <div class="service-icon">
                <i class="fas fa-truck"></i>
            </div>
            <div class="service-text">
                <h3>Vận chuyển toàn quốc</h3>
                <p>Vận chuyển nhanh chóng</p>
            </div>
        </div>

        <!-- Mục 2 -->
        <div class="service-item">
            <div class="service-icon">
                <i class="fas fa-gift"></i>
            </div>
            <div class="service-text">
                <h3>Ưu đãi hấp dẫn</h3>
                <p>Nhiều ưu đãi khuyến mãi hot</p>
            </div>
        </div>

        <!-- Mục 3 -->
        <div class="service-item">
            <div class="service-icon">
                <i class="fas fa-award"></i>
            </div>
            <div class="service-text">
                <h3>Bảo đảm chất lượng</h3>
                <p>Sản phẩm đã được kiểm định</p>
            </div>
        </div>

        <!-- Mục 4 -->
        <div class="service-item">
            <div class="service-icon">
                <i class="fas fa-headset"></i>
            </div>
            <div class="service-text">
                <h3>Hotline: 0999999999</h3>
                <p>Vui lòng gọi hotline để hỗ trợ</p>
            </div>
        </div>
    </div>
</div>
<h1 class="title">GIÀY CHÍNH HÃNG NIKE</h1>
<main class="container">
    <c:forEach var="sp" items="${listGiay}">
        <div class="product-card">
            <div class="product-img">
                <img src="${sp.hinhAnh}" alt="${sp.tenGiay}">
            </div>
            <h3>${sp.tenGiay}</h3>
            <p class="price">${sp.gia} VNĐ</p>
            <button class="add-cart">Xem chi tiết</button>
        </div>
    </c:forEach>
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
                <p>Địa chỉ: Số 48 ngách 26 ngõ Thái Thịnh 2, Đống Đa, Hà Nội.</p>
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
                <li><a href="#">Trang chủ</a></li>
                <li><a href="#">Sản phẩm</a></li>
                <li><a href="#">Chính sách bảo mật</a></li>
                <li><a href="#">Điều khoản dịch vụ</a></li>
            </ul>
        </div>

        <!-- Cột 3: Hỗ trợ -->
        <div class="footer-col">
            <h4>HỖ TRỢ KHÁCH HÀNG</h4>
            <ul>
                <li><a href="#">Tìm kiếm</a></li>
                <li><a href="#">Chính sách đổi trả</a></li>
                <li><a href="#">Chính sách thanh toán</a></li>
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
                <a href="https://www.instagram.com/accounts/login/?next=%2Fnoobbon3793%2F&source=omni_redirect"><i class="fab fa-instagram"></i></a>
                <a href="https://www.youtube.com/@nercatto-w6n"><i class="fa-brands fa-youtube"></i>
                </a>

            </div>
        </div>
    </div>
</footer>
</body>
</html>
