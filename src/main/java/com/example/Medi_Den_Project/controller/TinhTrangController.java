package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.HoaDon;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.Session;

import java.io.IOException;
import java.time.format.DateTimeFormatter;

@WebServlet("/tinh-trang")
public class TinhTrangController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/giay/hien-thi");
            return;
        }

        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            int id = Integer.parseInt(idStr);
            HoaDon donHang = session.get(HoaDon.class, id);

            if (donHang == null) {
                resp.sendRedirect(req.getContextPath() + "/giay/hien-thi");
                return;
            }

            DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            req.setAttribute("donHang", donHang);
            req.setAttribute("ngayDatStr", donHang.getNgayDat() != null ? donHang.getNgayDat().format(fmt) : "");

            req.getRequestDispatcher("/view/tinh-trang.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/giay/hien-thi");
        }
    }
}