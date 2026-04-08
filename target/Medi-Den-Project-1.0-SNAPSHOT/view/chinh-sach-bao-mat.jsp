<%@ page import="com.example.Medi_Den_Project.entity.TaiKhoan" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Chính sách bảo mật - Medi Den</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/view/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* CSS cho phần nội dung chính sách */
        .policy-container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 40px;
            background: #fff;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            border-radius: 10px;
            line-height: 1.8;
            color: #333;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .policy-container h1 {
            color: #ff1493;
            text-align: center;
            text-transform: uppercase;
            margin-bottom: 30px;
            font-weight: 800;
        }
        .policy-container h2 {
            color: #333;
            border-left: 4px solid #ff1493;
            padding-left: 15px;
            margin-top: 30px;
            font-size: 1.4rem;
            text-transform: uppercase;
        }
        .policy-container h3 {
            color: #555;
            margin-top: 20px;
            font-size: 1.1rem;
        }
        .policy-container p, .policy-container li {
            margin-bottom: 10px;
            text-align: justify;
        }
        .policy-container ul {
            padding-left: 20px;
        }
        .highlight {
            color: #ff1493;
            font-weight: bold;
        }
        .contact-box {
            background: #fff0f6;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
            border: 1px dashed #ff1493;
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
        <a class="btn logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        <%
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

<!-- PHẦN NỘI DUNG CHÍNH SÁCH BẢO MẬT & ĐỔI TRẢ -->
<main class="policy-container">
    <h1>Chính sách bảo mật</h1>

    <h2>4. CHÍNH SÁCH ĐỔI TRẢ HÀNG</h2>

    <h3>4.1. Điều kiện đổi trả</h3>
    <p>Chúng tôi hỗ trợ đổi trả sản phẩm trong vòng <span class="highlight">10 ngày</span> kể từ ngày nhận hàng.</p>
    <ul>
        <li>Đổi trả sản phẩm nếu có lỗi từ nhà sản xuất: đế bị bong tróc, nứt, lỗi đường may, hoặc các lỗi kỹ thuật về form dáng.</li>
        <li>Đổi trả sản phẩm miễn phí nếu khách hàng gặp bất kỳ vấn đề kích ứng hoặc không vừa size (đối với hàng chưa qua sử dụng).</li>
        <li>Hàng không đúng với sản phẩm khách hàng đã đặt đơn (sai mẫu, sai màu, sai size).</li>
    </ul>
    <p><strong>Yêu cầu sản phẩm:</strong> Phải còn nguyên tem mác, hộp đựng và chưa qua sử dụng. Mã đơn hàng phải trùng khớp với thông tin hệ thống.</p>

    <h3>4.1.1 Sản phẩm nguyên giá & Khuyến mãi</h3>
    <ul>
        <li><strong>Sản phẩm nguyên giá:</strong> Được đổi sang sản phẩm khác giá trị tương đương hoặc cao hơn (bù chênh lệch).</li>
        <li><strong>Sản phẩm khuyến mãi:</strong> Vẫn hỗ trợ đổi trả theo chương trình hiện hành tại thời điểm đổi.</li>
    </ul>

    <h2>4.2. Quy trình và thủ tục</h2>
    <p>1. Gọi điện hoặc gửi email thông báo tình trạng sản phẩm kèm hình ảnh/video lỗi.</p>
    <p>2. Gửi hàng về kho của <span class="highlight">Medi Den</span> (đảm bảo hàng nguyên vẹn, không hư hại do cố ý).</p>
    <p>3. Thời gian xử lý: Trong vòng <strong>03 ngày làm việc</strong> kể từ khi nhận được hàng.</p>

    <h2>4.3. Cước phí vận chuyển</h2>
    <ul>
        <li><strong>Lỗi do shop (Giao sai, hàng lỗi):</strong> Shop chịu 100% phí vận chuyển lượt về và lượt đi lần 2.</li>
        <li><strong>Lỗi do khách hàng (Muốn đổi mẫu, đổi size):</strong> Khách hàng chịu phí vận chuyển 2 chiều.</li>
    </ul>

    <div class="contact-box">
        <p><strong>Thông tin liên hệ hỗ trợ:</strong></p>
        <p><i class="fas fa-phone-alt"></i> Tổng đài tư vấn: <span class="highlight">08 2222 1992</span></p>
        <p><i class="fas fa-envelope"></i> Email: MediDen8888@gmail.com</p>
        <p><i class="fas fa-map-marker-alt"></i> Địa chỉ: 118 Đ. Phương Canh, Nam Từ Liêm, Hà Nội.</p>
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