package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.repository.TaiKhoanRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(value = {
        "/login", "/logout"
})
public class LoginController extends HttpServlet {
    TaiKhoanRepository taiKhoanRepository = new TaiKhoanRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("login")) {
            req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req, resp);
        }
        if (uri.contains("logout")) {
            req.getSession().invalidate(); // Xoá session user
            resp.sendRedirect(req.getContextPath() + "/login"); // quay về trang login
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // 1. Kiểm tra đăng nhập (User + Pass)
        TaiKhoan tk = taiKhoanRepository.login(username, password);

        if (tk != null) {
            // 2. Nếu đăng nhập đúng, kiểm tra tiếp trạng thái hoạt động
            if (Boolean.FALSE.equals(tk.getTrangThai())) {
                req.setAttribute("message", "Tài khoản của bạn đã bị vô hiệu hóa. Vui lòng liên hệ Admin!");
                // Quan trọng: Phải forward về đúng trang login đang hiển thị
                req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req, resp);
                return;
            }

            // 3. Nếu mọi thứ OK, lưu session và chuyển hướng theo vai trò
            req.getSession().setAttribute("user", tk);
            if ("ADMIN".equalsIgnoreCase(tk.getVaiTro())) {
                resp.sendRedirect(req.getContextPath() + "/trang-chu-admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/giay/hien-thi");
            }
        } else {
            // 4. Sai tài khoản hoặc mật khẩu
            req.setAttribute("message", "Sai tên đăng nhập hoặc mật khẩu!");
            req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req, resp);
        }
    }
}
