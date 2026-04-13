<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng - Medi Den</title>
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
        .topbar-avatar {
            width: 36px; height: 36px; background: white; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-weight: 700; font-size: 15px; color: var(--pink); cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
        }
        .topbar-avatar:hover { transform: scale(1.08); box-shadow: 0 4px 16px rgba(0,0,0,0.18); }

        /* ── LAYOUT & SIDEBAR ── */
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
            position: relative; user-select: none; margin-bottom: 4px;
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
        .page-header {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 24px;
        }
        .page-header h1 { font-size: 26px; font-weight: 800; color: var(--text-dark); letter-spacing: -0.5px; }

        /* ── STAT CARDS ── */
        .stats-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: white; border-radius: var(--radius);
            border: 1.5px solid rgba(240,18,122,0.07);
            box-shadow: var(--shadow); padding: 20px 22px;
        }
        .stat-icon {
            width: 42px; height: 42px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; margin-bottom: 14px;
        }
        .stat-label { font-size: 12.5px; color: var(--text-light); font-weight: 600; margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-value { font-size: 26px; font-weight: 800; color: var(--text-dark); letter-spacing: -0.5px; }
        .stat-sub { font-size: 12px; color: var(--text-light); margin-top: 4px; }

        /* ── CARD ── */
        .card {
            background: white; border-radius: var(--radius);
            box-shadow: var(--shadow); border: 1.5px solid rgba(240,18,122,0.07);
            overflow: hidden; margin-bottom: 24px;
        }
        .card-header {
            padding: 18px 24px;
            border-bottom: 1.5px solid rgba(240,18,122,0.08);
            display: flex; align-items: center; justify-content: space-between;
            flex-wrap: wrap; gap: 12px;
        }
        .card-title { font-size: 15px; font-weight: 700; color: var(--text-dark); }
        .card-meta { font-size: 13px; color: var(--text-light); }
        .card-meta strong { color: var(--text-dark); }

        /* ── FILTER TABS ── */
        .filter-tabs { display: flex; gap: 6px; flex-wrap: wrap; }
        .filter-tab {
            padding: 6px 14px; border-radius: 20px; font-size: 12.5px; font-weight: 600;
            border: 1.5px solid rgba(240,18,122,0.15); background: transparent;
            color: var(--text-light); cursor: pointer; transition: all 0.2s; font-family: inherit;
        }
        .filter-tab:hover { background: var(--pink-soft); color: var(--pink); border-color: var(--pink); }
        .filter-tab.active { background: var(--pink); color: white; border-color: var(--pink); }

        /* ── TABLE ── */
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; }
        thead th {
            padding: 12px 20px; text-align: left;
            font-size: 11.5px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.8px; color: var(--text-light);
            background: #fdf0f7; border-bottom: 1.5px solid rgba(240,18,122,0.08);
            white-space: nowrap;
        }
        tbody tr { border-bottom: 1px solid rgba(240,18,122,0.06); transition: background 0.18s; }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background: #fdf0f7; }
        tbody td { padding: 14px 20px; font-size: 13.5px; color: var(--text-dark); font-weight: 500; vertical-align: middle; }

        /* ── CUSTOMER CELL ── */
        .customer-cell { display: flex; align-items: center; gap: 10px; }
        .customer-avatar {
            width: 38px; height: 38px; border-radius: 50%;
            background: var(--pink-soft); color: var(--pink);
            display: flex; align-items: center; justify-content: center;
            font-size: 13px; font-weight: 700; flex-shrink: 0;
        }
        .customer-name { font-weight: 700; font-size: 13.5px; }
        .customer-sub { font-size: 11.5px; color: var(--text-light); margin-top: 1px; }

        /* ── BADGES ── */
        .badge {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 4px 12px; border-radius: 20px;
            font-size: 12px; font-weight: 700; white-space: nowrap;
        }
        .badge-dot { width: 6px; height: 6px; border-radius: 50%; background: currentColor; flex-shrink: 0; }
        .badge-wait    { background: #fef3c7; color: #92400e; }
        .badge-confirm { background: #dbeafe; color: #1e40af; }
        .badge-ship    { background: #ede9fe; color: #5b21b6; }
        .badge-done    { background: #d1fae5; color: #065f46; }
        .badge-cancel  { background: #fee2e2; color: #991b1b; }

        /* ── BUTTONS ── */
        .btn-edit {
            background: var(--pink-soft); color: var(--pink);
            border: none; padding: 6px 14px; border-radius: 8px;
            font-family: inherit; font-size: 12.5px; font-weight: 600;
            cursor: pointer; transition: all 0.2s; margin-right: 6px;
        }
        .btn-edit:hover { background: var(--pink); color: white; }
        .btn-delete {
            background: none; color: #dc2626; border: none;
            padding: 6px 10px; border-radius: 8px;
            font-family: inherit; font-size: 12.5px; font-weight: 700;
            cursor: pointer; transition: background 0.2s;
        }
        .btn-delete:hover { background: #fee2e2; }

        /* ── MONEY ── */
        .money { font-weight: 800; color: var(--pink); }

        /* ── EMPTY STATE ── */
        .empty-state {
            padding: 60px 20px; text-align: center; color: var(--text-light);
        }
        .empty-state-icon { font-size: 48px; margin-bottom: 16px; }
        .empty-state-text { font-size: 15px; font-weight: 600; }
        .empty-state-sub { font-size: 13px; margin-top: 6px; }

        /* ── PROFILE DROPDOWN ── */
        .profile-wrapper { position: relative; }
        .profile-dropdown {
            position: absolute; top: calc(100% + 12px); right: 0;
            background: white; border-radius: 14px;
            box-shadow: 0 8px 32px rgba(240,18,122,0.18), 0 2px 8px rgba(0,0,0,0.08);
            border: 1.5px solid rgba(240,18,122,0.12); min-width: 220px;
            padding: 16px; display: none; z-index: 999;
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
    </style>
</head>
<body>

<header class="topbar">
    <div class="topbar-logo">
        <div class="logo-icon">M</div>
        <span class="logo-text">Medi Den</span>
    </div>
    <span class="topbar-title">Quản lý Hóa đơn</span>
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
            <div class="nav-item active">
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

    <main class="main">
        <div class="page-header">
            <h1>Quản lý đơn hàng</h1>
        </div>

        <%-- ══ TABLE CARD ══ --%>
        <div class="card">
            <div class="card-header">
                <div style="display:flex; align-items:center; gap:12px;">
                    <span class="card-title">Danh sách hóa đơn</span>
                    <span class="card-meta">Tổng: <strong>${listHoaDon.size()}</strong> hóa đơn</span>
                </div>
                <div class="filter-tabs">
                    <button class="filter-tab active" onclick="filterTab(this, '')">Tất cả</button>
                    <button class="filter-tab" onclick="filterTab(this, 'Chờ xác nhận')">Chờ xác nhận</button>
                    <button class="filter-tab" onclick="filterTab(this, 'Đang giao')">Đang giao</button>
                    <button class="filter-tab" onclick="filterTab(this, 'Hoàn thành')">Hoàn thành</button>
                    <button class="filter-tab" onclick="filterTab(this, 'Đã hủy')">Đã hủy</button>
                </div>
            </div>

            <div class="table-wrap">
                <table id="orderTable">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Khách hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Địa chỉ</th>
                        <th style="text-align:right; padding-right:24px;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty listHoaDon}">
                            <tr>
                                <td colspan="7">
                                    <div class="empty-state">
                                        <div class="empty-state-icon">📭</div>
                                        <div class="empty-state-text">Chưa có đơn hàng nào</div>
                                        <div class="empty-state-sub">Đơn hàng mới sẽ xuất hiện tại đây</div>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="hd" items="${listHoaDon}">
                                <tr data-trangthai="${hd.trangThai}" data-tongtien="${hd.tongTien}">
                                    <td style="color:var(--text-light); font-size:13px;">#${hd.id}</td>

                                    <td>
                                        <div class="customer-cell">
                                            <div class="customer-avatar">
                                                <c:choose>
                                                    <c:when test="${hd.khachHang != null and not empty hd.khachHang.ten}">
                                                        ${fn:toUpperCase(fn:substring(hd.khachHang.ten, 0, 2))}
                                                    </c:when>
                                                    <c:otherwise>KH</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <div class="customer-name">
                                                    ${hd.khachHang != null ? hd.khachHang.ten : '---'}
                                                </div>
                                                <div class="customer-sub">Khách hàng</div>
                                            </div>
                                        </div>
                                    </td>

                                    <td style="color:var(--text-light);">${hd.ngayDat}</td>

                                    <td>
                                        <span class="money">
                                            <fmt:formatNumber value="${hd.tongTien}" pattern="#,###"/> đ
                                        </span>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${hd.trangThai == 'Chờ xác nhận'}">
                                                <span class="badge badge-wait"><span class="badge-dot"></span>${hd.trangThai}</span>
                                            </c:when>
                                            <c:when test="${hd.trangThai == 'Đã xác nhận'}">
                                                <span class="badge badge-confirm"><span class="badge-dot"></span>${hd.trangThai}</span>
                                            </c:when>
                                            <c:when test="${hd.trangThai == 'Đang giao'}">
                                                <span class="badge badge-ship"><span class="badge-dot"></span>${hd.trangThai}</span>
                                            </c:when>
                                            <c:when test="${hd.trangThai == 'Hoàn thành'}">
                                                <span class="badge badge-done"><span class="badge-dot"></span>${hd.trangThai}</span>
                                            </c:when>
                                            <c:when test="${hd.trangThai == 'Đã hủy'}">
                                                <span class="badge badge-cancel"><span class="badge-dot"></span>${hd.trangThai}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-wait"><span class="badge-dot"></span>${hd.trangThai}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td style="color:var(--text-light); font-size:13px; max-width:180px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;" title="${hd.diaChi}">
                                        ${hd.diaChi}
                                    </td>

                                    <td style="text-align:right; padding-right:24px;">
                                        <button class="btn-edit" onclick="xemChiTiet('${hd.id}')">
                                            Chi tiết
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';

    /* ── STAT COUNTS (tính từ DOM) ── */
    (function calcStats() {
        const rows = document.querySelectorAll('#orderTable tbody tr[data-trangthai]');
        let wait = 0, done = 0, tongTien = 0;
        rows.forEach(function(r) {
            var tt = r.getAttribute('data-trangthai');
            if (tt === 'Chờ xác nhận') wait++;
            if (tt === 'Hoàn thành')   done++;
            var val = parseFloat(r.getAttribute('data-tongtien')) || 0;
            tongTien += val;
        });
        document.getElementById('countWait').innerText = wait;
        document.getElementById('countDone').innerText = done;
        document.getElementById('tongDoanhThu').innerText =
            tongTien.toLocaleString('vi-VN') + ' đ';
    })();

    /* ── FILTER TABS ── */
    function filterTab(btn, trangThai) {
        document.querySelectorAll('.filter-tab').forEach(function(b) { b.classList.remove('active'); });
        btn.classList.add('active');
        document.querySelectorAll('#orderTable tbody tr').forEach(function(row) {
            if (!trangThai || row.getAttribute('data-trangthai') === trangThai) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    /* ── XEM CHI TIẾT ── */
    function xemChiTiet(id) {
        window.location.href = contextPath + '/don-hang/chi-tiet?id=' + id;
    }


    /* ── PROFILE DROPDOWN ── */
    function toggleDropdown() {
        document.getElementById('profileDropdown').classList.toggle('open');
    }
    document.addEventListener('click', function(e) {
        var wrapper = document.querySelector('.profile-wrapper');
        if (wrapper && !wrapper.contains(e.target)) {
            document.getElementById('profileDropdown').classList.remove('open');
        }
    });
</script>
</body>
</html>
