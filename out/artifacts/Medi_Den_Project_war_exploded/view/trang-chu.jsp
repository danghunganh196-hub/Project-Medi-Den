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

<html>
<head>
    <title>Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- ✅ SWIPER CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>

    <!-- ❗ SWIPER JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <style>
        /* ---------- Brand section wrapper ---------- */
        .brand-section {
            padding: 40px 5%;
            max-width: 1400px;
            margin: 0 auto;
        }
        .brand-section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            border-bottom: 3px solid #e91e63;
            padding-bottom: 12px;
        }
        .brand-section-header h2 {
            font-size: 1.6rem;
            font-weight: 800;
            color: #222;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .brand-section-header a {
            color: #e91e63;
            font-weight: 600;
            text-decoration: none;
            font-size: 0.95rem;
            transition: 0.2s;
        }
        .brand-section-header a:hover { text-decoration: underline; }

        /* ---------- Horizontal scroll row ---------- */
        .product-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        @media (max-width: 1100px) { .product-row { grid-template-columns: repeat(3, 1fr); } }
        @media (max-width: 768px)  { .product-row { grid-template-columns: repeat(2, 1fr); } }

        /* ---------- Skeleton loader ---------- */
        .skeleton-card {
            background: #fff;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .skeleton-img  { width: 100%; height: 200px; background: #f0f0f0; border-radius: 10px; animation: pulse 1.4s ease-in-out infinite; }
        .skeleton-line { height: 16px; background: #f0f0f0; border-radius: 8px; animation: pulse 1.4s ease-in-out infinite; }
        .skeleton-line.short { width: 55%; }
        .skeleton-line.btn   { height: 36px; margin-top: 8px; }
        @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:.45} }

        /* ---------- Divider giữa các section ---------- */
        .section-divider {
            height: 6px;
            background: linear-gradient(90deg, #e91e63 0%, #ff80ab 50%, #e91e63 100%);
            margin: 10px 0;
            opacity: .15;
            border-radius: 3px;
        }
    </style>
</head>
<!-- TOAST -->
<div id="toast" style="
    position: fixed;
    top: 20px;
    right: 20px;
    background: #4CAF50;
    color: white;
    padding: 12px 20px;
    border-radius: 6px;
    display: none;
    z-index: 9999;
    font-weight: bold;
">
    ✅ Đã thêm vào giỏ hàng!
</div>
<body>
<header>
    <div class="top-bar">
        <%
            TaiKhoan user = (TaiKhoan) session.getAttribute("user");
            if (user == null) {
        %>
        <a class="btn login" href="/login">Đăng nhập</a>
        <a class="btn register" href="/register">Đăng ký</a>
        <%
        } else {
        %>
        <span>Xin chào, <b><%= user.getUsername() %></b></span>
        <a class="btn" href="${pageContext.request.contextPath}/don-hang-cua-toi"
           style="background:#e91e8c; color:white; padding:6px 14px; border-radius:6px; margin-right:8px;">
            📦 Đơn hàng của tôi
        </a>
        <a class="btn logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a><%
        }
    %>
    </div>
    <nav class="navbar">
        <div class="logo">
            <img src="https://cdn.discordapp.com/attachments/1453366979313537145/1491339709308338246/logo-agile.jpg?ex=69d755d6&is=69d60456&hm=6d035c5ef4284c65e6c34591c11bbc7d4274146a1c2b433e8d030441b8ef3e5e&" style="border-radius: 20px;" width="20%"
                 alt="Logo">
            <h1>Medi Den</h1>
        </div>
        <ul class="nav-links">
            <li class="dropdown">
                <a href="#">Giày Thể Thao <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao">Tất cả</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Nike">Nike</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Adidas">Adidas</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Puma">Puma</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=New+Balance">New Balance</a></li>:
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Converse">Converse</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Vans">Vans</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Clarks">Clarks</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#">Giày Thời Trang <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/giay/thoi-trang">Tất cả</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/thoi-trang?brand=Nike">Nike</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/thoi-trang?brand=Adidas">Adidas</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/thoi-trang?brand=Vans">Vans</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/thoi-trang?brand=Converse">Converse</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/thoi-trang?brand=Puma">Puma</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/thoi-trang?brand=New+Balance">New Balance</a></li>
                </ul>
            </li>
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
            <li class="dropdown">
                <a href="#">Giày Công Sở <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">

                    <li><a href="${pageContext.request.contextPath}/giay/cong-so?brand=Clarks">Clarks</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a href="#">Giày Cao Cấp <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/giay/cao-cap">Tất cả</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/cao-cap?brand=Balenciaga">Balenciaga</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/cao-cap?brand=New+Balance">New Balance</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/cao-cap?brand=Puma">Puma</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/cao-cap?brand=Converse">Converse</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/cao-cap?brand=Adidas">Adidas</a></li>

                </ul>
            </li>
        </ul>
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Tìm kiếm...">
            <button><i class="fas fa-search"></i></button>

            <!-- dropdown kết quả -->
            <div id="searchResult" class="search-result"></div>
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
        <div class="icon-btn" id="cart-icon" onclick="toggleCart()">
            <i class="fas fa-shopping-cart"></i>
            <span id="cart-count">0</span>
        </div>      
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
            <span id="cart-total-amount"></span>
        </div>
        <button class="btn-checkout" onclick="openCheckout()">THANH TOÁN</button>
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
                <h3>Vận chuyển nội thành Hà Nội</h3>
                <p>Giao hàng siêu tốc - Nhận ngay trong ngày</p>
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
                <h3>Hotline: 08 2222 1992</h3>
                <p>Vui lòng gọi hotline để hỗ trợ</p>
            </div>
        </div>
    </div>
</div>
<div class="brand-section">
    <div class="brand-section-header">
        <h2>👟 Giày Chính Hãng Nike</h2>
        <a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Nike">Xem tất cả Nike →</a>
    </div>
    <div class="product-row">
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
                    data-size="${sp.sizeString}"
                    data-sizeid="${sp.sizeIdString}"
                    data-sizestock="${sp.sizeStockString}"
                    data-desc="${sp.moTa}">
                Xem chi tiết
            </button>
        </div>
    </c:forEach>
    </div>
</div>
<div class="section-divider"></div>

<!-- ========== ADIDAS ========== -->
<div class="brand-section">
    <div class="brand-section-header">
        <h2>🔥 Adidas Nổi Bật</h2>
        <a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Adidas">Xem tất cả Adidas →</a>
    </div>
    <div class="product-row" id="row-adidas">
        <!-- skeleton -->
        <c:forEach begin="1" end="4">
            <div class="skeleton-card">
                <div class="skeleton-img"></div>
                <div class="skeleton-line"></div>
                <div class="skeleton-line short"></div>
                <div class="skeleton-line btn"></div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="section-divider"></div>

<!-- ========== PUMA ========== -->
<div class="brand-section">
    <div class="brand-section-header">
        <h2>⚡ Puma Collection</h2>
        <a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=Puma">Xem tất cả Puma →</a>
    </div>
    <div class="product-row" id="row-puma">
        <c:forEach begin="1" end="4">
            <div class="skeleton-card">
                <div class="skeleton-img"></div>
                <div class="skeleton-line"></div>
                <div class="skeleton-line short"></div>
                <div class="skeleton-line btn"></div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="section-divider"></div>

<!-- ========== NEW BALANCE ========== -->
<div class="brand-section">
    <div class="brand-section-header">
        <h2>🏃 New Balance Trending</h2>
        <a href="${pageContext.request.contextPath}/giay/xem-tat-ca?brand=New+Balance">Xem tất cả New Balance →</a>
    </div>
    <div class="product-row" id="row-nb">
        <c:forEach begin="1" end="4">
            <div class="skeleton-card">
                <div class="skeleton-img"></div>
                <div class="skeleton-line"></div>
                <div class="skeleton-line short"></div>
                <div class="skeleton-line btn"></div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="section-divider"></div>

<!-- ========== CONVERSE + VANS ========== -->
<div class="brand-section">
    <div class="brand-section-header">
        <h2>🎨 Converse &amp; Vans — Lifestyle</h2>
        <a href="${pageContext.request.contextPath}/giay/thoi-trang">Xem giày thời trang →</a>
    </div>
    <div class="product-row" id="row-cv">
        <c:forEach begin="1" end="4">
            <div class="skeleton-card">
                <div class="skeleton-img"></div>
                <div class="skeleton-line"></div>
                <div class="skeleton-line short"></div>
                <div class="skeleton-line btn"></div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="section-divider"></div>

<!-- ========== CAO CẤP / BALENCIAGA ========== -->
<div class="brand-section">
    <div class="brand-section-header">
        <h2>💎 Giày Cao Cấp — Balenciaga &amp; Premium</h2>
        <a href="${pageContext.request.contextPath}/giay/cao-cap">Xem tất cả →</a>
    </div>
    <div class="product-row" id="row-premium">
        <c:forEach begin="1" end="4">
            <div class="skeleton-card">
                <div class="skeleton-img"></div>
                <div class="skeleton-line"></div>
                <div class="skeleton-line short"></div>
                <div class="skeleton-line btn"></div>
            </div>
        </c:forEach>
    </div>
</div>

<div class="section-divider"></div>

<!-- ========== CLARKS CÔNG SỞ ========== -->
<div class="brand-section">
    <div class="brand-section-header">
        <h2>👞 Clarks — Giày Công Sở Chính Hãng</h2>
        <a href="${pageContext.request.contextPath}/giay/cong-so?brand=Clarks">Xem tất cả Clarks →</a>
    </div>
    <div class="product-row" id="row-clarks">
        <c:forEach begin="1" end="4">
            <div class="skeleton-card">
                <div class="skeleton-img"></div>
                <div class="skeleton-line"></div>
                <div class="skeleton-line short"></div>
                <div class="skeleton-line btn"></div>
            </div>
        </c:forEach>
    </div>
</div>

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

                <p>Số lượng: <small id="stockHint" style="font-size:0.85rem; margin-left:8px;"></small></p>
                <div class="qty-box">
                    <button onclick="changeQty(-1)">-</button>
                    <input id="modalQty" type="number" value="1" min="1" step="1"
                           oninput="validateQtyInput(this)">
                    <button onclick="changeQty(1)">+</button>
                </div>
                <small id="qtyError" style="color:red; font-size:0.85rem;"></small>
                <div class="modal-actions">
                    <button class="btn-buy-now" onclick="buyNowFromModal()">MUA NGAY</button>
                    <button class="btn-add-to-cart"
                            onclick="addToCart()">
                        Thêm vào giỏ
                    </button>
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
                    <div class="row-flex-3">
                        <div class="input-group">
                            <select id="sel-tinh" class="pink-input pink-select" onchange="loadQuan()">
                                <option value="">Chọn tỉnh / thành</option>
                            </select>
                            <small class="error-msg" id="tinh-error"></small>
                        </div>
                        <div class="input-group">
                            <select id="sel-quan" class="pink-input pink-select" onchange="loadPhuong()" disabled >
                                <option value="">Chọn quận / huyện</option>
                            </select>
                            <small class="error-msg" id="quan-error"></small>
                        </div>
                        <div class="input-group">
                            <select id="sel-phuong" class="pink-input pink-select" disabled >
                                <option value="">Chọn phường / xã</option>
                            </select>
                            <small class="error-msg" id="phuong-error"></small>
                        </div>
                    </div>

                    <div class="input-group">
                        <input type="text" id="address" placeholder="Số nhà, tên đường..." class="pink-input" required>
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
                        <p><strong>Email :</strong> <span id="res-email"></span></p>
                        <p><strong>Địa chỉ:</strong> <span id="res-address"></span></p>
                        <p><strong>Thanh toán:</strong> <span id="res-payment"></span></p>
                    </div>
                    <button class="btn-pink-large"
                            onclick="window.location.href = window.contextPath + '/tinh-trang?id=' + window._lastOrderId">
                        TIẾP TỤC MUA SẮM
                    </button>
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
        <div class="brand-item">
            <img src="https://cdn.worldvectorlogo.com/logos/puma-logo.svg" alt="Puma">
        </div>
        <div class="brand-item">
            <img src="https://logodownload.org/wp-content/uploads/2014/10/new-balance-logo-1.png" alt="New Balance">
        </div>
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
<script>
    window.onload = function () {
        new Swiper('.swiper', {
            loop: true,

            // 🔥 HIỆU ỨNG FADE
            effect: 'fade',
            fadeEffect: {
                crossFade: true
            },

            autoplay: {
                delay: 2000,
                disableOnInteraction: false
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
    };
</script>
<script>
    window.isLoggedIn = <%= session.getAttribute("user") != null %>;
    window.contextPath = "${pageContext.request.contextPath}";
</script>
<script>
    (function () {
        /* -------------------------------------------------------
           Lấy sản phẩm từ API theo brand rồi render vào rowId
           Lấy tối đa `limit` sản phẩm đầu tiên
        ------------------------------------------------------- */
        function loadBrandRow(brand, rowId, limit) {
            limit = limit || 4;
            const url = window.contextPath + '/giay/xem-tat-ca?brand=' + encodeURIComponent(brand);

            fetch(url, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
                .then(function (res) { return res.text(); })
                .then(function (html) {
                    /* Parse HTML trả về, lấy các button.add-cart để lấy data-* */
                    const parser = new DOMParser();
                    const doc    = parser.parseFromString(html, 'text/html');
                    const buttons = Array.from(doc.querySelectorAll('button.add-cart')).slice(0, limit);
                    const imgs    = Array.from(doc.querySelectorAll('.product-img img, .product-card img')).slice(0, limit);
                    const names   = Array.from(doc.querySelectorAll('.product-card h3')).slice(0, limit);
                    const prices  = Array.from(doc.querySelectorAll('.product-card .price')).slice(0, limit);

                    if (buttons.length === 0) {
                        document.getElementById(rowId).innerHTML =
                            '<p style="color:#888;grid-column:1/-1;text-align:center;">Không có sản phẩm.</p>';
                        return;
                    }

                    let html2 = '';
                    buttons.forEach(function (btn, i) {
                        const name  = btn.dataset.name  || (names[i]  ? names[i].innerText  : '');
                        const price = btn.dataset.price  || '';
                        const img   = btn.dataset.img   || (imgs[i]   ? imgs[i].src         : '');
                        const priceFormatted = prices[i] ? prices[i].innerText : Number(price).toLocaleString('vi-VN') + ' VNĐ';

                        const dataAttrs = [
                            'data-id="'        + (btn.dataset.id        || '') + '"',
                            'data-name="'      + escAttr(name)               + '"',
                            'data-price="'     + (btn.dataset.price     || '') + '"',
                            'data-img="'       + escAttr(img)                + '"',
                            'data-brand="'     + escAttr(btn.dataset.brand  || '') + '"',
                            'data-size="'      + escAttr(btn.dataset.size   || '') + '"',
                            'data-sizeid="'    + escAttr(btn.dataset.sizeid || '') + '"',
                            'data-sizestock="' + escAttr(btn.dataset.sizestock || '') + '"',
                            'data-desc="'      + escAttr(btn.dataset.desc   || '') + '"',
                        ].join(' ');

                        html2 += '<div class="product-card">' +
                            '<div class="product-img"><img src="' + escAttr(img) + '" alt="' + escAttr(name) + '" loading="lazy"></div>' +
                            '<h3>' + escHtml(name) + '</h3>' +
                            '<p class="price">' + escHtml(priceFormatted) + '</p>' +
                            '<button class="add-cart" onclick="openProductModal(this)" ' + dataAttrs + '>Xem chi tiết</button>' +
                            '</div>';
                    });

                    document.getElementById(rowId).innerHTML = html2;
                })
                .catch(function (err) {
                    console.warn('Load brand row lỗi:', brand, err);
                    document.getElementById(rowId).innerHTML =
                        '<p style="color:#ccc;grid-column:1/-1;text-align:center;">Không tải được sản phẩm.</p>';
                });
        }

        /* Converse + Vans lấy cả 2 brand rồi trộn */
        function loadMixedRow(brands, rowId, limit) {
            limit = limit || 4;
            const promises = brands.map(function (brand) {
                const url = window.contextPath + '/giay/xem-tat-ca?brand=' + encodeURIComponent(brand);
                return fetch(url, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
                    .then(function (res) { return res.text(); })
                    .then(function (html) {
                        const doc = new DOMParser().parseFromString(html, 'text/html');
                        return Array.from(doc.querySelectorAll('button.add-cart')).slice(0, Math.ceil(limit / brands.length));
                    })
                    .catch(function () { return []; });
            });

            Promise.all(promises).then(function (results) {
                /* Xen kẽ: brand0[0], brand1[0], brand0[1], brand1[1], ... */
                const merged = [];
                const max = Math.max.apply(null, results.map(function (r) { return r.length; }));
                for (let i = 0; i < max && merged.length < limit; i++) {
                    results.forEach(function (arr) { if (arr[i]) merged.push(arr[i]); });
                }

                if (merged.length === 0) {
                    document.getElementById(rowId).innerHTML =
                        '<p style="color:#888;grid-column:1/-1;text-align:center;">Không có sản phẩm.</p>';
                    return;
                }

                let html2 = '';
                merged.slice(0, limit).forEach(function (btn) {
                    const name  = btn.dataset.name  || '';
                    const price = btn.dataset.price  || '';
                    const img   = btn.dataset.img   || '';
                    const priceFormatted = Number(price).toLocaleString('vi-VN') + ' VNĐ';

                    const dataAttrs = [
                        'data-id="'        + (btn.dataset.id        || '') + '"',
                        'data-name="'      + escAttr(name)               + '"',
                        'data-price="'     + (btn.dataset.price     || '') + '"',
                        'data-img="'       + escAttr(img)                + '"',
                        'data-brand="'     + escAttr(btn.dataset.brand  || '') + '"',
                        'data-size="'      + escAttr(btn.dataset.size   || '') + '"',
                        'data-sizeid="'    + escAttr(btn.dataset.sizeid || '') + '"',
                        'data-sizestock="' + escAttr(btn.dataset.sizestock || '') + '"',
                        'data-desc="'      + escAttr(btn.dataset.desc   || '') + '"',
                    ].join(' ');

                    html2 += '<div class="product-card">' +
                        '<div class="product-img"><img src="' + escAttr(img) + '" alt="' + escAttr(name) + '" loading="lazy"></div>' +
                        '<h3>' + escHtml(name) + '</h3>' +
                        '<p class="price">' + priceFormatted + '</p>' +
                        '<button class="add-cart" onclick="openProductModal(this)" ' + dataAttrs + '>Xem chi tiết</button>' +
                        '</div>';
                });

                document.getElementById(rowId).innerHTML = html2;
            });
        }

        /* Helpers thoát ký tự */
        function escAttr(str) {
            return String(str).replace(/"/g, '&quot;').replace(/'/g, '&#39;');
        }
        function escHtml(str) {
            return String(str)
                .replace(/&/g, '&amp;').replace(/</g, '&lt;')
                .replace(/>/g, '&gt;').replace(/"/g, '&quot;');
        }

        /* -------- Gọi load cho từng section -------- */
        document.addEventListener('DOMContentLoaded', function () {
            loadBrandRow('Adidas',      'row-adidas',   4);
            loadBrandRow('Puma',        'row-puma',     4);
            loadBrandRow('New Balance', 'row-nb',       4);
            loadMixedRow(['Converse', 'Vans'], 'row-cv', 4);
            loadBrandRow('Balenciaga',  'row-premium',  4);
            loadBrandRow('Clarks',      'row-clarks',   4);
        });
    })();
</script>
<script src="${pageContext.request.contextPath}/view/script.js"></script>

</body>
</html>