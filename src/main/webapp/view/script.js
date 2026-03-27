function openModal(name, price, img, desc) {
    document.getElementById("modalName").innerText = name;
    document.getElementById("modalPrice").innerText = price;
    document.getElementById("modalImg").src = img;
    document.getElementById("modalDesc").innerText = desc;
    document.getElementById("productModal").style.display = "block";
}

function closeModal() {
    document.getElementById("productModal").style.display = "none";
}

// Đóng modal khi click ra ngoài vùng trắng
window.onclick = function(event) {
    window.onclick = function (event) {
        let modal = document.getElementById("productModal");
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
    const swiper = new Swiper('.swiper', {
        // Cấu hình chuyển slide mượt mà
        loop: true,
        effect: 'fade', // Hiệu ứng mờ dần (thay bằng 'slide' nếu muốn trượt ngang)
        autoplay: {
            delay: 3000,
            disableOnInteraction: false,
        },

        // Phân trang (dấu chấm)
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },

        // Nút mũi tên
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });
    document.addEventListener("DOMContentLoaded", function () {

        // ===== SWIPER (chỉ 1 lần) =====
        const swiper = new Swiper('.swiper', {
            loop: true,
            effect: 'fade',
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });

        // ===== GIỎ HÀNG =====
        let cart = [];

        const cartIcon = document.getElementById('cart-icon');
        const miniCart = document.getElementById('mini-cart');

        // 👉 toggleCart chuẩn
        window.toggleCart = function () {
            if (!miniCart) return;
            miniCart.classList.toggle('active');
        };

        // 👉 click icon mở
        if (cartIcon) {
            cartIcon.addEventListener('click', function (e) {
                e.stopPropagation(); // tránh bị đóng ngay
                toggleCart();
            });
        }

        // 👉 click ngoài đóng giỏ
        document.addEventListener('click', function (e) {
            if (!miniCart || !cartIcon) return;

            if (!miniCart.contains(e.target) && !cartIcon.contains(e.target)) {
                miniCart.classList.remove('active');
            }
        });

        // ===== MODAL SẢN PHẨM =====
        window.openProductModal = function (button) {
            const name = button.getAttribute('data-name');
            const price = button.getAttribute('data-price');
            const img = button.getAttribute('data-img');
            const desc = button.getAttribute('data-desc');
            const brand = button.getAttribute('data-brand');

            document.getElementById('modalName').innerText = name;
            document.getElementById('modalPrice').innerText = price;
            document.getElementById('modalImg').src = img;
            document.getElementById('modalDesc').innerText = desc;
            document.getElementById('modalBrand').innerText = brand;

            document.getElementById('productModal').style.display = "block";
            document.body.style.overflow = "hidden";
        };

        window.closeModal = function () {
            document.getElementById('productModal').style.display = "none";
            document.body.style.overflow = "auto";
        };

        // 👉 GỘP 1 window.onclick duy nhất
        window.addEventListener('click', function (event) {
            const modal = document.getElementById('productModal');
            if (event.target === modal) {
                closeModal();
            }
        });

        // ===== SHOW MORE =====
        window.showMore = function (button) {
            const parent = button.closest('.category-block');
            const hiddenProducts = parent.querySelectorAll('.hidden-item');

            hiddenProducts.forEach(item => {
                item.style.display = 'block';
            });

            button.parentElement.style.display = 'none';
        };

        // ===== THÊM VÀO GIỎ =====
        window.addToCart = function () {
            const name = document.getElementById('modalName').innerText;
            const priceText = document.getElementById('modalPrice').innerText;
            const price = parseInt(priceText.replace(/\D/g, ''));
            const img = document.getElementById('modalImg').src;
            const qty = parseInt(document.querySelector('.qty-input input').value);

            const existingItem = cart.find(item => item.name === name);

            if (existingItem) {
                existingItem.qty += qty;
            } else {
                cart.push({name, price, img, qty});
            }

            renderCart();
            alert("Đã thêm vào giỏ!");
        };

        function renderCart() {
            const list = document.getElementById('cart-items-list');
            const countLabel = document.getElementById('cart-count');
            const totalLabel = document.getElementById('cart-total-amount');

            if (!list) return;

            list.innerHTML = "";
            let total = 0;
            let count = 0;

            cart.forEach((item, index) => {
                total += item.price * item.qty;
                count += item.qty;

                list.innerHTML += `
                <div class="cart-item">
                    <img src="${item.img}">
                    <div class="item-info">
                        <h4>${item.name}</h4>
                        <span>${item.qty}</span>
                        <span>${(item.price * item.qty).toLocaleString()}đ</span>
                    </div>
                    <span onclick="removeItem(${index})">&times;</span>
                </div>
            `;
            });

            countLabel.innerText = count;
            totalLabel.innerText = total.toLocaleString() + "đ";
        }

        window.removeItem = function (index) {
            cart.splice(index, 1);
            renderCart();
        };

        // ===== THANH TOÁN =====
        const checkoutBtn = document.querySelector('.btn-checkout');

        if (checkoutBtn) {
            checkoutBtn.addEventListener('click', function () {
                document.getElementById('checkout-modal').style.display = 'block';
                miniCart.classList.remove('active');
            });
        }

        window.closeCheckout = function () {
            document.getElementById('checkout-modal').style.display = 'none';
        };

        // ===== VALIDATE =====
        window.validateStep1 = function () {
            const name = document.getElementById('fullname').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const address = document.getElementById('address').value.trim();

            document.querySelectorAll('.error-msg').forEach(el => el.innerText = '');
            let isValid = true;

            if (name === "") {
                document.getElementById('name-error').innerText = "Vui lòng nhập họ tên";
                isValid = false;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                document.getElementById('email-error').innerText = "Email không hợp lệ";
                isValid = false;
            }

            const phoneRegex = /^(0[3|5|7|8|9])[0-9]{8}$/;
            if (!phoneRegex.test(phone)) {
                document.getElementById('phone-error').innerText = "SĐT không hợp lệ";
                isValid = false;
            }

            if (address.length < 10) {
                document.getElementById('address-error').innerText = "Địa chỉ quá ngắn";
                isValid = false;
            }

            if (isValid) {
                document.getElementById('step-1').classList.remove('active');
                document.getElementById('step-2').classList.add('active');
            }
        };

        // ===== PAYMENT =====
        document.querySelectorAll('input[name="payment"]').forEach(radio => {
            radio.addEventListener('change', (e) => {
                const bankInfo = document.getElementById('bank-info');
                bankInfo.style.display = (e.target.value === 'Bank') ? 'block' : 'none';
            });
        });

        window.completeOrder = function () {
            document.getElementById('res-name').innerText = document.getElementById('fullname').value;
            document.getElementById('res-phone').innerText = document.getElementById('phone').value;
            document.getElementById('res-address').innerText = document.getElementById('address').value;

            const payMethod = document.querySelector('input[name="payment"]:checked').value;

            document.getElementById('res-payment').innerText =
                payMethod === 'COD' ? "Thanh toán khi nhận hàng" : "Chuyển khoản";

            document.getElementById('step-2').classList.remove('active');
            document.getElementById('step-3').classList.add('active');
        };

        // ===== MUA NGAY =====
        window.buyNowFromModal = function () {
            closeModal();

            setTimeout(() => {
                document.getElementById('checkout-modal').style.display = 'block';

                document.querySelectorAll('.checkout-step').forEach(step => {
                    step.classList.remove('active');
                });

                document.getElementById('step-1').classList.add('active');
            }, 300);
        };
    });
}