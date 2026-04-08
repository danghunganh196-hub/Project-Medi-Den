package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.GioHang;
import com.example.Medi_Den_Project.entity.GioHangChiTiet;
import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.entity.SizeGiay;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.math.BigDecimal;

public class GioHangRepository {

    public GioHang getOrCreateCart(Session session, KhachHang kh) {
        Query<GioHang> q = session.createQuery("FROM GioHang g WHERE g.khachHang = :kh", GioHang.class);
        q.setParameter("kh", kh);
        GioHang cart = q.uniqueResult();

        if (cart == null) {
            cart = new GioHang();
            cart.setKhachHang(kh);
            cart.setTongTien(BigDecimal.ZERO);
            session.persist(cart);
        }
        return cart;
    }
    public GioHang findByKhachHang(Session session, KhachHang kh) {
        return session.createQuery(
                "SELECT g FROM GioHang g LEFT JOIN FETCH g.chiTietList WHERE g.khachHang = :kh",
                GioHang.class
        )
                .setParameter("kh", kh)
                .uniqueResult();
    }

    public void addToCart(Session session, KhachHang kh, Giay giay, SizeGiay size, int soLuong, double donGia) {
        Transaction tx = session.beginTransaction();
        try {
            GioHang cart = getOrCreateCart(session, kh);

            // Kiểm tra nếu sản phẩm + size đã có trong giỏ
            GioHangChiTiet existItem = null;
            for (GioHangChiTiet item : cart.getChiTietList()) {
                if (item.getGiay().getId().equals(giay.getId())
                        && item.getSizeGiay().getId().equals(size.getId())) {
                    existItem = item;
                    break;
                }
            }

            if (existItem != null) {
                existItem.setSoLuong(existItem.getSoLuong() + soLuong);
            } else {
                GioHangChiTiet newItem = new GioHangChiTiet();
                newItem.setGiay(giay);
                newItem.setSizeGiay(size);
                newItem.setSoLuong(soLuong);
                newItem.setDonGia(BigDecimal.valueOf(donGia));
                newItem.setGioHang(cart);
                cart.getChiTietList().add(newItem);
            }

            // Cập nhật tổng tiền
            BigDecimal total = cart.getChiTietList().stream()
                    .map(i -> i.getDonGia().multiply(BigDecimal.valueOf(i.getSoLuong())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            cart.setTongTien(total);

            session.persist(cart);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            e.printStackTrace();
        }
    }
}