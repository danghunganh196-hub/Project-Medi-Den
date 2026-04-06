package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.entity.TheLoaiGiay;
import com.example.Medi_Den_Project.repository.GiayRepository;
import com.example.Medi_Den_Project.repository.HoaDonRepository;
import com.example.Medi_Den_Project.repository.KhachHangRepository;
import com.example.Medi_Den_Project.repository.TheLoaiGiayRepository;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.example.Medi_Den_Project.entity.SizeGiay;
import com.example.Medi_Den_Project.repository.SizeGiayRepository;
import com.google.gson.Gson;

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
        "/trang-chu-admin",
        "/size-giay",
        "/size-giay/add",
        "/size-giay/update",
        "/size-giay/delete",
})
public class QuanLyController extends HttpServlet{
    TheLoaiGiayRepository theLoaiGiayRepository = new TheLoaiGiayRepository();
    KhachHangRepository khachHangRepository = new KhachHangRepository();
    GiayRepository giayRepository = new GiayRepository();
    HoaDonRepository hoaDonRepository = new HoaDonRepository();

    SizeGiayRepository sizeGiayRepository = new SizeGiayRepository();
    Gson gson = new GsonBuilder()
            .excludeFieldsWithModifiers(java.lang.reflect.Modifier.TRANSIENT)
            .create();


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
            String action = req.getParameter("action");
            if ("getSizes".equals(action)) {
                spGetSizes(req, resp);  // trả JSON
            } else {
                sphienThi(req, resp);   // render trang bình thường
            }
        } else if (uri.contains("don-hang")) {
            hdhienThi(req,resp);
        } else if (uri.contains("trang-chu-admin")) {
            trangChuAdmin(req,resp);
        } else if (uri.contains("size-giay")) {
            spGetSizes(req, resp);
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
            req.setAttribute("listDanhMuc", theLoaiGiayRepository.getAll());
            req.getRequestDispatcher("/quan-ly/san-pham.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println(">>> LỖI: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void spGetSizes(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int giayId = Integer.parseInt(req.getParameter("giayId"));
        List<SizeGiay> list = sizeGiayRepository.getByGiayId(giayId);

        // Build JSON thủ công, tránh circular reference
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            SizeGiay s = list.get(i);
            if (i > 0) sb.append(",");
            sb.append("{")
                    .append("\"id\":").append(s.getId()).append(",")
                    .append("\"soSize\":").append(s.getSoSize()).append(",")
                    .append("\"soLuong\":").append(s.getSoLuong())
                    .append("}");
        }
        sb.append("]");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(sb.toString());
    }

    private void spThemSize(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int giayId  = Integer.parseInt(req.getParameter("giayId"));
            int soSize  = Integer.parseInt(req.getParameter("soSize"));
            int soLuong = Integer.parseInt(req.getParameter("soLuong"));

            Giay giay = giayRepository.getById(giayId);
            if (giay == null) { resp.sendError(404); return; }

            SizeGiay size = new SizeGiay();
            size.setGiay(giay);
            size.setSoSize(soSize);
            size.setSoLuong(soLuong);

            sizeGiayRepository.them(size);
            resp.getWriter().write("OK");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

    private void spCapNhatSize(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int sizeId  = Integer.parseInt(req.getParameter("sizeId"));
            int soLuong = Integer.parseInt(req.getParameter("soLuong"));

            SizeGiay size = sizeGiayRepository.getById(sizeId);
            if (size == null) { resp.sendError(404); return; }

            size.setSoLuong(soLuong);
            sizeGiayRepository.capNhat(size);
            resp.getWriter().write("OK");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

    private void spXoaSize(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int sizeId = Integer.parseInt(req.getParameter("sizeId"));
            boolean ok = sizeGiayRepository.xoa(sizeId);

            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(ok ? "OK" : "ERROR_FK");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

    private void dmhienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listTheLoai",theLoaiGiayRepository.getAll());
        req.getRequestDispatcher("/quan-ly/danh-muc.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();
        if (uri.contains("danh-muc/add")) {
            dmThem(req, resp);
        } else if (uri.contains("danh-muc/update")) {
            dmSua(req, resp);
        } else if (uri.contains("size-giay")) {
            String action = req.getParameter("action");
            switch (action) {
                case "them"     -> spThemSize(req, resp);
                case "capNhat"  -> spCapNhatSize(req, resp);
                case "xoa"      -> spXoaSize(req, resp);
            }
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
