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

    let cart = JSON.parse(localStorage.getItem('medi_cart')) || [];

    // ================= TOAST =================
    function showToast(message) {
        const toast = document.getElementById("toast");
        toast.innerText = message;
        toast.style.display = "block";

        setTimeout(() => {
            toast.style.display = "none";
        }, 2000);
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
        document.getElementById('modalPrice').innerText =
            Number(price).toLocaleString('vi-VN') + " VNĐ";
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
                    sizeContainer.querySelectorAll('button')
                        .forEach(b => b.classList.remove('active'));

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

        const name = document.getElementById('modalName').innerText;
        const priceText = document.getElementById('modalPrice').innerText;
        const price = parseInt(priceText.replace(/\D/g, '')) || 0;
        const img = document.getElementById('modalImg').src;

        const size = window.selectedSize;
        const sizeId = window.selectedSizeId;
        const giayId = window.selectedGiayId;

        // 🔥 LẤY SỐ LƯỢNG USER CHỌN
        const qtyInput = document.getElementById('modalQty');
        const qty = parseInt(qtyInput.value) || 1;

        const idx = cart.findIndex(i =>
            i.giayId == giayId && i.sizeId == sizeId
        );

        if (idx > -1) {
            cart[idx].qty = (cart[idx].qty || 0) + qty; // cộng đúng số lượng
        } else {
            cart.push({
                giayId,
                sizeId,
                name,
                price,
                img,
                qty: qty, // dùng qty user chọn
                size
            });
        }

        localStorage.setItem('medi_cart', JSON.stringify(cart));

        renderCart();

        showToast("✅ Đã thêm vào giỏ hàng!");

        closeModal();
    };
    // ================= RENDER CART =================
    window.renderCart = function () {

        const list = document.getElementById('cart-items-list');
        if (!list) return;

        let total = 0;
        let count = 0;

        list.innerHTML = "";

        cart.forEach((item, i) => {

            let qty = item.qty || 1; // FIX

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
                    <span onclick="removeItem(${i})">&times;</span>
                </div>
            `;
        });

        document.getElementById('cart-count').innerText = count;
        document.getElementById('cart-total-amount').innerText =
            total.toLocaleString() + "đ";
    };

    window.removeItem = function (i) {
        cart.splice(i, 1);
        localStorage.setItem('medi_cart', JSON.stringify(cart));
        renderCart();
    };

    renderCart();
});