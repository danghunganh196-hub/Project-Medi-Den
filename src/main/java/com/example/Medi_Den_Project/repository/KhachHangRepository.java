package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class KhachHangRepository {
    private Session session;

    public KhachHangRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<KhachHang> getAll(){
        return session.createQuery("SELECT kh FROM KhachHang kh").list();
    }

    public KhachHang getById(Integer id){
        return session.find(KhachHang.class, id);
    }

    public void themKhachHang(KhachHang kh){
        try {
            session.getTransaction().begin();
            session.save(kh);
            session.getTransaction().commit();
        } catch (Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
        }
    }

    public boolean toggleTrangThai(Integer id) {
        Transaction tx = null;
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            tx = session.beginTransaction();

            KhachHang kh = session.get(KhachHang.class, id);
            if (kh == null) return false;

            // Đảo trạng thái
            boolean trangThaiMoi = !Boolean.TRUE.equals(kh.getTrangThai());
            kh.setTrangThai(trangThaiMoi);
            session.merge(kh);
            tx.commit();
            return trangThaiMoi;
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }

    public boolean isEmailExists(String email) {
        try {
            // Trả về true nếu tìm thấy khách hàng có email này
            Long count = (Long) session.createQuery("SELECT count(kh) FROM KhachHang kh WHERE kh.email = :e")
                    .setParameter("e", email)
                    .uniqueResult();
            return count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
