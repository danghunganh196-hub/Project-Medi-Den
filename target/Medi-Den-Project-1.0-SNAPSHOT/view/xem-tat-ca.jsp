<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Sản phẩm ${param.brand} - Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* CSS Tinh chỉnh riêng cho trang danh mục */
        .collection-wrapper { background-color: #f9f9f9; padding: 40px 0; min-height: 80vh; }
        .adidas-style-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .product-card {
            background: #fff; border-radius: 12px; padding: 20px;
            text-align: center; box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: 0.3s; border: 1px solid #eee;
        }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
        .product-card img { max-width: 100%; height: 220px; object-fit: contain; margin-bottom: 15px; }
        .product-card h3 { font-size: 18px; color: #333; margin: 10px 0; height: 45px; overflow: hidden; }
        .product-card .price { color: #ff1493; font-weight: bold; font-size: 1.2rem; margin-bottom: 15px; }

        .collection-header { text-align: center; margin-bottom: 30px; }
        .collection-header h1 { text-transform: uppercase; font-weight: 800; margin-bottom: 10px; }
        .btn-back { color: #ff1493; text-decoration: none; font-weight: 500; transition: 0.3s; }
        .btn-back:hover { text-decoration: underline; }

        .toolbar {
            max-width: 1200px; margin: 0 auto 20px;
            display: flex; justify-content: flex-end; align-items: center; gap: 15px;
        }
        .sort-dropdown { padding: 8px 12px; border-radius: 5px; border: 1px solid #ddd; outline: none; }
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
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=New+Balance">New Balance</a></li>
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

<div class="collection-wrapper">
    <div class="collection-header">
        <h1>GIÀY CHÍNH HÃNG ${param.brand}</h1>
        <a href="${pageContext.request.contextPath}/giay/hien-thi" class="btn-back">← Quay về trang chủ</a>
    </div>

    <div class="toolbar">
        <span id="product-count">${listGiay.size()} sản phẩm</span>
        <select id="sortPrice" class="sort-dropdown" onchange="sortProducts()">
            <option value="default">Sắp xếp: Mặc định</option>
            <option value="asc">Giá: Thấp đến Cao</option>
            <option value="desc">Giá: Cao đến Thấp</option>
        </select>
    </div>

    <main id="productList" class="container">
        <c:forEach var="sp" items="${listGiay}">
            <c:set var="sizeStr" value="${sp.sizeString}" />
            <c:if test="${empty sizeStr}">
                <c:set var="sizeStr" value="" />
            </c:if>

            <div class="product-card"
                 data-price="${sp.gia}"
                 data-name="${sp.tenGiay}"
                 data-brand="${sp.thuongHieu}">

                <div class="product-img">
                    <img src="${sp.hinhAnh}" alt="${sp.tenGiay}">
                </div>

                <h3>${sp.tenGiay}</h3>

                <p class="price">
                    <fmt:formatNumber value="${sp.gia}" pattern="#,###"/> VNĐ
                </p>

                <button class="add-cart"
                        onclick="openProductModal(this)"
                        data-id="${sp.id}"
                        data-name="${sp.tenGiay}"
                        data-price="${sp.gia}"
                        data-img="${sp.hinhAnh}"
                        data-brand="${sp.thuongHieu}"
                        data-size="${sp.sizeString}"
                        data-sizeid="${sp.sizeIdString}"
                        data-desc="${sp.moTa}">
                    Xem chi tiết
                </button>
            </div>
        </c:forEach>
    </main>
</div>
<!-- TOAST -->
<div id="toast" style="position:fixed;top:20px;right:20px;background:#4CAF50;color:white;padding:12px 20px;border-radius:6px;display:none;z-index:9999;font-weight:bold;"></div>

<!-- SIDEBAR CART -->
<aside class="sidebar">
    <div class="icon-btn" id="cart-icon" onclick="toggleCart()">
        <i class="fas fa-shopping-cart"></i>
        <span id="cart-count">0</span>
    </div>
</aside>

<!-- MINI CART -->
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

<!-- PRODUCT MODAL -->
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
                <p>Số lượng:</p>
                <div class="qty-box">
                    <button onclick="changeQty(-1)">-</button>
                    <input id="modalQty" type="number" value="1" min="1"
                           oninput="if(this.value < 1 || this.value === '') this.value = 1;">
                    <button onclick="changeQty(1)">+</button>
                </div>
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
    // Hàm sắp xếp sản phẩm theo giá không cần tải lại trang
    function sortProducts() {
        const sortValue = document.getElementById('sortPrice').value;
        const productList = document.getElementById('productList');
        const products = Array.from(productList.getElementsByClassName('product-card'));

        if (sortValue === 'default') return;

        products.sort((a, b) => {
            const priceA = parseFloat(a.getAttribute('data-price'));
            const priceB = parseFloat(b.getAttribute('data-price'));
            return sortValue === 'asc' ? priceA - priceB : priceB - priceA;
        });

        // Xóa danh sách cũ và chèn danh sách đã sắp xếp
        productList.innerHTML = '';
        products.forEach(p => productList.appendChild(p));
    }
</script>
<script>
    window.isLoggedIn = <%= session.getAttribute("user") != null %>;
    window.contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/view/script.js"></script>
</body>
</html>