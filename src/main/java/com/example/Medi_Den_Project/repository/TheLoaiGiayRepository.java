package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.TheLoaiGiay;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;

import java.util.List;

public class TheLoaiGiayRepository {
    private Session session;

    public TheLoaiGiayRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<TheLoaiGiay> getAll(){
        return session.createQuery("SELECT tl FROM TheLoaiGiay tl").list();
    }

    public TheLoaiGiay getById(Integer id){
        return session.find(TheLoaiGiay.class, id);
    }

    public void themTheLoai(TheLoaiGiay tlg){
        try {
            session.getTransaction().begin();
            session.save(tlg);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
    }

    public void suaTheLoai(TheLoaiGiay tlg){
        try {
            session.getTransaction().begin();
            session.merge(tlg);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
    }

    public void xoaTheLoai(Integer id){
        try {
            session.getTransaction().begin();
            session.delete(this.getById(id));
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        }
    }

    public List<TheLoaiGiay> searchByTen(String keyword) {
        try {
            // Tìm kiếm các thể loại có tên chứa keyword (không phân biệt hoa thường với %...%)
            return session.createQuery("SELECT tl FROM TheLoaiGiay tl WHERE tl.tenTheLoai LIKE :k", TheLoaiGiay.class)
                    .setParameter("k", "%" + keyword + "%")
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
