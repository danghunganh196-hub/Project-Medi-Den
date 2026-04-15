<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Hp
  Date: 4/13/2026
  Time: 12:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        /* CSS đồng bộ với hệ thống QuanLyController */
        :root {
            --pink: #F0127A;
            --pink-soft: #fce4f0;
            --text-dark: #1a0010;
            --text-light: #b5527a;
            --shadow: 0 4px 24px rgba(240,18,122,0.10);
            --radius: 16px;
        }

        .detail-container {
            max-width: 900px;
            margin: 20px auto;
            font-family: 'Be Vietnam Pro', sans-serif;
        }

        .card {
            background: white;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            border: 1.5px solid rgba(240,18,122,0.07);
            overflow: hidden;
        }

        .card-header {
            padding: 20px 24px;
            border-bottom: 1.5px solid rgba(240,18,122,0.08);
            background: #fdf0f7;
        }

        .card-header h3 {
            margin: 0;
            color: var(--pink);
            font-size: 20px;
            font-weight: 800;
        }

        .card-body {
            padding: 24px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-item label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-light);
            margin-bottom: 4px;
        }

        .info-item span {
            font-size: 15px;
            font-weight: 600;
            color: var(--text-dark);
        }

        .status-highlight {
            padding: 4px 12px;
            border-radius: 20px;
            background: var(--pink-soft);
            color: var(--pink);
            font-size: 13px;
        }

        .money-total {
            font-size: 22px;
            font-weight: 800;
            color: var(--pink);
        }

        .action-bar {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .btn-confirm {
            background: var(--pink);
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 700;
            font-size: 14px;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
        }

        .btn-confirm:hover {
            background: #c70060;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(240,18,122,0.3);
        }

        .btn-back {
            color: var(--text-light);
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            transition: color 0.2s;
        }

        .btn-back:hover {
            color: var(--pink);
        }
    </style>
</head>
<body>
<div class="detail-container">
    <div class="card">
        <div class="card-header">
            <h3>📦 Chi tiết đơn hàng #${hoaDon.id}</h3>
        </div>
        <div class="card-body">
            <div class="info-grid">
                <div class="info-item">
                    <label>Khách hàng</label>
                    <span>${hoaDon.khachHang.ten}</span>
                </div>
                <div class="info-item">
                    <label>Ngày đặt</label>
                    <span>${hoaDon.ngayDat}</span>
                </div>
                <div class="info-item">
                    <label>Trạng thái</label>
                    <span class="status-highlight">${hoaDon.trangThai}</span>
                </div>
                <div class="info-item">
                    <label>Tổng thanh toán</label>
                    <div class="money-total"><fmt:formatNumber value="${hoaDon.tongTien}" pattern="#,###"/> đ</div>
                </div>
                <div class="info-item" style="grid-column: span 2;">
                    <label>Địa chỉ nhận hàng</label>
                    <span>${hoaDon.diaChi}</span>
                </div>
            </div>

            <div class="action-bar">
                <c:if test="${hoaDon.trangThai == 'Chờ xác nhận'}">
                    <a href="${pageContext.request.contextPath}/don-hang/xac-nhan?id=${hoaDon.id}"
                       class="btn-confirm">
                        ✅ Xác nhận đơn hàng
                    </a>
                </c:if>

                <a href="${pageContext.request.contextPath}/don-hang" class="btn-back">
                    ← Quay lại danh sách
                </a>
            </div>
        </div>
    </div>
</div>
<label>Sản phẩm đã đặt</label>
<table style="width:100%; border-collapse: collapse; margin-top:10px;">
    <thead style="background: #fdf0f7; font-size: 12px;">
    <tr>
        <th style="padding:10px; text-align:left;">Sản phẩm</th>
        <th style="padding:10px; text-align:center;">Số lượng</th>
        <th style="padding:10px; text-align:right;">Đơn giá</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="ct" items="${dsChiTiet}">
        <tr style="border-bottom: 1px solid #eee; font-size: 14px;">
            <td style="padding:10px;">${ct.giay.tenGiay}</td>
            <td style="padding:10px; text-align:center;">${ct.soLuong}</td>
            <td style="padding:10px; text-align:right;">${ct.donGia} đ</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
