<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Chính sách giao nhận - Medi Den</title>
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
        /* Style chung cho tất cả các danh sách để thụt lề thống nhất */
        .policy-card ul {
            margin-left: 40px; /* Thụt vào lề đồng nhất */
            margin-top: 10px;
            margin-bottom: 15px;
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
        /* Danh sách trong box lưu ý bỏ dấu chấm tròn vì đã có dấu gạch ngang */
        .important-note-box ul {
            list-style-type: none;
            margin-left: 20px;
        }

        .pink-contact-box {
            background-color: #fff0f5;
            border: 2px dashed #ff69b4;
            border-radius: 10px;
            padding: 25px;
            margin-top: 40px;
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
        <h1>Chính sách giao nhận hàng</h1>

        <p>Nhằm đáp ứng nhu cầu mua sắm Sneaker trực tuyến ngày càng cao, <strong>Medi Den</strong> hân hạnh gửi tới Quý khách chính sách vận chuyển linh hoạt. Chúng tôi cam kết thủ tục nhanh chóng, đảm bảo đôi giày của bạn được đóng gói kỹ lưỡng và giao tận tay trong thời gian ngắn nhất.</p>

        <h2 class="section-title">2.1 Đặt hàng và xác nhận đơn hàng</h2>
        <p>Khi đặt hàng, Quý khách vui lòng cung cấp đầy đủ và chính xác các thông tin (Số điện thoại, địa chỉ cụ thể). Chúng tôi không chịu trách nhiệm đối với trường hợp giao hàng chậm trễ hay thất lạc do thông tin sai lệch.</p>
        <p>Sau khi đặt hàng thành công, đội ngũ CSKH của <strong>Medi Den</strong> sẽ liên hệ qua điện thoại để xác minh đơn hàng và thống nhất thời gian giao nhận.</p>

        <h2 class="section-title">2.2 Hình thức thanh toán</h2>
        <ul style="list-style-type: disc;">
            <li><strong>Thanh toán trả trước:</strong> Chuyển khoản qua ngân hàng (Ưu tiên xử lý đơn hàng nhanh).</li>
            <li><strong>Thanh toán trả sau (COD):</strong> Quý khách nhận hàng và thanh toán tiền mặt trực tiếp cho bưu tá.</li>
        </ul>

        <h2 class="section-title">2.3 Kiểm tra tình trạng đơn hàng</h2>
        <p>Để tra cứu đơn hàng đã gửi đi hay chưa, Quý khách có thể:</p>
        <ul style="list-style-type: disc;">
            <li>Sử dụng mã vận đơn tại mục <strong>Tra cứu đơn hàng</strong> trên website.</li>
            <li>Liên hệ trực tiếp Hotline: <span class="highlight-text">08 2222 1992</span> để gặp nhân viên hỗ trợ.</li>
        </ul>

        <h2 class="section-title">2.4 Khu vực và Thời gian giao hàng</h2>
        <p>Hiện tại, <strong>Medi Den</strong> tập trung phục vụ và giao hàng
            <span class="highlight-text">duy nhất tại khu vực nội thành và ngoại thành Hà Nội</span>
            để đảm bảo chất lượng phục vụ tốt nhất.</p>

        <p style="margin-top: 15px;"><strong>Thời gian nhận hàng dự kiến:</strong></p>
        <ul style="list-style-type: disc;">
            <li><strong>Giao hàng tiêu chuẩn:</strong> 1 - 2 ngày làm việc.</li>
            <li><strong>Giao hàng hỏa tốc:</strong> Nhận hàng ngay trong vòng 2 giờ (Vui lòng liên hệ Hotline).</li>
        </ul>

        <div class="important-note-box">
            <strong>⚠️ LƯU Ý QUAN TRỌNG:</strong>
            <ul>
                <li>- Đơn hàng <span class="highlight-text">KHÔNG ĐỒNG KIỂM</span> (Theo quy định bảo mật niêm phong sản phẩm).</li>
                <li>- Quý khách vui lòng <strong>QUAY VIDEO CLIP KHI MỞ HỘP HÀNG</strong>. Đây là bằng chứng duy nhất để Medi Den giải quyết các khiếu nại về việc thiếu hàng, sai mẫu hoặc hư hỏng do vận chuyển.</li>
            </ul>
        </div>

        <h2 class="section-title">2.5 Chi phí giao hàng</h2>
        <ul style="list-style-type: disc;">
            <li><strong>Cước phí cố định:</strong> <span class="highlight-text">30.000 VNĐ</span> áp dụng cho mọi đơn hàng Sneaker tại khu vực Hà Nội.</li>
            <li>Trong một số trường hợp đơn hàng nặng hoặc yêu cầu hỏa tốc, phí vận chuyển sẽ được thỏa thuận trực tiếp dựa trên đơn vị vận chuyển bên thứ 3.</li>
        </ul>

        <h2 class="section-title">2.6 Trường hợp đơn hàng bị hủy</h2>
        <p>Đơn hàng sẽ bị hủy nếu nhân viên giao hàng không thể liên hệ với Quý khách quá 03 lần hoặc Quý khách vắng mặt tại điểm giao mà không hẹn trước.</p>

        <!-- Box liên hệ nền hồng viền đứt đoạn -->
        <div class="pink-contact-box">
            <strong>Thông tin hỗ trợ vận chuyển - Medi Den</strong>
            <p><i class="fas fa-phone-alt"></i> Hotline: <span style="color: #ff1493; font-weight: bold;">08 2222 1992</span></p>
            <p><i class="fas fa-envelope"></i> Email: MediDen8888@gmail.com</p>
            <p><i class="fas fa-map-marker-alt"></i> Địa chỉ gửi hàng: 118 Đ. Phương Canh, Nam Từ Liêm, Hà Nội.</p>
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