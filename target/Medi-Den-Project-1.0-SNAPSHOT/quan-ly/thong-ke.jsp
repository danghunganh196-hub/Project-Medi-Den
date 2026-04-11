<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <div class="topbar-avatar" onclick="toggleDropdown()">A</div>
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
        <div class="page-header">
            <h1>📊 Thống kê hệ thống</h1>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">💰</div>
                <div class="stat-value">248.5tr</div>
                <div class="stat-label">Doanh thu tháng này</div>
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
    </main>
</div>

<script>
    function toggleDropdown() {
        // Thêm dropdown nếu bạn muốn
        //tést
    }
</script>
</body>
</html>