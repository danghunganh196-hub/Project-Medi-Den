<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Chính sách thanh toán</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .policy-wrapper {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .policy-card {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            line-height: 1.8;
        }
        .policy-card h1 {
            color: #ff1493;
            text-align: center;
            text-transform: uppercase;
            margin-bottom: 40px;
            font-weight: 800;
        }
        .section-title {
            color: #d81b60;
            font-size: 1.3rem;
            margin-top: 30px;
            border-bottom: 2px solid #fce4ec;
            display: inline-block;
            margin-bottom: 15px;
        }
        .method-box {
            margin-bottom: 25px;
            padding-left: 15px;
        }
        .method-name {
            font-weight: bold;
            color: #333;
            font-size: 1.1rem;
            display: block;
            margin-bottom: 5px;
        }
        .bank-info {
            background: #fdf2f8;
            border-radius: 8px;
            padding: 20px;
            margin: 15px 0;
            border: 1px solid #fbcfe8;
        }
        .important-note {
            background-color: #fff0f6;
            border-left: 5px solid #ff1493;
            padding: 20px;
            margin: 30px 0;
        }
        .important-note strong { color: #d81b60; }

        /* Style Box Liên hệ nền hồng viền đứt đoạn */
        .pink-contact-box {
            background-color: #fff0f5;
            border: 2px dashed #ff69b4;
            border-radius: 10px;
            padding: 25px;
            margin-top: 40px;
            color: #333;
        }
        .pink-contact-box strong {
            display: block;
            margin-bottom: 10px;
            font-size: 1.1rem;
            text-transform: uppercase;
        }
        .pink-contact-box i {
            color: #ff1493;
            margin-right: 10px;
            width: 20px;
        }
    </style>
</head>
<body>

<header>
    <nav class="navbar">
        <div class="logo">
            <img src="/images/logo/Screenshot 2026-03-19 014252.png" style="border-radius: 20px;" width="20%"
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
            <input type="text" name="search" placeholder="Tìm kiếm...">
            <button><i class="fas fa-search"></i></button>
        </div>
    </nav>
</header>

<main class="policy-wrapper">
    <div class="policy-card">
        <h1>Chính sách thanh toán</h1>

        <p>Chào mừng quý khách đến với <strong>Medi Den</strong>. Để mang lại trải nghiệm mua sắm tiện lợi nhất, chúng tôi áp dụng đa dạng các hình thức thanh toán an toàn và linh hoạt như sau:</p>

        <h2 class="section-title">1. Thanh toán trả trước (Chuyển khoản)</h2>
        <div class="method-box">
            <span class="method-name">Áp dụng cho mọi đơn hàng hoặc bắt buộc với đơn hàng trên 500.000 VNĐ.</span>
            <p>Sau khi chốt đơn, quý khách vui lòng chuyển khoản vào tài khoản chính thức của shop. Nội dung chuyển khoản ghi rõ: <strong>[Họ tên + Số điện thoại đặt hàng]</strong>.</p>

            <div class="bank-info">
                <strong>Thông tin tài khoản ngân hàng:</strong><br>
                Ngân hàng: <strong>Techcombank (TCB)</strong><br>
                Số tài khoản: <strong>19061706200888</strong><br>
                Chủ tài khoản: <strong>DANG HUNG ANH</strong><br>
                Chi nhánh: Hà Nội
            </div>
            <p><em>*Lưu ý: Sau khi chuyển tiền thành công, quý khách vui lòng chụp lại màn hình giao dịch để nhân viên Medi Den xác nhận nhanh nhất.</em></p>
        </div>

        <h2 class="section-title">2. Thanh toán khi nhận hàng (COD)</h2>
        <div class="method-box">
            <span class="method-name">Trả tiền mặt trực tiếp cho nhân viên giao hàng.</span>
            <p>Quý khách sẽ thanh toán toàn bộ giá trị đơn hàng (bao gồm tiền sản phẩm và phí vận chuyển nếu có) cho nhân viên giao hàng sau khi nhận hàng thành công.</p>
        </div>

        <div class="important-note">
            <strong> QUY ĐỊNH ĐỒNG KIỂM & NHẬN HÀNG:</strong>
            <ul>
                <li>Nhằm đảm bảo tính nguyên vẹn của niêm phong, <strong>Medi Den không áp dụng chế độ đồng kiểm</strong> (thử hàng trước khi thanh toán).</li>
                <li>Quý khách vui lòng <strong>Quay video quá trình mở hàng</strong> ngay khi nhận. Đây là tư liệu quan trọng nhất để Medi Den hỗ trợ giải quyết các khiếu nại về thiếu hàng, sai mẫu hoặc sản phẩm hư hỏng.</li>
                <li>Mọi khiếu nại không có video mở hàng có thể sẽ bị từ chối xử lý theo quy định của shop.</li>
            </ul>
        </div>

        <h2 class="section-title">3. Bảo mật thông tin thanh toán</h2>
        <p>Medi Den cam kết bảo mật tuyệt đối thông tin cá nhân và thông tin tài khoản của khách hàng. Chúng tôi không lưu trữ thông tin thẻ ngân hàng của bạn trên hệ thống công khai.</p>

        <!-- Box liên hệ nền hồng viền đứt đoạn -->
        <div class="pink-contact-box">
            <strong>Thông tin liên hệ hỗ trợ thanh toán</strong>
            <p><i class="fas fa-phone-alt"></i> Hotline tư vấn: <span style="color: #ff1493; font-weight: bold;">08 2222 1992</span></p>
            <p><i class="fas fa-envelope"></i> Email: MediDen8888@gmail.com</p>
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