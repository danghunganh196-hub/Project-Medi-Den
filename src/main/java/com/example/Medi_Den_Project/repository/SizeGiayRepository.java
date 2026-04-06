package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.SizeGiay;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class SizeGiayRepository {
    public List<SizeGiay> getByGiayId(int giayId) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.createQuery(
                            "FROM SizeGiay s WHERE s.giay.id = :giayId", SizeGiay.class)
                    .setParameter("giayId", giayId)
                    .list();
        }
    }
    public SizeGiay findById(Session session, Integer id) {
        if (id == null) return null;
        return session.get(SizeGiay.class, id);
    }

    // Thêm size mới
    public void them(SizeGiay size) {
        Transaction tx = null;
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            tx = session.beginTransaction();
            session.persist(size);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    // Sửa số lượng tồn
    public void capNhat(SizeGiay size) {
        Transaction tx = null;
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            tx = session.beginTransaction();
            session.merge(size);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }

    // Xoá size — kiểm tra FK trước
    public boolean xoa(int sizeId) {
        Transaction tx = null;
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            tx = session.beginTransaction();

            // Kiểm tra xem size đã có trong đơn hàng chưa
            Long count = session.createQuery(
                            "SELECT COUNT(c) FROM ChiTietHoaDon c WHERE c.sizeGiay.id = :id", Long.class)
                    .setParameter("id", sizeId)
                    .uniqueResult();

            if (count > 0) {
                tx.rollback();
                return false; // không xoá được, báo lại UI
            }

            SizeGiay size = session.get(SizeGiay.class, sizeId);
            if (size != null) session.remove(size);
            tx.commit();
            return true;

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            return false;
        }
    }
    public SizeGiay getById(int id) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.get(SizeGiay.class, id);
        }
    }

    public void xoaTatCaSizeCuaGiay(int giayId) {
        Transaction tx = null;
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            tx = session.beginTransaction();

            // Sử dụng HQL để xóa tất cả các size liên quan đến giayId
            session.createMutationQuery("DELETE FROM SizeGiay s WHERE s.giay.id = :giayId")
                    .setParameter("giayId", giayId)
                    .executeUpdate();

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }
}
