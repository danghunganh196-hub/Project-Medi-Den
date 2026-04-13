package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.*;
import com.example.Medi_Den_Project.repository.GiayRepository;
import com.example.Medi_Den_Project.repository.GioHangRepository;
import com.example.Medi_Den_Project.repository.SizeGiayRepository;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.hibernate.Session;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AddToCartServlet", value = "/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private GioHangRepository ghRepo = new GioHangRepository();
    private GiayRepository giayRepo = new GiayRepository();
    private SizeGiayRepository sizeRepo = new SizeGiayRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        HttpSession httpSession = request.getSession();
        TaiKhoan user = (TaiKhoan) httpSession.getAttribute("user");

        if (user == null) {
            out.print("{\"status\":\"error\",\"message\":\"NOT_LOGGED_IN\"}");
            return;
        }

        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            BufferedReader reader = request.getReader();
            JsonObject data = gson.fromJson(reader, JsonObject.class);

            Integer giayId = data.get("giayId").getAsInt();
            Integer sizeId = data.get("sizeId").getAsInt();
            int qty = data.get("qty").getAsInt();
            double price = data.get("price").getAsDouble();

            Giay giay = giayRepo.findById(session, giayId);
            SizeGiay size = sizeRepo.findById(session, sizeId);

            if (giay == null || size == null) {
                out.print("{\"status\":\"error\",\"message\":\"Sản phẩm hoặc size không tồn tại\"}");
                return;
            }

            KhachHang kh = user.getKhachHang();
            ghRepo.addToCart(session, kh, giay, size, qty, price);

            out.print("{\"status\":\"success\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
