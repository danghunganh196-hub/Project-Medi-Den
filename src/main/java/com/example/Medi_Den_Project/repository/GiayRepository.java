package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class GiayRepository {

    public List<Giay> getAll() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.createQuery("FROM Giay", Giay.class).list();
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

            // DEBUG – xem sizeString
            list.forEach(g -> System.out.println("Giay: " + g.getTenGiay() + " -> sizeString: " + g.getSizeString()));
            return list;
        }
    }

    public List<Giay> getAllFlex(String brand, String sort) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            StringBuilder hql = new StringBuilder("FROM Giay g WHERE 1=1");

            if (brand != null && !brand.isEmpty()) {
                hql.append(" AND g.thuongHieu = :brandName");
            }

            if ("asc".equals(sort)) {
                hql.append(" ORDER BY g.gia ASC");
            } else if ("desc".equals(sort)) {
                hql.append(" ORDER BY g.gia DESC");
            }

            Query<Giay> query = session.createQuery(hql.toString(), Giay.class);
            if (brand != null && !brand.isEmpty()) {
                query.setParameter("brandName", brand);
            }

            List<Giay> list = query.list();
            list.forEach(g -> System.out.println("Flex: " + g.getTenGiay() + " -> sizeString: " + g.getSizeString()));
            return list;
        }
    }

    public Long countByBrand(String brand) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            String hql = "SELECT count(g) FROM Giay g";
            if (brand != null && !brand.isEmpty()) {
                hql += " WHERE g.thuongHieu = :brandName";
            }

            Query<Long> q = session.createQuery(hql, Long.class);
            if (brand != null && !brand.isEmpty()) {
                q.setParameter("brandName", brand);
            }
            return q.uniqueResult();
        }
    }

    public Giay getById(Integer id) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.get(Giay.class, id);
        }
    }
    public Giay findByName(Session session, String name) { return session.createQuery( "FROM Giay WHERE tenGiay = :name", Giay.class ) .setParameter("name", name) .uniqueResult(); }

}

