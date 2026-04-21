<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê - Medi Den</title>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --pink: #F0127A;
            --pink-dark: #c70060;
            --pink-soft: #fce4f0;
            --pink-glow: rgba(240, 18, 122, 0.18);
            --sidebar-bg: #ffffff;
            --text-dark: #1a0010;
            --text-mid: #6b0038;
            --text-light: #b5527a;
            --shadow: 0 4px 24px rgba(240,18,122,0.10);
            --radius: 16px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Be Vietnam Pro', sans-serif;
            background: #ffffff;
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* === TOPBAR === */
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
        .topbar-logo { display: flex; align-items: center; gap: 12px; }
        .logo-icon {
            width: 40px; height: 40px;
            background: white; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-weight: 800; font-size: 18px; color: var(--pink);
        }
        .logo-text { color: white; font-size: 20px; font-weight: 700; }
        .topbar-title { color: white; font-size: 17px; font-weight: 600; }
        .topbar-avatar {
            width: 36px; height: 36px; background: white; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: 700; font-size: 15px; color: var(--pink);
            cursor: pointer;
        }

        /* === LAYOUT === */
        .layout { display: flex; min-height: calc(100vh - 64px); }

        /* === SIDEBAR (FULL) === */
        .sidebar {
            width: 260px; background: var(--sidebar-bg);
            padding: 28px 0 24px; display: flex; flex-direction: column; gap: 4px;
            border-right: 1.5px solid rgba(240,18,122,0.12);
            position: sticky; top: 64px; height: calc(100vh - 64px); overflow-y: auto;
        }
        .sidebar-section { padding: 0 16px; margin-bottom: 8px; }
        .sidebar-section-label {
            font-size: 11px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 1.2px; color: var(--text-light); padding: 0 12px; margin-bottom: 6px;
        }
        .nav-item {
            display: flex; align-items: center; gap: 12px; padding: 11px 14px;
            border-radius: 12px; cursor: pointer; color: var(--text-mid);
            font-size: 14.5px; font-weight: 500;
            transition: all 0.2s;
        }
        .nav-item .nav-icon {
            width: 36px; height: 36px; background: rgba(240,18,122,0.08);
            border-radius: 10px; display: flex; align-items: center; justify-content: center;
            font-size: 17px;
        }
        .nav-item:hover { background: #fdf0f7; color: var(--pink); transform: translateX(3px); }
        .nav-item.active { background: var(--pink); color: white; }
        .nav-item.active .nav-icon { background: rgba(255,255,255,0.22); }

        .sidebar-divider { height: 1px; background: rgba(240,18,122,0.12); margin: 10px 20px; }

        /* === MAIN === */
        .main { flex: 1; padding: 32px 36px; }
        .page-header h1 { font-size: 26px; font-weight: 800; margin-bottom: 8px; }

        /* Stat Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
        }
        .stat-card {
            background: white;
            border-radius: var(--radius);
            padding: 24px;
            box-shadow: var(--shadow);
            border: 1.5px solid rgba(240,18,122,0.07);
            transition: all 0.25s;
        }
        .stat-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px var(--pink-glow); }
        .stat-icon {
            width: 56px; height: 56px;
            background: var(--pink-soft);
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 28px;
            margin-bottom: 16px;
        }
        .stat-value { font-size: 32px; font-weight: 800; color: var(--text-dark); }
        .stat-label { font-size: 14px; color: var(--text-light); font-weight: 500; }

        /* Thêm vào <style> */
        .card {
            background: white; border-radius: var(--radius);
            box-shadow: var(--shadow); border: 1.5px solid rgba(240,18,122,0.07);
            overflow: hidden; margin-bottom: 24px;
        }
        .card-header {
            padding: 20px 24px 16px;
            border-bottom: 1.5px solid rgba(240,18,122,0.08);
            display: flex; align-items: center; justify-content: space-between;
        }
        .card-title { font-size: 15px; font-weight: 700; color: var(--text-dark); }
        table { width: 100%; border-collapse: collapse; }
        thead th {
            padding: 12px 20px; text-align: left; font-size: 11.5px;
            font-weight: 700; text-transform: uppercase; letter-spacing: 0.8px;
            color: var(--text-light); background: #fdf0f7;
            border-bottom: 1.5px solid rgba(240,18,122,0.08);
        }
        tbody tr { border-bottom: 1px solid rgba(240,18,122,0.06); transition: background 0.18s; }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: #fdf0f7; }
        tbody td { padding: 13px 20px; font-size: 13.5px; font-weight: 500; }
        .badge { display:inline-block; padding:3px 10px; border-radius:20px; font-size:12px; font-weight:700; }
        .badge-gold   { background:#fef9c3; color:#a16207; }
        .badge-silver { background:#f1f5f9; color:#475569; }
        .badge-bronze { background:#fef3c7; color:#92400e; }

        .profile-wrapper {
            position: relative;
        }
        .profile-dropdown {
            position: absolute;
            top: calc(100% + 12px);
            right: 0;
            background: white;
            border-radius: 14px;
            box-shadow: 0 8px 32px rgba(240,18,122,0.18), 0 2px 8px rgba(0,0,0,0.08);
            border: 1.5px solid rgba(240,18,122,0.12);
            min-width: 220px;
            padding: 16px;
            display: none;
            z-index: 999;
            animation: dropIn 0.2s ease;
        }
        .profile-dropdown.open { display: block; }
        @keyframes dropIn {
            from { opacity: 0; transform: translateY(-8px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .profile-dropdown-header {
            display: flex;
            align-items: center;
            gap: 12px;
            padding-bottom: 14px;
            border-bottom: 1.5px solid rgba(240,18,122,0.10);
            margin-bottom: 12px;
        }
        .profile-avatar-lg {
            width: 44px; height: 44px;
            background: var(--pink);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: 700; font-size: 18px; color: white;
            flex-shrink: 0;
        }
        .profile-name {
            font-size: 15px;
            font-weight: 700;
            color: var(--text-dark);
        }
        .profile-role {
            font-size: 12px;
            color: var(--text-light);
            margin-top: 2px;
        }
        .profile-greeting {
            font-size: 13px;
            color: var(--text-mid);
            margin-bottom: 14px;
            padding: 8px 10px;
            background: var(--pink-soft);
            border-radius: 8px;
            font-weight: 500;
        }
        .btn-logout {
            width: 100%;
            padding: 10px 14px;
            background: white;
            border: 1.5px solid rgba(240,18,122,0.25);
            border-radius: 10px;
            color: var(--pink);
            font-family: inherit;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.2s, color 0.2s, border-color 0.2s;
            display: flex; align-items: center; justify-content: center; gap: 8px;
        }
        .btn-logout:hover {
            background: var(--pink);
            color: white;
            border-color: var(--pink);
        }
    </style>
</head>
<body>

<!-- TOPBAR -->
<header class="topbar">
    <div class="topbar-logo">
        <div class="logo-icon">M</div>
        <span class="logo-text">Medi Den</span>
    </div>
    <span class="topbar-title">Thống kê & Báo cáo</span>
    <div class="topbar-right">
        <div class="profile-wrapper">
            <div class="topbar-avatar" id="avatarBtn" onclick="toggleDropdown()">A</div>
            <div class="profile-dropdown" id="profileDropdown">
                <div class="profile-dropdown-header">
                    <div class="profile-avatar-lg">A</div>
                    <div>
                        <div class="profile-name">Admin</div>
                        <div class="profile-role">Quản trị viên</div>
                    </div>
                </div>
                <div class="profile-greeting">👋 Xin chào, Admin!</div>
                <button class="btn-logout" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                    🚪 Đăng xuất
                </button>
            </div>
        </div>
    </div>
</header>

<div class="layout">
    <!-- SIDEBAR FULL -->
    <nav class="sidebar">
        <div class="sidebar-section">
            <div class="sidebar-section-label">Chính</div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/trang-chu-admin'">
                <div class="nav-icon">🏠</div>
                Trang chủ
            </div>
        </div>

        <div class="sidebar-divider"></div>

        <div class="sidebar-section">
            <div class="sidebar-section-label">Quản lý</div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/danh-muc'">
                <div class="nav-icon">📂</div>
                Quản lý danh mục
            </div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/san-pham'">
                <div class="nav-icon">👟</div>
                Quản lý sản phẩm
            </div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/don-hang'">
                <div class="nav-icon">🛒</div>
                Quản lý đơn hàng
            </div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/khach-hang'">
                <div class="nav-icon">👥</div>
                Quản lý khách hàng
            </div>
        </div>

        <div class="sidebar-divider"></div>

        <div class="sidebar-section">
            <div class="sidebar-section-label">Hệ thống</div>
            <div class="nav-item active">
                <div class="nav-icon">📊</div>
                Thống kê & Báo cáo
            </div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/cai-dat'">
                <div class="nav-icon">⚙️</div>
                Cài đặt
            </div>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main class="main">
        <div class="page-header" style="margin-bottom:28px;">
            <h1>📊 Thống kê hệ thống</h1>
        </div>

        <%-- STAT CARDS --%>
        <div class="stats-grid" style="margin-bottom:32px;">
            <div class="stat-card">
                <div class="stat-icon">💰</div>
                <div class="stat-value">
                    <fmt:formatNumber value="${tongDoanhThu}" type="number" maxFractionDigits="0"/>đ
                </div>
                <div class="stat-label">Tổng doanh thu</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📦</div>
                <div class="stat-value">${tongDonHang}</div>
                <div class="stat-label">Tổng đơn hàng</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">👥</div>
                <div class="stat-value">${tongKhachHang}</div>
                <div class="stat-label">Tổng khách hàng</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">👟</div>
                <div class="stat-value">${tongSanPham}</div>
                <div class="stat-label">Sản phẩm đang kinh doanh</div>
            </div>
        </div>

        <%-- BẢNG TOP KHÁCH HÀNG --%>
        <div class="card">
            <div class="card-header">
                <span class="card-title">🏆 Top khách hàng</span>
                <span style="font-size:13px; color:var(--text-light);">Xếp hạng theo tổng chi tiêu</span>
            </div>
            <table>
                <thead>
                <tr>
                    <th style="width:60px; text-align:center;">Hạng</th>
                    <th>Khách hàng</th>
                    <th>Email</th>
                    <th style="text-align:right;">Số đơn</th>
                    <th style="text-align:right; padding-right:24px;">Tổng chi tiêu</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="row" items="${topKhachHang}" varStatus="loop">
                    <tr>
                        <td style="text-align:center;">
                            <c:choose>
                                <c:when test="${loop.index == 0}">
                                    <span class="badge badge-gold">🥇 1</span>
                                </c:when>
                                <c:when test="${loop.index == 1}">
                                    <span class="badge badge-silver">🥈 2</span>
                                </c:when>
                                <c:when test="${loop.index == 2}">
                                    <span class="badge badge-bronze">🥉 3</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color:var(--text-light); font-weight:600;">#${loop.index + 1}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><strong>${row[0]}</strong></td>
                        <td style="color:var(--text-light);">${row[1]}</td>
                        <td style="text-align:right;">${row[3]} đơn</td>
                        <td style="text-align:right; padding-right:24px; color:var(--pink); font-weight:700;">
                            <fmt:formatNumber value="${row[2]}" type="number" maxFractionDigits="0"/>đ
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty topKhachHang}">
                    <tr>
                        <td colspan="5" style="text-align:center; color:var(--text-light); padding:24px;">
                            Chưa có dữ liệu đơn hàng
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>

<script>
    function toggleDropdown() {
        document.getElementById('profileDropdown').classList.toggle('open');
    }
    document.addEventListener('click', function(e) {
        if (!document.querySelector('.profile-wrapper').contains(e.target)) {
            document.getElementById('profileDropdown').classList.remove('open');
        }
    });
</script>
</body>
</html>