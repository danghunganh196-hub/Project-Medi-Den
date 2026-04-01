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

@WebServlet(name = "giayController",value = {
        "/giay/hien-thi",
        "/giay/xem-tat-ca"
})
public class GiayController extends HttpServlet {
    GiayRepository giayRepository = new GiayRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Object user = req.getSession().getAttribute("user");

        if(user == null){
            resp.sendRedirect("/login");
            return;
        }

        String uri = req.getRequestURI();
        if(uri.contains("xem-tat-ca")){
            xemTatCa(req, resp);
        }
        // NHÁNH 2: Nếu vào hien-thi (Trang chủ cũ)
        else if(uri.contains("hien-thi")){
            hienThi(req, resp);
        }
    }
    private void hienThi(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException {
        req.setAttribute("listGiay", giayRepository.getNikeOnly());
        req.getRequestDispatcher("/view/trang-chu.jsp").forward(req, resp);
    }
    private void xemTatCa(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Lấy tham số từ URL (ví dụ: ?brand=Adidas&sort=desc)
        String brand = req.getParameter("brand");
        String sort = req.getParameter("sort");

        // 2. Gọi hàm Repository mới để lấy danh sách đã lọc và sắp xếp
        List<Giay> list = giayRepository.getAllFlex(brand, sort);

        // 3. Gọi hàm đếm số lượng sản phẩm của hãng đó
        Long count = giayRepository.countByBrand(brand);

        // 4. Đẩy dữ liệu sang JSP
        req.setAttribute("listGiay", list);
        req.setAttribute("totalCount", count);

        // Trỏ về trang danh mục (không có slide/vận chuyển)
        req.getRequestDispatcher("/view/xem-tat-ca.jsp").forward(req, resp);
    }
}
