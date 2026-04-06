<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Chính sách Đổi trả - Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .policy-wrapper {
            max-width: 1100px;
            margin: 40px auto;
            padding: 20px;
            font-family: 'Segoe UI', Arial, sans-serif;
            color: #333;
            line-height: 1.7;
        }
        .policy-card {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.08);
        }
        .policy-card h1 {
            color: #ff1493;
            text-align: center;
            text-transform: uppercase;
            margin-bottom: 30px;
            font-size: 2rem;
        }
        .section-title {
            color: #d81b60;
            border-bottom: 2px solid #fce4ec;
            padding-bottom: 5px;
            margin-top: 25px;
            font-size: 1.3rem;
            text-transform: uppercase;
        }
        .sub-section {
            font-weight: bold;
            color: #333;
            margin-top: 15px;
            display: block;
        }

        /* Căn chỉnh thụt lề cho tất cả các danh sách */
        .policy-card ul, .policy-card ol {
            padding-left: 0;
            margin-left: 40px;
            margin-top: 10px;
            margin-bottom: 15px;
        }
        .policy-card li { margin-bottom: 8px; }

        .highlight-box {
            background: #fff5f8;
            border-left: 4px solid #ff1493;
            padding: 15px;
            margin: 20px 0;
        }

        /* --- PHẦN CHỈNH SỬA: BOX LIÊN HỆ NỀN HỒNG VIỀN ĐỨT --- */
        .pink-contact-box {
            background-color: #fff0f5; /* Nền hồng nhạt */
            border: 2px dashed #ff69b4; /* Viền nét đứt hồng */
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
        .pink-contact-box p {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        .pink-contact-box i {
            color: #ff1493;
            margin-right: 12px;
            width: 20px;
            text-align: center;
        }
        .pink-contact-box a {
            color: #ff1493;
            text-decoration: none;
            font-weight: bold;
        }
        .pink-contact-box a:hover {
            text-decoration: underline;
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
        <h1>Chính sách đổi trả hàng</h1>

        <h2 class="section-title">4.1. Điều kiện đổi trả</h2>
        <p>Chúng tôi hỗ trợ đổi trả sản phẩm trong vòng <strong style="color: #ff1493;">10 ngày</strong> kể từ ngày quý khách nhận được hàng.</p>

        <div class="highlight-box">
            <strong>Medi Den hỗ trợ đổi trả cho các trường hợp:</strong>
            <ul style="list-style-type: disc;">
                <li>Sản phẩm có lỗi từ nhà sản xuất: Hở keo, nứt đế, da bị bong tróc khi chưa sử dụng, lỗi đường chỉ may.</li>
                <li>Sản phẩm bị hư hại trong quá trình vận chuyển (bẹp form nặng, trầy xước sản phẩm).</li>
                <li>Khách hàng gặp vấn đề về kích ứng da hoặc không vừa size khi thử sản phẩm.</li>
                <li>Giao nhầm sản phẩm so với đơn đặt hàng (sai mẫu, sai màu, sai kích cỡ).</li>
            </ul>
        </div>

        <p><strong>Yêu cầu bắt buộc:</strong></p>
        <ul style="list-style-type: disc;">
            <li>Sản phẩm đổi trả phải còn nguyên tem mác, đầy đủ phụ kiện (nếu có) và chưa qua sử dụng ngoài trời.</li>
            <li>Mã đơn hàng phải khớp với thông tin trên hệ thống của <strong>Medi Den</strong>.</li>
            <li>Quý khách vui lòng cung cấp hóa đơn mua hàng đi kèm.</li>
        </ul>
        <p><em>*Lưu ý: Không áp dụng đổi trả với các sản phẩm là quà tặng kèm trong chương trình ưu đãi.</em></p>

        <span class="sub-section">4.1.1 Đối với sản phẩm nguyên giá</span>
        <p>Khách hàng được đổi sang sản phẩm khác giá trị tương đương hoặc cao hơn (vui lòng thanh toán phần chênh lệch).</p>

        <span class="sub-section">4.1.2 Đối với sản phẩm khuyến mãi</span>
        <p>Sản phẩm vẫn được áp dụng đổi trả theo giá trị sau khi đã giảm giá. Khách hàng có thể đổi sang sản phẩm khác bằng hoặc cao hơn giá trị này.</p>

        <h2 class="section-title">4.2. Quy trình và thủ tục</h2>
        <p>Nếu đủ điều kiện trên, quý khách vui lòng thực hiện theo các bước:</p>
        <ol>
            <li>Liên hệ Hotline <strong>08 2222 1992</strong> hoặc nhắn tin qua Fanpage để thông báo lỗi/nhu cầu đổi size.</li>
            <li>Gửi sản phẩm về địa chỉ shop (đảm bảo đóng gói cẩn thận, không làm hỏng hộp giày nguyên bản).</li>
            <li>Sau khi nhận được hàng và kiểm tra (trong vòng 03 ngày làm việc), <strong>Medi Den</strong> sẽ gửi lại sản phẩm mới hoặc hoàn tiền theo cam kết.</li>
        </ol>

        <h2 class="section-title">4.3. Cước phí vận chuyển</h2>
        <span class="sub-section">4.3.1. Đối với đơn đổi hàng</span>
        <ul style="list-style-type: disc;">
            <li><strong>Lỗi do khách hàng (muốn đổi mẫu, đổi size):</strong> Khách hàng thanh toán phí vận chuyển 2 chiều.</li>
            <li><strong>Lỗi do Medi Den (giao sai, lỗi NSX):</strong> Shop chịu 100% chi phí vận chuyển lượt về và giao lại.</li>
        </ul>

        <span class="sub-section">4.3.2. Đối với đơn trả hàng (Hủy đơn)</span>
        <p>Trường hợp hàng đã giao đến nơi nhưng khách không nhận hoặc muốn hủy đơn không lý do lỗi, khách hàng vui lòng thanh toán phí ship chiều đi cho bưu tá.</p>

        <!-- ĐÃ ĐỔI SANG NỀN HỒNG VIỀN ĐỨT -->
        <div class="pink-contact-box">
            <strong>THÔNG TIN LIÊN HỆ HỖ TRỢ</strong>
            <p><i class="fas fa-phone-alt"></i> Hotline: 08 2222 1992</p>
            <p><i class="fas fa-envelope"></i> Email: MediDen8888@gmail.com</p>
            <p><i class="fas fa-globe"></i> Website: <a href="${pageContext.request.contextPath}/giay/hien-thi">Medi Den Online</a></p>
            <p><i class="fas fa-map-marker-alt"></i> Địa chỉ: 118 Đ. Phương Canh, Nam Từ Liêm, Hà Nội.</p>
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