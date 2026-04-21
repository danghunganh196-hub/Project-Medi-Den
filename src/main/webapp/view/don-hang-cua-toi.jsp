<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Đơn hàng của tôi - Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .orders-page { max-width: 900px; margin: 40px auto 80px; padding: 0 20px; font-family: 'Segoe UI', sans-serif; }
        .orders-page h1 { color: #e91e8c; text-align: center; margin-bottom: 30px; }
        .order-card {
            background: #fff;
            border: 1px solid #f0c0d8;
            border-radius: 14px;
            padding: 20px 28px;
            margin-bottom: 18px;
            box-shadow: 0 3px 12px rgba(233,30,140,0.07);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }
        .order-card-info { flex: 1; }
        .order-card-info .order-id { font-weight: 700; color: #333; font-size: 1rem; }
        .order-card-info .order-meta { color: #888; font-size: 0.85rem; margin-top: 4px; }
        .order-card-info .order-total { color: #e91e8c; font-weight: 700; font-size: 1rem; margin-top: 6px; }
        .status-badge {
            display: inline-block; padding: 4px 12px;
            border-radius: 20px; font-size: 0.78rem; font-weight: 700;
        }
        .status-badge.pending    { background: #fff3e0; color: #e65100; }
        .status-badge.processing { background: #e3f2fd; color: #1565c0; }
        .status-badge.shipping   { background: #f3e5f5; color: #7b1fa2; }
        .status-badge.done       { background: #e8f5e9; color: #2e7d32; }
        .btn-view-order {
            background: linear-gradient(135deg, #e91e8c, #ff69b4);
            color: white; border: none; padding: 10px 20px;
            border-radius: 8px; font-weight: 700; cursor: pointer;
            text-decoration: none; font-size: 0.9rem; white-space: nowrap;
        }
        .btn-view-order:hover { opacity: 0.85; }
        .empty-msg { text-align: center; color: #aaa; margin-top: 60px; font-size: 1.1rem; }
    </style>
</head>
<body>
<header>
    <div class="top-bar">
        <%
            TaiKhoan user = (TaiKhoan) session.getAttribute("user");
            if (user != null) {
        %>
        <span>Xin chào, <b><%= user.getUsername() %></b></span>
        <a class="btn logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        <% } %>
    </div>
    <nav class="navbar">
        <div class="logo">
            <img src="https://cdn.discordapp.com/attachments/1453366979313537145/1491339709308338246/logo-agile.jpg?ex=69d755d6&is=69d60456&hm=6d035c5ef4284c65e6c34591c11bbc7d4274146a1c2b433e8d030441b8ef3e5e&"
                 style="border-radius:20px;" width="20%" alt="Logo">
            <h1>Medi Den</h1>
        </div>
    </nav>
</header>

<div class="orders-page">
    <h1>📦 Đơn hàng của tôi</h1>

    <c:choose>
        <c:when test="${empty danhSachDonHang}">
            <p class="empty-msg">Bạn chưa có đơn hàng nào.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="hd" items="${danhSachDonHang}">
                <div class="order-card">
                    <div class="order-card-info">
                        <div class="order-id">
                            Đơn hàng #${hd.id}
                            <c:choose>
                                <c:when test="${hd.trangThai == 'CHO_XU_LY'}">
                                    <span class="status-badge pending">Chờ xử lý</span>
                                </c:when>
                                <c:when test="${hd.trangThai == 'DANG_XU_LY'}">
                                    <span class="status-badge processing">Đang xử lý</span>
                                </c:when>
                                <c:when test="${hd.trangThai == 'DANG_GIAO'}">
                                    <span class="status-badge shipping">Đang giao hàng</span>
                                </c:when>
                                <c:when test="${hd.trangThai == 'HOAN_THANH'}">
                                    <span class="status-badge done">Hoàn thành</span>
                                </c:when>
                            </c:choose>
                        </div>
                        <div class="order-meta">
                            Ngày đặt: ${requestScope['ngay_'.concat(hd.id)]} &nbsp;|&nbsp;
                            Địa chỉ: ${hd.diaChi}
                        </div>
                        <div class="order-total">
                            <fmt:formatNumber value="${hd.tongTien}" pattern="#,###"/> VNĐ
                        </div>
                    </div>
                    <a class="btn-view-order" href="${pageContext.request.contextPath}/tinh-trang?id=${hd.id}">
                        Xem chi tiết
                    </a>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    <div style="text-align:center; margin-top:30px;">
        <a href="${pageContext.request.contextPath}/giay/hien-thi"
           style="color:#e91e8c; font-weight:700; text-decoration:none;">
            ← Tiếp tục mua sắm
        </a>
    </div>
</div>
</body>
</html>
