package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.GioHang;
import com.example.Medi_Den_Project.entity.GioHangChiTiet;
import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class CartDAO {
    private GioHangRepository ghRepo = new GioHangRepository();
    private GioHangChiTietRepository ghctRepo = new GioHangChiTietRepository();

    public boolean removeItem(int userId, int giayId, int sizeId) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            Transaction tx = session.beginTransaction();

            // Lấy user
            TaiKhoan user = session.get(TaiKhoan.class, userId);
            if (user == null) return false;

            // Lấy giỏ hàng của user
            GioHang gioHang = ghRepo.findByKhachHang(session, user.getKhachHang());
            if (gioHang == null) return false;

            // Lấy chi tiết giỏ hàng
            GioHangChiTiet ghct = ghctRepo.findByGiayAndSize(session, gioHang, giayId, sizeId);
            if (ghct == null) return false;

            // Xóa chi tiết
            session.delete(ghct);
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
