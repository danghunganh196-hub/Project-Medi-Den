package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.HoaDon;
import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Session;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/don-hang-cua-toi")
public class DonHangCuaToiController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        TaiKhoan user = (TaiKhoan) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            int khachHangId = user.getKhachHang().getId();

            List<HoaDon> danhSach = session.createQuery(
                    "FROM HoaDon h WHERE h.khachHang.id = :id ORDER BY h.id DESC",
                    HoaDon.class
            ).setParameter("id", khachHangId).getResultList();

            // Format ngày cho từng đơn
            DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            danhSach.forEach(hd -> {
                if (hd.getNgayDat() != null) {
                    req.setAttribute("ngay_" + hd.getId(), hd.getNgayDat().format(fmt));
                }
            });

            req.setAttribute("danhSachDonHang", danhSach);
            req.getRequestDispatcher("/view/don-hang-cua-toi.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/giay/hien-thi");
        }
    }
}
