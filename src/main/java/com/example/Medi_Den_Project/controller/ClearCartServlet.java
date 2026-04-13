package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.IOException;

@WebServlet(name = "ClearCartServlet", value = "/ClearCartServlet")
public class ClearCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        TaiKhoan user = (TaiKhoan) request.getSession().getAttribute("user");

        if (user == null) {
            response.getWriter().write("{\"status\":\"NOT_LOGGED_IN\"}");
            return;
        }

        Session session = HibernateConfig.getFACTORY().openSession();
        Transaction tx = session.beginTransaction();

        try {
            session.createQuery(
                    "DELETE FROM GioHangChiTiet WHERE gioHang.khachHang.id = :khId"
            ).setParameter("khId", user.getKhachHang().getId())
                    .executeUpdate();

            tx.commit();

            response.getWriter().write("{\"status\":\"success\"}");

        } catch (Exception e) {
            tx.rollback();
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\"}");
        } finally {
            session.close();
        }

    }
}
