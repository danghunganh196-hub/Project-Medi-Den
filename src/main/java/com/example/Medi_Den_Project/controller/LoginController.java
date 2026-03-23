package com.example.Medi_Den_Project.controller;

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
        HttpSession session = req.getSession();

        // tai khoan admin: admin - 3636
        if (
                username.equals("admin") && password.equals("3636")
        ) {
            // tk, mk dung
            if (username.equals("admin")) {
                session.setAttribute("daDangNhap", username);
                resp.sendRedirect("/giay/hien-thi");
            }
        } else {
            // tk, mk sai
            req.setAttribute("message", "Sai thong tin dang nhap");
            req.getRequestDispatcher("/view/dang-nhap.jsp").forward(req, resp);
        }
    }
}
