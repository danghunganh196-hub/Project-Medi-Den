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
function openModal(name, price, img, desc) {
    document.getElementById("modalName").innerText = name;
    document.getElementById("modalPrice").innerText = price;
    document.getElementById("modalImg").src = img;
    document.getElementById("modalDesc").innerText = desc;
    
    // Hiển thị modal
    document.getElementById("productModal").style.display = "block";
    
    // Ngăn cuộn trang web khi đang mở modal
    document.body.style.overflow = "hidden";
}

function closeModal() {
    document.getElementById("productModal").style.display = "none";
    document.body.style.overflow = "auto";
}

// Đóng modal khi click ra ngoài vùng trắng
window.onclick = function(event) {
    let modal = document.getElementById("productModal");
    if (event.target == modal) {
        closeModal();
    }
}

function showMore(button) {
    // Tìm nhóm sản phẩm của riêng hãng đó
    const parent = button.closest('.category-block');
    const hiddenProducts = parent.querySelectorAll('.hidden-item');

    hiddenProducts.forEach(item => {
        item.style.display = 'block'; // Hiện sản phẩm
    });

    // Sau khi hiện xong thì ẩn nút "Xem thêm"
    button.parentElement.style.display = 'none';
}

function openProductModal(button) {
    // 1. Lấy dữ liệu từ thuộc tính data- của nút được click
    const name = button.getAttribute('data-name');
    const price = button.getAttribute('data-price');
    const img = button.getAttribute('data-img');
    const desc = button.getAttribute('data-desc');
    const brand = button.getAttribute('data-brand');

    // 2. Điền dữ liệu vào các phần tử trong Modal
    document.getElementById('modalName').innerText = name;
    document.getElementById('modalPrice').innerText = price;
    document.getElementById('modalImg').src = img;
    document.getElementById('modalDesc').innerText = desc;
    document.getElementById('modalBrand').innerText = brand;

    // 3. Hiển thị Modal
    document.getElementById('productModal').style.display = "block";
}

function closeModal() {
    document.getElementById('productModal').style.display = "none";
}

// Đóng modal khi click ra ngoài vùng nội dung
window.onclick = function(event) {
    const modal = document.getElementById('productModal');
    if (event.target == modal) {
        modal.style.display = "none";
    }
}