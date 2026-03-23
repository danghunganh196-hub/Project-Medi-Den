<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Medi Den Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #ff2d55;
            --accent-color: #00ffcc;
            --bg-dark: #0f0f0f;
            --card-bg: #1a1a1a;
            --text-light: #ffffff;
            --text-gray: #aaaaaa;
        }

        body {
            font-family: 'Arial';
            background-color: var(--bg-dark);
            color: var(--text-light);
            margin: 0;
            padding: 0;
        }

        /* HEADER & NAVBAR (Giữ style trang chủ) */
        header {
            background: #000;
            border-bottom: 2px solid var(--primary-color);
        }

        .top-bar {
            text-align: right;
            padding: 8px 5%;
            font-size: 12px;
            background: #111;
            color: var(--text-gray);
            letter-spacing: 1px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo h1 {
            font-size: 24px;
            color: var(--text-light);
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 20px;
        }

        .nav-links a {
            color: var(--text-light);
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            transition: 0.3s;
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        /* ADMIN MAIN CONTENT */
        .admin-wrapper {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            border-left: 5px solid var(--primary-color);
            padding-left: 15px;
        }

        .page-header h2 {
            margin: 0;
            font-size: 28px;
            letter-spacing: 1px;
        }

        /* FORM THÊM MỚI (Style Pink-Input) */
        .card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            margin-bottom: 30px;
        }

        .form-add {
            display: flex;
            gap: 15px;
        }

        .pink-input {
            flex: 1;
            background: #222;
            border: 1px solid #333;
            padding: 12px 20px;
            border-radius: 8px;
            color: white;
            outline: none;
            transition: 0.3s;
        }

        .pink-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 10px rgba(255, 45, 85, 0.3);
        }

        .btn-pink {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-pink:hover {
            background: #e0244b;
            transform: translateY(-2px);
        }

        /* TABLE STYLE */
        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        th {
            text-align: left;
            padding: 15px;
            color: var(--text-gray);
            font-weight: normal;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 1px;
        }

        td {
            background: #222;
            padding: 15px;
            vertical-align: middle;
        }

        td:first-child { border-radius: 10px 0 0 10px; text-align: center; width: 80px; }
        td:last-child { border-radius: 0 10px 10px 0; text-align: right; }

        tr:hover td {
            background: #2a2a2a;
        }

        .category-name {
            font-weight: 600;
            font-size: 16px;
        }

        /* ACTIONS BUTTONS */
        .action-btn {
            width: 35px;
            height: 35px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            margin-left: 8px;
            transition: 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-edit { background: rgba(0, 255, 204, 0.1); color: var(--accent-color); }
        .btn-edit:hover { background: var(--accent-color); color: black; }

        .btn-delete { background: rgba(255, 45, 85, 0.1); color: var(--primary-color); }
        .btn-delete:hover { background: var(--primary-color); color: white; }

        /* FOOTER */
        footer {
            margin-top: 100px;
            padding: 40px;
            background: #000;
            text-align: center;
            border-top: 1px solid #222;
        }

        .footer-logo h2 { color: var(--primary-color); margin-bottom: 10px; }
        .copy { color: var(--text-gray); font-size: 13px; }

    </style>
</head>
<body>

<header>
    <div class="top-bar">HỆ THỐNG QUẢN TRỊ ADMIN</div>
    <nav class="navbar">
        <div class="logo">
            <img src="https://via.placeholder.com/50" style="border-radius: 10px;" width="40" alt="Logo">
            <h1>Medi Den</h1>
        </div>
        <ul class="nav-links">
            <li><a href="#"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="#" style="color: var(--primary-color);"><i class="fas fa-list"></i>Danh mục</a></li>
            <li><a href="#"><i class="fas fa-shoe-prints"></i> Sản phẩm</a></li>
            <li><a href="#"><i class="fas fa-shopping-cart"></i> Đơn hàng</a></li>
        </ul>
    </nav>
</header>

<main class="admin-wrapper">
    <div class="page-header">
        <h2>QUẢN LÝ DANH MỤC</h2>
        <span style="color: var(--text-gray)">Home / Category</span>
    </div>

    <div class="card">
        <form action="/the-loai/add" method="post" class="form-add">
            <input type="text" name="ten_the_loai" class="pink-input" placeholder="Tên danh mục mới (vd: Giày Chạy Bộ)..." required>
            <button class="btn-pink">
                <i class="fas fa-plus"></i> THÊM DANH MỤC
            </button>
        </form>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>TÊN DANH MỤC</th>
                <th>NGÀY TẠO</th>
                <th>THAO TÁC</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>#01</td>
                <td><span class="category-name">NIKE CLASSIC</span></td>
                <td style="color: #666;">23/03/2026</td>
                <td>
                    <button class="action-btn btn-edit" title="Sửa"><i class="fas fa-pen"></i></button>
                    <button class="action-btn btn-delete" title="Xóa"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            <tr>
                <td>#02</td>
                <td><span class="category-name">ADIDAS ULTRABOOST</span></td>
                <td style="color: #666;">22/03/2026</td>
                <td>
                    <button class="action-btn btn-edit" title="Sửa"><i class="fas fa-pen"></i></button>
                    <button class="action-btn btn-delete" title="Xóa"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            <tr>
                <td>#03</td>
                <td><span class="category-name">JORDAN SPECIAL</span></td>
                <td style="color: #666;">21/03/2026</td>
                <td>
                    <button class="action-btn btn-edit" title="Sửa"><i class="fas fa-pen"></i></button>
                    <button class="action-btn btn-delete" title="Xóa"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</main>

<footer>
    <div class="footer-logo"><h2>Medi Den</h2></div>
    <p class="copy">© 2026 Medi Den Admin Dashboard. Designed for sneakers management.</p>
</footer>

</body>
</html>