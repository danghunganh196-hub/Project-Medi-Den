package com.example.Medi_Den_Project.repository;

import com.example.Medi_Den_Project.entity.Giay;
import com.example.Medi_Den_Project.entity.HoaDon;
import com.example.Medi_Den_Project.entity.HoaDonChiTiet;
import com.example.Medi_Den_Project.entity.KhachHang;
import com.example.Medi_Den_Project.utility.HibernateConfig;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class HoaDonRepository {
    private Session session;

    public HoaDonRepository() {
        session = HibernateConfig.getFACTORY().openSession();
    }

    public List<HoaDon> getAll() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            return session.createQuery("FROM HoaDon h ORDER BY h.ngayDat DESC", HoaDon.class).list();
        }
    }

    public HoaDon getById(Integer id) {
        return session.find(HoaDon.class, id);
    }

    public void saveFullOrder(Session session, KhachHang khInput,
                              HoaDon hd, List<HoaDonChiTiet> listCT) {

        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();

            // ===== CHECK EMAIL TRÙNG =====
            KhachHang existingKH = session.createQuery(
                    "FROM KhachHang WHERE email = :email", KhachHang.class)
                    .setParameter("email", khInput.getEmail())
                    .uniqueResult();

            KhachHang kh;
            if (existingKH != null) {
                kh = existingKH;
            } else {
                session.persist(khInput);
                kh = khInput;
            }

            // ===== LƯU HÓA ĐƠN =====
            hd.setKhachHang(kh);
            session.persist(hd);

            // ===== LƯU CHI TIẾT =====
            for (HoaDonChiTiet ct : listCT) {
                ct.setHoaDon(hd);

                Giay managedGiay = session.merge(ct.getGiay());
                ct.setGiay(managedGiay);

                session.persist(ct);
            }

            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw new RuntimeException("Lỗi lưu đơn: " + e.getMessage());
        }
    }

    public void updateTrangThai(Integer id, String trangThaiMoi) {
        Transaction transaction = null;
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            transaction = session.beginTransaction();

            // Lấy đối tượng HoaDon từ DB
            HoaDon hd = session.get(HoaDon.class, id);
            if (hd != null) {
                // Cập nhật trạng thái
                hd.setTrangThai(trangThaiMoi);
                session.merge(hd); // Lưu thay đổi
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public List<HoaDonChiTiet> getChiTietByHoaDonId(Integer hoaDonId) {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            // Sử dụng JOIN FETCH để lấy luôn thông tin sản phẩm (giay)
            String hql = "SELECT ct FROM HoaDonChiTiet ct " +
                    "JOIN FETCH ct.giay " +
                    "WHERE ct.hoaDon.id = :hdId";
            return session.createQuery(hql, HoaDonChiTiet.class)
                    .setParameter("hdId", hoaDonId)
                    .list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Tổng doanh thu từ tất cả hóa đơn
    public double getTongDoanhThu() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            Double result = session.createQuery(
                    "SELECT SUM(h.tongTien) FROM HoaDon h", Double.class)
                    .uniqueResult();
            return result != null ? result : 0.0;
        }
    }

    // Top khách hàng theo tổng tiền đã mua
// Trả về List<Object[]> với [0]=tên, [1]=email, [2]=tổng tiền, [3]=số đơn
    public List<Object[]> getTopKhachHang() {
        try (Session session = HibernateConfig.getFACTORY().openSession()) {
            String hql = "SELECT kh.ten, kh.email, SUM(h.tongTien), COUNT(h.id) " +
                    "FROM HoaDon h JOIN h.khachHang kh " +
                    "GROUP BY kh.id, kh.ten, kh.email " +
                    "ORDER BY SUM(h.tongTien) DESC";
            return session.createQuery(hql, Object[].class)
                    .setMaxResults(10)  // ← THÊM DÒNG NÀY
                    .list();
        }
    }
}
