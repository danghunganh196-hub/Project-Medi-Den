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
        String uri = req.getRequestURI();
        if(uri.contains("hien-thi")){
            hienThi(req,resp);
        }
    }

    private void hienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listGiay",giayRepository.getAll());
        req.getRequestDispatcher("/view/hien-thi.jsp").forward(req,resp);
    }
}
