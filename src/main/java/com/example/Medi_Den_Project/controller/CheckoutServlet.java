package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.entity.HoaDon;
import com.example.Medi_Den_Project.entity.HoaDonChiTiet;
import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.repository.GiayRepository;
import com.example.Medi_Den_Project.repository.HoaDonRepository;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.hibernate.Session;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    //    private HoaDonRepository hdRepo = new HoaDonRepository();
//    private GiayRepository giayRepo = new GiayRepository();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        try (Session session = HibernateConfig.getFACTORY().openSession()) {

            BufferedReader reader = request.getReader();
            JsonObject data = gson.fromJson(reader, JsonObject.class);

            if (data == null) {
                out.print("{\"status\":\"error\",\"message\":\"Data null\"}");
                return;
            }

            HoaDonRepository hdRepo = new HoaDonRepository();
            GiayRepository giayRepo = new GiayRepository();

            // ===== KHÁCH HÀNG =====
            KhachHang kh = new KhachHang();
            kh.setTen(data.get("tenKhachHang").getAsString());
            kh.setEmail(data.get("email").getAsString());
            kh.setDiaChi(data.get("diaChi").getAsString());
            kh.setGioiTinh(true);
            kh.setTuoi(20);

            // ===== HÓA ĐƠN =====
            HoaDon hd = new HoaDon();
            hd.setNgayDat(LocalDate.now());
            hd.setTongTien(data.get("tongTien").getAsDouble());
            hd.setDiaChi(data.get("diaChi").getAsString());
            hd.setTrangThai("Chờ xác nhận");

            // ===== CHI TIẾT =====
            JsonArray items = data.getAsJsonArray("chiTiet");
            List<HoaDonChiTiet> listCT = new ArrayList<>();

            for (JsonElement e : items) {
                JsonObject item = e.getAsJsonObject();

                String tenSP = item.get("tenSanPham").getAsString();

                Giay sp = giayRepo.findByName(session, tenSP);

                if (sp == null) {
                    out.print("{\"status\":\"error\",\"message\":\"Không tìm thấy SP: " + tenSP + "\"}");
                    return;
                }

                HoaDonChiTiet ct = new HoaDonChiTiet();
                ct.setGiay(sp);
                ct.setSoLuong(item.get("soLuong").getAsInt());
                ct.setDonGia(item.get("donGia").getAsDouble());
                ct.setThanhTien(ct.getSoLuong() * ct.getDonGia());

                listCT.add(ct);
            }

            // 🔥 GỌI SAVE CHUNG SESSION
            hdRepo.saveFullOrder(session, kh, hd, listCT);

            out.print("{\"status\":\"success\"}");

        } catch (Exception e) {
            e.printStackTrace();
            JsonObject err = new JsonObject();
            err.addProperty("status", "error");
            err.addProperty("message", e.getMessage());

            out.print(new Gson().toJson(err));
        }
    }
}
