package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.repository.KhachHangRepository;
import com.example.Medi_Den_Project.repository.TaiKhoanRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = {
        "/register"
})
public class RegisterController extends HttpServlet {

    KhachHangRepository khRepo = new KhachHangRepository();
    TaiKhoanRepository tkRepo = new TaiKhoanRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("register")){
            req.getRequestDispatcher("/view/dang-ky.jsp").forward(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String ten = req.getParameter("ten").trim();
        String username = req.getParameter("username").trim();
        String password = req.getParameter("password").trim();
        Boolean gioiTinh = Boolean.valueOf(req.getParameter("gioiTinh"));
        Integer tuoi = Integer.valueOf(req.getParameter("tuoi"));
        String diaChi = req.getParameter("diaChi").trim();
        String email = req.getParameter("email").trim();

        // 1. Kiểm tra các trường không được để trống (sau khi đã trim)
        if (ten.isEmpty() || username.isEmpty() || password.trim().isEmpty() || diaChi.isEmpty() || email.isEmpty()) {
            req.setAttribute("message", "Vui lòng không để trống hoặc nhập chỉ toàn khoảng trắng!");
            req.getRequestDispatcher("/view/dang-ky.jsp").forward(req, resp);
            return;
        }

        // 2. Kiểm tra Username không được chứa khoảng trắng ở giữa
        // \s đại diện cho bất kỳ ký tự khoảng trắng nào (cách, tab, xuống dòng)
        if (username.contains(" ")) {
            req.setAttribute("message", "Tên đăng nhập không được chứa khoảng trắng!");
            req.getRequestDispatcher("/view/dang-ky.jsp").forward(req, resp);
            return;
        }

        // 4. Kiểm tra Email (Regex cũ của bạn đã bao gồm việc chặn space)
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (!email.matches(emailRegex)) {
            req.setAttribute("message", "Định dạng Email không hợp lệ!");
            req.getRequestDispatcher("/view/dang-ky.jsp").forward(req, resp);
            return;
        }

        // 1. Kiểm tra Email duy nhất
        if (khRepo.isEmailExists(email)) {
            req.setAttribute("message", "Email này đã được sử dụng!<br>Vui lòng dùng email khác.");
            req.getRequestDispatcher("/view/dang-ky.jsp").forward(req, resp);
            return;
        }

        // 2. Kiểm tra Username duy nhất
        if (tkRepo.isUsernameExists(username)) {
            req.setAttribute("message", "Tên đăng nhập đã tồn tại!<br>Vui lòng chọn tên khác.");
            req.getRequestDispatcher("/view/dang-ky.jsp").forward(req, resp);
            return;
        }

        // 1. Tạo KhachHang
        KhachHang kh = new KhachHang();
        kh.setTen(ten);
        kh.setGioiTinh(gioiTinh);
        kh.setTuoi(tuoi);
        kh.setDiaChi(diaChi);
        kh.setEmail(email);
        khRepo.themKhachHang(kh);

        // 2. Tạo TaiKhoan
        TaiKhoan tk = new TaiKhoan();
        tk.setUsername(username);
        tk.setPassword(password);
        tk.setVaiTro("USER");
        tk.setTrangThai(true);
        tk.setKhachHang(kh);
        tkRepo.themTaiKhoan(tk);

        // Thông báo
        req.setAttribute("message", "Đăng ký thành công!<br>Vui lòng chuyển qua trang đăng nhập để tiếp tục!");

        req.getRequestDispatcher("/view/dang-ky.jsp").forward(req, resp);
    }
}
