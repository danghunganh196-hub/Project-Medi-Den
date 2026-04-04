package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.repository.GiayRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "giayController", value = {
        "/giay/hien-thi",
        "/giay/xem-tat-ca"
})
public class GiayController extends HttpServlet {

    private final GiayRepository giayRepository = new GiayRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("xem-tat-ca")) {
            xemTatCa(req, resp);
        } else if (uri.contains("hien-thi")) {
            hienThi(req, resp);
        }
    }

    private void hienThi(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Giay> listNike = giayRepository.getNikeOnly();
        req.setAttribute("listGiay", listNike);
        req.getRequestDispatcher("/view/trang-chu.jsp").forward(req, resp);
    }

    private void xemTatCa(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brand = req.getParameter("brand");
        String sort = req.getParameter("sort");

        List<Giay> list = giayRepository.getAllFlex(brand, sort);
        Long count = giayRepository.countByBrand(brand);

        req.setAttribute("listGiay", list);
        req.setAttribute("totalCount", count);
        req.getRequestDispatcher("/view/xem-tat-ca.jsp").forward(req, resp);
    }
}
