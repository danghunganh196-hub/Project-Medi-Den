package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.GioHang;
import com.example.Medi_Den_Project.entity.GioHangChiTiet;
import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.repository.GioHangRepository;
import com.example.Medi_Den_Project.repository.GioHangChiTietRepository;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

@WebServlet(name = "RemoveFromCartServlet", value = "/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    private GioHangRepository ghRepo = new GioHangRepository();
    private GioHangChiTietRepository ghctRepo = new GioHangChiTietRepository();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Đọc JSON từ request
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);

            JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();

            if (!json.has("giayId") || !json.has("sizeId")) {
                out.print("{\"status\":\"error\",\"message\":\"Thiếu giayId hoặc sizeId\"}");
                return;
            }

            Integer giayId = json.get("giayId").getAsInt();
            Integer sizeId = json.get("sizeId").getAsInt();

            // Lấy user
            HttpSession httpSession = request.getSession();
            TaiKhoan user = (TaiKhoan) httpSession.getAttribute("user");
            if (user == null) {
                out.print("{\"status\":\"NOT_LOGGED_IN\"}");
                return;
            }

            try (Session session = HibernateConfig.getFACTORY().openSession()) {
                Transaction tx = session.beginTransaction();

                GioHang gioHang = ghRepo.findByKhachHang(session, user.getKhachHang());
                if (gioHang != null) {
                    GioHangChiTiet ghct = ghctRepo.findByGiayAndSize(session, gioHang, giayId, sizeId);
                    if (ghct != null) {
                        session.remove(ghct);
                        gioHang.getChiTietList().remove(ghct);
                        BigDecimal total = gioHang.getChiTietList().stream()
                                .map(i -> i.getDonGia().multiply(BigDecimal.valueOf(i.getSoLuong())))
                                .reduce(BigDecimal.ZERO, BigDecimal::add);

                        gioHang.setTongTien(total);

                        session.merge(gioHang); // 👈 quan trọng

                        tx.commit();

                        out.print("{\"status\":\"success\"}");
                        return;
                    }
                }

                out.print("{\"status\":\"error\",\"message\":\"Sản phẩm không tồn tại trong giỏ\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage().replace("\"", "'") + "\"}");
        }
    }
}