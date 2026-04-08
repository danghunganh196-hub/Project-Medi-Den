package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class TaiKhoanRepository {
    private Session session = null;

    public TaiKhoanRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<TaiKhoan> getAll(){
        return session.createQuery("SELECT tk FROM TaiKhoan tk").list();
    }

    public TaiKhoan getById(Integer id){
        return session.find(TaiKhoan.class, id);
    }

    public void themTaiKhoan(TaiKhoan tk){
        try{
            session.getTransaction().begin();
            session.save(tk);
            session.getTransaction().commit();
        }catch (Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
        }
    }

    public TaiKhoan findByUsername(String username) {
        try {
            return (TaiKhoan) session.createQuery("FROM TaiKhoan WHERE username = :u")
                    .setParameter("u", username)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public TaiKhoan login(String username, String password) {
        // Bỏ điều kiện trangThai = true ở đây để Controller có thể kiểm tra riêng
        return (TaiKhoan) session.createQuery(
                "FROM TaiKhoan WHERE username = :u AND password = :p")
                .setParameter("u", username)
                .setParameter("p", password)
                .uniqueResult();
    }

    public void capNhatTrangThaiTheoKhachHang(Integer khachHangId, boolean trangThaiMoi) {
        Transaction tx = null;
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            tx = session.beginTransaction();
            session.createMutationQuery(
                    "UPDATE TaiKhoan SET trangThai = :tt WHERE khachHang.id = :khId")
                    .setParameter("tt", trangThaiMoi)
                    .setParameter("khId", khachHangId)
                    .executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}
