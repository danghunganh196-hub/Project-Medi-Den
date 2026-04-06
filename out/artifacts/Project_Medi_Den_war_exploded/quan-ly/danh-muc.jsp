<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Medi Den</title>
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
        body { font-family: 'Be Vietnam Pro', sans-serif; background: #ffffff; color: var(--text-dark); min-height: 100vh; }
        .topbar { background: var(--pink); height: 64px; display: flex; align-items: center; justify-content: space-between; padding: 0 32px; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 16px rgba(240,18,122,0.25); }
        .topbar-logo { display: flex; align-items: center; gap: 12px; }
        .logo-icon { width: 40px; height: 40px; background: white; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 18px; color: var(--pink); box-shadow: 0 2px 8px rgba(0,0,0,0.15); }
        .logo-text { color: white; font-size: 20px; font-weight: 700; letter-spacing: 0.5px; }
        .topbar-title { color: white; font-size: 17px; font-weight: 600; letter-spacing: 0.3px; }
        .topbar-right { display: flex; align-items: center; gap: 20px; }
        .topbar-search { display: flex; align-items: center; background: rgba(255,255,255,0.2); border: 1.5px solid rgba(255,255,255,0.35); border-radius: 24px; padding: 6px 16px; gap: 8px; cursor: pointer; }
        .topbar-search input { background: transparent; border: none; outline: none; color: white; font-family: inherit; font-size: 14px; width: 160px; }
        .topbar-search input::placeholder { color: rgba(255,255,255,0.7); }
        .topbar-avatar { width: 36px; height: 36px; background: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 15px; color: var(--pink); cursor: pointer; box-shadow: 0 2px 8px rgba(0,0,0,0.12); }
        .layout { display: flex; min-height: calc(100vh - 64px); }
        .sidebar { width: 260px; background: var(--sidebar-bg); padding: 28px 0 24px; display: flex; flex-direction: column; gap: 4px; border-right: 1.5px solid rgba(240,18,122,0.12); position: sticky; top: 64px; height: calc(100vh - 64px); overflow-y: auto; }
        .sidebar-section { padding: 0 16px; margin-bottom: 8px; }
        .sidebar-section-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 1.2px; color: var(--text-light); padding: 0 12px; margin-bottom: 6px; }
        .nav-item { display: flex; align-items: center; gap: 12px; padding: 11px 14px; border-radius: 12px; cursor: pointer; color: var(--text-mid); font-size: 14.5px; font-weight: 500; transition: background 0.2s, color 0.2s, transform 0.15s; user-select: none; }
        .nav-item .nav-icon { width: 36px; height: 36px; background: rgba(240,18,122,0.08); border-radius: 10px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; font-size: 17px; }
        .nav-item:hover { background: #fdf0f7; color: var(--pink); transform: translateX(3px); }
        .nav-item.active { background: var(--pink); color: white; box-shadow: 0 4px 16px var(--pink-glow); }
        .nav-item.active .nav-icon { background: rgba(255,255,255,0.22); }
        .nav-badge { margin-left: auto; background: var(--pink); color: white; font-size: 11px; font-weight: 700; padding: 2px 8px; border-radius: 10px; min-width: 22px; text-align: center; }
        .nav-item.active .nav-badge { background: rgba(255,255,255,0.3); }
        .sidebar-divider { height: 1px; background: rgba(240,18,122,0.12); margin: 10px 20px; }
        .main { flex: 1; padding: 32px 36px; overflow-y: auto; background: #ffffff; }
        .page-header { margin-bottom: 32px; }
        .page-header h1 { font-size: 26px; font-weight: 800; color: var(--text-dark); letter-spacing: -0.5px; }
        .card { background: white; border-radius: var(--radius); box-shadow: var(--shadow); border: 1.5px solid rgba(240,18,122,0.07); overflow: hidden; margin-bottom: 24px; }
        .card-header { padding: 20px 24px 16px; border-bottom: 1.5px solid rgba(240,18,122,0.08); display: flex; align-items: center; justify-content: space-between; }
        .card-title { font-size: 15px; font-weight: 700; color: var(--text-dark); }
        .table-wrap { padding: 0; }
        table { width: 100%; border-collapse: collapse; }
        thead th { padding: 12px 20px; text-align: left; font-size: 11.5px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.8px; color: var(--text-light); background: #fdf0f7; border-bottom: 1.5px solid rgba(240,18,122,0.08); }
        tbody tr { border-bottom: 1px solid rgba(240,18,122,0.06); transition: background 0.18s; cursor: pointer; }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: #fdf0f7; }
        tbody td { padding: 13px 20px; font-size: 13.5px; color: var(--text-dark); font-weight: 500; }

        /* ====== CSS RIÊNG CỦA TRANG NÀY ====== */
        .btn-pink { background: var(--pink); color: white; border: none; padding: 9px 20px; border-radius: 10px; font-family: inherit; font-size: 13.5px; font-weight: 600; cursor: pointer; transition: background 0.2s, transform 0.15s; }
        .btn-pink:hover { background: var(--pink-dark); transform: translateY(-1px); }
        .btn-edit { background: #fef9c3; color: #a16207; border: none; padding: 5px 12px; border-radius: 8px; font-family: inherit; font-size: 12.5px; font-weight: 600; cursor: pointer; }
        .btn-delete { background: #fee2e2; color: #dc2626; border: none; padding: 5px 12px; border-radius: 8px; font-family: inherit; font-size: 12.5px; font-weight: 600; cursor: pointer; }
        .btn-edit:hover, .btn-delete:hover { opacity: 0.75; }
    </style>
</head>
<body>

<!-- TOPBAR (giữ nguyên như trang-chu-admin.jsp) -->
<header class="topbar">
    <div class="topbar-logo">
        <div class="logo-icon">M</div>
        <span class="logo-text">Medi Den</span>
    </div>
    <span class="topbar-title">Quản lý danh mục</span>
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

    <!-- SIDEBAR (giữ nguyên, chỉ đổi active) -->
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
            <div class="nav-item active">
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

    <!-- MAIN -->
    <main class="main">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:24px;">
            <h1 style="font-size:26px; font-weight:800;">Quản lý danh mục</h1>
            <button class="btn-pink" onclick="moFormThem()">＋ Thêm danh mục</button>
        </div>

        <div id="formCard" class="card" style="display:none;">
            <div class="card-header">
                <span class="card-title" id="formTitle">Thêm danh mục mới</span>
                <span style="cursor:pointer; font-weight:bold;" onclick="dongForm()">✕ Đóng</span>
            </div>
            <div style="padding:24px;">
                <form id="mainForm" method="post" action="">
                    <input type="hidden" name="id" id="formId">
                    <div style="display:flex; gap:16px; align-items:flex-end;">
                        <div style="flex:1;">
                            <label style="display:block; font-size:13px; font-weight:600; margin-bottom:8px;">Tên thể loại</label>
                            <input required type="text" name="tenTheLoai" id="inputTen" placeholder="Nhập tên..."
                                   style="width:100%; padding:10px 14px; border:1.5px solid rgba(240,18,122,0.2); border-radius:10px; outline:none;">
                        </div>
                        <button type="submit" class="btn-pink" id="btnSubmit">Xác nhận</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <span class="card-title">Danh sách thể loại</span>
            </div>
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên thể loại</th>
                    <th style="text-align:right;">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="tl" items="${listTheLoai}">
                    <tr id="row-${tl.id}">
                        <td>#${tl.id}</td>
                        <td><strong>${tl.tenTheLoai}</strong></td>
                        <td style="text-align:right;">
                            <button class="btn-edit" onclick="moFormSua('${tl.id}', '${tl.tenTheLoai}')">Sửa</button>
                            <a href="${pageContext.request.contextPath}/danh-muc/delete?id=${tl.id}"
                               class="btn-delete" onclick="return confirm('Xóa danh mục này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</div>

<script>
    const formCard = document.getElementById('formCard');
    const formTitle = document.getElementById('formTitle');
    const mainForm = document.getElementById('mainForm');
    const inputId = document.getElementById('formId');
    const inputTen = document.getElementById('inputTen');
    const btnSubmit = document.getElementById('btnSubmit');

    function moFormThem() {
        formCard.style.display = 'block';
        formTitle.innerText = 'Thêm danh mục mới';
        mainForm.action = "${pageContext.request.contextPath}/danh-muc/add";
        inputId.value = "";
        inputTen.value = "";
        btnSubmit.innerText = "Thêm ngay";
        inputTen.focus();
    }

    function moFormSua(id, ten) {
        formCard.style.display = 'block';
        formTitle.innerText = 'Sửa danh mục #' + id;
        mainForm.action = "${pageContext.request.contextPath}/danh-muc/update";
        inputId.value = id;
        inputTen.value = ten;
        btnSubmit.innerText = "Lưu thay đổi";
        inputTen.focus();

        // Highlight dòng đang chọn
        document.querySelectorAll('tbody tr').forEach(r => r.style.background = '');
        document.getElementById('row-' + id).style.background = '#fce4f0';
    }

    function dongForm() {
        formCard.style.display = 'none';
        document.querySelectorAll('tbody tr').forEach(r => r.style.background = '');
    }
</script>
</div>

</body>
</html>