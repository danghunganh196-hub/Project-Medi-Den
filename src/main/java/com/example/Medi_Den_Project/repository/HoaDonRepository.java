package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.HoaDon;
import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;

import java.util.List;

public class HoaDonRepository {
    private Session session;

    public HoaDonRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<HoaDon> getAll(){
        return session.createQuery("SELECT hd FROM HoaDon hd").list();
    }

    public HoaDon getById(Integer id){
        return session.find(HoaDon.class, id);
    }

    public void themHoaDon(HoaDon hd){
        try {
            session.getTransaction().begin();
            session.save(hd);
            session.getTransaction().commit();
        } catch (Exception e){
            e.printStackTrace();
            session.getTransaction().rollback();
        }
    }
}
