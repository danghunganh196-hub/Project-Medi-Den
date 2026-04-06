package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.GioHang;
import com.example.Medi_Den_Project.entity.GioHangChiTiet;
import org.hibernate.Session;

public class GioHangChiTietRepository {

    public GioHangChiTiet findByGiayAndSize(Session session, GioHang gioHang, Integer giayId, Integer sizeId) {
        return session.createQuery(
                "FROM GioHangChiTiet ghct " +
                        "WHERE ghct.gioHang = :gioHang " +
                        "AND ghct.giay.id = :giayId " +
                        "AND ghct.sizeGiay.id = :sizeId", GioHangChiTiet.class)
                .setParameter("gioHang", gioHang)
                .setParameter("giayId", giayId)
                .setParameter("sizeId", sizeId)
                .uniqueResult();
    }
}