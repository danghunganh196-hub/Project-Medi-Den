package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.repository.TaiKhoanRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(value = {
        "/login"
})
public class LoginController extends HttpServlet {
    TaiKhoanRepository repo = new TaiKhoanRepository();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.contains("login")){
            req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        TaiKhoan tk = repo.login(username, password);

        if (tk != null) {

            req.getSession().setAttribute("user", tk);

            if ("ADMIN".equalsIgnoreCase(tk.getVaiTro())) {
                req.getSession().setAttribute("role", "ADMIN");
            } else {
                req.getSession().setAttribute("role", "USER");
            }

            resp.sendRedirect("/giay/hien-thi");
            return;
        }
    }
}
