package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.entity.TaiKhoan;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;

import java.util.List;

public class TaiKhoanRepository {
    private Session session;

    public TaiKhoanRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<TaiKhoan> getAll(){
        return session.createQuery("SELECT tk FROM TaiKhoan tk").list();
    }

    public TaiKhoan getById(Integer id){
        return session.find(TaiKhoan.class, id);
    }
}
