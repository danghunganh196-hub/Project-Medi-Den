<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 3/19/2026
  Time: 10:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<header>
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
            <div class="swiper-slide"><img
                    src="https://www.elleman.vn/app/uploads/2018/08/13/gi%C3%A0y-sneakers-2-elle-man-8.jpg"
                    alt="Banner 2"></div>
            <div class="swiper-slide"><img
                    src="https://png.pngtree.com/thumb_back/fh260/background/20220929/pngtree-shoes-promotion-banner-background-image_1466238.jpg"
                    alt="Banner 3"></div>
        </div>
        <div class="swiper-pagination"></div>

        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
    </div>
</div>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<aside class="sidebar">
    <!-- Thêm id và thẻ số lượng vào đây -->
    <div class="icon-btn" id="cart-icon">
        <i class="fas fa-shopping-cart"></i>
        <span id="cart-count">0</span> <!-- Số nhảy ở đây -->
    </div>
    <div class="icon-btn"><i class="fas fa-cog"></i></div>
</aside>

<div id="mini-cart" class="mini-cart">
    <div class="cart-header">
        <h3>GIỎ HÀNG</h3>
        <span class="close-mini-cart" onclick="toggleCart()">&times;</span>
    </div>

    <div id="cart-items-list">
        <!-- Sản phẩm sẽ tự động hiện ở đây qua JavaScript -->
    </div>

    <div class="cart-footer">
        <div class="total-price">
            <span>TỔNG TIỀN:</span>
            <span id="cart-total-amount">0đ</span>
        </div>
        <button class="btn-checkout">THANH TOÁN</button>
    </div>
</div>
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
            <p class="price">
                <fmt:formatNumber value="${sp.gia}" pattern="#,###" /> VNĐ
            </p>
            <button class="add-cart"
                    onclick="openModal('${sp.tenGiay}', '${sp.gia}', '${sp.hinhAnh}', '${sp.thuongHieu}')">
                Xem chi tiết
            </button>
        </div> </c:forEach>
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
                <a href="https://www.instagram.com/accounts/login/?next=%2Fnoobbon3793%2F&source=omni_redirect"><i
                        class="fab fa-instagram"></i></a>
                <a href="https://www.youtube.com/@nercatto-w6n"><i class="fa-brands fa-youtube"></i>
                </a>

            </div>
        </div>
    </div>
</footer>
<script src="${pageContext.request.contextPath}/view/script.js"></script>
</body>
</html>