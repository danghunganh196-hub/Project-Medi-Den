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
}
