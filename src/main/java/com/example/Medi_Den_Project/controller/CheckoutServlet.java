package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.*;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        TaiKhoan user = (TaiKhoan) request.getSession().getAttribute("user");
        if (user == null) {
            response.getWriter().write("{\"status\":\"NOT_LOGGED_IN\"}");
            return;
        }

        Session session = HibernateConfig.getFACTORY().openSession();
        Transaction tx = session.beginTransaction();

        try {
            JsonObject data = gson.fromJson(request.getReader(), JsonObject.class);

            String diaChi = data.get("diaChi").getAsString();
            String payment = data.get("payment").getAsString();
            JsonArray items = data.getAsJsonArray("items");

            KhachHang kh = session.get(KhachHang.class, user.getKhachHang().getId());

            if (kh == null) {
                throw new RuntimeException("Không tìm thấy khách hàng!");
            }

            // ===== HÓA ĐƠN =====
            HoaDon hoaDon = new HoaDon();
            hoaDon.setKhachHang(kh);
            hoaDon.setDiaChi(diaChi);
            hoaDon.setPhuongThucTT(payment);
            hoaDon.setNgayDat(LocalDate.now());
            hoaDon.setTrangThai("Chờ xác nhận");
            hoaDon.setTongTien(0.0);

            session.save(hoaDon);

            double total = 0;

            // ===== CHI TIẾT =====
            for (JsonElement e : items) {

                JsonObject obj = e.getAsJsonObject();

                int giayId = obj.get("giayId").getAsInt();
                int sizeId = obj.get("sizeId").getAsInt();
                int qty = obj.get("qty").getAsInt();
                double price = obj.get("price").getAsDouble();

                Giay giay = session.get(Giay.class, giayId);
                SizeGiay size = session.get(SizeGiay.class, sizeId);

                if (giay == null) throw new RuntimeException("Không tìm thấy giày");
                if (size == null) throw new RuntimeException("Không tìm thấy size");

                // THÊM ĐOẠN NÀY Ở ĐÂY
                int tonKho = size.getSoLuong();
                if (tonKho < qty) {
                    throw new RuntimeException("Sản phẩm không đủ số lượng trong kho");
                }
                size.setSoLuong(tonKho - qty);
                session.update(size);

                HoaDonChiTiet ct = new HoaDonChiTiet();
                ct.setHoaDon(hoaDon);
                ct.setGiay(giay);
                ct.setSizeGiay(size);
                ct.setSoLuong(qty);
                ct.setDonGia(price);

                session.save(ct);
                total += price * qty;
            }

            hoaDon.setTongTien(total);
            session.update(hoaDon);

            tx.commit();

            // ===== RESPONSE =====
            JsonObject res = new JsonObject();
            res.addProperty("status", "success");
            res.addProperty("name", kh.getTen() != null ? kh.getTen() : "Không rõ");
            res.addProperty("email", kh.getEmail() != null ? kh.getEmail() : "Chưa có email");

            response.getWriter().write(gson.toJson(res));

        } catch (Exception e) {
            tx.rollback();
            e.printStackTrace();

            response.getWriter().write(
                    "{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}"
            );
        } finally {
            session.close();
        }
    }
}