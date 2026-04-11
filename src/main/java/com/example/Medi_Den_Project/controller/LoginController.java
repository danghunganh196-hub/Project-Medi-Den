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
        "/login", "/logout","/forgot-password"
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
        if (uri.contains("forgot-password")) {
            req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        // ✅ Thêm POST forgot-password
        if (uri.contains("forgot-password")) {
            String username    = req.getParameter("username");
            String newPassword = req.getParameter("newPassword");
            String confirmPass = req.getParameter("confirmPassword");

            if (!newPassword.equals(confirmPass)) {
                req.setAttribute("message", "Mật khẩu nhập lại không khớp!");
                req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
                return;
            }

            boolean success = taiKhoanRepository.resetPassword(username, newPassword);
            if (success) {
                req.setAttribute("message", "Đổi mật khẩu thành công!");
                req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req, resp);
            } else {
                req.setAttribute("message", "Không tìm thấy tài khoản!");
                req.getRequestDispatcher("/view/forgot-password.jsp").forward(req, resp);
            }
            return;
        }

        // ===== LOGIN như cũ =====
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        TaiKhoan tk = taiKhoanRepository.login(username, password);

        if (tk != null) {
            if (Boolean.FALSE.equals(tk.getTrangThai())) {
                req.setAttribute("message", "Tài khoản của bạn đã bị vô hiệu hóa.<br>Vui lòng liên hệ Admin!");
                req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req, resp);
                return;
            }
            req.getSession().setAttribute("user", tk);
            if ("ADMIN".equalsIgnoreCase(tk.getVaiTro())) {
                resp.sendRedirect(req.getContextPath() + "/trang-chu-admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/giay/hien-thi");
            }
        } else {
            req.setAttribute("message", "Sai tên đăng nhập hoặc mật khẩu!");
            req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req, resp);
        }
    }
}
