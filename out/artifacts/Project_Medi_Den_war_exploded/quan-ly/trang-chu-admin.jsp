<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Trang chủ Quản lý - Medi Den</title>
  <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <style>
    :root {
      --pink: #F0127A;
      --pink-dark: #c70060;
      --pink-deeper: #8b0044;
      --pink-soft: #fce4f0;
      --pink-glow: rgba(240, 18, 122, 0.18);
      --sidebar-bg: #ffffff;
      --white: #ffffff;
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

  </style>
</head>
<body>

<!-- TOPBAR -->
<header class="topbar">
  <div class="topbar-logo">
    <div class="logo-icon">M</div>
    <span class="logo-text">Medi Den</span>
  </div>
  <span class="topbar-title">Trang chủ Quản lý</span>
  <div class="topbar-right">
    <div class="topbar-search">
      <svg width="15" height="15" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2.5">
        <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
      </svg>
      <input type="text" placeholder="Tìm kiếm...">
    </div>
    <div class="topbar-avatar">A</div>
  </div>
</header>

<div class="layout">

  <!-- SIDEBAR -->
  <nav class="sidebar">
    <div class="sidebar-section">
      <div class="sidebar-section-label">Chính</div>
      <div class="nav-item active">
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

  <!-- MAIN CONTENT -->
  <main class="main">
    <div class="page-header">
      <h1>Xin chào, Admin</h1>
    </div>

    <!-- STAT CARDS -->
    <div class="stats-grid">
      <div class="stat-card">
        <div class="stat-icon">💰</div>
        <div class="stat-value">-</div>
        <div class="stat-label">Doanh thu tháng</div>
      </div>
      <div class="stat-card">
        <div class="stat-icon">🛍️</div>
        <div class="stat-value">-</div>
        <div class="stat-label">Đơn hàng mới</div>
      </div>
      <div class="stat-card">
        <div class="stat-icon">👥</div>
        <div class="stat-value">-</div>
        <div class="stat-label">Khách hàng</div>
      </div>
      <div class="stat-card">
        <div class="stat-icon">👟</div>
        <div class="stat-value">-</div>
        <div class="stat-label">Sản phẩm</div>
      </div>
    </div>

    <!-- TABLE: Recent Orders (full width) -->
    <div class="card">
      <div class="card-header">
        <span class="card-title">Đơn hàng gần đây</span>
        <span class="card-action">Xem tất cả →</span>
      </div>
      <div class="table-wrap">
        <table>
          <thead>
          <tr>
            <th>Mã đơn</th>
            <th>Khách hàng</th>
            <th>Sản phẩm</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
          </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </div>

    <!-- QUICK LINKS -->
    <div class="quick-grid">
      <div class="quick-card" onclick="window.location.href='${pageContext.request.contextPath}/danh-muc'">
        <div class="quick-icon">📂</div>
        <div class="quick-label">Quản lý danh mục</div>
        <div class="quick-desc">Thêm, sửa, xóa danh mục sản phẩm</div>
      </div>
      <div class="quick-card" onclick="window.location.href='${pageContext.request.contextPath}/san-pham'">
        <div class="quick-icon">👟</div>
        <div class="quick-label">Quản lý sản phẩm</div>
        <div class="quick-desc">Cập nhật thông tin & kho hàng</div>
      </div>
      <div class="quick-card" onclick="window.location.href='${pageContext.request.contextPath}/don-hang'">
        <div class="quick-icon">🛒</div>
        <div class="quick-label">Quản lý đơn hàng</div>
        <div class="quick-desc">Theo dõi & xử lý đơn hàng</div>
      </div>
      <div class="quick-card" onclick="window.location.href='${pageContext.request.contextPath}/khach-hang'">
        <div class="quick-icon">👥</div>
        <div class="quick-label">Quản lý khách hàng</div>
        <div class="quick-desc">Danh sách & lịch sử mua hàng</div>
      </div>
    </div>
  </main>
</div>
</body>
</html>