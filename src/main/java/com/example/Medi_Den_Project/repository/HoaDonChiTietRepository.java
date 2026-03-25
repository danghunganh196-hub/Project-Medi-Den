package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.HoaDonChiTiet;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;

import java.util.List;

public class HoaDonChiTietRepository {
    private Session session;

    public HoaDonChiTietRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<HoaDonChiTietRepository> getAll(){
        return session.createQuery("SELECT ct FROM HoaDonChiTiet ct").list();
    }

    public HoaDonChiTiet getById(Integer id){
        return session.find(HoaDonChiTiet.class, id);
    }

    public void them(HoaDonChiTiet ct){
        try {
            session.getTransaction().begin();
            session.save(ct);
            session.getTransaction().commit();
        } catch (Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
        }
    }
}
