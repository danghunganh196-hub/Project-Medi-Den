// ================= CART TOGGLE =================
window.toggleCart = function () {
    const miniCart = document.getElementById('mini-cart');
    if (miniCart) {
        miniCart.classList.toggle('active');
    } else {
        console.error("Không tìm thấy thẻ id='mini-cart' trong HTML");
    }
};

// ================= MODAL SẢN PHẨM =================
window.openProductModal = function (button) {
    const modal = document.getElementById('productModal');
    const name = button.dataset.name;
    const price = button.dataset.price;
    const img = button.dataset.img;
    const brand = button.dataset.brand;
    const sizeData = button.dataset.size;
    const sizeIdData = button.dataset.sizeid;
    const sizeStockData = button.dataset.sizestock || '';
    const giayId = button.dataset.id;

    window.selectedGiayId = giayId;
    document.getElementById('modalName').innerText = name;
    document.getElementById('modalPrice').innerText = Number(price).toLocaleString('vi-VN') + " VNĐ";
    document.getElementById('modalImg').src = img;
    document.getElementById('modalBrand').innerText = brand;
    document.getElementById('modalDesc').innerText = button.dataset.desc || '';

    const sizeContainer = document.getElementById('modalSizeContainer');
    sizeContainer.innerHTML = "";
    window.selectedSize = null;
    window.selectedSizeId = null;
    window.sizeStockMap = {};
    window.currentStock = 0;
    const stockHint = document.getElementById('stockHint');
    if (stockHint) stockHint.innerText = '';

    if (sizeData && sizeIdData) {
        const sizes = sizeData.split(',');
        const sizeIds = sizeIdData.split(',');
        if (sizeStockData) {
            const stocks = sizeStockData.split(',');
            sizeIds.forEach((id, i) => {
                window.sizeStockMap[id] = parseInt(stocks[i]) || 0;
            });
        }
        sizes.forEach((size, index) => {
            const btn = document.createElement('button');
            btn.innerText = size;
            btn.className = "size-item-btn";
            btn.onclick = function () {
                sizeContainer.querySelectorAll('button').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                window.selectedSize = size;
                window.selectedSizeId = sizeIds[index];
                window.currentStock = window.sizeStockMap[sizeIds[index]] || 0;
                const hint = document.getElementById('stockHint');
                if (hint) {
                    if (window.currentStock === 0) {
                        hint.innerText = '⚠ Size này đã hết hàng!';
                        hint.style.color = 'red';
                    } else {
                        hint.innerText = `Còn ${window.currentStock} đôi`;
                        hint.style.color = 'green';
                    }
                }
                document.getElementById('modalQty').value = 1;
                document.getElementById('qtyError').innerText = '';
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
    const errorEl = document.getElementById('qtyError');
    let val = parseInt(input.value) || 1;
    val += delta;
    if (val < 1) val = 1;
    const max = window.currentStock || 999;
    if (val > max) {
        val = max;
        if (errorEl) errorEl.innerText = `⚠ Chỉ còn ${max} đôi trong kho!`;
    } else {
        if (errorEl) errorEl.innerText = '';
    }
    input.value = val;
};

window.validateQtyInput = function (input) {
    const errorEl = document.getElementById('qtyError');
    input.value = input.value.replace(/[^0-9]/g, '');
    let val = parseInt(input.value);
    if (isNaN(val) || val < 1) {
        if (errorEl) errorEl.innerText = '⚠ Số lượng phải ít nhất là 1!';
        return;
    }
    const max = window.currentStock || 999;
    if (val > max) {
        input.value = max;
        if (errorEl) errorEl.innerText = `⚠ Chỉ còn ${max} đôi trong kho!`;
    } else {
        if (errorEl) errorEl.innerText = '';
    }
};

document.addEventListener("DOMContentLoaded", function () {

    // ================= CONSTANTS =================
    const API = 'https://provinces.open-api.vn/api';
    const HA_NOI_CODE = 1;

    window.buyNowItem = null;

    // ================= KHÔI PHỤC CHECKOUT SAU LOGIN =================
    const urlParams = new URLSearchParams(window.location.search);
    const pending = sessionStorage.getItem('pendingCheckout');

    if (urlParams.get('openCheckout') === 'true' && pending && window.isLoggedIn) {
        sessionStorage.removeItem('pendingCheckout');
        const pendingData = JSON.parse(pending);
        if (pendingData.buyNowItem) {
            window.buyNowItem = pendingData.buyNowItem;
        }
        // Mở checkout ở step 1 (nhập địa chỉ)
        const checkoutModal = document.getElementById('checkout-modal');
        if (checkoutModal) {
            checkoutModal.style.display = 'block';
            document.querySelectorAll('.checkout-step').forEach(s => s.classList.remove('active'));
            document.getElementById('step-1').classList.add('active');
            initTinhSelect();
        }
    }

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
                    resultBox.innerHTML = "";
                    if (data.length === 0) {
                        resultBox.innerHTML = "<p style='padding:15px; color:#888; text-align:center;'>Không tìm thấy sản phẩm</p>";
                    } else {
                        const html = data.map(sp => `
    <div class="search-item"
         onclick="openProductModal(this)"
         data-id="${sp.id}"
         data-name="${sp.name}"
         data-price="${sp.price}"
         data-img="${sp.image}"
         data-brand="${sp.brand}"
         data-size="${sp.sizeString}"
         data-sizeid="${sp.sizeIdString}"
         data-sizestock="${sp.sizeStockString || ''}"
         data-desc="${sp.desc || ''}"
    >
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

        const qty = parseInt(document.getElementById('modalQty').value) || 0;
        if (qty < 1) {
            showToast("❌ Số lượng phải ít nhất là 1!");
            return;
        }
        if (window.currentStock > 0 && qty > window.currentStock) {
            showToast(`❌ Chỉ còn ${window.currentStock} đôi trong kho!`);
            return;
        }

        const idx = cart.findIndex(item => item.giayId == giayId && item.sizeId == sizeId);
        if (idx > -1) {
            cart[idx].qty += qty;
        } else {
            cart.push({giayId, sizeId, size, name, price, img, qty});
        }
        localStorage.setItem('medi_cart', JSON.stringify(cart));

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

            data.forEach((item) => {
                let qty = item.qty || 1;
                total += item.price * qty;
                count += qty;

                list.innerHTML += `
                    <div class="cart-item">
                        <img src="${item.img}" alt="${item.name}">
                        <div class="item-info">
                            <h4>${item.name}</h4>
                            <p>Size: ${item.size}</p>
                            <p>
                                <span class="item-qty">${qty}</span>
                                <span class="item-price">${item.price.toLocaleString()}đ</span>
                            </p>
                        </div>
                        <span class="remove-item" onclick="removeItem(${item.giayId}, ${item.sizeId})">&times;</span>
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

    function initTinhSelect() {
        const sel = document.getElementById('sel-tinh');
        if (!sel) return;
        sel.innerHTML = '<option value="1">Thành phố Hà Nội</option>';
        sel.disabled = true;
        loadQuanHaNoi();
    }

    function loadQuanHaNoi() {
        const selQuan = document.getElementById('sel-quan');
        const selPhuong = document.getElementById('sel-phuong');

        selQuan.innerHTML = '<option value="">Chọn quận / huyện</option>';
        selPhuong.innerHTML = '<option value="">Chọn phường / xã</option>';
        selQuan.disabled = true;
        selPhuong.disabled = true;

        fetch(`${API}/p/${HA_NOI_CODE}?depth=2`)
            .then(r => r.json())
            .then(data => {
                (data.districts || []).forEach(d => {
                    const opt = document.createElement('option');
                    opt.value = d.code;
                    opt.text = d.name;
                    selQuan.appendChild(opt);
                });
                selQuan.disabled = false;
            })
            .catch(() => console.warn("Không load được quận/huyện Hà Nội"));
    }

    window.loadQuan = loadQuanHaNoi;

    window.loadPhuong = function () {
        const quanCode = document.getElementById('sel-quan').value;
        const selPhuong = document.getElementById('sel-phuong');

        selPhuong.innerHTML = '<option value="">Chọn phường / xã</option>';
        selPhuong.disabled = true;

        if (!quanCode) return;

        fetch(`${API}/d/${quanCode}?depth=2`)
            .then(r => r.json())
            .then(data => {
                (data.wards || []).forEach(w => {
                    const opt = document.createElement('option');
                    opt.value = w.code;
                    opt.text = w.name;
                    selPhuong.appendChild(opt);
                });
                selPhuong.disabled = false;
            })
            .catch(() => console.warn("Không load được phường/xã"));
    };

    // ================= MUA NGAY =================
    window.buyNowFromModal = function () {
        if (!window.selectedSizeId) {
            showToast("❌ Vui lòng chọn size!");
            return;
        }
        const qty = parseInt(document.getElementById('modalQty').value) || 0;
        if (qty < 1) {
            showToast("❌ Số lượng phải ít nhất là 1!");
            return;
        }
        if (window.currentStock > 0 && qty > window.currentStock) {
            showToast(`❌ Chỉ còn ${window.currentStock} đôi trong kho!`);
            return;
        }
        window.buyNowItem = {
            giayId: Number(window.selectedGiayId),
            sizeId: Number(window.selectedSizeId),
            qty: Number(document.getElementById('modalQty').value),
            price: parseInt(document.getElementById('modalPrice').innerText.replace(/\D/g, ''))
        };

        closeModal();
        document.getElementById('checkout-modal').style.display = 'block';
        document.getElementById('step-1').classList.add('active');
        initTinhSelect();
    };

    // ================= VALIDATE BƯỚC 1 =================
    window.validateStep1 = function () {
        let valid = true;

        ['tinh-error', 'quan-error', 'phuong-error', 'address-error'].forEach(id => {
            const el = document.getElementById(id);
            if (el) el.innerText = '';
        });

        ['sel-tinh', 'sel-quan', 'sel-phuong', 'address'].forEach(id => {
            const el = document.getElementById(id);
            if (el) el.classList.remove('error');
        });

        const quan = document.getElementById('sel-quan');
        if (!quan.value) {
            document.getElementById('quan-error').innerText = '⚠ Vui lòng chọn quận / huyện';
            quan.classList.add('error');
            valid = false;
        }

        const phuong = document.getElementById('sel-phuong');
        if (!phuong.value) {
            document.getElementById('phuong-error').innerText = '⚠ Vui lòng chọn phường / xã';
            phuong.classList.add('error');
            valid = false;
        }

        const address = document.getElementById('address');
        if (!address.value.trim()) {
            document.getElementById('address-error').innerText = '⚠ Vui lòng nhập số nhà, tên đường';
            address.classList.add('error');
            valid = false;
        }

        if (valid) {
            const quanText   = quan.options[quan.selectedIndex].text;
            const phuongText = phuong.options[phuong.selectedIndex].text;
            window.fullAddress = `${address.value.trim()}, ${phuongText}, ${quanText}, Thành phố Hà Nội`;

            document.getElementById('step-1').classList.remove('active');
            document.getElementById('step-2').classList.add('active');
        }
    };

    // ================= MỞ CHECKOUT TỪ GIỎ HÀNG =================
    window.openCheckout = function () {
        if (!window.isLoggedIn) {
            alert("Bạn cần đăng nhập!");
            window.location.href = "/login";
            return;
        }

        const cart = JSON.parse(localStorage.getItem('medi_cart')) || [];
        if (cart.length === 0) {
            alert("Giỏ hàng trống!");
            return;
        }

        document.getElementById('mini-cart').classList.remove('active');
        document.querySelectorAll('.checkout-step').forEach(s => s.classList.remove('active'));
        document.getElementById('step-1').classList.add('active');
        document.getElementById('checkout-modal').style.display = 'block';
        initTinhSelect();
    };

    // ================= HOÀN TẤT ĐƠN HÀNG =================
    window.completeOrder = async function () {
        const payment = document.querySelector('input[name="payment"]:checked');
        const paymentValue = payment?.value;

        if (!paymentValue) {
            alert("Vui lòng chọn phương thức thanh toán!");
            return;
        }

        const cart = window.buyNowItem
            ? [window.buyNowItem]
            : (JSON.parse(localStorage.getItem('medi_cart')) || []);

        if (cart.length === 0) {
            alert("Không có sản phẩm!");
            return;
        }

        const payload = {
            diaChi: window.fullAddress || "",
            payment: paymentValue,
            items: cart.map(item => ({
                giayId: Number(item.giayId),
                sizeId: Number(item.sizeId),
                qty: Number(item.qty),
                price: Number(item.price)
            }))
        };

        try {
            const res = await fetch(window.contextPath + "/checkout", {
                method: "POST",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify(payload)
            });

            const data = await res.json();

            if (data.status === "success") {
                if (!window.buyNowItem) {
                    localStorage.removeItem('medi_cart');
                    await fetch(window.contextPath + "/ClearCartServlet", {
                        method: "POST"
                    });
                }
                window.buyNowItem = null;
                document.getElementById('cart-items-list').innerHTML = "";
                document.getElementById('cart-count').innerText = 0;
                document.getElementById('cart-total-amount').innerText = "0đ";

                window.location.href = window.contextPath + '/tinh-trang?id=' + data.orderId;

            } else if (data.status === "NOT_LOGGED_IN") {
                // Lưu buyNowItem vào sessionStorage trước khi redirect
                sessionStorage.setItem('pendingCheckout', JSON.stringify({
                    buyNowItem: window.buyNowItem || null
                }));
                alert("Bạn cần đăng nhập!");
                window.location.href = window.contextPath + "/login?checkout=true";
            } else {
                alert("Lỗi: " + data.message);
            }

        } catch (err) {
            console.error(err);
            alert("Lỗi server!");
        }
    };

    // ================= ĐÓNG CHECKOUT =================
    window.closeCheckout = function () {
        document.getElementById('checkout-modal').style.display = 'none';
    };

    // ================= TOGGLE BANK INFO =================
    window.toggleBankInfo = function (show) {
        document.getElementById('bank-info').style.display = show ? 'block' : 'none';
    };

}); // end DOMContentLoaded