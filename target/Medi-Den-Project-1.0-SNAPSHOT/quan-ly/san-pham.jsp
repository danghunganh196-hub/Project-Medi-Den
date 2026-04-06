<main class="main">
    <div class="page-header">
        <h1>Quản lý sản phẩm</h1>
        <button class="btn-pink" onclick="moFormThem()">＋ Thêm sản phẩm</button>
    </div>

    <%-- FORM THÊM / SỬA --%>
    <div id="formCard" class="card">
        <div class="card-header">
            <span class="card-title" id="formTitle">Thêm sản phẩm mới</span>
            <span class="card-action" onclick="dongForm()">✕ Đóng</span>
        </div>
        <div class="form-inner">
            <form id="mainForm" method="post" action="${pageContext.request.contextPath}/san-pham/add">
                <input type="hidden" name="id" id="formId">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Tên sản phẩm</label>
                        <input type="text" name="ten" id="inputTen" required>
                    </div>
                    <div class="form-group">
                        <label>Danh mục</label>
                        <select name="danhMucId" id="inputDanhMuc">
                            <c:forEach var="dm" items="${listTheLoai}">
                                <option value="${dm.id}">${dm.tenTheLoai}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Giá (VNĐ)</label>
                        <input type="number" name="gia" id="inputGia">
                    </div>
                    <div class="form-group">
                        <label>Thương hiệu</label>
                        <input type="text" name="thuongHieu" id="inputThuongHieu">
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" class="btn-cancel" onclick="dongForm()">Hủy bỏ</button>
                    <button type="submit" class="btn-pink" id="btnSubmit">Xác nhận</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card">
        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Giá</th>
                    <th>Size</th>
                    <th style="text-align:right;">Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="sp" items="${listSanPham}">
                    <tr id="row-${sp.id}">
                        <td>#${sp.id}</td>
                        <td>
                            <div style="display:flex; align-items:center; gap:12px;">
                                <img src="${empty sp.hinhAnh ? 'https://via.placeholder.com/44' : sp.hinhAnh}" class="product-img">
                                <strong>${sp.tenGiay}</strong>
                            </div>
                        </td>
                        <td>${sp.theLoaiGiay.tenTheLoai}</td>
                        <td style="color:var(--pink); font-weight:700;">
                            <fmt:formatNumber value="${sp.gia}" pattern="#,###"/> đ
                        </td>
                        <td>${sp.getSizeString()}</td>
                        <td style="text-align:right; padding-right:24px;">
                            <button class="btn-edit" onclick="moFormSua('${sp.id}', '${sp.tenGiay}', '${sp.gia}', '${sp.theLoaiGiay.id}', '${sp.thuongHieu}')">Sửa</button>
                            <a href="${pageContext.request.contextPath}/san-pham/delete?id=${sp.id}" class="btn-delete" onclick="return confirm('Xóa sản phẩm này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>

<script>
    const formCard = document.getElementById('formCard');
    const mainForm = document.getElementById('mainForm');

    function moFormThem() {
        formCard.style.display = 'block';
        document.getElementById('formTitle').innerText = 'Thêm sản phẩm mới';
        mainForm.action = "${pageContext.request.contextPath}/san-pham/add";
        mainForm.reset();
        document.getElementById('formId').value = "";
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    function moFormSua(id, ten, gia, danhMucId, thuongHieu) {
        formCard.style.display = 'block';
        document.getElementById('formTitle').innerText = 'Sửa sản phẩm #' + id;
        mainForm.action = "${pageContext.request.contextPath}/san-pham/update";

        document.getElementById('formId').value = id;
        document.getElementById('inputTen').value = ten;
        document.getElementById('inputGia').value = gia;
        document.getElementById('inputDanhMuc').value = danhMucId;
        document.getElementById('inputThuongHieu').value = thuongHieu;

        window.scrollTo({ top: 0, behavior: 'smooth' });

        document.querySelectorAll('tbody tr').forEach(r => r.style.background = '');
        document.getElementById('row-' + id).style.background = '#fce4f0';
    }

    function dongForm() {
        formCard.style.display = 'none';
        document.querySelectorAll('tbody tr').forEach(r => r.style.background = '');
    }
</script>