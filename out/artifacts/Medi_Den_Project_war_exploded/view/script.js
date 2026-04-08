// ================= CART TOGGLE (ĐÃ FIX LỖI) =================
window.toggleCart = function () {
    // Khai báo biến bên trong hàm để đảm bảo luôn lấy được thẻ mới nhất
    const miniCart = document.getElementById('mini-cart');
    if (miniCart) {
        miniCart.classList.toggle('active');
    } else {
        console.error("Không tìm thấy thẻ id='mini-cart' trong HTML");
    }
};

document.addEventListener("DOMContentLoaded", function () {
    const input = document.getElementById("searchInput");
    const resultBox = document.getElementById("searchResult");

    if (input) {
        input.addEventListener("keyup", function () {
            let keyword = this.value.trim();

            if (keyword.length === 0) {
                resultBox.style.display = "none";
                return;
            }

            fetch(window.contextPath + "/search?keyword=" + keyword)
                .then(res => {
                    if (!res.ok) throw new Error("Server lỗi: " + res.status);
                    return res.json();
                })
                .then(data => {
                    resultBox.innerHTML = ""; // Xóa sạch kết quả cũ trước khi hiện mới

                    if (data.length === 0) {
                        resultBox.innerHTML = "<p style='padding:15px; color:#888; text-align:center;'>Không tìm thấy sản phẩm</p>";
                    } else {
                        // Sử dụng map và join để tối ưu hiệu suất và tránh lỗi hiển thị
                        const html = data.map(sp => `
                            <div class="search-item" onclick="window.location.href='${window.contextPath}/giay/chi-tiet?id=${sp.id}'">
                                <img src="${sp.image}" alt="${sp.name}">
                                <div class="search-item-info">
                                    <div class="search-item-name">${sp.name}</div>
                                    <div class="search-item-price">${Number(sp.price).toLocaleString('vi-VN')}đ</div>
                                </div>
                            </div>
                        `).join('');
                        resultBox.innerHTML = html;
                    }
                    resultBox.style.display = "block";
                })
                .catch(err => {
                    console.error("Lỗi search:", err);
                    resultBox.style.display = "none";
                });
        });
    }

    let cart = JSON.parse(localStorage.getItem('medi_cart')) || [];

    // ================= TOAST =================
    function showToast(message) {
        const toast = document.getElementById("toast");
        toast.innerText = message;
        toast.style.display = "block";
        setTimeout(() => toast.style.display = "none", 2000);
    }

    // ================= MODAL =================
    window.openProductModal = function (button) {
        const modal = document.getElementById('productModal');
        const name = button.dataset.name;
        const price = button.dataset.price;
        const img = button.dataset.img;
        const brand = button.dataset.brand;
        const sizeData = button.dataset.size;
        const sizeIdData = button.dataset.sizeid;
        const giayId = button.dataset.id;

        window.selectedGiayId = giayId;
        document.getElementById('modalName').innerText = name;
        document.getElementById('modalPrice').innerText = Number(price).toLocaleString('vi-VN') + " VNĐ";
        document.getElementById('modalImg').src = img;
        document.getElementById('modalBrand').innerText = brand;

        const sizeContainer = document.getElementById('modalSizeContainer');
        sizeContainer.innerHTML = "";
        window.selectedSize = null;
        window.selectedSizeId = null;

        if (sizeData && sizeIdData) {
            const sizes = sizeData.split(',');
            const sizeIds = sizeIdData.split(',');
            sizes.forEach((size, index) => {
                const btn = document.createElement('button');
                btn.innerText = size;
                btn.className = "size-item-btn";
                btn.onclick = function () {
                    sizeContainer.querySelectorAll('button').forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    window.selectedSize = size;
                    window.selectedSizeId = sizeIds[index];
                };
                sizeContainer.appendChild(btn);
            });
        }

        document.getElementById('modalQty').value = 1;
        modal.style.display = "block";
    };

    window.closeModal = function () {
        document.getElementById('productModal').style.display = "none";
    };
    window.changeQty = function (delta) {
        const input = document.getElementById('modalQty');
        let val = parseInt(input.value) || 1;
        val += delta;
        if (val < 1) val = 1;
        input.value = val;
    };

    // ================= ADD TO CART =================
    window.addToCart = function () {
        if (!window.selectedSizeId) {
            showToast("❌ Vui lòng chọn size!");
            return;
        }

        const giayId = window.selectedGiayId;
        const sizeId = window.selectedSizeId;
        const size = window.selectedSize;
        const name = document.getElementById('modalName').innerText;
        const priceText = document.getElementById('modalPrice').innerText;
        const price = parseInt(priceText.replace(/\D/g, '')) || 0;
        const img = document.getElementById('modalImg').src;
        const qty = parseInt(document.getElementById('modalQty').value) || 1;

        // Update localStorage
        const idx = cart.findIndex(item => item.giayId == giayId && item.sizeId == sizeId);
        if (idx > -1) {
            cart[idx].qty += qty;
        } else {
            cart.push({giayId, sizeId, size, name, price, img, qty});
        }
        localStorage.setItem('medi_cart', JSON.stringify(cart));

        // Send to server
        const payload = {giayId, sizeId, qty, price};
        fetch(window.contextPath + '/AddToCartServlet', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(payload)
        })
            .then(res => res.json())
            .then(data => {
                if (data.status === "success") {
                    showToast("✅ Đã thêm vào giỏ hàng!");
                    renderCart();
                    closeModal();
                } else if (data.status === "NOT_LOGGED_IN") {
                    showToast("⚠ Bạn cần đăng nhập trước!");
                    window.location.href = window.contextPath + "/view/dang-nhap.jsp";
                } else {
                    showToast("❌ Lỗi: " + data.message);
                }
            })
            .catch(err => {
                console.error(err);
                showToast("❌ Có lỗi xảy ra khi thêm giỏ hàng!");
            });
    };

    // ================= RENDER CART =================
    window.renderCart = async function () {
        const list = document.getElementById('cart-items-list');
        if (!list) return;

        try {
            const res = await fetch(window.contextPath + '/GetCartServlet');
            const data = await res.json();

            if (data.status === "NOT_LOGGED_IN") {
                list.innerHTML = `<p>⚠ Bạn cần đăng nhập để xem giỏ hàng</p>`;
                document.getElementById('cart-count').innerText = 0;
                document.getElementById('cart-total-amount').innerText = "0đ";
                return;
            }

            let total = 0, count = 0;
            list.innerHTML = "";

            data.forEach((item, i) => {
                let qty = item.qty || 1;
                total += item.price * qty;
                count += qty;

                list.innerHTML += `
                <div class="cart-item">
                    <img src="${item.img}" width="50">
                    <div>
                        <h4>${item.name}</h4>
                        <p>Size: ${item.size}</p>
                        <p>${qty} x ${item.price.toLocaleString()}đ</p>
                    </div>
                    <span onclick="removeItem(${item.giayId}, ${item.sizeId})">&times;</span>
                </div>
            `;
            });

            document.getElementById('cart-count').innerText = count;
            document.getElementById('cart-total-amount').innerText = total.toLocaleString() + "đ";

        } catch (err) {
            console.error(err);
            list.innerHTML = "<p>❌ Lỗi khi tải giỏ hàng</p>";
        }
    };

// ================= REMOVE ITEM =================
    window.removeItem = async function (giayId, sizeId) {
        console.log("CLICK XÓA:", giayId, sizeId);
        if (!window.isLoggedIn) {
            showToast("⚠ Bạn cần đăng nhập để xóa sản phẩm!");
            return;
        }

        try {
            const payload = {giayId, sizeId};
            const res = await fetch(window.contextPath + '/RemoveFromCartServlet', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(payload)
            });

            const text = await res.text();
            let data;
            try {
                data = JSON.parse(text);
            } catch (e) {
                console.error("Server trả về HTML thay vì JSON:", text);
                showToast("❌ Lỗi server, không thể xóa giỏ hàng!");
                return;
            }

            if (data.status === "success") {
                showToast("✅ Đã xóa sản phẩm khỏi giỏ hàng!");

                let cart = JSON.parse(localStorage.getItem('medi_cart')) || [];
                cart = cart.filter(item => !(item.giayId == giayId && item.sizeId == sizeId));
                localStorage.setItem('medi_cart', JSON.stringify(cart));

                renderCart();
            } else if (data.status === "NOT_LOGGED_IN") {
                showToast("⚠ Bạn cần đăng nhập!");
                window.location.href = window.contextPath + "/view/dang-nhap.jsp";
            } else {
                showToast("❌ Lỗi: " + (data.message || "Không xác định"));
            }

        } catch (err) {
            console.error("Xóa giỏ hàng lỗi:", err);
            showToast("❌ Có lỗi xảy ra khi xóa sản phẩm!");
        }
    };
    renderCart();
});