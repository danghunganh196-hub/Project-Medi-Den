package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.repository.GiayRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "giayController",value = {
        "/giay/hien-thi",
        "/giay/",
})
public class GiayController extends HttpServlet {
    GiayRepository giayRepository = new GiayRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
<<<<<<< HEAD
        String path = req.getServletPath();
        if (path.equals("/giay/hien-thi")) {
            hienThi(req, resp);
        } else {
            hienThi(req, resp);
=======
        if(req.getSession().getAttribute("daDangNhap") == null){
            resp.sendRedirect("/login");
            return;
        }

        String uri = req.getRequestURI();
        if(uri.contains("hien-thi")){
            hienThi(req,resp);
>>>>>>> 4b8d0d6cfe38ab59e0ccdd664f95e37c0f41863e
        }
    }

    private void hienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
<<<<<<< HEAD
        req.setAttribute("listGiay", giayRepository.getNikeOnly());
        req.getRequestDispatcher("/view/trang-chu.jsp").forward(req, resp);
=======
        req.setAttribute("listGiay",giayRepository.getAll());
        req.getRequestDispatcher("/Web_ban_giay/index.html").forward(req,resp);
>>>>>>> 4b8d0d6cfe38ab59e0ccdd664f95e37c0f41863e
    }
}
