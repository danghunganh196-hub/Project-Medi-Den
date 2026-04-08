package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.repository.GiayRepository;
import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SearchServlet", value = "/search")
public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();

        try {
            String keyword = request.getParameter("keyword");
            if (keyword == null) keyword = "";

            GiayRepository repo = new GiayRepository();
            List<Giay> list = repo.searchByName(keyword);

            List<Map<String, Object>> result = new ArrayList<>();

            for (Giay g : list) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", g.getId());
                map.put("name", g.getTenGiay());
                map.put("price", g.getGia());
                map.put("image", g.getHinhAnh());
                result.add(map);
            }

            response.getWriter().write(gson.toJson(result));

        } catch (Exception e) {
            e.printStackTrace(); // 👈 NHÌN Ở ĐÂY
            response.setStatus(200);
            response.getWriter().write("[]"); // 👈 tránh crash JS
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
