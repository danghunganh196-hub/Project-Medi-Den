package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.repository.GiayRepository;
import com.example.Medi_Den_Project.repository.HoaDonRepository;
import com.example.Medi_Den_Project.repository.KhachHangRepository;
import com.example.Medi_Den_Project.repository.TheLoaiGiayRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "quanLyController",value = {
        "/danh-muc",
        "/khach-hang",
        "/san-pham",
        "/don-hang",
        "/trang-chu-admin"
})
public class QuanLyController extends HttpServlet{
    TheLoaiGiayRepository theLoaiGiayRepository = new TheLoaiGiayRepository();
    KhachHangRepository khachHangRepository = new KhachHangRepository();
    GiayRepository giayRepository = new GiayRepository();
    HoaDonRepository hoaDonRepository = new HoaDonRepository();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("danh-muc")) {
            dmhienThi(req,resp);
        } else if (uri.contains("khach-hang")) {
            khhienThi(req,resp);
        } else if (uri.contains("san-pham")) {
            sphienThi(req,resp);
        } else if (uri.contains("don-hang")) {
            hdhienThi(req,resp);
        } else if (uri.contains("trang-chu-admin")) {
            trangChuAdmin(req,resp);
        }
    }

    private void trangChuAdmin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/quan-ly/trang-chu-admin.jsp").forward(req,resp);
    }

    private void khhienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listKhachHang",khachHangRepository.getAll());
        req.getRequestDispatcher("/quan-ly/khach-hang.jsp").forward(req,resp);
    }

    private void hdhienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listHoaDon",hoaDonRepository.getAll());
        req.getRequestDispatcher("/quan-ly/don-hang.jsp").forward(req,resp);
    }

    private void sphienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listSanPham",giayRepository.getAll());
        req.getRequestDispatcher("/quan-ly/san-pham.jsp").forward(req,resp);
    }

    private void dmhienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listTheLoai",theLoaiGiayRepository.getAll());
        req.getRequestDispatcher("/quan-ly/danh-muc.jsp").forward(req,resp);
    }
}
