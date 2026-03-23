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
        String ten = req.getParameter("ten");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        Boolean gioiTinh = Boolean.valueOf(req.getParameter("gioiTinh"));
        Integer tuoi = req.getParameter("tuoi").isEmpty() ? null : Integer.valueOf(req.getParameter("tuoi"));
        String diaChi = req.getParameter("diaChi");
        String email = req.getParameter("email");

        // 1. Tạo KhachHang
        KhachHang kh = new KhachHang();
        kh.setTen(ten);
        kh.setGioiTinh(gioiTinh);
        kh.setTuoi(tuoi);
        kh.setDiaChi(diaChi);
        kh.setEmail(email);

        KhachHangRepository khRepo = new KhachHangRepository();
        khRepo.themKhachHang(kh);

        // 2. Tạo TaiKhoan
        TaiKhoan tk = new TaiKhoan();
        tk.setUsername(username);
        tk.setPassword(password);
        tk.setVaiTro("USER");
        tk.setTrangThai(true);
        tk.setKhachHang(kh);

        TaiKhoanRepository tkRepo = new TaiKhoanRepository();
        tkRepo.themTaiKhoan(tk);

        // Thông báo
        req.setAttribute("message", "Đăng ký thành công!");

        req.getRequestDispatcher("/view/dang-ky.jsp").forward(req, resp);
    }
}
