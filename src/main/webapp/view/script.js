document.addEventListener("DOMContentLoaded", function () {
    // 1. KHỞI TẠO SWIPER
    new Swiper('.swiper', {
        loop: true, effect: 'fade',
        autoplay: { delay: 3000 },
        pagination: { el: '.swiper-pagination', clickable: true },
        navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev' },
    });

    // 2. GIỎ HÀNG
    let cart = JSON.parse(localStorage.getItem('medi_cart')) || [];

    const cartIcon = document.getElementById('cart-icon');
    const miniCart = document.getElementById('mini-cart');
    window.toggleCart = () => miniCart.classList.toggle('active');

    if (cartIcon) {
        cartIcon.onclick = (e) => { e.stopPropagation(); toggleCart(); };
    }

    // 3. MODAL CHI TIẾT SẢN PHẨM
    window.openProductModal = function (button) {
        const name = button.getAttribute('data-name');
        const price = button.getAttribute('data-price');
        const img = button.getAttribute('data-img');
        const brand = button.getAttribute('data-brand');
        const desc = button.getAttribute('data-desc');

        document.getElementById('modalName').innerText = name;
        document.getElementById('modalPrice').innerText = Number(price).toLocaleString('vi-VN') + " VNĐ";
        document.getElementById('modalImg').src = img;
        document.getElementById('modalBrand').innerText = brand;
        document.getElementById('modalDesc').innerText = desc || "Sản phẩm chính hãng chất lượng cao.";

        document.getElementById('productModal').style.display = "block";
        document.body.style.overflow = "hidden";
    };

    window.closeModal = () => {
        document.getElementById('productModal').style.display = "none";
        document.body.style.overflow = "auto";
    };

    window.buyNowFromModal = function() {
        addToCart();
        closeModal();
        document.querySelector('.btn-checkout').click();
    };

    // 4. THÊM VÀO GIỎ HÀNG
    window.addToCart = function () {
        const name = document.getElementById('modalName').innerText;
        const price = parseInt(document.getElementById('modalPrice').innerText.replace(/\D/g, ''));
        const img = document.getElementById('modalImg').src;
        const qtyInput = document.querySelector('.qty-input input');
        const qty = qtyInput ? parseInt(qtyInput.value) : 1;

        const itemIdx = cart.findIndex(item => item.name === name);
        if (itemIdx > -1) cart[itemIdx].qty += qty;
        else cart.push({ name, price, img, qty });

        renderCart();
        alert("Đã thêm vào giỏ!");
    };

    window.renderCart = function () {
        const list = document.getElementById('cart-items-list');
        if(!list) return;
        let total = 0, count = 0;
        list.innerHTML = "";
        cart.forEach((item, i) => {
            total += item.price * item.qty;
            count += item.qty;
            list.innerHTML += `<div class="cart-item">
                <img src="${item.img}">
                <div><h4>${item.name}</h4><p>${item.qty} x ${item.price.toLocaleString()}đ</p></div>
                <span onclick="removeItem(${i})">&times;</span>
            </div>`;
        });
        const cartCount = document.getElementById('cart-count');
        const cartTotal = document.getElementById('cart-total-amount');
        if(cartCount) cartCount.innerText = count;
        if(cartTotal) cartTotal.innerText = total.toLocaleString() + "đ";
        localStorage.setItem('medi_cart', JSON.stringify(cart));
    };

    window.removeItem = (i) => { cart.splice(i, 1); renderCart(); };

    // 5. THANH TOÁN
    const checkoutModal = document.getElementById('checkout-modal');
    const btnCheckOut = document.querySelector('.btn-checkout');
    if(btnCheckOut) {
        btnCheckOut.onclick = () => {
            if(cart.length === 0) return alert("Giỏ hàng trống!");
            checkoutModal.style.display = 'block';
            miniCart.classList.remove('active');
        };
    }

    window.closeCheckout = () => checkoutModal.style.display = 'none';

    window.validateStep1 = () => {
        const name = document.getElementById('fullname').value;
        const phone = document.getElementById('phone').value;
        const address = document.getElementById('address').value;
        if (!name || !phone || !address) return alert("Vui lòng nhập đầy đủ thông tin!");
        document.getElementById('step-1').classList.remove('active');
        document.getElementById('step-2').classList.add('active');
    };

    window.completeOrder = function () {
        console.log("===> [1] Đã nhảy vào hàm completeOrder");
        try {
            const name = document.getElementById('fullname').value;
            const email = document.getElementById('email').value || "khongco@email.com"; // Bắt thêm Email để Java không bị Null
            const phone = document.getElementById('phone').value;
            const address = document.getElementById('address').value;
            const paymentElem = document.querySelector('input[name="payment"]:checked');
            const paymentMethod = paymentElem ? paymentElem.value : "COD";

            let totalMoney = 0;
            cart.forEach(item => totalMoney += (item.price * item.qty));

            const orderData = {
                tenKhachHang: name,
                email: email, // Đã bổ sung Email vào kiện hàng
                soDienThoai: phone,
                diaChi: address,
                phuongThucTT: paymentMethod,
                tongTien: totalMoney,
                chiTiet: cart.map(item => ({
                    tenSanPham: item.name,
                    soLuong: item.qty,
                    donGia: item.price
                }))
            };

            console.log("===> [2] Đã đóng gói orderData:", orderData);

            // SỬA LỖI 404: Gọi đúng contextPath lấy từ JSP
            const url = (window.contextPath || "") + '/checkout';
            console.log("===> [3] Chuẩn bị POST tới URL:", url);

            fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(orderData)
            })
                .then(res => {
                    if(!res.ok) throw new Error("Lỗi HTTP: " + res.status);
                    return res.json();
                })
                .then(data => {
                    console.log("===> [4] Phản hồi từ Java:", data);
                    if (data.status === 'success') {
                        alert("🎉 Đặt hàng thành công!");
                        localStorage.removeItem('medi_cart');
                        location.reload();
                    } else {
                        alert("❌ Lỗi từ Server: " + data.message);
                    }
                })
                .catch(err => {
                    console.error("Lỗi Fetch:", err);
                    alert("Lỗi kết nối đến máy chủ. Xem Console F12 để biết chi tiết.");
                });

        } catch (err) {
            console.error("===> LỖI JS:", err);
        }
    };

    renderCart();
    const paymentRadios = document.querySelectorAll('input[name="payment"]');
    const bankInfo = document.getElementById('bank-info');

    paymentRadios.forEach(radio => {
        radio.addEventListener('change', function () {
            if (this.value === 'Bank') {
                bankInfo.style.display = 'block';
            } else {
                bankInfo.style.display = 'none';
            }
        });
    });
});