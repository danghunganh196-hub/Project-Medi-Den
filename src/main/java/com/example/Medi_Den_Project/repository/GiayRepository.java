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

    public List<Giay> getNikeOnly() {
        String hql = "SELECT g FROM Giay g WHERE g.thuongHieu = 'Nike'";
        return session.createQuery(hql, Giay.class)
                .setMaxResults(4) // Giới hạn lấy đúng 4 bản ghi đầu tiên
                .list();
    }
    public Giay getById(Integer id){
        return session.find(Giay.class, id);
    }

}