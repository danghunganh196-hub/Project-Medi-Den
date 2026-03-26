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