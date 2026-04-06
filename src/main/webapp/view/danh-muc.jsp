<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${categoryName} - Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .collection-wrapper { background-color: #f9f9f9; padding: 40px 0; min-height: 80vh; }
        .adidas-style-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px; max-width: 1200px; margin: 0 auto;
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
        .btn-back { color: #ff1493; text-decoration: none; font-weight: 500; }
        .btn-back:hover { text-decoration: underline; }
        .toolbar {
            max-width: 1200px; margin: 0 auto 20px;
            display: flex; justify-content: space-between; align-items: center; gap: 15px;
        }
        .sort-dropdown { padding: 8px 12px; border-radius: 5px; border: 1px solid #ddd; outline: none; }
        .filter-brand { display: flex; gap: 8px; flex-wrap: wrap; }
        .filter-brand a {
            padding: 6px 14px; border-radius: 20px; border: 1px solid #ddd;
            text-decoration: none; color: #333; font-size: 0.9rem; transition: 0.2s;
        }
        .filter-brand a:hover, .filter-brand a.active { background: #ff1493; color: #fff; border-color: #ff1493; }
    </style>
</head>
<body>
<%-- HEADER (copy từ trang chủ) --%>
<header>
    <div class="top-bar">
        <%
            TaiKhoan user = (TaiKhoan) session.getAttribute("user");
            if (user == null) {
        %>
        <a class="btn login" href="/view/dang-nhap.jsp">Đăng nhập</a>
        <a class="btn register" href="/view/dang-ky.jsp">Đăng ký</a>
        <% } else { %>
        <span>Xin chào, <b><%= user.getUsername() %></b></span>
        <a class="btn logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        <% } %>
    </div>
    <nav class="navbar">
        <div class="logo">
            <img src="/images/logo/Screenshot 2026-03-19 014252.png" style="border-radius: 20px;" width="20%" alt="Logo">
            <h1>Medi Den</h1>
        </div>
        <ul class="nav-links">
            <li class="dropdown">
                <a href="#">Giày Thể Thao <i class="fas fa-chevron-down"></i></a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Nike">Nike</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Adidas">Adidas</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=Puma">Puma</a></li>
                    <li><a href="${pageContext.request.contextPath}/giay/the-thao?brand=New+Balance">New Balance</a></li>
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
                </ul>
            </li>
        </ul>
        <div class="search-box">
            <input type="text" name="search" placeholder="Tìm kiếm...">
            <button><i class="fas fa-search"></i></button>
        </div>
    </nav>
</header>

<div class="collection-wrapper">
    <div class="collection-header">
        <h1>${categoryName}<c:if test="${not empty param.brand}"> - ${param.brand}</c:if></h1>
        <a href="${pageContext.request.contextPath}/giay/hien-thi" class="btn-back">← Quay về trang chủ</a>
    </div>

    <div class="toolbar">
        <span>${listGiay.size()} sản phẩm</span>
        <select id="sortPrice" class="sort-dropdown" onchange="sortProducts()">
            <option value="default">Sắp xếp: Mặc định</option>
            <option value="asc">Giá: Thấp đến Cao</option>
            <option value="desc">Giá: Cao đến Thấp</option>
        </select>
    </div>

    <main class="adidas-style-grid" id="productList">
        <c:forEach var="sp" items="${listGiay}">
            <div class="product-card" data-price="${sp.gia}">
                <img src="${sp.hinhAnh}" alt="${sp.tenGiay}"
                     onerror="this.src='https://via.placeholder.com/300x220?text=Medi+Den'">
                <h3>${sp.tenGiay}</h3>
                <p class="price"><fmt:formatNumber value="${sp.gia}" pattern="#,###"/> VNĐ</p>
                <button class="add-cart"
                        style="width:100%; padding:10px; background:#333; color:#fff; border:none; border-radius:5px; cursor:pointer"
                        onclick="openProductModal(this)"
                        data-id="${sp.id}"
                        data-name="${sp.tenGiay}"
                        data-price="${sp.gia}"
                        data-img="${sp.hinhAnh}"
                        data-brand="${sp.thuongHieu}"
                        data-size="${sp.sizeString}"
                        data-sizeid="${sp.sizeIdString}">
                    Xem chi tiết
                </button>
            </div>
        </c:forEach>

        <c:if test="${empty listGiay}">
            <div style="text-align:center; width:100%; padding:50px; grid-column: 1/-1;">
                <p>Hiện không có sản phẩm nào trong danh mục này.</p>
                <a href="${pageContext.request.contextPath}/giay/hien-thi" style="color:#ff69b4;">Quay lại mua sắm</a>
            </div>
        </c:if>
    </main>
</div>

<%-- Giữ nguyên các modal từ trang chủ --%>
<script>
    window.isLoggedIn = <%= session.getAttribute("user") != null %>;
    window.contextPath = "${pageContext.request.contextPath}";

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
        productList.innerHTML = '';
        products.forEach(p => productList.appendChild(p));
    }
</script>
<script src="${pageContext.request.contextPath}/view/script.js"></script>
</body>
</html>