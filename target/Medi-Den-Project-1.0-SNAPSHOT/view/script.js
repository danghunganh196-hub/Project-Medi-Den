document.addEventListener("DOMContentLoaded", function () {

    console.log("JS OK");

    // ================= SWIPER =================
    if (typeof Swiper !== "undefined") {
        new Swiper('.swiper', {
            loop: true,
            effect: 'fade',
            autoplay: { delay: 3000 },
            pagination: {
                el: '.swiper-pagination',
                clickable: true
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev'
            }
        });
    }

    // ================= CART =================
    let cart = JSON.parse(localStorage.getItem('medi_cart')) || [];

    const cartIcon = document.getElementById('cart-icon');
    const miniCart = document.getElementById('mini-cart');

    window.toggleCart = function () {
        if (miniCart) miniCart.classList.toggle('active');
    };

    if (cartIcon && miniCart) {
        cartIcon.onclick = function (e) {
            e.stopPropagation();
            toggleCart();
        };
    }

    // ================= MODAL =================
    window.openProductModal = function (button) {

        const modal = document.getElementById('productModal');
        if (!modal) return;

        const name = button.dataset.name;
        const price = button.dataset.price;
        const img = button.dataset.img;
        const brand = button.dataset.brand;
        const sizeData = button.dataset.size;

        document.getElementById('modalName').innerText = name;
        document.getElementById('modalPrice').innerText =
            Number(price).toLocaleString('vi-VN') + " VNĐ";
        document.getElementById('modalImg').src = img;
        document.getElementById('modalBrand').innerText = brand;

        const sizeContainer = document.getElementById('modalSizeContainer');
        sizeContainer.innerHTML = "";
        window.selectedSize = null;

        if (!sizeData || sizeData.trim() === "") {
            sizeContainer.innerHTML = "<em>Hết hàng</em>";
        } else {
            const sizes = sizeData.split(',');

            sizes.forEach(size => {
                const btn = document.createElement('button');
                btn.innerText = size;
                btn.className = "size-item-btn";

                btn.onclick = function () {
                    sizeContainer.querySelectorAll('button')
                        .forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    window.selectedSize = size;
                };

                sizeContainer.appendChild(btn);
            });
        }

        modal.style.display = "block";
    };

    window.closeModal = function () {
        const modal = document.getElementById('productModal');
        if (modal) modal.style.display = "none";
    };

    // ================= ADD CART =================
    window.addToCart = function () {

        if (!window.selectedSize) {
            alert("Chọn size!");
            return;
        }

        const name = document.getElementById('modalName').innerText;
        const price = parseInt(document.getElementById('modalPrice').innerText.replace(/\D/g, ''));
        const img = document.getElementById('modalImg').src;
        const size = window.selectedSize;

        const idx = cart.findIndex(i => i.name === name && i.size === size);

        if (idx > -1) {
            cart[idx].qty++;
        } else {
            cart.push({ name, price, img, qty: 1, size });
        }

        renderCart();
    };

    // ================= RENDER =================
    window.renderCart = function () {
        const list = document.getElementById('cart-items-list');
        if (!list) return;

        let total = 0;
        let count = 0;
        list.innerHTML = "";

        cart.forEach((item, i) => {
            total += item.price * item.qty;
            count += item.qty;

            list.innerHTML += `
                <div class="cart-item">
                    <img src="${item.img}">
                    <div>
                        <h4>${item.name}</h4>
                        <p>${item.qty} x ${item.price.toLocaleString()}đ</p>
                    </div>
                    <span onclick="removeItem(${i})">&times;</span>
                </div>
            `;
        });

        const countEl = document.getElementById('cart-count');
        const totalEl = document.getElementById('cart-total-amount');

        if (countEl) countEl.innerText = count;
        if (totalEl) totalEl.innerText = total.toLocaleString() + "đ";

        localStorage.setItem('medi_cart', JSON.stringify(cart));
    };

    window.removeItem = function (i) {
        cart.splice(i, 1);
        renderCart();
    };

    renderCart();
});