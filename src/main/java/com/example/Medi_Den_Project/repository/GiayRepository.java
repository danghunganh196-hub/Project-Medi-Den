package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.query.Query;
import java.util.List;

public class GiayRepository {
    // Hàm lấy tất cả sản phẩm (không lọc, không sắp xếp) để phục vụ trang Quản lý
    public List<Giay> getAll() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.createQuery("FROM Giay", Giay.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    // 1. Hàm cũ: Lấy 4 đôi Nike cho trang chủ (GIỮ NGUYÊN)
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

    // 2. HÀM MỚI TỔNG HỢP: Vừa lọc hãng, vừa sắp xếp giá (Dùng cho trang xem-tat-ca)
    public List<Giay> getAllFlex(String brand, String sort) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            // Xây dựng câu HQL động
            StringBuilder hql = new StringBuilder("FROM Giay g WHERE 1=1");

            // Nếu có chọn hãng thì lọc theo hãng
            if (brand != null && !brand.isEmpty()) {
                hql.append(" AND g.thuongHieu = :brandName");
            }

            // Sắp xếp theo giá
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

    // 3. HÀM MỚI: Đếm số lượng sản phẩm để hiển thị lên trang web
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

    // 4. Các hàm bổ trợ khác (GIỮ NGUYÊN)
    public Giay getById(Integer id) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.get(Giay.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public Giay findByName(Session session, String name) {
        return session.createQuery("FROM Giay WHERE tenGiay = :name", Giay.class)
                .setParameter("name", name)
                .uniqueResult();
    }}