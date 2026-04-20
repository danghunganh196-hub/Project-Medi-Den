<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Trạng thái đơn hàng - Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* ===== ORDER STATUS PAGE ===== */
        .order-status-page {
            max-width: 860px;
            margin: 48px auto 80px;
            padding: 0 20px;
            font-family: 'Segoe UI', sans-serif;
        }

        .order-status-page h1 {
            text-align: center;
            color: #e91e8c;
            font-size: 2rem;
            margin-bottom: 6px;
            letter-spacing: 1px;
        }

        .order-id-label {
            text-align: center;
            color: #888;
            font-size: 0.95rem;
            margin-bottom: 40px;
        }

        /* ===== TIMELINE ===== */
        .timeline-wrapper {
            background: #fff;
            border: 1px solid #f0c0d8;
            border-radius: 16px;
            padding: 36px 40px;
            margin-bottom: 32px;
            box-shadow: 0 4px 20px rgba(233,30,140,0.07);
        }

        .timeline-wrapper h2 {
            color: #e91e8c;
            font-size: 1.1rem;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .timeline {
            display: flex;
            justify-content: space-between;
            position: relative;
            padding-bottom: 10px;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 22px;
            left: 10%;
            right: 10%;
            height: 3px;
            background: #f0c0d8;
            z-index: 0;
        }

        /* Fill the progress bar up to current step */
        .timeline .progress-line {
            position: absolute;
            top: 22px;
            left: 10%;
            height: 3px;
            background: linear-gradient(90deg, #e91e8c, #ff69b4);
            z-index: 1;
            transition: width 0.6s ease;
        }

        .timeline-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
            width: 25%;
        }

        .step-icon {
            width: 46px;
            height: 46px;
            border-radius: 50%;
            background: #f5f5f5;
            border: 3px solid #f0c0d8;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            color: #ccc;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }

        .timeline-step.active .step-icon,
        .timeline-step.done .step-icon {
            background: linear-gradient(135deg, #e91e8c, #ff69b4);
            border-color: #e91e8c;
            color: white;
            box-shadow: 0 4px 14px rgba(233,30,140,0.35);
        }

        .step-label {
            font-size: 0.78rem;
            color: #bbb;
            text-align: center;
            font-weight: 500;
        }

        .timeline-step.active .step-label,
        .timeline-step.done .step-label {
            color: #e91e8c;
            font-weight: 700;
        }

        .step-time {
            font-size: 0.7rem;
            color: #ccc;
            margin-top: 4px;
        }

        .timeline-step.done .step-time,
        .timeline-step.active .step-time {
            color: #e991b8;
        }

        /* ===== ORDER ITEMS ===== */
        .order-items-card {
            background: #fff;
            border: 1px solid #f0c0d8;
            border-radius: 16px;
            padding: 32px 40px;
            margin-bottom: 32px;
            box-shadow: 0 4px 20px rgba(233,30,140,0.07);
        }

        .order-items-card h2 {
            color: #e91e8c;
            font-size: 1.1rem;
            margin-bottom: 24px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .order-item-row {
            display: flex;
            align-items: center;
            gap: 18px;
            padding: 14px 0;
            border-bottom: 1px solid #fce8f3;
        }

        .order-item-row:last-child {
            border-bottom: none;
        }

        .order-item-img {
            width: 70px;
            height: 70px;
            border-radius: 10px;
            object-fit: cover;
            border: 1px solid #f0c0d8;
            flex-shrink: 0;
        }

        .order-item-info {
            flex: 1;
        }

        .order-item-info .item-name {
            font-weight: 700;
            color: #333;
            font-size: 0.95rem;
            margin-bottom: 4px;
        }

        .order-item-info .item-meta {
            font-size: 0.82rem;
            color: #888;
        }

        .order-item-price {
            font-weight: 700;
            color: #e91e8c;
            font-size: 1rem;
            white-space: nowrap;
        }

        /* ===== TOTAL ===== */
        .order-total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 18px;
            padding-top: 16px;
            border-top: 2px solid #f0c0d8;
        }

        .order-total-row .total-label {
            font-weight: 700;
            font-size: 1rem;
            color: #555;
        }

        .order-total-row .total-amount {
            font-weight: 800;
            font-size: 1.3rem;
            color: #e91e8c;
        }

        /* ===== INFO CARD ===== */
        .order-info-card {
            background: #fff;
            border: 1px solid #f0c0d8;
            border-radius: 16px;
            padding: 28px 40px;
            margin-bottom: 32px;
            box-shadow: 0 4px 20px rgba(233,30,140,0.07);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px 30px;
        }

        .order-info-card h2 {
            grid-column: 1 / -1;
            color: #e91e8c;
            font-size: 1.1rem;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .info-row {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }

        .info-row .info-label {
            font-size: 0.75rem;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-row .info-value {
            font-size: 0.93rem;
            color: #333;
            font-weight: 600;
        }

        /* ===== BACK BUTTON ===== */
        .btn-back-home {
            display: block;
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #e91e8c, #ff69b4);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 700;
            letter-spacing: 1px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: opacity 0.2s;
        }

        .btn-back-home:hover {
            opacity: 0.88;
        }

        /* ===== STATUS BADGE ===== */
        .status-badge {
            display: inline-block;
            padding: 4px 14px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 700;
            margin-left: 10px;
            vertical-align: middle;
        }

        .status-badge.pending   { background: #fff3e0; color: #e65100; }
        .status-badge.processing{ background: #e3f2fd; color: #1565c0; }
        .status-badge.shipping  { background: #f3e5f5; color: #7b1fa2; }
        .status-badge.done      { background: #e8f5e9; color: #2e7d32; }

        @media (max-width: 600px) {
            .timeline-wrapper, .order-items-card, .order-info-card {
                padding: 22px 16px;
            }
            .timeline::before { left: 5%; right: 5%; }
            .step-label { font-size: 0.68rem; }
            .order-info-card { grid-template-columns: 1fr; }
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
        <a class="btn login" href="/login">Đăng nhập</a>
        <a class="btn register" href="/register">Đăng ký</a>
        <%
        } else {
        %>
        <span>Xin chào, <b><%= user.getUsername() %></b></span>
        <a class="btn logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        <%
        }
        %>
    </div>
    <nav class="navbar">
        <div class="logo">
            <img src="https://cdn.discordapp.com/attachments/1453366979313537145/1491339709308338246/logo-agile.jpg?ex=69d755d6&is=69d60456&hm=6d035c5ef4284c65e6c34591c11bbc7d4274146a1c2b433e8d030441b8ef3e5e&"
                 style="border-radius: 20px;" width="20%" alt="Logo">
            <h1>Medi Den</h1>
        </div>
    </nav>
</header>

<div class="order-status-page">

    <h1>📦 Trạng Thái Đơn Hàng</h1>
    <p class="order-id-label">
        Mã đơn hàng: <strong>#${donHang.id}</strong>
        <%-- Badge trạng thái --%>
        <c:choose>
            <c:when test="${donHang.trangThai == 'CHO_XU_LY'}">
                <span class="status-badge pending">Chờ xử lý</span>
            </c:when>
            <c:when test="${donHang.trangThai == 'DANG_XU_LY'}">
                <span class="status-badge processing">Đang xử lý</span>
            </c:when>
            <c:when test="${donHang.trangThai == 'DANG_GIAO'}">
                <span class="status-badge shipping">Đang giao hàng</span>
            </c:when>
            <c:when test="${donHang.trangThai == 'HOAN_THANH'}">
                <span class="status-badge done">Hoàn thành</span>
            </c:when>
        </c:choose>
    </p>

    <%-- ===== TIMELINE ===== --%>
    <div class="timeline-wrapper">
        <h2><i class="fas fa-route" style="margin-right:8px;"></i>Hành trình đơn hàng</h2>

        <%--
            Logic step:
            0 = CHO_XU_LY  → step 1 active
            1 = DANG_XU_LY → step 2 active
            2 = DANG_GIAO  → step 3 active
            3 = HOAN_THANH → step 4 active
        --%>
        <c:set var="step" value="0"/>
        <c:choose>
            <c:when test="${donHang.trangThai == 'CHO_XU_LY'}">   <c:set var="step" value="1"/></c:when>
            <c:when test="${donHang.trangThai == 'DANG_XU_LY'}">  <c:set var="step" value="2"/></c:when>
            <c:when test="${donHang.trangThai == 'DANG_GIAO'}">   <c:set var="step" value="3"/></c:when>
            <c:when test="${donHang.trangThai == 'HOAN_THANH'}">  <c:set var="step" value="4"/></c:when>
        </c:choose>

        <div class="timeline">
            <%-- Progress line width driven by step --%>
            <div class="progress-line" id="progressLine"></div>

            <div class="timeline-step ${step >= 1 ? 'done' : ''}">
                <div class="step-icon"><i class="fas fa-check-circle"></i></div>
                <div class="step-label">Đã đặt hàng</div>
                <div class="step-time">
                    <fmt:formatDate value="${donHang.ngayDat}" pattern="dd/MM/yyyy HH:mm"/>
                </div>
            </div>

            <div class="timeline-step ${step == 2 ? 'active' : (step > 2 ? 'done' : '')}">
                <div class="step-icon"><i class="fas fa-cog"></i></div>
                <div class="step-label">Đang xử lý</div>
                <div class="step-time">
                    <c:if test="${step >= 2}"><fmt:formatDate value="${donHang.ngayXuLy}" pattern="dd/MM/yyyy HH:mm"/></c:if>
                </div>
            </div>

            <div class="timeline-step ${step == 3 ? 'active' : (step > 3 ? 'done' : '')}">
                <div class="step-icon"><i class="fas fa-truck"></i></div>
                <div class="step-label">Đang giao hàng</div>
                <div class="step-time">
                    <c:if test="${step >= 3}"><fmt:formatDate value="${donHang.ngayGiao}" pattern="dd/MM/yyyy HH:mm"/></c:if>
                </div>
            </div>

            <div class="timeline-step ${step == 4 ? 'active done' : ''}">
                <div class="step-icon"><i class="fas fa-box-open"></i></div>
                <div class="step-label">Hoàn tất</div>
                <div class="step-time">
                    <c:if test="${step >= 4}"><fmt:formatDate value="${donHang.ngayHoanThanh}" pattern="dd/MM/yyyy HH:mm"/></c:if>
                </div>
            </div>
        </div>
    </div>

    <%-- ===== SẢN PHẨM ĐÃ ĐẶT ===== --%>
    <div class="order-items-card">
        <h2><i class="fas fa-shoe-prints" style="margin-right:8px;"></i>Sản phẩm đã đặt</h2>

        <c:forEach var="chiTiet" items="${donHang.chiTietDonHangs}">
            <div class="order-item-row">
                <img class="order-item-img" src="${chiTiet.giay.hinhAnh}" alt="${chiTiet.giay.tenGiay}">
                <div class="order-item-info">
                    <div class="item-name">${chiTiet.giay.tenGiay}</div>
                    <div class="item-meta">
                        Size: <strong>${chiTiet.size}</strong> &nbsp;|&nbsp;
                        Số lượng: <strong>${chiTiet.soLuong}</strong> &nbsp;|&nbsp;
                        Thương hiệu: ${chiTiet.giay.thuongHieu}
                    </div>
                </div>
                <div class="order-item-price">
                    <fmt:formatNumber value="${chiTiet.donGia * chiTiet.soLuong}" pattern="#,###"/> VNĐ
                </div>
            </div>
        </c:forEach>

        <div class="order-total-row">
            <span class="total-label">Tổng tiền sản phẩm:</span>
            <span class="total-amount"><fmt:formatNumber value="${donHang.tongTien}" pattern="#,###"/> VNĐ</span>
        </div>
        <div style="display:flex;justify-content:space-between;padding-top:8px;font-size:0.9rem;color:#888;">
            <span>Phí vận chuyển:</span>
            <span>35,000 VNĐ</span>
        </div>
        <div class="order-total-row" style="margin-top:10px;">
            <span class="total-label" style="font-size:1.1rem;">Tổng thanh toán:</span>
            <span class="total-amount" style="font-size:1.5rem;">
                <fmt:formatNumber value="${donHang.tongTien + 35000}" pattern="#,###"/> VNĐ
            </span>
        </div>
    </div>

    <%-- ===== THÔNG TIN GIAO HÀNG ===== --%>
    <div class="order-info-card">
        <h2><i class="fas fa-info-circle" style="margin-right:8px;"></i>Thông tin đơn hàng</h2>

        <div class="info-row">
            <span class="info-label">Người nhận</span>
            <span class="info-value">${donHang.tenNguoiNhan}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Email</span>
            <span class="info-value">${donHang.email}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Địa chỉ giao hàng</span>
            <span class="info-value">${donHang.diaChiGiaoHang}</span>
        </div>
        <div class="info-row">
            <span class="info-label">Phương thức thanh toán</span>
            <span class="info-value">
                <c:choose>
                    <c:when test="${donHang.phuongThucThanhToan == 'COD'}">Thanh toán khi nhận hàng (COD)</c:when>
                    <c:when test="${donHang.phuongThucThanhToan == 'Bank'}">Chuyển khoản ngân hàng</c:when>
                    <c:otherwise>${donHang.phuongThucThanhToan}</c:otherwise>
                </c:choose>
            </span>
        </div>
        <div class="info-row">
            <span class="info-label">Ngày đặt hàng</span>
            <span class="info-value"><fmt:formatDate value="${donHang.ngayDat}" pattern="dd/MM/yyyy HH:mm"/></span>
        </div>
        <div class="info-row">
            <span class="info-label">Phí vận chuyển</span>
            <span class="info-value">35,000 VNĐ — Giao hàng tận nơi</span>
        </div>
    </div>

    <a class="btn-back-home" href="${pageContext.request.contextPath}/giay/hien-thi">
        <i class="fas fa-home" style="margin-right:8px;"></i>TIẾP TỤC MUA SẮM
    </a>

</div>

<%-- ===== FOOTER ===== --%>
<footer>
    <div class="footer-brands">
        <div class="brand-item"><img src="https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_NIKE.svg" alt="Nike"></div>
        <div class="brand-item"><img src="https://upload.wikimedia.org/wikipedia/commons/2/20/Adidas_Logo.svg" alt="Adidas"></div>
        <div class="brand-item"><img src="https://upload.wikimedia.org/wikipedia/en/3/37/Jumpman_logo.svg" alt="Jordan"></div>
        <div class="brand-item"><img src="https://cdn.worldvectorlogo.com/logos/puma-logo.svg" alt="Puma"></div>
        <div class="brand-item"><img src="https://logodownload.org/wp-content/uploads/2014/10/new-balance-logo-1.png" alt="New Balance"></div>
    </div>
    <hr class="footer-divider">
    <div class="footer-container">
        <div class="footer-col">
            <div class="info-item"><i class="fas fa-map-marker-alt"></i><p>Địa chỉ: 118 Đ.Phương Canh, Nam Từ Liêm, Hà Nội.</p></div>
            <div class="info-item"><i class="fas fa-phone-alt"></i><p>Hotline: 08 2222 1992</p></div>
            <div class="info-item"><i class="fas fa-envelope"></i><p>Email: MediDen8888@gmail.com</p></div>
        </div>
        <div class="footer-col">
            <h4>CHÍNH SÁCH</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/giay/hien-thi">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/view/gioi-thieu.jsp">Giới thiệu</a></li>
                <li><a href="${pageContext.request.contextPath}/view/chinh-sach-bao-mat.jsp">Chính sách bảo mật</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>HỖ TRỢ KHÁCH HÀNG</h4>
            <ul>
                <li><a href="${pageContext.request.contextPath}/view/chinh-sach-giao-nhan.jsp">Chính sách giao nhận</a></li>
                <li><a href="${pageContext.request.contextPath}/view/chinh-sach-doi-tra.jsp">Chính sách đổi trả</a></li>
                <li><a href="${pageContext.request.contextPath}/view/chinh-sach-thanh-toan.jsp">Chính sách thanh toán</a></li>
            </ul>
        </div>
        <div class="footer-col">
            <h4>ĐĂNG KÝ NHẬN TIN</h4>
            <div class="subscribe-form">
                <input type="email" placeholder="Nhập địa chỉ email">
                <button>Đăng ký</button>
            </div>
            <div class="social-icons">
                <a href="https://www.facebook.com/dang.hung.anh.887452"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.instagram.com/accounts/login/?next=%2Fnoobbon3793%2F"><i class="fab fa-instagram"></i></a>
                <a href="https://www.youtube.com/@nercatto-w6n"><i class="fa-brands fa-youtube"></i></a>
            </div>
        </div>
    </div>
</footer>

<script>
    // Tự động tính chiều rộng progress line theo step hiện tại
    window.addEventListener('DOMContentLoaded', function () {
        var step = ${step};
        var widthMap = { 1: '0%', 2: '33%', 3: '66%', 4: '100%' };
        var line = document.getElementById('progressLine');
        if (line && widthMap[step]) {
            line.style.width = widthMap[step];
        }
    });
</script>
</body>
</html>
