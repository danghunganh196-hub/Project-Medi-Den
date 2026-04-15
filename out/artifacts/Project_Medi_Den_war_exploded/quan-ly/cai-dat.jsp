<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 4/10/2026
  Time: 9:22 PM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cài đặt - Medi Den</title>
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
    .topbar-logo { display: flex; align-items: center; gap: 12px; }
    .logo-icon {
      width: 40px; height: 40px;
      background: white; border-radius: 10px;
      display: flex; align-items: center; justify-content: center;
      font-weight: 800; font-size: 18px; color: var(--pink);
      box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    }
    .logo-text { color: white; font-size: 20px; font-weight: 700; letter-spacing: 0.5px; }
    .topbar-title { color: white; font-size: 17px; font-weight: 600; letter-spacing: 0.3px; }
    .topbar-right { display: flex; align-items: center; gap: 20px; }
    .topbar-avatar {
      width: 36px; height: 36px; background: white; border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-weight: 700; font-size: 15px; color: var(--pink);
      cursor: pointer; transition: transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 2px 8px rgba(0,0,0,0.12);
    }
    .topbar-avatar:hover { transform: scale(1.08); box-shadow: 0 4px 16px rgba(0,0,0,0.18); }

    /* ── LAYOUT ── */
    .layout { display: flex; min-height: calc(100vh - 64px); }

    /* ── SIDEBAR ── */
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
      transition: background 0.2s, color 0.2s, transform 0.15s, box-shadow 0.2s;
      position: relative; user-select: none;
    }
    .nav-item .nav-icon {
      width: 36px; height: 36px; background: rgba(240,18,122,0.08);
      border-radius: 10px; display: flex; align-items: center; justify-content: center;
      flex-shrink: 0; transition: background 0.2s, transform 0.2s; font-size: 17px;
    }
    .nav-item:hover { background: #fdf0f7; color: var(--pink); transform: translateX(3px); box-shadow: 0 2px 12px var(--pink-glow); }
    .nav-item:hover .nav-icon { background: var(--pink-soft); transform: scale(1.1); }
    .nav-item.active { background: var(--pink); color: white; box-shadow: 0 4px 16px var(--pink-glow); }
    .nav-item.active .nav-icon { background: rgba(255,255,255,0.22); }
    .sidebar-divider { height: 1px; background: rgba(240,18,122,0.12); margin: 10px 20px; }

    /* ── MAIN ── */
    .main { flex: 1; padding: 32px 36px; overflow-y: auto; background: #ffffff; }
    .page-header { margin-bottom: 32px; }
    .page-header h1 { font-size: 26px; font-weight: 800; color: var(--text-dark); letter-spacing: -0.5px; }
    .page-header p { font-size: 14px; color: var(--text-light); margin-top: 6px; font-weight: 500; }

    /* ── SETTINGS LAYOUT ── */
    .settings-layout {
      display: grid;
      grid-template-columns: 220px 1fr;
      gap: 24px;
      align-items: start;
    }

    /* ── SETTINGS NAV ── */
    .settings-nav {
      background: white;
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      border: 1.5px solid rgba(240,18,122,0.07);
      overflow: hidden;
      position: sticky;
      top: 96px;
    }
    .settings-nav-item {
      display: flex; align-items: center; gap: 10px;
      padding: 13px 18px; cursor: pointer;
      font-size: 13.5px; font-weight: 600; color: var(--text-mid);
      border-bottom: 1px solid rgba(240,18,122,0.07);
      transition: background 0.2s, color 0.2s;
      user-select: none;
    }
    .settings-nav-item:last-child { border-bottom: none; }
    .settings-nav-item:hover { background: #fdf0f7; color: var(--pink); }
    .settings-nav-item.active { background: var(--pink-soft); color: var(--pink); font-weight: 700; }
    .settings-nav-item.active::before {
      content: '';
      position: absolute;
      left: 0; top: 0; bottom: 0;
      width: 3px;
      background: var(--pink);
      border-radius: 0 2px 2px 0;
    }
    .settings-nav-item { position: relative; }

    /* ── CARD ── */
    .card {
      background: white; border-radius: var(--radius);
      box-shadow: var(--shadow); border: 1.5px solid rgba(240,18,122,0.07);
      overflow: hidden; margin-bottom: 24px;
    }
    .card-header {
      padding: 20px 24px 16px; border-bottom: 1.5px solid rgba(240,18,122,0.08);
      display: flex; align-items: center; gap: 12px;
    }
    .card-header-icon {
      width: 40px; height: 40px; background: var(--pink-soft); border-radius: 10px;
      display: flex; align-items: center; justify-content: center; font-size: 20px;
    }
    .card-title { font-size: 15px; font-weight: 700; color: var(--text-dark); }
    .card-subtitle { font-size: 12.5px; color: var(--text-light); margin-top: 2px; }
    .card-body { padding: 24px; }

    /* ── FORM ── */
    .form-group { margin-bottom: 20px; }
    .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    .form-label {
      display: block; font-size: 13px; font-weight: 700;
      color: var(--text-mid); margin-bottom: 7px;
    }
    .form-input {
      width: 100%; padding: 10px 14px;
      border: 1.5px solid rgba(240,18,122,0.18);
      border-radius: 10px; font-family: inherit; font-size: 14px;
      color: var(--text-dark); outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
      background: white;
    }
    .form-input:focus {
      border-color: var(--pink);
      box-shadow: 0 0 0 3px rgba(240,18,122,0.10);
    }
    .form-input::placeholder { color: #c9a0b8; }
    .form-select {
      width: 100%; padding: 10px 14px;
      border: 1.5px solid rgba(240,18,122,0.18);
      border-radius: 10px; font-family: inherit; font-size: 14px;
      color: var(--text-dark); outline: none;
      transition: border-color 0.2s, box-shadow 0.2s;
      background: white; cursor: pointer;
      appearance: none;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%23b5527a' stroke-width='1.8' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
      background-repeat: no-repeat;
      background-position: right 14px center;
      padding-right: 36px;
    }
    .form-select:focus { border-color: var(--pink); box-shadow: 0 0 0 3px rgba(240,18,122,0.10); }

    /* ── TOGGLE ── */
    .toggle-row {
      display: flex; align-items: center; justify-content: space-between;
      padding: 14px 0; border-bottom: 1px solid rgba(240,18,122,0.07);
    }
    .toggle-row:last-child { border-bottom: none; padding-bottom: 0; }
    .toggle-info {}
    .toggle-label { font-size: 14px; font-weight: 600; color: var(--text-dark); }
    .toggle-desc { font-size: 12px; color: var(--text-light); margin-top: 3px; }
    .toggle-switch {
      position: relative; width: 46px; height: 26px;
      flex-shrink: 0;
    }
    .toggle-switch input { opacity: 0; width: 0; height: 0; }
    .toggle-slider {
      position: absolute; cursor: pointer;
      top: 0; left: 0; right: 0; bottom: 0;
      background: #e8c4d8; border-radius: 26px;
      transition: background 0.3s;
    }
    .toggle-slider:before {
      content: '';
      position: absolute; width: 20px; height: 20px;
      left: 3px; bottom: 3px;
      background: white; border-radius: 50%;
      transition: transform 0.3s;
      box-shadow: 0 1px 4px rgba(0,0,0,0.18);
    }
    .toggle-switch input:checked + .toggle-slider { background: var(--pink); }
    .toggle-switch input:checked + .toggle-slider:before { transform: translateX(20px); }

    /* ── PAYMENT METHOD CARDS ── */
    .payment-methods { display: flex; flex-direction: column; gap: 12px; }
    .payment-method-card {
      display: flex; align-items: center; justify-content: space-between;
      padding: 14px 18px;
      border: 1.5px solid rgba(240,18,122,0.12);
      border-radius: 12px;
      transition: border-color 0.2s, background 0.2s;
      cursor: pointer;
    }
    .payment-method-card:hover { border-color: var(--pink); background: #fdf0f7; }
    .payment-method-card.enabled { border-color: var(--pink); background: var(--pink-soft); }
    .payment-method-left { display: flex; align-items: center; gap: 12px; }
    .payment-icon {
      width: 40px; height: 40px; border-radius: 10px;
      display: flex; align-items: center; justify-content: center;
      font-size: 20px; background: white;
      box-shadow: 0 2px 8px rgba(240,18,122,0.10);
    }
    .payment-name { font-size: 14px; font-weight: 700; color: var(--text-dark); }
    .payment-desc { font-size: 12px; color: var(--text-light); margin-top: 2px; }

    /* ── USER TABLE ── */
    .user-table-header {
      display: flex; align-items: center; justify-content: space-between;
      padding: 20px 24px 16px;
      border-bottom: 1.5px solid rgba(240,18,122,0.08);
    }
    table { width: 100%; border-collapse: collapse; }
    thead th {
      padding: 12px 20px; text-align: left;
      font-size: 11.5px; font-weight: 700; text-transform: uppercase;
      letter-spacing: 0.8px; color: var(--text-light);
      background: #fdf0f7; border-bottom: 1.5px solid rgba(240,18,122,0.08);
    }
    tbody tr {
      border-bottom: 1px solid rgba(240,18,122,0.06);
      transition: background 0.18s;
    }
    tbody tr:last-child { border-bottom: none; }
    tbody tr:hover { background: #fdf0f7; }
    tbody td { padding: 13px 20px; font-size: 13.5px; color: var(--text-dark); font-weight: 500; }

    .role-badge {
      display: inline-block; padding: 3px 10px; border-radius: 20px;
      font-size: 11.5px; font-weight: 700;
    }
    .role-admin { background: var(--pink-soft); color: var(--pink-dark); }
    .role-staff { background: #dbeafe; color: #1d4ed8; }
    .role-warehouse { background: #fef9c3; color: #a16207; }

    .user-avatar-sm {
      width: 32px; height: 32px; border-radius: 50%;
      background: var(--pink); color: white;
      display: inline-flex; align-items: center; justify-content: center;
      font-weight: 700; font-size: 13px; margin-right: 8px; vertical-align: middle;
    }

    /* ── BUTTONS ── */
    .btn-primary {
      padding: 10px 22px; background: var(--pink); color: white;
      border: none; border-radius: 10px; font-family: inherit;
      font-size: 14px; font-weight: 700; cursor: pointer;
      transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
      display: inline-flex; align-items: center; gap: 8px;
    }
    .btn-primary:hover { background: var(--pink-dark); transform: translateY(-1px); box-shadow: 0 4px 14px var(--pink-glow); }
    .btn-ghost {
      padding: 10px 18px; background: white;
      border: 1.5px solid rgba(240,18,122,0.22); border-radius: 10px;
      font-family: inherit; font-size: 13.5px; font-weight: 700;
      color: var(--pink); cursor: pointer;
      transition: background 0.2s, border-color 0.2s;
      display: inline-flex; align-items: center; gap: 7px;
    }
    .btn-ghost:hover { background: var(--pink-soft); border-color: var(--pink); }
    .btn-danger {
      padding: 6px 14px; background: #fee2e2; color: #dc2626;
      border: none; border-radius: 8px; font-family: inherit;
      font-size: 12.5px; font-weight: 700; cursor: pointer;
      transition: background 0.2s;
    }
    .btn-danger:hover { background: #fecaca; }
    .btn-edit {
      padding: 6px 14px; background: var(--pink-soft); color: var(--pink-dark);
      border: none; border-radius: 8px; font-family: inherit;
      font-size: 12.5px; font-weight: 700; cursor: pointer;
      transition: background 0.2s; margin-right: 6px;
    }
    .btn-edit:hover { background: #f9c0dc; }

    .form-footer {
      display: flex; align-items: center; justify-content: flex-end;
      gap: 10px; padding-top: 20px;
      border-top: 1.5px solid rgba(240,18,122,0.08);
      margin-top: 4px;
    }

    /* ── SECTION TABS ── */
    .section { display: none; }
    .section.active { display: block; }

    /* ── BANK INFO ── */
    .bank-info-box {
      background: var(--pink-soft); border-radius: 12px;
      padding: 16px 20px; margin-top: 16px;
      border: 1.5px dashed rgba(240,18,122,0.25);
    }
    .bank-info-box .bank-label { font-size: 12px; color: var(--text-light); font-weight: 600; margin-bottom: 4px; }
    .bank-info-box .bank-value { font-size: 15px; font-weight: 800; color: var(--pink-dark); }

    /* ── PROFILE DROPDOWN ── */
    .profile-wrapper { position: relative; }
    .profile-dropdown {
      position: absolute; top: calc(100% + 12px); right: 0;
      background: white; border-radius: 14px;
      box-shadow: 0 8px 32px rgba(240,18,122,0.18), 0 2px 8px rgba(0,0,0,0.08);
      border: 1.5px solid rgba(240,18,122,0.12);
      min-width: 220px; padding: 16px; display: none; z-index: 999;
      animation: dropIn 0.2s ease;
    }
    .profile-dropdown.open { display: block; }
    @keyframes dropIn {
      from { opacity: 0; transform: translateY(-8px); }
      to   { opacity: 1; transform: translateY(0); }
    }
    .profile-dropdown-header {
      display: flex; align-items: center; gap: 12px;
      padding-bottom: 14px; border-bottom: 1.5px solid rgba(240,18,122,0.10); margin-bottom: 12px;
    }
    .profile-avatar-lg {
      width: 44px; height: 44px; background: var(--pink); border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-weight: 700; font-size: 18px; color: white; flex-shrink: 0;
    }
    .profile-name { font-size: 15px; font-weight: 700; color: var(--text-dark); }
    .profile-role { font-size: 12px; color: var(--text-light); margin-top: 2px; }
    .profile-greeting {
      font-size: 13px; color: var(--text-mid); margin-bottom: 14px;
      padding: 8px 10px; background: var(--pink-soft); border-radius: 8px; font-weight: 500;
    }
    .btn-logout {
      width: 100%; padding: 10px 14px; background: white;
      border: 1.5px solid rgba(240,18,122,0.25); border-radius: 10px;
      color: var(--pink); font-family: inherit; font-size: 14px; font-weight: 700;
      cursor: pointer; transition: background 0.2s, color 0.2s, border-color 0.2s;
      display: flex; align-items: center; justify-content: center; gap: 8px;
    }
    .btn-logout:hover { background: var(--pink); color: white; border-color: var(--pink); }

    /* ── MODAL ── */
    .modal-backdrop {
      display: none; position: fixed; inset: 0;
      background: rgba(26,0,16,0.45); z-index: 500;
      align-items: center; justify-content: center;
    }
    .modal-backdrop.open { display: flex; }
    .modal {
      background: white; border-radius: 20px; padding: 28px;
      width: 100%; max-width: 440px;
      box-shadow: 0 16px 48px rgba(240,18,122,0.18);
      animation: modalIn 0.25s ease;
    }
    @keyframes modalIn {
      from { opacity: 0; transform: scale(0.95) translateY(10px); }
      to   { opacity: 1; transform: scale(1) translateY(0); }
    }
    .modal-title { font-size: 18px; font-weight: 800; color: var(--text-dark); margin-bottom: 20px; }
    .modal-footer { display: flex; gap: 10px; justify-content: flex-end; margin-top: 20px; }

    /* save toast */
    .toast {
      position: fixed; bottom: 32px; right: 32px; z-index: 9999;
      background: var(--pink); color: white; padding: 14px 22px;
      border-radius: 12px; font-size: 14px; font-weight: 700;
      box-shadow: 0 8px 24px var(--pink-glow);
      display: flex; align-items: center; gap: 10px;
      transform: translateY(80px); opacity: 0;
      transition: transform 0.35s ease, opacity 0.35s ease;
    }
    .toast.show { transform: translateY(0); opacity: 1; }
  </style>
</head>
<body>

<!-- TOPBAR -->
<header class="topbar">
  <div class="topbar-logo">
    <div class="logo-icon">M</div>
    <span class="logo-text">Medi Den</span>
  </div>
  <span class="topbar-title">Cài đặt hệ thống</span>
  <div class="topbar-right">
    <div class="profile-wrapper">
      <div class="topbar-avatar" onclick="toggleDropdown()">A</div>
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
  <!-- SIDEBAR -->
  <nav class="sidebar">
    <div class="sidebar-section">
      <div class="sidebar-section-label">Chính</div>
      <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/'">
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
      <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/thong-ke'">
        <div class="nav-icon">📊</div>
        Thống kê & Báo cáo
      </div>
      <div class="nav-item active">
        <div class="nav-icon">⚙️</div>
        Cài đặt
      </div>
    </div>
  </nav>

  <!-- MAIN -->
  <main class="main">
    <div class="page-header">
      <h1>⚙️ Cài đặt hệ thống</h1>
      <p>Quản lý cấu hình thanh toán và tài khoản người dùng</p>
    </div>

    <div class="settings-layout">
      <!-- Settings Nav -->
      <div class="settings-nav">
        <div class="settings-nav-item active" onclick="showSection('payment')">💳 Thanh toán</div>
        <div class="settings-nav-item" onclick="showSection('users')">👤 Người dùng</div>
      </div>

      <!-- Settings Content -->
      <div>

        <!-- ── PAYMENT SECTION ── -->
        <div id="section-payment" class="section active">

          <!-- Phương thức thanh toán -->
          <div class="card">
            <div class="card-header">
              <div class="card-header-icon">💳</div>
              <div>
                <div class="card-title">Phương thức thanh toán</div>
                <div class="card-subtitle">Bật/tắt các hình thức thanh toán cho khách hàng</div>
              </div>
            </div>
            <div class="card-body">
              <div class="payment-methods">

                <div class="payment-method-card enabled" onclick="this.classList.toggle('enabled')">
                  <div class="payment-method-left">
                    <div class="payment-icon">💵</div>
                    <div>
                      <div class="payment-name">Thanh toán khi nhận hàng (COD)</div>
                      <div class="payment-desc">Khách hàng thanh toán bằng tiền mặt khi nhận hàng</div>
                    </div>
                  </div>
                  <label class="toggle-switch" onclick="event.stopPropagation()">
                    <input type="checkbox" checked onchange="this.closest('.payment-method-card').classList.toggle('enabled',this.checked)">
                    <span class="toggle-slider"></span>
                  </label>
                </div>

                <div class="payment-method-card enabled" onclick="this.classList.toggle('enabled')">
                  <div class="payment-method-left">
                    <div class="payment-icon">🏦</div>
                    <div>
                      <div class="payment-name">Chuyển khoản ngân hàng</div>
                      <div class="payment-desc">Khách hàng chuyển khoản qua tài khoản ngân hàng</div>
                    </div>
                  </div>
                  <label class="toggle-switch" onclick="event.stopPropagation()">
                    <input type="checkbox" checked onchange="this.closest('.payment-method-card').classList.toggle('enabled',this.checked)">
                    <span class="toggle-slider"></span>
                  </label>
                </div>

                <div class="payment-method-card" onclick="this.classList.toggle('enabled')">
                  <div class="payment-method-left">
                    <div class="payment-icon">📱</div>
                    <div>
                      <div class="payment-name">Ví điện tử (MoMo, ZaloPay)</div>
                      <div class="payment-desc">Thanh toán qua ví điện tử phổ biến</div>
                    </div>
                  </div>
                  <label class="toggle-switch" onclick="event.stopPropagation()">
                    <input type="checkbox" onchange="this.closest('.payment-method-card').classList.toggle('enabled',this.checked)">
                    <span class="toggle-slider"></span>
                  </label>
                </div>

              </div>
            </div>
          </div>

          <!-- Thông tin tài khoản ngân hàng -->
          <div class="card">
            <div class="card-header">
              <div class="card-header-icon">🏦</div>
              <div>
                <div class="card-title">Thông tin tài khoản ngân hàng</div>
                <div class="card-subtitle">Hiển thị cho khách hàng khi chọn chuyển khoản</div>
              </div>
            </div>
            <div class="card-body">
              <div class="form-row">
                <div class="form-group">
                  <label class="form-label">Tên ngân hàng</label>
                  <select class="form-select">
                    <option>Vietcombank</option>
                    <option>Techcombank</option>
                    <option>BIDV</option>
                    <option>MB Bank</option>
                    <option>VPBank</option>
                    <option>Agribank</option>
                  </select>
                </div>
                <div class="form-group">
                  <label class="form-label">Số tài khoản</label>
                  <input type="text" class="form-input" placeholder="Nhập số tài khoản" value="1234567890" id="bankNumber">
                </div>
              </div>
              <div class="form-row">
                <div class="form-group">
                  <label class="form-label">Tên chủ tài khoản</label>
                  <input type="text" class="form-input" placeholder="Nhập tên chủ tài khoản" value="NGUYEN VAN A" id="bankName">
                </div>
                <div class="form-group">
                  <label class="form-label">Chi nhánh</label>
                  <input type="text" class="form-input" placeholder="Ví dụ: Chi nhánh Hà Nội" value="Chi nhánh Hà Nội">
                </div>
              </div>

              <div class="bank-info-box">
                <div class="bank-label">Xem trước thông tin hiển thị</div>
                <div class="bank-value" id="previewBankName">NGUYEN VAN A</div>
                <div style="font-size:13px;color:var(--text-mid);margin-top:4px;">STK: <strong id="previewBankNumber">1234567890</strong></div>
              </div>

              <div class="form-footer">
                <button class="btn-ghost">Hủy</button>
                <button class="btn-primary" onclick="saveToast()">💾 Lưu thay đổi</button>
              </div>
            </div>
          </div>
        </div>
        <!-- ── USERS SECTION ── -->
        <div id="section-users" class="section">
          <div class="card">
            <div class="user-table-header">
              <div>
                <div class="card-title">Quản lý người dùng hệ thống</div>
                <div class="card-subtitle" style="margin-top:4px;">
                  Tổng số tài khoản: <strong>${listTaiKhoan.size()}</strong>
                </div>
              </div>
              <button class="btn-primary" onclick="openAddModal()">+ Thêm nhân viên</button>
            </div>

            <table>
              <thead>
              <tr>
                <th>Nhân viên</th>
                <th>Username</th>
                <th>Vai trò</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="tk" items="${listTaiKhoan}">
                <tr>
                  <td>
                            <span class="user-avatar-sm"
                                  style="background: ${tk.vaiTro eq 'Quản trị viên' ? '#F0127A' :
                                         tk.vaiTro eq 'Nhân viên bán hàng' ? '#1d4ed8' : '#a16207'}">
                                ${tk.username.substring(0,1).toUpperCase()}
                            </span>
                      ${tk.username}
                  </td>
                  <td>${tk.username}@mediden.vn</td>
                  <td>
                            <span class="role-badge
                                ${tk.vaiTro eq 'Quản trị viên' ? 'role-admin' :
                                  tk.vaiTro eq 'Nhân viên bán hàng' ? 'role-staff' : 'role-warehouse'}">
                                ${tk.vaiTro}
                            </span>
                  </td>
                  <td>
                            <span class="role-badge"
                                  style="background:${tk.trangThai ? '#dcfce7' : '#fee2e2'};
                                          color:${tk.trangThai ? '#16a34a' : '#dc2626'}">
                                ${tk.trangThai ? 'Hoạt động' : 'Khóa'}
                            </span>
                  </td>
                  <td>
                    <button class="btn-edit" onclick="editUser(${tk.id})">Sửa</button>
                    <button class="btn-danger"
                            onclick="deleteUser(${tk.id})"
                      ${tk.vaiTro eq 'Quản trị viên' ? 'disabled style="opacity:0.4;cursor:not-allowed;"' : ''}>
                      Xóa
                    </button>
                  </td>
                </tr>
              </c:forEach>

              <c:if test="${empty listTaiKhoan}">
                <tr>
                  <td colspan="5" style="text-align:center; padding:50px; color:#b5527a; font-style:italic;">
                    Chưa có tài khoản nào. Nhấn nút "+ Thêm nhân viên" để tạo.
                  </td>
                </tr>
              </c:if>
              </tbody>
            </table>
          </div>
        </div>

      </div>
    </div>
  </main>
</div>

<!-- MODAL: Thêm nhân viên -->
<div class="modal-backdrop" id="addModal">
  <div class="modal">
    <div class="modal-title">➕ Thêm nhân viên mới</div>
    <div class="form-group">
      <label class="form-label">Họ và tên</label>
      <input type="text" class="form-input" placeholder="Nhập họ và tên">
    </div>
    <div class="form-group">
      <label class="form-label">Email đăng nhập</label>
      <input type="email" class="form-input" placeholder="email@mediden.vn">
    </div>
    <div class="form-row">
      <div class="form-group">
        <label class="form-label">Mật khẩu</label>
        <input type="password" class="form-input" placeholder="Nhập mật khẩu">
      </div>
      <div class="form-group">
        <label class="form-label">Vai trò</label>
        <select class="form-select">
          <option>Nhân viên bán hàng</option>
          <option>Nhân viên kho</option>
          <option>Quản trị viên</option>
        </select>
      </div>
    </div>
    <div class="modal-footer">
      <button class="btn-ghost" onclick="closeAddModal()">Hủy</button>
      <button class="btn-primary" onclick="closeAddModal(); saveToast()">✅ Thêm nhân viên</button>
    </div>
  </div>
</div>

<!-- TOAST -->
<div class="toast" id="toast">✅ Đã lưu thay đổi thành công!</div>

<script>
  // Dropdown
  function toggleDropdown() {
    document.getElementById('profileDropdown').classList.toggle('open');
  }
  document.addEventListener('click', function(e) {
    if (!document.querySelector('.profile-wrapper').contains(e.target)) {
      document.getElementById('profileDropdown').classList.remove('open');
    }
  });

  // Section tabs
  function showSection(name) {
    document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
    document.getElementById('section-' + name).classList.add('active');
    document.querySelectorAll('.settings-nav-item').forEach(i => i.classList.remove('active'));
    event.currentTarget.classList.add('active');
  }

  // Bank preview
  document.getElementById('bankName').addEventListener('input', function() {
    document.getElementById('previewBankName').textContent = this.value || '—';
  });
  document.getElementById('bankNumber').addEventListener('input', function() {
    document.getElementById('previewBankNumber').textContent = this.value || '—';
  });

  // Modal
  function openAddModal() { document.getElementById('addModal').classList.add('open'); }
  function closeAddModal() { document.getElementById('addModal').classList.remove('open'); }
  document.getElementById('addModal').addEventListener('click', function(e) {
    if (e.target === this) closeAddModal();
  });

  // Toast
  function saveToast() {
    const t = document.getElementById('toast');
    t.classList.add('show');
    setTimeout(() => t.classList.remove('show'), 2800);
  }
</script>
</body>
</html>
