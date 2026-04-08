package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.List;

public class GiayRepository {
    public List<Giay> searchByName(String keyword) {
        Session session = HibernateConfig.getFACTORY().openSession();

        try {
            if (keyword == null) keyword = "";

            String hql = "FROM Giay g WHERE lower(g.tenGiay) LIKE lower(:kw)";

            return session.createQuery(hql, Giay.class)
                    .setParameter("kw", "%" + keyword + "%")
                    .setMaxResults(5) // 🔥 Giới hạn tối đa 5 sản phẩm ở đây
                    .getResultList();

        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            session.close();
        }
    }

    public List<Giay> getAll() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.createQuery(
                    "SELECT DISTINCT g FROM Giay g " +
                            "LEFT JOIN FETCH g.listSize " +
                            "LEFT JOIN FETCH g.theLoaiGiay",
                    Giay.class
            ).list();
        }
    }
    public Giay findById(Session session, Integer id) {
        if (id == null) return null;
        return session.get(Giay.class, id);
    }

    public Giay getById(Integer id) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.get(Giay.class, id);
        }
    }

    public void them(Giay giay) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            session.beginTransaction();
            session.persist(giay);
            session.getTransaction().commit();
        }
    }

    public void sua(Giay giay) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            session.beginTransaction();
            session.merge(giay);
            session.getTransaction().commit();
        }
    }

    public boolean xoa(Integer id) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            session.beginTransaction();
            Giay g = session.get(Giay.class, id);
            if (g == null) return false;
            session.remove(g);
            session.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Giay> getNikeOnly() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            List<Giay> list = session.createQuery(
                    "FROM Giay g WHERE g.thuongHieu = :brandName",
                    Giay.class
            ).setParameter("brandName", "Nike")
                    .setMaxResults(4)
                    .list();
            list.forEach(g -> System.out.println("Giay: " + g.getTenGiay() + " -> sizeString: " + g.getSizeString()));
            return list;
        }
    }

    public List<Giay> getAllFlex(String brand, String sort) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            StringBuilder hql = new StringBuilder("FROM Giay g WHERE 1=1");
            if (brand != null && !brand.isEmpty()) hql.append(" AND g.thuongHieu = :brandName");
            if ("asc".equals(sort))        hql.append(" ORDER BY g.gia ASC");
            else if ("desc".equals(sort))  hql.append(" ORDER BY g.gia DESC");

            Query<Giay> query = session.createQuery(hql.toString(), Giay.class);
            if (brand != null && !brand.isEmpty()) query.setParameter("brandName", brand);
            List<Giay> list = query.list();
            list.forEach(g -> System.out.println("Flex: " + g.getTenGiay() + " -> sizeString: " + g.getSizeString()));
            return list;
        }
    }

    public Long countByBrand(String brand) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            String hql = "SELECT count(g) FROM Giay g";
            if (brand != null && !brand.isEmpty()) hql += " WHERE g.thuongHieu = :brandName";
            Query<Long> q = session.createQuery(hql, Long.class);
            if (brand != null && !brand.isEmpty()) q.setParameter("brandName", brand);
            return q.uniqueResult();
        }
    }

    public Giay findByName(Session session, String name) {
        return session.createQuery("FROM Giay WHERE tenGiay = :name", Giay.class)
                .setParameter("name", name)
                .uniqueResult();
    }

    public List<Giay> getByCategory(Integer categoryId, String brand) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            StringBuilder hql = new StringBuilder("FROM Giay g WHERE g.theLoaiGiay.id = :catId");

            if (brand != null && !brand.isEmpty()) {
                hql.append(" AND g.thuongHieu = :brandName");
            }

            var query = session.createQuery(hql.toString(), Giay.class)
                    .setParameter("catId", categoryId);

            if (brand != null && !brand.isEmpty()) {
                query.setParameter("brandName", brand);
            }

            return query.list();
        }
    }
}