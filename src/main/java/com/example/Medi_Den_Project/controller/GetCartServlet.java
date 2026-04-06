package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.GioHang;
import com.example.Medi_Den_Project.entity.GioHangChiTiet;
import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.repository.GioHangRepository;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.hibernate.Session;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetCartServlet", value = "/GetCartServlet")
public class GetCartServlet extends HttpServlet {
    private GioHangRepository ghRepo = new GioHangRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null) {
            out.print("{\"status\":\"NOT_LOGGED_IN\"}");
            return;
        }

        try (Session s = HibernateConfig.getFACTORY().openSession()) {
            GioHang gioHang = ghRepo.findByKhachHang(s, user.getKhachHang()); // 1 giỏ hàng

            if (gioHang == null || gioHang.getChiTietList().isEmpty()) {
                out.print("[]"); // giỏ trống
                return;
            }

            Gson gson = new Gson();
            List<JsonObject> cartJson = new ArrayList<>();

            for (GioHangChiTiet ghct : gioHang.getChiTietList()) {
                JsonObject obj = new JsonObject();
                obj.addProperty("giayId", ghct.getGiay().getId());
                obj.addProperty("name", ghct.getGiay().getTenGiay());
                obj.addProperty("price", ghct.getDonGia().doubleValue());
                obj.addProperty("size", ghct.getSizeGiay().getSoSize());
                obj.addProperty("qty", ghct.getSoLuong());
                obj.addProperty("img", ghct.getGiay().getHinhAnh());
                cartJson.add(obj);
            }

            out.print(gson.toJson(cartJson));
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
