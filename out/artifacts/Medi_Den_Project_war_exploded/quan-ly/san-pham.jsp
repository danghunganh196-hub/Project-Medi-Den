<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm - Medi Den</title>
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

        .topbar {
            background: var(--pink);
            height: 64px;
            display: flex; align-items: center; justify-content: space-between;
            padding: 0 32px;
            position: sticky; top: 0; z-index: 100;
            box-shadow: 0 2px 16px rgba(240,18,122,0.25);
        }
        .topbar-logo { display: flex; align-items: center; gap: 12px; }
        .logo-icon {
            width: 40px; height: 40px; background: white; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-weight: 800; font-size: 18px; color: var(--pink);
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        .logo-text { color: white; font-size: 20px; font-weight: 700; letter-spacing: 0.5px; }
        .topbar-title { color: white; font-size: 17px; font-weight: 600; letter-spacing: 0.3px; }
        .topbar-right { display: flex; align-items: center; gap: 20px; }
        .topbar-search {
            display: flex; align-items: center;
            background: rgba(255,255,255,0.2); border: 1.5px solid rgba(255,255,255,0.35);
            border-radius: 24px; padding: 6px 16px; gap: 8px;
            transition: background 0.25s, border-color 0.25s; cursor: pointer;
        }
        .topbar-search:hover { background: rgba(255,255,255,0.32); border-color: rgba(255,255,255,0.6); }
        .topbar-search input {
            background: transparent; border: none; outline: none;
            color: white; font-family: inherit; font-size: 14px; width: 160px;
        }
        .topbar-search input::placeholder { color: rgba(255,255,255,0.7); }
        .topbar-avatar {
            width: 36px; height: 36px; background: white; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: 700; font-size: 15px; color: var(--pink); cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
        }
        .topbar-avatar:hover { transform: scale(1.08); box-shadow: 0 4px 16px rgba(0,0,0,0.18); }

        .layout { display: flex; min-height: calc(100vh - 64px); }

        .sidebar {
            width: 260px; background: var(--sidebar-bg);
            padding: 28px 0 24px;
            display: flex; flex-direction: column; gap: 4px;
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

        .main { flex: 1; padding: 32px 36px; overflow-y: auto; background: #ffffff; }
        .page-header {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 24px;
        }
        .page-header h1 { font-size: 26px; font-weight: 800; color: var(--text-dark); letter-spacing: -0.5px; }

        .btn-pink {
            background: var(--pink); color: white; border: none;
            padding: 9px 20px; border-radius: 10px;
            font-family: inherit; font-size: 13.5px; font-weight: 600;
            cursor: pointer; transition: all 0.2s;
            display: flex; align-items: center; gap: 6px;
        }
        .btn-pink:hover { background: var(--pink-dark); transform: translateY(-2px); box-shadow: 0 4px 12px var(--pink-glow); }
        .btn-edit {
            background: var(--pink-soft); color: var(--pink); border: none;
            padding: 9px 20px; border-radius: 10px;
            font-family: inherit; font-size: 13.5px; font-weight: 600;
            cursor: pointer; transition: all 0.2s;
        }
        .btn-edit:not(:disabled):hover { background: var(--pink); color: white; transform: translateY(-2px); }

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
        .card-action { font-size: 12.5px; font-weight: 600; color: var(--pink); cursor: pointer; transition: opacity 0.2s; }
        .card-action:hover { opacity: 0.7; }

        #formCard { display: none; margin-bottom: 24px; }
        .form-inner { padding: 24px; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: var(--text-mid); margin-bottom: 8px; }
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%; padding: 10px 14px;
            border: 1.5px solid rgba(240,18,122,0.2); border-radius: 10px;
            font-family: inherit; font-size: 14px; outline: none;
            transition: border-color 0.2s; resize: vertical;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus { border-color: var(--pink); }
        .form-group.full { grid-column: 1 / -1; }
        .form-actions { display: flex; justify-content: flex-end; gap: 12px; }
        .btn-cancel {
            background: none; border: none; cursor: pointer; color: var(--text-light);
            font-family: inherit; font-size: 13.5px; padding: 9px 16px; border-radius: 10px; transition: background 0.2s;
        }
        .btn-cancel:hover { background: var(--pink-soft); }

        .table-wrap { padding: 0; }
        table { width: 100%; border-collapse: collapse; }
        thead th {
            padding: 12px 20px; text-align: left;
            font-size: 11.5px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.8px; color: var(--text-light);
            background: #fdf0f7; border-bottom: 1.5px solid rgba(240,18,122,0.08);
        }
        tbody tr { border-bottom: 1px solid rgba(240,18,122,0.06); transition: background 0.18s; cursor: pointer; }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: #fdf0f7; }
        tbody td { padding: 13px 20px; font-size: 13.5px; color: var(--text-dark); font-weight: 500; }

        .badge { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: 11.5px; font-weight: 700; }
        .badge-green { background: #dcfce7; color: #16a34a; }
        .badge-red   { background: #fee2e2; color: #dc2626; }

        .btn-delete {
            color: #dc2626; border: none; background: none; cursor: pointer;
            font-weight: 700; font-size: 13px; padding: 4px 8px; border-radius: 6px; transition: background 0.2s;
        }
        .btn-delete:hover { background: #fee2e2; }

        .product-img {
            width: 44px; height: 44px; border-radius: 10px; object-fit: cover;
            border: 1.5px solid rgba(240,18,122,0.12); background: var(--pink-soft);
        }
        .product-img-placeholder {
            width: 44px; height: 44px; border-radius: 10px;
            background: var(--pink-soft); display: flex; align-items: center;
            justify-content: center; font-size: 20px;
            border: 1.5px solid rgba(240,18,122,0.12);
        }
        .size-tag {
            display: inline-block; background: var(--pink-soft); color: var(--pink);
            font-size: 11px; font-weight: 700; padding: 2px 7px;
            border-radius: 6px; margin: 1px;
        }

        /* ── PROFILE DROPDOWN ── */
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

<header class="topbar">
    <div class="topbar-logo">
        <div class="logo-icon">M</div>
        <span class="logo-text">Medi Den</span>
    </div>
    <span class="topbar-title">Quản lý sản phẩm</span>
    <div class="topbar-right">
        <form action="${pageContext.request.contextPath}/san-pham/search" method="get">
            <div class="topbar-search" style="display: flex; align-items: center;">
                <button type="submit" style="background: none; border: none; padding: 0; cursor: pointer;">
                    <svg width="15" height="15" fill="none" viewBox="0 0 24 24" stroke="white" stroke-width="2.5">
                        <circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/>
                    </svg>
                </button>
                <input type="text" name="searchKeywordSp" value="${searchKeywordSp}" placeholder="Tìm kiếm sản phẩm...">
            </div>
        </form>

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
            <div class="nav-item active">
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
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/cai-dat'">
                <div class="nav-icon">⚙️</div>
                Cài đặt
            </div>
        </div>
    </nav>

    <main class="main">
        <div class="page-header">
            <h1>Quản lý sản phẩm</h1>
            <button class="btn-pink" onclick="toggleForm('them')">＋ Thêm sản phẩm</button>
        </div>

        <c:if test="${not empty errorMessage}">
            <div style="background-color: #fee2e2; color: #dc2626; padding: 12px; border-radius: 8px; margin-bottom: 16px; font-weight: 600;">
                ⚠️ ${errorMessage}
            </div>
        </c:if>

        <%-- ══════════════════════════════════════════════════
             FORM THÊM / SỬA
             THAY ĐỔI SO VỚI BẢN CŨ:
             1. id="spForm" để JS cập nhật action động
             2. enctype="multipart/form-data" để upload ảnh
             3. Bỏ hidden "action", thay bằng action URL riêng
             4. Thêm span#anhHienTai hiện tên ảnh khi sửa
        ═══════════════════════════════════════════════════ --%>
        <div id="formCard" class="card">
            <div class="card-header">
                <span class="card-title" id="formTitle">Thêm sản phẩm mới</span>
                <span class="card-action" onclick="dongForm()">✕ Đóng</span>
            </div>
            <div class="form-inner">
                <form id="spForm"
                      method="post"
                      action="${pageContext.request.contextPath}/san-pham/add"
                      enctype="multipart/form-data">

                    <input type="hidden" name="id" id="formId" value="">

                    <div class="form-grid">
                        <div class="form-group">
                            <label>Tên sản phẩm</label>
                            <input type="text" name="ten" id="inputTen"
                                   placeholder="Nhập tên sản phẩm..." required>
                        </div>
                        <div class="form-group">
                            <label>Danh mục</label>
                            <select name="danhMucId" id="inputDanhMuc">
                                <c:forEach var="dm" items="${listDanhMuc}">
                                    <option value="${dm.id}">${dm.tenTheLoai}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Giá (VNĐ)</label>
                            <input type="number" name="gia" id="inputGia"
                                   placeholder="Nhập giá..." min="0" step="1000">
                        </div>
                        <div class="form-group">
                            <label>Thương hiệu</label>
                            <input type="text" name="thuongHieu" id="inputThuongHieu"
                                   placeholder="Nhập thương hiệu...">
                        </div>
                        <div class="form-group">
                            <label>
                                Hình ảnh
                                <span id="anhHienTai"
                                      style="font-weight:400; color:var(--text-light); font-size:12px;"></span>
                            </label>
                            <input type="file" name="hinhAnh" id="inputHinhAnh" accept="image/*">
                        </div>
                        <div class="form-group full">
                            <label>Mô tả sản phẩm</label>
                            <textarea name="moTa" id="inputMoTa" rows="4"
                                      placeholder="Nhập mô tả sản phẩm..."></textarea>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="btn-cancel" onclick="dongForm()">Hủy bỏ</button>
                        <button type="submit" class="btn-pink" id="btnSubmit">＋ Thêm</button>
                    </div>
                </form>

                <%-- BẢNG QUẢN LÝ SIZE — chỉ hiện khi mode = "sửa" --%>
                <div id="sizeSection" style="display:none; margin-top:24px;">
                    <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:12px;">
                        <span style="font-size:14px; font-weight:700; color:var(--text-dark);">Quản lý size</span>
                        <button type="button" class="btn-pink" style="padding:6px 14px; font-size:12.5px;"
                                onclick="toggleThemSize()">＋ Thêm size</button>
                    </div>

                    <div id="themSizeForm" style="display:none; background:var(--pink-soft); border-radius:12px; padding:16px; margin-bottom:12px;">
                        <div style="display:flex; gap:12px; align-items:flex-end;">
                            <div class="form-group" style="margin:0; flex:1;">
                                <label>Size</label>
                                <input type="number" id="inputSizeMoi" min="35" max="50" placeholder="VD: 42">
                            </div>
                            <div class="form-group" style="margin:0; flex:1;">
                                <label>Số lượng</label>
                                <input type="number" id="inputSoLuongMoi" min="0" placeholder="VD: 5">
                            </div>
                            <button type="button" class="btn-pink" style="padding:10px 18px; white-space:nowrap;"
                                    onclick="themSizeMoi()">Thêm</button>
                            <button type="button" class="btn-cancel" onclick="toggleThemSize()">Hủy</button>
                        </div>
                    </div>

                    <div id="sizeBang" style="border:1.5px solid rgba(240,18,122,0.12); border-radius:12px; overflow:hidden;">
                        <table style="width:100%; border-collapse:collapse;">
                            <thead>
                            <tr style="background:#fdf0f7;">
                                <th style="padding:10px 16px; text-align:left; font-size:11.5px; font-weight:700;
                                    text-transform:uppercase; letter-spacing:0.8px; color:var(--text-light);">Size</th>
                                <th style="padding:10px 16px; text-align:left; font-size:11.5px; font-weight:700;
                                    text-transform:uppercase; letter-spacing:0.8px; color:var(--text-light);">Tồn kho</th>
                                <th style="padding:10px 16px; text-align:right; font-size:11.5px; font-weight:700;
                                    text-transform:uppercase; letter-spacing:0.8px; color:var(--text-light);">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody id="sizeTbody"></tbody>
                        </table>
                        <div id="sizeEmpty" style="display:none; padding:20px; text-align:center;
                             font-size:13px; color:var(--text-light);">
                            Chưa có size nào. Thêm size bên trên.
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- ══════════════════════════════════════════════════
             BẢNG DANH SÁCH SẢN PHẨM
             THAY ĐỔI: chonRow() nhận thêm tham số hinhAnh
        ═══════════════════════════════════════════════════ --%>
        <div class="card">
            <div class="card-header">
                <span class="card-title">Danh sách sản phẩm</span>
                <span style="font-size:13px; color:var(--text-light);">
                    Tổng: <strong>${listSanPham.size()}</strong> sản phẩm
                </span>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Sản phẩm</th>
                        <th>Thể loại</th>
                        <th>Giá</th>
                        <th>Size & Số lượng</th>
                        <th>Trạng thái</th>
                        <th style="text-align:right; padding-right:24px;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="sp" items="${listSanPham}">
                        <c:set var="tongSL" value="0"/>
                        <c:forEach var="sg" items="${sp.listSize}">
                            <c:set var="tongSL" value="${tongSL + sg.soLuong}"/>
                        </c:forEach>

                        <tr onclick="chonRow(this, '${sp.id}', '${sp.tenGiay}', '${sp.gia}', '${sp.theLoaiGiay.id}', '${sp.thuongHieu}', '${sp.hinhAnh}', '${sp.moTa}')">
                            <td style="color:var(--text-light); font-size:13px;">#${sp.id}</td>
                            <td>
                                <div style="display:flex; align-items:center; gap:12px;">
                                    <c:choose>
                                        <c:when test="${not empty sp.hinhAnh}">
                                            <img src="${sp.hinhAnh}" alt="${sp.tenGiay}" class="product-img">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-img-placeholder">👟</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <strong>${sp.tenGiay}</strong>
                                        <div style="font-size:12px; color:var(--text-light);">${sp.thuongHieu}</div>
                                    </div>
                                </div>
                            </td>
                            <td>${sp.theLoaiGiay.tenTheLoai}</td>
                            <td style="font-weight:700; color:var(--pink);">
                                <fmt:formatNumber value="${sp.gia}" pattern="#,###"/> đ
                            </td>
                            <td>
                                <c:forEach var="sg" items="${sp.listSize}">
                                    <span class="size-tag">${sg.soSize}: ${sg.soLuong}</span>
                                </c:forEach>
                            </td>
                            <td>
                                <span class="badge ${tongSL > 0 ? 'badge-green' : 'badge-red'}">
                                        ${tongSL > 0 ? 'Còn hàng' : 'Hết hàng'}
                                </span>
                            </td>
                            <td style="text-align:right; padding-right:24px;">
                                <button class="btn-edit"
                                        style="margin-right:6px; padding:5px 12px; font-size:12.5px; border-radius:8px;"
                                        onclick="event.stopPropagation();
                                                chonRow(this.closest('tr'), '${sp.id}', '${sp.tenGiay}', '${sp.gia}', '${sp.theLoaiGiay.id}', '${sp.thuongHieu}', '${sp.hinhAnh}','${sp.moTa}');
                                                toggleForm('sua')">
                                    Sửa
                                </button>
                                <button class="btn-delete"
                                        onclick="event.stopPropagation(); xoaSanPham('${sp.id}', '${sp.tenGiay}')">
                                    Xóa
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    let selectedId   = null;
    let currentSizes = [];

    // ─── SIZE ─────────────────────────────────────────────────────────────────
    async function loadSizes(giayId) {
        try {
            const res = await fetch(contextPath + '/san-pham?action=getSizes&giayId=' + giayId);
            currentSizes = await res.json();
            renderSizeTable();
        } catch (e) {
            console.error('Lỗi load size:', e);
        }
    }

    function renderSizeTable() {
        const tbody = document.getElementById('sizeTbody');
        const empty = document.getElementById('sizeEmpty');
        tbody.innerHTML = '';

        if (currentSizes.length === 0) {
            empty.style.display = 'block';
            return;
        }
        empty.style.display = 'none';

        currentSizes.forEach(s => {
            const tr = document.createElement('tr');
            tr.style.borderTop = '1px solid rgba(240,18,122,0.06)';
            tr.innerHTML =
                '<td style="padding:10px 16px; font-weight:600;">' + s.soSize + '</td>' +
                '<td style="padding:10px 16px;">' +
                '<input type="number" value="' + s.soLuong + '" min="0"' +
                ' style="width:80px; padding:5px 8px; border:1.5px solid rgba(240,18,122,0.2);' +
                ' border-radius:8px; font-family:inherit; font-size:13px;"' +
                ' onchange="capNhatSoLuong(' + s.id + ', this.value)">' +
                '</td>' +
                '<td style="padding:10px 16px; text-align:right;">' +
                '<button onclick="xoaSize(' + s.id + ', ' + s.soSize + ')"' +
                ' style="color:#dc2626; border:none; background:none; cursor:pointer;' +
                ' font-weight:700; font-size:12.5px; padding:4px 8px; border-radius:6px;"' +
                ' onmouseover="this.style.background=\'#fee2e2\'"' +
                ' onmouseout="this.style.background=\'none\'">Xóa</button>' +
                '</td>';
            tbody.appendChild(tr);
        });
    }

    function toggleThemSize() {
        const f = document.getElementById('themSizeForm');
        f.style.display = f.style.display === 'none' ? 'block' : 'none';
        if (f.style.display === 'block') document.getElementById('inputSizeMoi').focus();
    }

    async function themSizeMoi() {
        const soSize  = document.getElementById('inputSizeMoi').value;
        const soLuong = document.getElementById('inputSoLuongMoi').value;
        if (!soSize || !soLuong)                        { alert('Vui lòng nhập đủ size và số lượng'); return; }
        if (soSize < 35 || soSize > 50)                 { alert('Size phải từ 35 đến 50'); return; }
        if (currentSizes.find(s => s.soSize == soSize)) { alert('Size này đã tồn tại'); return; }

        const res = await fetch(contextPath + '/size-giay', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'action=them&giayId=' + selectedId + '&soSize=' + soSize + '&soLuong=' + soLuong
        });
        if (res.ok) {
            document.getElementById('inputSizeMoi').value    = '';
            document.getElementById('inputSoLuongMoi').value = '';
            toggleThemSize();
            await loadSizes(selectedId);
        }
    }

    async function capNhatSoLuong(sizeId, soLuong) {
        await fetch(contextPath + '/size-giay', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'action=capNhat&sizeId=' + sizeId + '&soLuong=' + soLuong
        });
    }

    async function xoaSize(sizeId, soSize) {
        if (!confirm('Xóa size ' + soSize + '?')) return;
        const res    = await fetch(contextPath + '/size-giay', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'action=xoa&sizeId=' + sizeId
        });
        const result = await res.text();
        if (result === 'ERROR_FK') {
            alert('Không thể xóa — size này đã có trong đơn hàng!');
        } else {
            await loadSizes(selectedId);
        }
    }

    // ─── CHỌN HÀNG ────────────────────────────────────────────────────────────
    // Thêm tham số hinhAnh so với bản cũ
    function chonRow(row, id, ten, gia, danhMucId, thuongHieu, hinhAnh, moTa) {
        document.querySelectorAll('tbody tr').forEach(r => r.style.background = '');

        if (selectedId === id) {
            selectedId = null;
            dongForm();
            return;
        }

        selectedId = id;
        row.style.background = '#fce4f0';

        document.getElementById('formId').value          = id;
        document.getElementById('inputTen').value        = ten;
        document.getElementById('inputGia').value        = gia;
        document.getElementById('inputThuongHieu').value = thuongHieu;
        document.getElementById('inputMoTa').value = moTa || '';

        const dmSelect = document.getElementById('inputDanhMuc');
        if (dmSelect) dmSelect.value = String(danhMucId);

        // Hiện tên ảnh hiện tại để người dùng biết
        const anhLabel = document.getElementById('anhHienTai');
        if (hinhAnh && hinhAnh !== 'null' && hinhAnh.trim() !== '') {
            anhLabel.textContent = '(hiện tại: ' + hinhAnh.split('/').pop() + ')';
        } else {
            anhLabel.textContent = '';
        }
    }

    // ─── TOGGLE FORM ──────────────────────────────────────────────────────────
    function toggleForm(mode) {
        const formCard  = document.getElementById('formCard');
        const formTitle = document.getElementById('formTitle');
        const spForm    = document.getElementById('spForm');      // lấy form theo id
        const btnSubmit = document.getElementById('btnSubmit');

        // Click cùng mode → đóng
        if (formCard.style.display !== 'none' && formCard.dataset.mode === mode) {
            dongForm(); return;
        }

        formCard.dataset.mode  = mode;
        formCard.style.display = 'block';

        if (mode === 'them') {
            formTitle.textContent  = 'Thêm sản phẩm mới';
            spForm.action          = contextPath + '/san-pham/add';    // POST → /san-pham/add
            btnSubmit.textContent  = '＋ Thêm';

            // Reset form
            document.getElementById('formId').value          = '';
            document.getElementById('inputTen').value        = '';
            document.getElementById('inputGia').value        = '';
            document.getElementById('inputThuongHieu').value = '';
            document.getElementById('inputHinhAnh').value    = '';
            document.getElementById('inputMoTa').value       = '';
            document.getElementById('anhHienTai').textContent = '';
            document.getElementById('sizeSection').style.display = 'none';
            document.getElementById('inputTen').focus();

        } else { // 'sua'
            if (!selectedId) { alert('Vui lòng chọn sản phẩm cần sửa!'); return; }
            formTitle.textContent  = 'Chỉnh sửa sản phẩm #' + selectedId;
            spForm.action          = contextPath + '/san-pham/update'; // POST → /san-pham/update
            btnSubmit.textContent  = '💾 Lưu thay đổi';

            document.getElementById('sizeSection').style.display = 'block';
            loadSizes(selectedId);
        }

        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function dongForm() {
        document.getElementById('formCard').style.display    = 'none';
        document.getElementById('sizeSection').style.display = 'none';
        document.getElementById('anhHienTai').textContent    = '';
        document.querySelectorAll('tbody tr').forEach(r => r.style.background = '');
        currentSizes = [];
        selectedId   = null;
    }

    // ─── XÓA SẢN PHẨM ─────────────────────────────────────────────────────────
    // GET /san-pham/delete?id=...
    function xoaSanPham(id, ten) {
        if (confirm('Bạn có chắc muốn xóa sản phẩm "' + ten + '"?\nThao tác này không thể hoàn tác!')) {
            window.location.href = contextPath + '/san-pham/delete?id=' + id;
        }
    }

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
