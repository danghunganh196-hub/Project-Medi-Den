package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.entity.TheLoaiGiay;
import com.example.Medi_Den_Project.repository.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "quanLyController",value = {
        "/danh-muc",
        "/danh-muc/add",
        "/danh-muc/update",
        "/danh-muc/delete",
        "/khach-hang",
        "/san-pham",
        "/san-pham/add",
        "/san-pham/update",
        "/san-pham/delete",
        "/don-hang",
        "/trang-chu-admin"
})
public class QuanLyController extends HttpServlet{
    TheLoaiGiayRepository theLoaiGiayRepository = new TheLoaiGiayRepository();
    KhachHangRepository khachHangRepository = new KhachHangRepository();
    GiayRepository giayRepository = new GiayRepository();
    HoaDonRepository hoaDonRepository = new HoaDonRepository();
    SizeGiayRepository sizeGiayRepository = new SizeGiayRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("danh-muc/delete")) {
            dmXoa(req, resp);
            return;
        }

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

    private void sphienThi(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            System.out.println(">>> sphienThi called");
            List<Giay> list = giayRepository.getAll();
            System.out.println(">>> listSanPham size: " + list.size());
            req.setAttribute("listSanPham", list);
            req.setAttribute("listTheLoai", theLoaiGiayRepository.getAll());
            req.setAttribute("listSizeGiay", sizeGiayRepository.getAll());
            req.getRequestDispatcher("/quan-ly/san-pham.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println(">>> LỖI: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void dmhienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listTheLoai",theLoaiGiayRepository.getAll());
        req.getRequestDispatcher("/quan-ly/danh-muc.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("danh-muc/add")) {
            dmThem(req, resp);
        } else if (uri.contains("danh-muc/update")) {
            dmSua(req, resp);
        }
    }

    private void dmThem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String ten = req.getParameter("tenTheLoai");

        TheLoaiGiay tlg = new TheLoaiGiay();
        tlg.setTenTheLoai(ten);

        theLoaiGiayRepository.themTheLoai(tlg);
        resp.sendRedirect("/danh-muc");
    }

    private void dmXoa(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Integer id = Integer.parseInt(idStr);
                theLoaiGiayRepository.xoaTheLoai(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/danh-muc");
    }

    private void dmSua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Integer id = Integer.parseInt(req.getParameter("id"));
            String tenMoi = req.getParameter("tenTheLoai");

            TheLoaiGiay tlg = theLoaiGiayRepository.getById(id);
            if (tlg != null) {
                tlg.setTenTheLoai(tenMoi);
                theLoaiGiayRepository.suaTheLoai(tlg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/danh-muc");
    }
}
