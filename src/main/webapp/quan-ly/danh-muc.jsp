<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Medi Den Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #ff2d55;
            --accent-color: #00ffcc;
            --bg-dark: #0f0f0f;
            --card-bg: #1a1a1a;
            --text-light: #ffffff;
            --text-gray: #aaaaaa;
        }
<<<<<<< HEAD

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: #ffffff;
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* ── TOPBAR ── */
        .topbar {
            background: var(--pink);
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 32px;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 16px rgba(240,18,122,0.25);
        }

        .topbar-logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .logo-icon {
            width: 40px; height: 40px;
            background: white;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-weight: 800; font-size: 18px;
            color: var(--pink);
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        .logo-text {
            color: white;
            font-size: 20px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        .topbar-title {
            color: white;
            font-size: 17px;
            font-weight: 600;
            letter-spacing: 0.3px;
        }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .topbar-search {
            display: flex;
            align-items: center;
            background: rgba(255,255,255,0.2);
            border: 1.5px solid rgba(255,255,255,0.35);
            border-radius: 24px;
            padding: 6px 16px;
            gap: 8px;
            transition: background 0.25s, border-color 0.25s;
            cursor: pointer;
        }
        .topbar-search:hover {
            background: rgba(255,255,255,0.32);
            border-color: rgba(255,255,255,0.6);
        }
        .topbar-search input {
            background: transparent;
            border: none; outline: none;
            color: white; font-family: inherit;
            font-size: 14px; width: 160px;
        }
        .topbar-search input::placeholder { color: rgba(255,255,255,0.7); }
        .topbar-search svg { opacity: 0.8; }

        .topbar-avatar {
            width: 36px; height: 36px;
            background: white;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: 700; font-size: 15px; color: var(--pink);
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
        }
        .topbar-avatar:hover { transform: scale(1.08); box-shadow: 0 4px 16px rgba(0,0,0,0.18); }

        /* ── LAYOUT ── */
        .layout {
            display: flex;
            min-height: calc(100vh - 64px);
        }

        /* ── SIDEBAR ── */
        .sidebar {
            width: 260px;
            background: var(--sidebar-bg);
            padding: 28px 0 24px;
            display: flex;
            flex-direction: column;
            gap: 4px;
            border-right: 1.5px solid rgba(240,18,122,0.12);
            position: sticky;
            top: 64px;
            height: calc(100vh - 64px);
            overflow-y: auto;
        }

        .sidebar-section {
            padding: 0 16px;
            margin-bottom: 8px;
        }
        .sidebar-section-label {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            color: var(--text-light);
            padding: 0 12px;
            margin-bottom: 6px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 11px 14px;
            border-radius: 12px;
            cursor: pointer;
            color: var(--text-mid);
            font-size: 14.5px;
            font-weight: 500;
            transition: background 0.2s, color 0.2s, transform 0.15s, box-shadow 0.2s;
            position: relative;
            user-select: none;
        }
        .nav-item .nav-icon {
            width: 36px; height: 36px;
            background: rgba(240,18,122,0.08);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
            transition: background 0.2s, transform 0.2s;
            font-size: 17px;
        }
        .nav-item:hover {
            background: #fdf0f7;
            color: var(--pink);
            transform: translateX(3px);
            box-shadow: 0 2px 12px var(--pink-glow);
        }
        .nav-item:hover .nav-icon {
            background: var(--pink-soft);
            transform: scale(1.1);
        }
        .nav-item.active {
            background: var(--pink);
            color: white;
            box-shadow: 0 4px 16px var(--pink-glow);
        }
        .nav-item.active .nav-icon {
            background: rgba(255,255,255,0.22);
        }
        .nav-badge {
            margin-left: auto;
            background: var(--pink);
            color: white;
            font-size: 11px;
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 10px;
            min-width: 22px;
            text-align: center;
        }
        .nav-item.active .nav-badge {
            background: rgba(255,255,255,0.3);
        }

        .sidebar-divider {
            height: 1px;
            background: rgba(240,18,122,0.12);
            margin: 10px 20px;
        }

        /* ── MAIN ── */
        .main {
            flex: 1;
            padding: 32px 36px;
            overflow-y: auto;
            background: #ffffff;
        }

        .page-header {
            margin-bottom: 32px;
        }
        .page-header h1 {
            font-size: 26px;
            font-weight: 800;
            color: var(--text-dark);
            letter-spacing: -0.5px;
        }

        /* ── STAT CARDS ── */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 32px;
        }
        .stat-card {
            background: white;
            border-radius: var(--radius);
            padding: 22px 24px;
            box-shadow: var(--shadow);
            border: 1.5px solid rgba(240,18,122,0.07);
            cursor: pointer;
            transition: transform 0.22s, box-shadow 0.22s, border-color 0.22s;
            position: relative;
            overflow: hidden;
        }
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: var(--pink);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.3s ease;
        }
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 36px rgba(240,18,122,0.15);
            border-color: rgba(240,18,122,0.2);
        }
        .stat-card:hover::before { transform: scaleX(1); }

        .stat-icon {
            width: 46px; height: 46px;
            background: var(--pink-soft);
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px;
            margin-bottom: 14px;
            transition: transform 0.2s;
        }
        .stat-card:hover .stat-icon { transform: scale(1.1) rotate(-5deg); }
        .stat-value {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-dark);
            line-height: 1;
            margin-bottom: 4px;
        }
        .stat-label {
            font-size: 13px;
            color: var(--text-light);
            font-weight: 500;
        }
        .stat-change {
            font-size: 12px;
            font-weight: 600;
            color: #16a34a;
            margin-top: 8px;
        }
        .stat-change.down { color: #dc2626; }

        /* ── CARD ── */
        .card {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            border: 1.5px solid rgba(240,18,122,0.07);
            overflow: hidden;
            margin-bottom: 24px;
        }
        .card-header {
            padding: 20px 24px 16px;
            border-bottom: 1.5px solid rgba(240,18,122,0.08);
            display: flex; align-items: center; justify-content: space-between;
        }
        .card-title {
            font-size: 15px;
            font-weight: 700;
            color: var(--text-dark);
        }
        .card-action {
            font-size: 12.5px;
            font-weight: 600;
            color: var(--pink);
            cursor: pointer;
            transition: opacity 0.2s;
        }
        .card-action:hover { opacity: 0.7; }

        /* ── TABLE ── */
        .table-wrap { padding: 0; }
        table { width: 100%; border-collapse: collapse; }
        thead th {
            padding: 12px 20px;
            text-align: left;
            font-size: 11.5px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: var(--text-light);
            background: #fdf0f7;
            border-bottom: 1.5px solid rgba(240,18,122,0.08);
        }
        tbody tr {
            border-bottom: 1px solid rgba(240,18,122,0.06);
            transition: background 0.18s;
            cursor: pointer;
        }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: #fdf0f7; }
        tbody td {
            padding: 13px 20px;
            font-size: 13.5px;
            color: var(--text-dark);
            font-weight: 500;
        }
        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 700;
        }
        .badge-green { background: #dcfce7; color: #16a34a; }
        .badge-yellow { background: #fef9c3; color: #a16207; }
        .badge-red { background: #fee2e2; color: #dc2626; }
        .badge-pink { background: var(--pink-soft); color: var(--pink-dark); }

        /* ── QUICK LINKS ── */
        .quick-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
        }
        .quick-card {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            display: flex; flex-direction: column; align-items: center; gap: 10px;
            box-shadow: var(--shadow);
            border: 1.5px solid rgba(240,18,122,0.07);
            cursor: pointer;
            transition: transform 0.22s, box-shadow 0.22s, background 0.22s;
            text-align: center;
        }
        .quick-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 32px var(--pink-glow);
            background: var(--pink);
        }
        .quick-card:hover .quick-icon { background: rgba(255,255,255,0.2); }
        .quick-card:hover .quick-label { color: white; }
        .quick-card:hover .quick-desc { color: rgba(255,255,255,0.75); }
        .quick-icon {
            width: 48px; height: 48px;
            background: var(--pink-soft);
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px;
            transition: background 0.22s, transform 0.22s;
        }
        .quick-card:hover .quick-icon { transform: scale(1.12) rotate(-6deg); }
        .quick-label { font-size: 14px; font-weight: 700; color: var(--text-dark); transition: color 0.22s; }
        .quick-desc { font-size: 12px; color: var(--text-light); transition: color 0.22s; line-height: 1.4; }

=======

        body {
            font-family: 'Arial', sans-serif;
            background-color: var(--bg-dark);
            color: var(--text-light);
            margin: 0;
            padding: 0;
        }

        header {
            background: #000;
            border-bottom: 2px solid var(--primary-color);
        }

        .top-bar {
            text-align: right;
            padding: 8px 5%;
            font-size: 12px;
            background: #111;
            color: var(--text-gray);
            letter-spacing: 1px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo h1 {
            font-size: 24px;
            color: var(--text-light);
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 20px;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            color: var(--text-light);
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        .admin-wrapper {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            border-left: 5px solid var(--primary-color);
            padding-left: 15px;
        }

        .page-header h2 {
            margin: 0;
            font-size: 28px;
            letter-spacing: 1px;
        }

        .card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            margin-bottom: 30px;
        }

        .form-add {
            display: flex;
            gap: 15px;
        }

        .pink-input {
            flex: 1;
            background: #222;
            border: 1px solid #333;
            padding: 12px 20px;
            border-radius: 8px;
            color: white;
            outline: none;
            transition: 0.3s;
            font-size: 14px;
        }

        .pink-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 10px rgba(255, 45, 85, 0.3);
        }

        .btn-pink {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }

        .btn-pink:hover {
            background: #e0244b;
            transform: translateY(-2px);
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        th {
            text-align: left;
            padding: 15px;
            color: var(--text-gray);
            font-weight: normal;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 1px;
        }

        td {
            background: #222;
            padding: 15px;
            vertical-align: middle;
        }

        td:first-child { border-radius: 10px 0 0 10px; text-align: center; width: 80px; }
        td:last-child { border-radius: 0 10px 10px 0; text-align: right; }

        tr:hover td {
            background: #2a2a2a;
        }

        .category-name {
            font-weight: 600;
            font-size: 16px;
        }

        .action-btn {
            width: 35px;
            height: 35px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            margin-left: 8px;
            transition: 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-edit { background: rgba(0, 255, 204, 0.1); color: var(--accent-color); }
        .btn-edit:hover { background: var(--accent-color); color: black; }

        .btn-delete { background: rgba(255, 45, 85, 0.1); color: var(--primary-color); }
        .btn-delete:hover { background: var(--primary-color); color: white; }

        footer {
            margin-top: 100px;
            padding: 40px;
            background: #000;
            text-align: center;
            border-top: 1px solid #222;
        }

        .footer-logo h2 { color: var(--primary-color); margin-bottom: 10px; }
        .copy { color: var(--text-gray); font-size: 13px; }
>>>>>>> 901322a5e3fa8ffe56dc819060cca1571310d667
    </style>
</head>
<body>

<header>
    <div class="top-bar">HỆ THỐNG QUẢN TRỊ ADMIN</div>
    <nav class="navbar">
        <div class="logo">
            <img src="https://via.placeholder.com/50" style="border-radius: 10px;" width="40" alt="Logo">
            <h1>Medi Den</h1>
        </div>
        <ul class="nav-links">
            <li><a href="#"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="#" style="color: var(--primary-color);"><i class="fas fa-list"></i> Danh mục</a></li>
            <li><a href="#"><i class="fas fa-shoe-prints"></i> Sản phẩm</a></li>
            <li><a href="#"><i class="fas fa-shopping-cart"></i> Đơn hàng</a></li>
        </ul>
    </nav>
</header>

<main class="admin-wrapper">
    <div class="page-header">
        <h2>QUẢN LÝ DANH MỤC</h2>
        <span style="color: var(--text-gray)">Home / Category</span>
    </div>

    <div class="card">
        <form action="/the-loai/add" method="post" class="form-add">
            <input type="text" name="ten_the_loai" class="pink-input"
                   placeholder="Tên danh mục mới (vd: Giày Chạy Bộ)..." required>
            <button type="submit" class="btn-pink">
                <i class="fas fa-plus"></i> THÊM DANH MỤC
            </button>
        </form>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>TÊN DANH MỤC</th>
                <th>NGÀY TẠO</th>
                <th>THAO TÁC</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>#01</td>
                <td><span class="category-name">NIKE CLASSIC</span></td>
                <td style="color: #666;">23/03/2026</td>
                <td>
                    <button class="action-btn btn-edit" title="Sửa"><i class="fas fa-pen"></i></button>
                    <button class="action-btn btn-delete" title="Xóa"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            <tr>
                <td>#02</td>
                <td><span class="category-name">ADIDAS ULTRABOOST</span></td>
                <td style="color: #666;">22/03/2026</td>
                <td>
                    <button class="action-btn btn-edit" title="Sửa"><i class="fas fa-pen"></i></button>
                    <button class="action-btn btn-delete" title="Xóa"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            <tr>
                <td>#03</td>
                <td><span class="category-name">JORDAN SPECIAL</span></td>
                <td style="color: #666;">21/03/2026</td>
                <td>
                    <button class="action-btn btn-edit" title="Sửa"><i class="fas fa-pen"></i></button>
                    <button class="action-btn btn-delete" title="Xóa"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</main>

<<<<<<< HEAD
        <div class="sidebar-section">
            <div class="sidebar-section-label">Quản lý</div>
            <div class="nav-item active" onclick="window.location.href='${pageContext.request.contextPath}/danh-muc'">
                <div class="nav-icon">📂</div>
                Quản lý danh mục
                <span class="nav-badge">4</span>
            </div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/san-pham'">
                <div class="nav-icon">👟</div>
                Quản lý sản phẩm
                <span class="nav-badge">24</span>
            </div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/don-hang'">
                <div class="nav-icon">🛒</div>
                Quản lý đơn hàng
                <span class="nav-badge">7</span>
            </div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/khach-hang'">
                <div class="nav-icon">👥</div>
                Quản lý khách hàng
            </div>
        </div>

        <div class="sidebar-divider"></div>

        <div class="sidebar-section">
            <div class="sidebar-section-label">Hệ thống</div>
            <div class="nav-item">
                <div class="nav-icon">📊</div>
                Thống kê & Báo cáo
            </div>
            <div class="nav-item">
                <div class="nav-icon">⚙️</div>
                Cài đặt
            </div>
        </div>
    </nav>

    <!-- MAIN -->
    <main class="main">
        <div class="page-header" style="display:flex; align-items:center; justify-content:space-between; margin-bottom:16px;">
            <h1>Quản lý danh mục</h1>
            <div style="display:flex; gap:10px;">
                <button class="btn-pink" onclick="toggleForm('them')">＋ Thêm danh mục</button>
                <button class="btn-edit" id="btnSua" style="padding:9px 20px; font-size:13.5px; border-radius:10px; opacity:0.5; cursor:not-allowed;" disabled onclick="toggleForm('sua')">Sửa</button>
            </div>
        </div>

        <%-- FORM THÊM / SỬA --%>
        <div id="formCard" class="card" style="display:none; margin-bottom:24px;">
            <div class="card-header">
                <span class="card-title" id="formTitle">Thêm danh mục mới</span>
                <span class="card-action" onclick="dongForm()">✕ Đóng</span>
            </div>
            <div style="padding:24px;">
                <form method="post" action="${pageContext.request.contextPath}/danh-muc/">
                    <input type="hidden" name="action" id="formAction" value="them">
                    <input type="hidden" name="id" id="formId" value="">
                    <div style="display:flex; gap:16px; align-items:flex-end;">
                        <div style="flex:1;">
                            <label style="display:block; font-size:13px; font-weight:600; color:var(--text-mid); margin-bottom:8px;">Tên thể loại</label>
                            <input type="text" name="tenTheLoai" id="inputTen"
                                   placeholder="Nhập tên thể loại..."
                                   style="width:100%; padding:10px 14px; border:1.5px solid rgba(240,18,122,0.2); border-radius:10px; font-family:inherit; font-size:14px; outline:none; transition:border-color 0.2s;"
                                   onfocus="this.style.borderColor='var(--pink)'" onblur="this.style.borderColor='rgba(240,18,122,0.2)'">
                        </div>
                        <button type="submit" class="btn-pink" style="white-space:nowrap;" id="btnSubmit">Thêm</button>
                    </div>
                </form>
            </div>
        </div>

        <%-- TABLE --%>
        <div class="card">
            <div class="card-header">
                <span class="card-title">Danh sách thể loại</span>
                <span style="font-size:13px; color:var(--text-light);">Tổng: <strong>${listTheLoai.size()}</strong> danh mục</span>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên thể loại</th>
                        <th style="text-align:right; padding-right:24px;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="tl" items="${listTheLoai}">
                        <tr onclick="chonRow(this, '${tl.id}', '${tl.tenTheLoai}')" style="cursor:pointer;">
                            <td style="color:var(--text-light); font-size:13px;">#${tl.id}</td>
                            <td><strong>${tl.tenTheLoai}</strong></td>
                            <td style="text-align:right; padding-right:24px;">
                                <button class="btn-delete" onclick="event.stopPropagation()">Xóa</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        let selectedId = null;

        function toggleForm(mode) {
            const formCard = document.getElementById('formCard');
            const formTitle = document.getElementById('formTitle');
            const formAction = document.getElementById('formAction');
            const btnSubmit = document.getElementById('btnSubmit');
            const inputTen = document.getElementById('inputTen');

            if (mode === 'sua' && !selectedId) return;

            // Nếu form đang mở cùng mode thì đóng lại
            if (formCard.style.display !== 'none' && formCard.dataset.mode === mode) {
                dongForm(); return;
            }

            formCard.dataset.mode = mode;
            formCard.style.display = 'block';

            if (mode === 'them') {
                formTitle.textContent = 'Thêm danh mục mới';
                formAction.value = 'them';
                btnSubmit.textContent = '＋ Thêm';
                inputTen.value = '';
                document.getElementById('formId').value = '';
            } else {
                formTitle.textContent = 'Sửa danh mục';
                formAction.value = 'sua';
                btnSubmit.textContent = '💾 Lưu';
                // inputTen.value đã được set bởi chonRow()
            }

            inputTen.focus();
        }

        function dongForm() {
            document.getElementById('formCard').style.display = 'none';
        }

        function chonRow(row, id, ten) {
            // Bỏ chọn row cũ
            document.querySelectorAll('tbody tr').forEach(r => r.style.background = '');

            if (selectedId === id) {
                // Click lại row đang chọn → bỏ chọn
                selectedId = null;
                const btn = document.getElementById('btnSua');
                btn.disabled = true; btn.style.opacity = '0.5'; btn.style.cursor = 'not-allowed';
                dongForm();
                return;
            }

            // Chọn row mới
            selectedId = id;
            row.style.background = '#fce4f0';
            document.getElementById('formId').value = id;
            document.getElementById('inputTen').value = ten;

            const btn = document.getElementById('btnSua');
            btn.disabled = false; btn.style.opacity = '1'; btn.style.cursor = 'pointer';
        }
    </script>
</div>
=======
<footer>
    <div class="footer-logo"><h2>Medi Den</h2></div>
    <p class="copy">© 2026 Medi Den Admin Dashboard. Designed for sneakers management.</p>
</footer>
>>>>>>> 901322a5e3fa8ffe56dc819060cca1571310d667

</body>
</html>
