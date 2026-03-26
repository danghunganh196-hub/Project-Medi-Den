//package com.example.Medi_Den_Project.controller;
//
//import com.example.Medi_Den_Project.entity.TaiKhoan;
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//
//@WebFilter(urlPatterns = {"/danh-muc", "/khach-hang", "/san-pham", "/don-hang", "/trang-chu-admin"})
//public class AdminFilter implements Filter {
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//
//        HttpServletRequest req = (HttpServletRequest) request;
//        HttpServletResponse resp = (HttpServletResponse) response;
//        HttpSession session = req.getSession(false);
//
//        TaiKhoan tk = (session != null) ? (TaiKhoan) session.getAttribute("user") : null;
//
//        if (tk != null && "ADMIN".equalsIgnoreCase(tk.getVaiTro())) {
//            chain.doFilter(request, response);
//        } else {
//            resp.sendRedirect(req.getContextPath() + "/login");
//        }
//    }
//}