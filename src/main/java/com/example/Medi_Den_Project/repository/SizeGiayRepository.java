package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.SizeGiay;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;

import java.util.List;

public class SizeGiayRepository {
    private Session session = null;

    public SizeGiayRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<SizeGiay> getAll() {
        return session.createQuery("FROM size_giay", SizeGiay.class).list();
    }

    public SizeGiay getById(Integer id) {
        return session.find(SizeGiay.class, id);
    }
}
