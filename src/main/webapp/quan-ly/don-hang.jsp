<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Đơn hàng - Medi Den</title>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --pink: #F0127A; --pink-dark: #c70060; --pink-soft: #fce4f0;
            --pink-glow: rgba(240, 18, 122, 0.18); --text-dark: #1a0010;
            --text-mid: #6b0038; --text-light: #b5527a; --shadow: 0 4px 24px rgba(240,18,122,0.10);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Be Vietnam Pro', sans-serif; }
        body { background: #ffffff; color: var(--text-dark); }

        /* TOPBAR */
        .topbar { background: var(--pink); height: 64px; display: flex; align-items: center; justify-content: space-between; padding: 0 32px; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 16px rgba(240,18,122,0.25); }
        .logo-icon { width: 40px; height: 40px; background: white; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-weight: 800; color: var(--pink); }

        /* LAYOUT & SIDEBAR */
        .layout { display: flex; min-height: calc(100vh - 64px); }
        .sidebar { width: 260px; background: #fff; padding: 28px 0; border-right: 1.5px solid rgba(240,18,122,0.12); position: sticky; top: 64px; height: calc(100vh - 64px); }
        .sidebar-section { padding: 0 16px; margin-bottom: 8px; }
        .sidebar-section-label { font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 1.2px; color: var(--text-light); padding: 0 12px; margin-bottom: 6px; }

        .nav-item { display: flex; align-items: center; gap: 12px; padding: 11px 14px; border-radius: 12px; cursor: pointer; color: var(--text-mid); font-size: 14.5px; font-weight: 500; transition: all 0.2s; margin-bottom: 4px; }
        .nav-icon { width: 36px; height: 36px; background: rgba(240,18,122,0.08); border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 17px; transition: 0.2s; }
        .nav-item:hover { background: #fdf0f7; color: var(--pink); transform: translateX(3px); box-shadow: 0 2px 12px var(--pink-glow); }
        .nav-item.active { background: var(--pink); color: white; box-shadow: 0 4px 16px var(--pink-glow); }
        .nav-item.active .nav-icon { background: rgba(255,255,255,0.22); }
        .nav-badge { margin-left: auto; background: var(--pink); color: white; font-size: 11px; font-weight: 700; padding: 2px 8px; border-radius: 10px; }
        .nav-item.active .nav-badge { background: rgba(255,255,255,0.3); }

        /* MAIN & CARDS */
        .main { flex: 1; padding: 32px 36px; background: #ffffff; }
        .card { background: white; border-radius: 16px; box-shadow: var(--shadow); border: 1.5px solid rgba(240,18,122,0.07); overflow: hidden; margin-bottom: 24px; }
        /* ... Giữ các style table cũ của ông ... */
    </style>
</head>
<body>

<header class="topbar">
    <div style="display:flex; align-items:center; gap:12px;">
        <div style="background:white; color:var(--pink); padding:5px 10px; border-radius:8px; font-weight:800;">M</div>
        <span style="font-weight:700; font-size:20px;">Medi Den</span>
    </div>
    <span style="font-weight:600;">Quản lý Hóa đơn</span>
    <div style="width:36px; height:36px; background:white; border-radius:50%; color:var(--pink); display:flex; align-items:center; justify-content:center; font-weight:700;">A</div>
</header>

<div class="layout">
    <nav class="sidebar">
        <div class="sidebar-section">
            <div class="sidebar-section-label">Chính</div>
            <div class="nav-item" onclick="location.href='trang-chu-admin.jsp'">
                <div class="nav-icon">🏠</div> Trang chủ
            </div>
        </div>
        <div class="sidebar-section">
            <div class="sidebar-section-label">Quản lý</div>
            <div class="nav-item" onclick="location.href='danh-muc'">
                <div class="nav-icon">📂</div> Quản lý danh mục
            </div>
            <div class="nav-item" onclick="location.href='san-pham'">
                <div class="nav-icon">👟</div> Quản lý sản phẩm
            </div>
            <div class="nav-item active">
                <div class="nav-icon">🛒</div> Quản lý đơn hàng
                <span class="nav-badge">7</span>
            </div>
            <div class="nav-item" onclick="location.href='khach-hang'">
                <div class="nav-icon">👥</div> Quản lý khách hàng
            </div>
        </div>
    </nav>

    <main class="main">
    </main>
</div>

<script>
    function showDetail(id, khTen, ngay, tong, diaChi, trangThai, ghiChu) {
        document.querySelectorAll('tr').forEach(r => r.classList.remove('active'));
        document.getElementById('row-' + id).classList.add('active');
        document.getElementById('detailBox').style.display = 'block';

        document.getElementById('dt-id').innerText = '#' + id;
        document.getElementById('dt-khachHang').innerText = khTen;
        document.getElementById('dt-ngayDat').innerText = ngay;
        document.getElementById('dt-diaChi').innerText = diaChi;
        document.getElementById('dt-ghiChu').innerText = ghiChu || '---';
        document.getElementById('dt-tongTien').innerText = Number(tong).toLocaleString();

        // AJAX Fetch logic here...
        fetch('${pageContext.request.contextPath}/hoa-don-chi-tiet?action=get&hdId=' + id)
            .then(res => res.json())
            .then(data => {
                let html = '';
                data.forEach(item => {
                    html += `<tr>
                        <td><strong>${item.tenGiay}</strong></td>
                        <td>${item.soLuong}</td>
                        <td>${item.donGia.toLocaleString()} đ</td>
                        <td style="font-weight:700; color:var(--pink)">${item.thanhTien.toLocaleString()} đ</td>
                    </tr>`;
                });
                document.getElementById('chiTietBody').innerHTML = html;
            });

        window.scrollTo({ top: document.getElementById('detailBox').offsetTop - 20, behavior: 'smooth' });
    }
</script>
</body>
</html>