package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;

import java.util.List;

public class GiayRepository {
    private Session session;

    public GiayRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<Giay> getAll(){
        return session.createQuery("SELECT gi FROM Giay gi").list();
    }

    public Giay getById(Integer id){
        return session.find(Giay.class, id);
    }

}