package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;

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

    public TaiKhoan login(String username, String password){
        return (TaiKhoan) session.createQuery(
                "FROM TaiKhoan WHERE username = :u AND password = :p")
                .setParameter("u", username)
                .setParameter("p", password)
                .uniqueResult();
    }
}
