document.addEventListener("DOMContentLoaded", function () {
    // 1. KHỞI TẠO SWIPER
    new Swiper('.swiper', {
        loop: true, effect: 'fade',
        autoplay: { delay: 3000 },
        pagination: { el: '.swiper-pagination', clickable: true },
        navigation: { nextEl: '.swiper-button-next', prevEl: '.swiper-button-prev' },
    });

    // 2. GIỎ HÀNG
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
        // KIỂM TRA ĐĂNG NHẬP TRƯỚC TIÊN (Đề phòng trường hợp lỗi ở addToCart)
        if (!window.isLoggedIn) {
            alert("Vui lòng đăng nhập để mua hàng!");
            window.location.href = (window.contextPath || "") + "/login";
            return;
        }

        addToCart(false);
        closeModal();

        const checkoutModal = document.getElementById('checkout-modal');
        if(checkoutModal) {
            checkoutModal.style.display = 'block';
        }
    };

    // 4. THÊM VÀO GIỎ HÀNG
    window.addToCart = function (showAlert = true) {
        // KIỂM TRA ĐĂNG NHẬP TRƯỚC TIÊN
        if (!window.isLoggedIn) {
            // Hiện alert
            alert("Vui lòng đăng nhập để mua hàng!");

            // Chuyển hướng đến trang đăng nhập
            window.location.href = (window.contextPath || "") + "/login";

            // Dừng hàm lại, không thêm vào giỏ
            return;
        }

        const name = document.getElementById('modalName').innerText;
        const price = parseInt(document.getElementById('modalPrice').innerText.replace(/\D/g, ''));
        const img = document.getElementById('modalImg').src;
        const qtyInput = document.querySelector('.qty-input input');
        const qty = qtyInput ? parseInt(qtyInput.value) : 1;

        const itemIdx = cart.findIndex(item => item.name === name);
        if (itemIdx > -1) cart[itemIdx].qty += qty;
        else cart.push({ name, price, img, qty });

        renderCart();

        if (showAlert) {
            alert("Đã thêm vào giỏ!");
        }
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
        try {
            // 1. Lấy các phần tử DOM
            const nameElem = document.getElementById('fullname');
            const phoneElem = document.getElementById('phone');
            const addressElem = document.getElementById('address');
            const emailElem = document.getElementById('email');

            // 2. Kiểm tra xem các ô nhập liệu có tồn tại không (Tránh lỗi null)
            if (!nameElem || !phoneElem || !addressElem) {
                console.error("Không tìm thấy các ID fullname, phone hoặc address trong HTML!");
                return;
            }

            const name = nameElem.value;
            const phone = phoneElem.value;
            const address = addressElem.value;
            const email = emailElem ? emailElem.value : "khach@gmail.com";

            // 3. Lấy phương thức thanh toán (Giá trị gửi Java và Nhãn hiển thị UI)
            const paymentRadio = document.querySelector('input[name="payment"]:checked');
            const paymentValue = paymentRadio ? paymentRadio.value : "COD";
            // Lấy chữ tiếng Việt (ví dụ: "Chuyển khoản...") để hiện ở Bước 3
            const paymentLabel = paymentRadio ? paymentRadio.parentElement.querySelector('span').innerText : "Thanh toán khi nhận hàng (COD)";

            // 4. Tính tổng tiền từ giỏ hàng hiện tại
            let totalMoney = 0;
            cart.forEach(item => totalMoney += (item.price * item.qty));

            // 5. Đóng gói dữ liệu (Key phải khớp 100% với Servlet Java)
            const orderData = {
                tenKhachHang: name,
                email: email,
                soDienThoai: phone,
                diaChi: address,
                phuongThucTT: paymentValue,
                tongTien: totalMoney,
                chiTiet: cart.map(item => ({
                    tenSanPham: item.name,
                    soLuong: item.qty,
                    donGia: item.price
                }))
            };

            const url = (window.contextPath || "") + '/checkout';

            // 6. Gửi dữ liệu lên Server
            fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(orderData)
            })
                .then(res => res.json())
                .then(data => {
                    if (data.status === 'success') {
                        // Đổ dữ liệu vào màn hình kết quả (Bước 3)
                        // Phải dùng câu lệnh IF để kiểm tra ID có tồn tại trong JSP không mới gán innerText
                        if(document.getElementById('res-name')) document.getElementById('res-name').innerText = name;
                        if(document.getElementById('res-phone')) document.getElementById('res-phone').innerText = phone;
                        if(document.getElementById('res-address')) document.getElementById('res-address').innerText = address;
                        if(document.getElementById('res-payment-method')) document.getElementById('res-payment-method').innerText = paymentLabel;

                        // Ẩn bước 2, hiện bước 3
                        const step2 = document.getElementById('step-2');
                        const step3 = document.getElementById('step-3');
                        if(step2) step2.classList.remove('active');
                        if(step3) step3.classList.add('active');

                        // Xóa giỏ hàng sau khi thành công
                        localStorage.removeItem('medi_cart');
                        cart = [];
                        if(typeof renderCart === "function") renderCart();

                        alert("🎉 Đặt hàng thành công!");
                    } else {
                        alert("❌ Lỗi: " + data.message);
                    }
                })
                .catch(err => {
                    console.error("Lỗi kết nối Fetch:", err);
                    alert("Lỗi kết nối đến server!");
                });

        } catch (err) {
            console.error("Lỗi Logic JS:", err);
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