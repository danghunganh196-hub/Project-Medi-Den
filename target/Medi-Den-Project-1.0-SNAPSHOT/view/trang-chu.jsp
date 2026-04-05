<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %><%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 3/19/2026
  Time: 10:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>

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
        <!-- Đảm bảo sizeString không rỗng -->
        <c:set var="sizeStr" value="${sp.sizeString}" />
        <c:if test="${empty sizeStr}">
            <c:set var="sizeStr" value="" />
        </c:if>

        <div class="product-card">
            <div class="product-img">
                <img src="${sp.hinhAnh}" alt="${sp.tenGiay}">
            </div>
            <h3>${sp.tenGiay}</h3>
            <p class="price"><fmt:formatNumber value="${sp.gia}" pattern="#,###"/> VNĐ</p>

            <button class="add-cart"
                    onclick="openProductModal(this)"
                    data-id="${sp.id}"
                    data-name="${sp.tenGiay}"
                    data-price="${sp.gia}"
                    data-img="${sp.hinhAnh}"
                    data-brand="${sp.thuongHieu}"
                    data-size="${sizeStr}">
                Xem chi tiết
            </button>
        </div>
    </c:forEach>
</main>

<div id="productModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <div class="modal-body">
            <div class="modal-left">
                <img id="modalImg" src="" alt="Sản phẩm">
            </div>
            <div class="modal-right">
                <h2 id="modalName">Tên sản phẩm</h2>
                <p class="brand-info">Thương hiệu: <span id="modalBrand"></span></p>
                <div class="modal-price-container">
                    <span id="modalPrice" class="price-main"></span>
                </div>

                <p id="modalDesc"></p>

                <p>Chọn kích cỡ (Size):</p>
                <div class="size-options" id="modalSizeContainer"></div>

                <div class="modal-actions">
                    <button class="btn-buy-now" onclick="buyNowFromModal()">MUA NGAY</button>
                    <button class="btn-add-to-cart" onclick="addToCart()">THÊM VÀO GIỎ</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- PHẦN THANH TOÁN 3 BƯỚC (Dán vào đây) -->
<div id="checkout-modal" class="modal">
    <div class="modal-content checkout-container">
        <span class="close-btn" onclick="closeCheckout()">&times;</span>

        <div class="checkout-layout">
            <!-- Cột trái: Các bước nhập liệu -->
            <div class="checkout-main">
                <!-- Bước 1: Thông tin -->
                <div id="step-1" class="checkout-step active">
                    <h2 class="pink-title">Thông tin giao hàng</h2>
                    <form id="form-info">
                        <div class="input-group">
                            <input type="text" id="fullname" placeholder="Họ và tên" class="pink-input">
                            <small class="error-msg" id="name-error"></small>
                        </div>

                        <div class="row-flex">
                            <div class="input-group">
                                <input type="email" id="email" placeholder="Email" class="pink-input">
                                <small class="error-msg" id="email-error"></small>
                            </div>
                            <div class="input-group">
                                <input type="tel" id="phone" placeholder="Số điện thoại" class="pink-input">
                                <small class="error-msg" id="phone-error"></small>
                            </div>
                        </div>

                        <div class="input-group">
                            <input type="text" id="address" placeholder="Địa chỉ nhận hàng" class="pink-input">
                            <small class="error-msg" id="address-error"></small>
                        </div>

                        <button type="button" class="btn-pink-large" onclick="validateStep1()">TIẾP TỤC ĐẾN PHƯƠNG
                            THỨC THANH TOÁN</button>
                    </form>
                </div>

                <!-- Bước 2: Thanh toán -->
                <div id="step-2" class="checkout-step">
                    <h3 class="pink-title">Phương thức vận chuyển</h3>
                    <div class="shipping-box">
                        <label>
                            <input type="radio" name="shipping" value="35000" checked>
                            <span>Giao hàng tận nơi - 35,000đ</span>
                        </label>
                    </div>

                    <h3 class="pink-title">Phương thức thanh toán</h3>
                    <div class="payment-methods">
                        <label class="payment-item">
                            <input type="radio" name="payment" value="COD" checked onclick="toggleBankInfo(false)">
                            <span>Thanh toán khi giao hàng (COD)</span>
                        </label>

                        <label class="payment-item">
                            <input type="radio" name="payment" value="Bank" onclick="toggleBankInfo(true)">
                            <span>Chuyển khoản qua ngân hàng</span>
                        </label>

                        <div id="bank-info" class="bank-details-box" style="display: none; margin-top: 10px; padding: 10px; border: 1px dashed #ff69b4; background: #fffafb;">
                            <p style="color: #d81b60; font-weight: bold;">Thông tin chuyển khoản:</p>
                            <p>Ngân hàng: <strong>Techcombank</strong></p>
                            <p>STK: <strong>19061706200888</strong></p>
                            <p>Chủ TK: <strong>DANG HUNG ANH</strong></p>
                            <p class="note" style="font-size: 0.9em; font-style: italic;">*Nội dung: [Họ tên + SĐT đặt hàng]</p>
                        </div>
                    </div>

                    <button type="button" class="btn-pink-large" onclick="completeOrder()">HOÀN TẤT ĐƠN HÀNG</button>
                </div>

                <!-- Bước 3: Hoàn tất -->
                <div id="step-3" class="checkout-step text-center">
                    <div class="success-icon">♥</div>
                    <h2 class="pink-title">Đặt hàng thành công!</h2>
                    <p>Cảm ơn bạn đã tin tưởng <strong>Medi Den</strong>.</p>
                    <div class="order-info-summary">
                        <p><strong>Người nhận:</strong> <span id="res-name"></span></p>
                        <p><strong>Số điện thoại:</strong> <span id="res-phone"></span></p>
                        <p><strong>Địa chỉ:</strong> <span id="res-address"></span></p>
                        <p><strong>Thanh toán:</strong> <span id="res-payment"></span></p>
                    </div>
                    <button class="btn-pink-large" onclick="location.reload()">TIẾP TỤC MUA SẮM</button>
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
<script>
    window.isLoggedIn = <%= session.getAttribute("user") != null %>;
    window.contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/view/script.js"></script>
</body>
</html>