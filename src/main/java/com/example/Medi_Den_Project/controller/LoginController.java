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
    TaiKhoanRepository repo = new TaiKhoanRepository();

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

        TaiKhoan tk = repo.login(username, password);

        if (tk != null) {
            req.getSession().setAttribute("user", tk); // lưu session user

            if ("ADMIN".equalsIgnoreCase(tk.getVaiTro())) {
                resp.sendRedirect(req.getContextPath() + "/trang-chu-admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/giay/hien-thi");
            }
            return;
        } else {
            req.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
            req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req, resp);
        }

    }
}
