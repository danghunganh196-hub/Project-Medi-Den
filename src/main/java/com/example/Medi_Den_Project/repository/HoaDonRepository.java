package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.entity.HoaDon;
import com.example.Medi_Den_Project.entity.HoaDonChiTiet;
import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class HoaDonRepository {
    private Session session;

    public HoaDonRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<HoaDon> getAll() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.createQuery("FROM HoaDon", HoaDon.class).list();
        }
    }

    public HoaDon getById(Integer id) {
        return session.find(HoaDon.class, id);
    }

    public void saveFullOrder(Session session, KhachHang khInput,
                              HoaDon hd, List<HoaDonChiTiet> listCT) {

        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();

            // ===== CHECK EMAIL TRÙNG =====
            KhachHang existingKH = session.createQuery(
                    "FROM KhachHang WHERE email = :email", KhachHang.class)
                    .setParameter("email", khInput.getEmail())
                    .uniqueResult();

            KhachHang kh;
            if (existingKH != null) {
                kh = existingKH;
            } else {
                session.persist(khInput);
                kh = khInput;
            }

            // ===== LƯU HÓA ĐƠN =====
            hd.setKhachHang(kh);
            session.persist(hd);

            // ===== LƯU CHI TIẾT =====
            for (HoaDonChiTiet ct : listCT) {
                ct.setHoaDon(hd);

                Giay managedGiay = session.merge(ct.getGiay());
                ct.setGiay(managedGiay);

                session.persist(ct);
            }

            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException("Lỗi lưu đơn: " + e.getMessage());
        }
    }
}
