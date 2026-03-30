<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khách hàng - Medi Den</title>
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
        .topbar-search {
            display: flex; align-items: center;
            background: rgba(255,255,255,0.2);
            border: 1.5px solid rgba(255,255,255,0.35);
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

        /* ── LAYOUT ── */
        .layout { display: flex; min-height: calc(100vh - 64px); }

        /* ── SIDEBAR ── */
        .sidebar {
            width: 260px; background: var(--sidebar-bg);
            padding: 28px 0 24px;
            display: flex; flex-direction: column; gap: 4px;
            border-right: 1.5px solid rgba(240,18,122,0.12);
            position: sticky; top: 64px;
            height: calc(100vh - 64px); overflow-y: auto;
        }
        .sidebar-section { padding: 0 16px; margin-bottom: 8px; }
        .sidebar-section-label {
            font-size: 11px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 1.2px; color: var(--text-light);
            padding: 0 12px; margin-bottom: 6px;
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
        .nav-badge {
            margin-left: auto; background: var(--pink); color: white;
            font-size: 11px; font-weight: 700; padding: 2px 8px;
            border-radius: 10px; min-width: 22px; text-align: center;
        }
        .nav-item.active .nav-badge { background: rgba(255,255,255,0.3); }
        .sidebar-divider { height: 1px; background: rgba(240,18,122,0.12); margin: 10px 20px; }

        /* ── MAIN ── */
        .main { flex: 1; padding: 32px 36px; overflow-y: auto; background: #ffffff; }
        .page-header {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 24px;
        }
        .page-header h1 { font-size: 26px; font-weight: 800; color: var(--text-dark); letter-spacing: -0.5px; }

        /* ── BUTTONS ── */
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

        /* ── CARD ── */
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

        /* ── FORM ── */
        #formCard { display: none; margin-bottom: 24px; }
        .form-inner { padding: 24px; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 20px; }
        .form-group label { display: block; font-size: 13px; font-weight: 600; color: var(--text-mid); margin-bottom: 8px; }
        .form-group input, .form-group select {
            width: 100%; padding: 10px 14px;
            border: 1.5px solid rgba(240,18,122,0.2); border-radius: 10px;
            font-family: inherit; font-size: 14px; outline: none;
            transition: border-color 0.2s;
        }
        .form-group input:focus, .form-group select:focus { border-color: var(--pink); }
        .form-actions { display: flex; justify-content: flex-end; gap: 12px; }
        .btn-cancel { background: none; border: none; cursor: pointer; color: var(--text-light); font-family: inherit; font-size: 13.5px; padding: 9px 16px; border-radius: 10px; transition: background 0.2s; }
        .btn-cancel:hover { background: var(--pink-soft); }

        /* ── TABLE ── */
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
        .badge-nam { background: #e0f2fe; color: #0369a1; }
        .badge-nu { background: #fce7f3; color: #be185d; }
        .btn-delete { color: #dc2626; border: none; background: none; cursor: pointer; font-weight: 700; font-size: 13px; padding: 4px 8px; border-radius: 6px; transition: background 0.2s; }
        .btn-delete:hover { background: #fee2e2; }
    </style>
</head>
<body>

<header class="topbar">
    <div class="topbar-logo">
        <div class="logo-icon">M</div>
        <span class="logo-text">Medi Den</span>
    </div>
    <span class="topbar-title">Quản lý khách hàng</span>
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

    <nav class="sidebar">
        <div class="sidebar-section">
            <div class="sidebar-section-label">Chính</div>
            <div class="nav-item" onclick="window.location.href='${pageContext.request.contextPath}/quan-ly/trang-chu-admin.jsp'">
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
            <div class="nav-item active">
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

    <main class="main">
        <div class="page-header">
            <h1>Quản lý khách hàng</h1>
            <div style="display:flex; gap:10px;">
                <button class="btn-pink" onclick="toggleForm('them')">＋ Thêm khách hàng</button>
                <button class="btn-edit" id="btnSua" style="opacity:0.5; cursor:not-allowed;" disabled onclick="toggleForm('sua')">✏️ Sửa</button>
            </div>
        </div>

        <%-- FORM THÊM / SỬA --%>
        <div id="formCard" class="card">
            <div class="card-header">
                <span class="card-title" id="formTitle">Thêm khách hàng mới</span>
                <span class="card-action" onclick="dongForm()">✕ Đóng</span>
            </div>
            <div class="form-inner">
                <form method="post" action="${pageContext.request.contextPath}/khach-hang">
                    <input type="hidden" name="action" id="formAction" value="them">
                    <input type="hidden" name="id" id="formId" value="">
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Họ và Tên</label>
                            <input type="text" name="ten" id="inputTen" placeholder="Nhập họ và tên..." required>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" id="inputEmail" placeholder="Nhập email...">
                        </div>
                        <div class="form-group">
                            <label>Tuổi</label>
                            <input type="number" name="tuoi" id="inputTuoi" placeholder="Nhập tuổi...">
                        </div>
                        <div class="form-group">
                            <label>Giới tính</label>
                            <select name="gioiTinh" id="inputGioiTinh">
                                <option value="true">Nam</option>
                                <option value="false">Nữ</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="btn-cancel" onclick="dongForm()">Hủy bỏ</button>
                        <button type="submit" class="btn-pink" id="btnSubmit">＋ Thêm</button>
                    </div>
                </form>
            </div>
        </div>

        <%-- TABLE --%>
        <div class="card">
            <div class="card-header">
                <span class="card-title">Danh sách khách hàng</span>
                <span style="font-size:13px; color:var(--text-light);">Tổng: <strong>${listKhachHang.size()}</strong> khách hàng</span>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Họ và Tên</th>
                            <th>Tuổi</th>
                            <th>Giới tính</th>
                            <th>Email</th>
                            <th style="text-align:right; padding-right:24px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="kh" items="${listKhachHang}">
                            <tr onclick="chonRow(this, '${kh.id}', '${kh.ten}', '${kh.tuoi}', '${kh.gioiTinh}', '${kh.email}')">
                                <td style="color:var(--text-light); font-size:13px;">#${kh.id}</td>
                                <td><strong>${kh.ten}</strong></td>
                                <td>${kh.tuoi}</td>
                                <td>
                                    <span class="badge ${kh.gioiTinh ? 'badge-nam' : 'badge-nu'}">
                                        ${kh.gioiTinh ? 'Nam' : 'Nữ'}
                                    </span>
                                </td>
                                <td>${kh.email}</td>
                                <td style="text-align:right; padding-right:24px;">
                                    <button class="btn-delete"
                                        onclick="event.stopPropagation(); xoaKhachHang('${kh.id}', '${kh.ten}')">Xóa</button>
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
    let selectedId = null;

    function chonRow(row, id, ten, tuoi, gioiTinh, email) {
        document.querySelectorAll('tbody tr').forEach(r => r.style.background = '');

        if (selectedId === id) {
            selectedId = null;
            const btn = document.getElementById('btnSua');
            btn.disabled = true; btn.style.opacity = '0.5'; btn.style.cursor = 'not-allowed';
            dongForm();
            return;
        }

        selectedId = id;
        row.style.background = '#fce4f0';

        document.getElementById('formId').value = id;
        document.getElementById('inputTen').value = ten;
        document.getElementById('inputTuoi').value = tuoi;
        document.getElementById('inputGioiTinh').value = gioiTinh;
        document.getElementById('inputEmail').value = email;

        const btn = document.getElementById('btnSua');
        btn.disabled = false; btn.style.opacity = '1'; btn.style.cursor = 'pointer';
    }

    function toggleForm(mode) {
        const formCard = document.getElementById('formCard');
        const formTitle = document.getElementById('formTitle');
        const formAction = document.getElementById('formAction');
        const btnSubmit = document.getElementById('btnSubmit');

        if (mode === 'sua' && !selectedId) return;

        if (formCard.style.display !== 'none' && formCard.dataset.mode === mode) {
            dongForm(); return;
        }

        formCard.dataset.mode = mode;
        formCard.style.display = 'block';

        if (mode === 'them') {
            formTitle.textContent = 'Thêm khách hàng mới';
            formAction.value = 'them';
            btnSubmit.textContent = '＋ Thêm';
            document.getElementById('formId').value = '';
            ['inputTen', 'inputTuoi', 'inputEmail'].forEach(i => document.getElementById(i).value = '');
            document.getElementById('inputTen').focus();
        } else {
            formTitle.textContent = 'Chỉnh sửa khách hàng #' + selectedId;
            formAction.value = 'sua';
            btnSubmit.textContent = '💾 Lưu';
        }

        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function dongForm() {
        document.getElementById('formCard').style.display = 'none';
    }

    function xoaKhachHang(id, ten) {
        if (confirm('Bạn có chắc muốn xóa khách hàng ' + ten + '?')) {
            window.location.href = '${pageContext.request.contextPath}/khach-hang?action=xoa&id=' + id;
        }
    }
</script>
</body>
</html>
