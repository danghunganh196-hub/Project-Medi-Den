package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class GiayRepository {

    // Lấy tất cả sản phẩm (cho trang Quản lý)
    public List<Giay> getAll() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.createQuery("FROM Giay", Giay.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Lấy 4 đôi Nike cho trang chủ
    public List<Giay> getNikeOnly() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            String hql = "FROM Giay g WHERE g.thuongHieu = 'Nike'";
            return session.createQuery(hql, Giay.class)
                    .setMaxResults(4)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Lọc hãng + sắp xếp giá (cho trang xem-tat-ca)
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
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Đếm số lượng sản phẩm
    public Long countByBrand(String brand) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            String hql = "SELECT count(g) FROM Giay g";
            if (brand != null && !brand.isEmpty()) {
                hql += " WHERE g.thuongHieu = :brandName";
            }
            Query<Long> query = session.createQuery(hql, Long.class);
            if (brand != null && !brand.isEmpty()) {
                query.setParameter("brandName", brand);
            }
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0L;
        }
    }

    // Lấy theo ID
    public Giay getById(Integer id) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.get(Giay.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Thêm sản phẩm
    public void themSanPham(Giay g) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            session.getTransaction().begin();
            session.save(g);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Sửa sản phẩm
    public void suaSanPham(Giay g) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            session.getTransaction().begin();
            session.merge(g);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa sản phẩm
    public void xoaSanPham(Integer id) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            session.getTransaction().begin();
            Giay g = session.get(Giay.class, id);
            if (g != null) session.delete(g);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Tìm theo tên
// Tìm theo tên (dùng session từ ngoài)
    public Giay findByName(Session session, String name) {
        return session.createQuery("FROM Giay WHERE tenGiay = :name", Giay.class)
                .setParameter("name", name)
                .uniqueResult();
    }
}