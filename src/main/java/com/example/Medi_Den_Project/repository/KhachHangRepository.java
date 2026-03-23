package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;

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
}
