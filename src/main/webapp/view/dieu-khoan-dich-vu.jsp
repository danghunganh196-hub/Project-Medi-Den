<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Điều khoản dịch vụ - Medi Den</title>
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
            line-height: 1.8;
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
            font-weight: 800;
        }
        .section-title {
            color: #d81b60;
            border-bottom: 2px solid #fce4ec;
            padding-bottom: 5px;
            margin-top: 30px;
            font-size: 1.3rem;
            font-weight: bold;
        }
        .highlight-text {
            color: #ff1493;
            font-weight: bold;
        }
        /* Căn chỉnh thụt lề thống nhất cho danh sách */
        .policy-card ul {
            margin-left: 40px;
            margin-top: 10px;
            margin-bottom: 15px;
            list-style-type: disc;
        }
        .policy-card ul li {
            margin-bottom: 8px;
        }
        .important-note-box {
            background-color: #fff5f8;
            border-left: 5px solid #ff1493;
            padding: 20px;
            margin: 25px 0;
        }
        /* Box liên hệ nền hồng viền đứt đoạn đồng bộ */
        .pink-contact-box {
            background-color: #fff0f5;
            border: 2px dashed #ff69b4;
            border-radius: 10px;
            padding: 25px;
            margin-top: 40px;
        }
        .pink-contact-box strong {
            display: block;
            margin-bottom: 15px;
            font-size: 1.1rem;
            text-transform: uppercase;
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
            <input type="text" name="search" placeholder="Tìm kiếm...">
            <button><i class="fas fa-search"></i></button>
        </div>
    </nav>

</header>

<main class="policy-wrapper">
    <div class="policy-card">
        <h1>Điều khoản dịch vụ</h1>

        <p>Chào mừng Quý khách hàng đến với hệ thống mua sắm Sneaker trực tuyến của <strong>Medi Den</strong>. Khi truy cập và sử dụng dịch vụ tại website, Quý khách đồng ý tuân thủ các điều khoản và điều kiện dưới đây.</p>

        <h2 class="section-title">1. Giới thiệu</h2>
        <p>Bằng việc truy cập vào website <strong>Medi Den</strong>, Quý khách xác nhận đã hiểu và đồng ý với các điều khoản này. Chúng tôi có quyền thay đổi, chỉnh sửa hoặc lược bỏ bất kỳ phần nào trong Điều khoản dịch vụ vào bất cứ lúc nào. Các thay đổi sẽ có hiệu lực ngay khi được đăng tải mà không cần thông báo trước.</p>
        <p>Quý khách vui lòng kiểm tra thường xuyên mục này để cập nhật những thay đổi mới nhất nhằm đảm bảo quyền lợi khi mua sắm.</p>

        <h2 class="section-title">2. Hướng dẫn sử dụng website</h2>
        <p>Để đảm bảo giao dịch an toàn, Quý khách hàng cần tuân thủ các quy định sau:</p>
        <ul>
            <li>Khách hàng phải đảm bảo đủ 18 tuổi hoặc truy cập dưới sự giám sát của người giám hộ hợp pháp.</li>
            <li>Có đầy đủ năng lực hành vi dân sự để thực hiện giao dịch mua bán theo quy định pháp luật Việt Nam.</li>
            <li>Cung cấp thông tin cá nhân (Họ tên, SĐT, Địa chỉ) chính xác để <strong>Medi Den</strong> phục vụ việc giao hàng tốt nhất.</li>
            <li>Quý khách đồng ý nhận email thông báo về tình trạng đơn hàng hoặc thông tin khuyến mãi. Nếu không muốn tiếp tục nhận tin, Quý khách có thể từ chối qua đường link ở cuối mỗi email.</li>
        </ul>

        <h2 class="section-title">3. Thanh toán an toàn và tiện lợi</h2>
        <p>Tại <strong>Medi Den</strong>, Quý khách có thể lựa chọn các phương thức thanh toán linh hoạt sau:</p>
        <ul>
            <li><strong>Cách 1: Thanh toán trực tiếp:</strong> Quý khách đến xem và thử giày trực tiếp tại kho hàng tại địa chỉ: 118 Đ. Phương Canh, Nam Từ Liêm, Hà Nội.</li>
            <li><strong>Cách 2: Thanh toán sau (COD):</strong> Quý khách nhận hàng tại địa chỉ yêu cầu và thanh toán tiền mặt trực tiếp cho nhân viên giao hàng.</li>
            <li><strong>Cách 3: Thanh toán Online:</strong> Chuyển khoản qua ngân hàng hoặc ví điện tử (Thông tin tài khoản sẽ được nhân viên CSKH cung cấp khi xác nhận đơn).</li>
        </ul>

        <div class="important-note-box">
            <strong>⚠️ LƯU Ý VỀ GIAO DỊCH:</strong>
            <p>Mọi giao dịch trên website đều được cam kết bảo mật thông tin tuyệt đối. <strong>Medi Den</strong> khuyến khích Quý khách không chia sẻ thông tin tài khoản hoặc mã OTP cho bất kỳ ai khác.</p>
        </div>

        <h2 class="section-title">4. Quyền và trách nhiệm của Medi Den</h2>
        <p>Chúng tôi cam kết cung cấp sản phẩm Sneaker đúng chất lượng, đúng hình ảnh đã đăng tải. Trong trường hợp có sự cố về sản phẩm hoặc dịch vụ, <strong>Medi Den</strong> sẽ giải quyết dựa trên tinh thần hỗ trợ khách hàng tối đa theo đúng <em>Chính sách Đổi trả</em> đã công bố.</p>

        <!-- Box liên hệ nền hồng viền đứt đoạn đồng bộ với các trang khác -->
        <div class="pink-contact-box">
            <strong>Hỗ trợ khách hàng - Medi Den Sneaker</strong>
            <p>
                <i class="fas fa-phone-alt"></i> Hotline hỗ trợ:
                <span style="margin-left: 5px; color: #ff1493; font-weight: bold;">08 2222 1992</span>
            </p>
            <p><i class="fas fa-envelope"></i> Email: MediDen8888@gmail.com</p>
            <p><i class="fas fa-clock"></i> Thời gian làm việc: 08:30 - 22:00 (Tất cả các ngày trong tuần)</p>
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