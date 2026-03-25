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
        .top-bar .btn {
            position: relative;
            text-decoration: none;
            color: white;
            font-size: 13px;
            padding: 7px;
            border-radius: 12px;
        }

        .top-bar .btn::after {
            content: "";
            position: absolute;
            left: 0;
            bottom: -2px;
            width: 0%;
            height: 2px;
            background: currentColor;
        }

        /* Hover là hiện ngay lập tức */
        .top-bar .btn:hover::after {
            width: 100%;
        }
        /* hover -> chạy từ trái sang phải */
        .top-bar .btn:hover::after {
            width: 100%;
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
        .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);
        }

        /* Khung trắng chứa nội dung */
        .modal-content {
            background-color: #fff;
            margin: 5% auto;
            padding: 30px;
            width: 80%;
            max-width: 900px;
            border-radius: 8px;
            position: relative;
        }

        .modal-body {
            display: flex;
            gap: 30px;
        }

        .modal-left { flex: 1; }
        .modal-left img {
            width: 100%;
            border-radius: 5px;
        }

        .modal-right { flex: 1.2; }

        /* Tên và giá */
        #modalName { font-size: 22px; color: #333; margin-bottom: 10px; }
        .price-main { font-size: 28px; color: #d70018; font-weight: bold; }
        .product-description { margin: 15px 0; font-size: 14px; color: #666; }

        /* Nút chọn size */
        .size-options button {
            padding: 8px 15px;
            border: 1px solid #ddd;
            background: #fff;
            margin-right: 5px;
            cursor: pointer;
        }
        .size-options button:hover { border-color: #e91e63; color: #e91e63; }

        /* Nút mua hàng màu đỏ giống ảnh mẫu */
        .modal-actions { display: flex; gap: 10px; margin-top: 20px; }
        /* Nút Mua Ngay trong Modal sản phẩm */
        .btn-buy-now {
            background-color: #ff2d81; /* Màu hồng đậm hơn để kích thích mua hàng */
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            line-height: 1.2;
        }

        .btn-buy-now span {
            font-size: 11px;
            font-weight: normal;
            display: block;
            margin-top: 4px;
            opacity: 0.9;
        }

        .btn-buy-now:hover {
            background-color: #e91e63;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(233, 30, 99, 0.4);
        }


        /* Nút đóng (X) */
        .close-btn {
            position: absolute; right: 15px; top: 10px;
            font-size: 25px; cursor: pointer; color: #888;
        }
        /* --- CSS cho Menu Dropdown --- */

        /* Đảm bảo menu cha là điểm tựa */
        .nav-links li {
            position: relative;
        }

        /* Kiểu dáng cho menu con (ẩn mặc định) */
        .dropdown-content {
            display: none; /* Ẩn đi */
            position: absolute;
            top: 100%; /* Hiện ngay bên dưới menu cha */
            left: 0;
            background-color: white;
            min-width: 200px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1000;
            list-style: none;
            padding: 0;
            border-radius: 0 0 5px 5px;
        }

        /* Kiểu dáng từng dòng trong menu con */
        .dropdown-content li {
            border-bottom: 1px solid #eee;
        }

        .dropdown-content li a {
            color: #333 !important; /* Chữ màu đen trên nền trắng */
            padding: 12px 16px;
            display: block;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: 0.3s;
        }

        /* Hiệu ứng khi di chuột vào từng dòng của menu con */
        .dropdown-content li a:hover {
            background-color: #f1f1f1;
            color: #e91e63 !important; /* Đổi màu chữ sang hồng khi hover */
            padding-left: 20px;
        }

        /* QUAN TRỌNG: Hiện menu con khi di chuột vào li cha */
        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* Thêm icon mũi tên nhỏ cho đẹp */
        .nav-links a i {
            font-size: 12px;
            margin-left: 5px;
        }

        /* Container bao bọc toàn bộ phần sản phẩm */
        .category-block {
            max-width: 1500px;
            margin: 40px auto;
            padding: 0 15px;
        }

        /* Lưới sản phẩm - Tự động xuống dòng khi đủ 4 cái */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 cột đều nhau */
            gap: 40px; /* Khoảng cách giữa các đôi giày */
        }

        /* Ẩn các sản phẩm hàng thứ 2 */
        .hidden-item {
            display: none;
        }

        /* Nút xem thêm thiết kế theo mẫu hiện đại */
        .load-more-wrapper {
            text-align: center;
            margin-top: 30px;
        }

        .btn-load-more {
            padding: 12px 35px;
            background-color: transparent;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-load-more:hover {
            border-color: #e91e63;
            color: #e91e63;
            background-color: #fff5f8;
        }

        /* Responsive cho điện thoại (Hiện 2 cột để không bị bé quá) */
        @media (max-width: 768px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        /* Số lượng trên icon giỏ hàng */
        #cart-icon {
            position: relative;
        }

        #cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: red;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border-radius: 50%;
            font-weight: bold;
        }

        /* Nút Thêm vào giỏ trong Modal */
        .btn-add-to-cart {
            background-color: #333; /* Màu đen xám giống ảnh mẫu */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-add-to-cart span {
            font-size: 11px;
            opacity: 0.8;
        }

        .btn-add-to-cart:hover {
            background-color: #555;
        }

        /* Khung giỏ hàng nhanh */
        .mini-cart {
            position: fixed;
            right: -400px; /* Ẩn đi mặc định */
            top: 0;
            width: 350px;
            height: 100vh;
            background: white;
            box-shadow: -2px 0 10px rgba(0,0,0,0.1);
            z-index: 1000;
            transition: 0.4s;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .mini-cart.active {
            right: 0; /* Hiện ra khi có class active */
        }

        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
        }

        /* Danh sách sản phẩm */
        #cart-items-list {
            flex-grow: 1;
            overflow-y: auto;
            padding: 15px 0;
        }

        .cart-item {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #ddd;
            position: relative;
        }

        .cart-item img {
            width: 70px;
            height: 70px;
            object-fit: cover;
        }

        .item-info h4 { font-size: 14px; margin-bottom: 5px; padding-right: 20px; }
        .item-info .item-qty {
            border: 1px solid #ddd;
            padding: 2px 8px;
            margin-right: 10px;
            font-size: 13px;
        }
        .item-info .item-price { color: red; font-weight: bold; }

        .remove-item {
            position: absolute;
            right: 0; top: 0;
            cursor: pointer;
            font-weight: bold;
        }

        /* Footer & Nút bấm */
        .cart-footer { border-top: 2px solid #eee; padding-top: 15px; }
        .total-price {
            display: flex;
            justify-content: space-between;
            font-weight: bold;
            margin-bottom: 15px;
        }
        #cart-total-amount { color: red; font-size: 18px; }

        .btn-checkout {
            width: 100%;
            padding: 12px;
            background: black;
            color: white;
            border: none;
            font-weight: bold;
            cursor: pointer;
        }

        /* Màu chủ đạo hồng */
        :root {
            --main-color: #ff69b4;
            --hover-color: #ff1493;
        }

        /* Nút bấm và các thành phần màu xanh cũ */
        .btn-checkout, .btn-submit, .btn-next, .btn-buy-now,
        #cart-count, .radio-input:checked + .radio-label::before {
            background-color: var(--main-color) !important;
            border-color: var(--main-color) !important;
            color: white !important;
        }

        /* Hiệu ứng Hover */
        .btn-checkout:hover, .btn-buy-now:hover, .btn-next:hover {
            background-color: var(--hover-color) !important;
        }

        /* Màu chữ liên kết và các icon */
        a, .price, .item-price, #cart-total-amount {
            color: var(--main-color);
        }

        /* Loại bỏ chữ Giỏ hàng cạnh nút điều hướng */
        .cart-link-back, .giỏ-hàng-text {
            display: none !important;
        }

        .checkout-step { display: none; }
        .checkout-step.active { display: block; }

        .pink-title { color: #ff69b4; margin-bottom: 20px; text-transform: uppercase; }

        .btn-pink-large {
            background-color: #ff69b4;
            color: white;
            border: none;
            padding: 15px 25px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            margin-top: 20px;
            transition: 0.3s;
        }

        .btn-pink-large:hover { background-color: #ff1493; }

        .pink-input {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ffc0cb;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .bank-details-box {
            background: #fff0f5;
            padding: 15px;
            border-left: 4px solid #ff69b4;
            margin-top: 10px;
            display: none;
        }

        .success-icon {
            font-size: 60px;
            color: #ff69b4;
            margin-bottom: 10px;
        }

        .input-group {
            margin-bottom: 10px;
            width: 100%;
            display: flex;
            flex-direction: column;
        }

        .error-msg {
            color: #ff0000; /* Màu đỏ cảnh báo */
            font-size: 12px;
            margin-top: -10px;
            margin-bottom: 10px;
            text-align: left;
            font-weight: 500;
        }

        /* Đổi viền input thành màu đỏ khi có lỗi (Optional - Thêm bằng JS nếu muốn) */
        .pink-input:focus {
            border-color: #ff69b4;
            outline: none;
            box-shadow: 0 0 5px rgba(255, 105, 180, 0.3);
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
        function openModal(img, name, price) {
            document.getElementById('modalImg').src = img;
            document.getElementById('modalName').textContent = name;
            document.getElementById('modalPrice').textContent = price + ' VNĐ';
            document.getElementById('productModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('productModal').style.display = 'none';
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
    <div class="top-bar">
        <a class="btn login" href="view/dang-nhap.jsp">Đăng nhập</a>
        <a class="btn register" href="view/dang-ky.jsp">Đăng ký</a>
    </div>
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
            <button class="add-cart" onclick="openModal('${sp.hinhAnh}', '${sp.tenGiay}', '${sp.gia}')">Xem chi tiết</button>        </div>
    </c:forEach>
</main>
<div id="productModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <div class="modal-body">
            <!-- Bên trái: Ảnh lớn -->
            <div class="modal-left">
                <img id="modalImg" src="" alt="Sản phẩm">
            </div>

            <!-- Bên phải: Thông tin chi tiết -->
            <div class="modal-right">
                <h2 id="modalName">Tên sản phẩm</h2>
                <p class="brand-info">Thương hiệu: <span id="modalBrand">Chính hãng</span> | Tình trạng: <span>Còn
                            hàng</span></p>
                <div class="modal-price-container">
                    <span id="modalPrice" class="price-main">0đ</span>
                </div>

                <p id="modalDesc" class="product-description"></p>

                <div class="size-section">
                    <h4>Kích thước:</h4>
                    <div class="size-options">
                        <button>40.5</button>
                        <button>42</button>
                        <button>42.5</button>
                    </div>
                </div>

                <div class="quantity-section">
                    <h4>Số lượng:</h4>
                    <div class="qty-input">
                        <button>-</button>
                        <input type="number" value="1" min="1">
                        <button>+</button>
                    </div>
                </div>

                <div class="modal-actions">
                    <button class="btn-buy-now" onclick="buyNowFromModal()">
                        MUA NGAY <br><span>Giao hàng thanh toán (COD)</span>
                    </button>

                    <button class="btn-add-to-cart" onclick="addToCart()">THÊM VÀO GIỎ <br><span>Thêm để mua
                                sau</span></button>
                </div>
            </div>
        </div>
    </div>
</div>
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
