package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.repository.KhachHangRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "giayController",value = {
        "/khach-hang/hien-thi",
        "/khach-hang/",
})
public class KhachHangController extends HttpServlet {
    KhachHangRepository repo = new KhachHangRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if (uri.contains("hien-thi")) {
            hienThi(req,resp);
        }
    }

    private void hienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listKhachHang",repo.getAll());
        req.getRequestDispatcher("/view/hien-thi.jsp").forward(req,resp);
    }
}
