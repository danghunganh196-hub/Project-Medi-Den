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

@WebServlet(
        name = "giayController",
        urlPatterns = {
                "/giay/hien-thi",
                "/giay/xem-tat-ca",
                "/giay/the-thao",
                "/giay/thoi-trang",
                "/giay/cong-so",
                "/giay/cao-cap"
        },
        loadOnStartup = 1
)
public class GiayController extends HttpServlet {

    private final GiayRepository giayRepository = new GiayRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("xem-tat-ca")) {
            xemTatCa(req, resp);
        } else if (uri.contains("hien-thi")) {
            hienThi(req, resp);
        } else if (uri.contains("the-thao")) {
            getGiayTheThao(req, resp);
        } else if (uri.contains("thoi-trang")) {
            getGiayThoiTrang(req, resp);
        } else if (uri.contains("cong-so")) {
            getGiayCongSo(req, resp);
        } else if (uri.contains("cao-cap")) {
            getGiayCaoCap(req, resp);
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

    // Thể thao: lọc theo hãng + the_loai_id = 1
    private void getGiayTheThao(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brand = req.getParameter("brand");
        List<Giay> list = giayRepository.getByCategory(1, brand);
        req.setAttribute("listGiay", list);
        req.setAttribute("categoryName", "Giày Thể Thao");
        req.getRequestDispatcher("/view/danh-muc.jsp").forward(req, resp);
    }

    // Thời trang: the_loai_id = 2, có thể lọc theo hãng
    private void getGiayThoiTrang(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brand = req.getParameter("brand");
        List<Giay> list = giayRepository.getByCategory(2, brand);
        req.setAttribute("listGiay", list);
        req.setAttribute("categoryName", "Giày Thời Trang");
        req.getRequestDispatcher("/view/danh-muc.jsp").forward(req, resp);
    }

    // Công sở: the_loai_id = 3
    private void getGiayCongSo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brand = req.getParameter("brand");
        List<Giay> list = giayRepository.getByCategory(3, brand);
        req.setAttribute("listGiay", list);
        req.setAttribute("categoryName", "Giày Công Sở");
        req.getRequestDispatcher("/view/danh-muc.jsp").forward(req, resp);
    }

    // Cao cấp: the_loai_id = 4
    private void getGiayCaoCap(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String brand = req.getParameter("brand");
        List<Giay> list = giayRepository.getByCategory(4, brand);
        req.setAttribute("listGiay", list);
        req.setAttribute("categoryName", "Giày Cao Cấp");
        req.getRequestDispatcher("/view/danh-muc.jsp").forward(req, resp);
    }
}