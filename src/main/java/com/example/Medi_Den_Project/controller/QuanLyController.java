package com.example.Medi_Den_Project.controller;

import com.example.Medi_Den_Project.entity.*;
import com.example.Medi_Den_Project.repository.*;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,       // 1 MB — ghi thẳng vào disk nếu file lớn hơn
        maxFileSize       = 5 * 1024 * 1024,   // tối đa 5 MB / file
        maxRequestSize    = 10 * 1024 * 1024   // tối đa 10 MB / request
)
@WebServlet(name = "quanLyController", value = {
        "/danh-muc",
        "/danh-muc/search",
        "/danh-muc/add",
        "/danh-muc/update",
        "/danh-muc/delete",
        "/khach-hang",
        "/khach-hang/search",
        "/khach-hang/toggle",
        "/san-pham",
        "/san-pham/search",
        "/san-pham/add",
        "/san-pham/update",
        "/san-pham/delete",
        "/don-hang",
        "/don-hang/chi-tiet",
        "/don-hang/xac-nhan",
        "/trang-chu-admin",
        "/size-giay",
        "/thong-ke",
        "/cai-dat"
})
public class QuanLyController extends HttpServlet {

    TheLoaiGiayRepository theLoaiGiayRepository = new TheLoaiGiayRepository();
    KhachHangRepository   khachHangRepository   = new KhachHangRepository();
    GiayRepository giayRepository        = new GiayRepository();
    HoaDonRepository      hoaDonRepository      = new HoaDonRepository();
    SizeGiayRepository    sizeGiayRepository    = new SizeGiayRepository();
    TaiKhoanRepository taiKhoanRepository = new TaiKhoanRepository();

    Gson gson = new GsonBuilder()
            .excludeFieldsWithModifiers(java.lang.reflect.Modifier.TRANSIENT)
            .create();

    // Hàm kiểm tra tính hợp lệ của dữ liệu đầu vào
    private String validateSanPham(String ten, String thuongHieu) {
        if (ten == null || ten.trim().isEmpty()) return "Tên sản phẩm không được để trống!";
        if (thuongHieu == null || thuongHieu.trim().isEmpty()) return "Thương hiệu không được để trống!";

        return null; // Trả về null nếu mọi thứ đều hợp lệ
    }

    // ─────────────────────────────────────────────────────────────────────────
    // GET
    // ─────────────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        if (uri.contains("danh-muc/delete")) { dmXoa(req, resp); return; }

        if (uri.contains("san-pham/delete"))  { spXoa(req, resp);    return; }

        if (uri.contains("khach-hang/toggle")) { khToggle(req, resp); return; }

        if (uri.contains("danh-muc/search")) { dmTim(req, resp); return; }

        if (uri.contains("khach-hang/search")) { khTim(req, resp); return; }

        if (uri.contains("san-pham/search")) { spTim(req, resp); return; }

        if (uri.contains("don-hang/chi-tiet")) {
            hdChiTiet(req, resp);
            return;
        }
        if (uri.contains("don-hang/xac-nhan")) {
            hdXacNhan(req, resp);
            return;
        }

        if (uri.contains("danh-muc")) {
            dmhienThi(req, resp);
        } else if (uri.contains("khach-hang")) {
            khhienThi(req, resp);
        } else if (uri.contains("san-pham")) {
            String action = req.getParameter("action");
            if ("getSizes".equals(action)) {
                spGetSizes(req, resp);
            } else {
                sphienThi(req, resp);
            }
        } else if (uri.contains("don-hang")) {
            hdhienThi(req, resp);
        } else if (uri.contains("trang-chu-admin")) {
            trangChuAdmin(req, resp);
        } else if (uri.contains("size-giay")) {
            spGetSizes(req, resp);
        }else if (uri.contains("cai-dat")) {
            hienthiCaiDat(req, resp);
        } else if (uri.contains("thong-ke")) {
            thongKe(req, resp);
        }
    }

    private void thongKe(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Lấy dữ liệu thống kê cơ bản
        long tongKhachHang = khachHangRepository.getAll().size();
        long tongSanPham   = giayRepository.getAll().size();
        long tongDonHang   = hoaDonRepository.getAll().size();

        // Doanh thu (demo - sau này sẽ query thật từ HoaDon)
        double doanhThuThang = 248500000; // 248.5 triệu (bạn có thể thay bằng query sau)

        req.setAttribute("tongKhachHang", tongKhachHang);
        req.setAttribute("tongSanPham", tongSanPham);
        req.setAttribute("tongDonHang", tongDonHang);
        req.setAttribute("doanhThuThang", doanhThuThang);

        req.getRequestDispatcher("/quan-ly/thong-ke.jsp").forward(req, resp);
    }

    private void hienthiCaiDat(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("listTaiKhoan",taiKhoanRepository.getAll());
        req.getRequestDispatcher("/quan-ly/cai-dat.jsp").forward(req, resp);
    }

    private void spTim(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("searchKeywordSp");
        List<Giay> list;

        if (keyword != null && !keyword.trim().isEmpty()) {
            list = giayRepository.searchByNameAdmin(keyword.trim());
            req.setAttribute("searchKeywordSp", keyword);
        } else {
            list = giayRepository.getAll();
        }

        req.setAttribute("listSanPham", list);
        req.setAttribute("listDanhMuc", theLoaiGiayRepository.getAll()); // Vẫn cần list danh mục cho modal thêm/sửa
        req.getRequestDispatcher("/quan-ly/san-pham.jsp").forward(req, resp);
    }

    private void khTim(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("searchKeywordKh");
        List<KhachHang> list;

        if (keyword != null && !keyword.trim().isEmpty()) {
            // Nếu có nhập từ khóa -> Tìm kiếm
            list = khachHangRepository.searchByTen(keyword.trim());
            req.setAttribute("searchKeywordKh", keyword); // Gửi lại để hiển thị trên ô input
        } else {
            // Nếu không -> Lấy tất cả
            list = khachHangRepository.getAll();
        }

        req.setAttribute("listKhachHang", list);
        req.getRequestDispatcher("/quan-ly/khach-hang.jsp").forward(req, resp);
    }

    private void dmTim(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("searchKeywordDm");
        List<TheLoaiGiay> list;

        // Kiểm tra nếu người dùng có nhập từ khóa
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = theLoaiGiayRepository.searchByTen(keyword.trim());
            // Gửi lại keyword để ô input không bị trống sau khi load trang
            req.setAttribute("searchKeywordDm", keyword);
        } else {
            list = theLoaiGiayRepository.getAll();
        }

        req.setAttribute("listTheLoai", list);
        req.getRequestDispatcher("/quan-ly/danh-muc.jsp").forward(req, resp);
    }

    private void khToggle(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));

            // Bước 1: đảo trangThai KhachHang, nhận trạng thái MỚI
            boolean trangThaiMoi = khachHangRepository.toggleTrangThai(id);

            // Bước 2: áp trạng thái đó sang tất cả TaiKhoan của khách hàng này
            taiKhoanRepository.capNhatTrangThaiTheoKhachHang(id, trangThaiMoi);

        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/khach-hang");
    }

    // ─────────────────────────────────────────────────────────────────────────
    // POST
    // ─────────────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.contains("danh-muc/add")) {
            dmThem(req, resp);
        } else if (uri.contains("danh-muc/update")) {
            dmSua(req, resp);
        } else if (uri.contains("san-pham/add")) {
            spThem(req, resp);
        } else if (uri.contains("san-pham/update")) {
            spSua(req, resp);
        } else if (uri.contains("size-giay")) {
            String action = req.getParameter("action");
            switch (action) {
                case "them"    -> spThemSize(req, resp);
                case "capNhat" -> spCapNhatSize(req, resp);
                case "xoa"     -> spXoaSize(req, resp);
            }
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // SẢN PHẨM — hiển thị
    // ─────────────────────────────────────────────────────────────────────────
    private void sphienThi(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<Giay> list = giayRepository.getAll();
            req.setAttribute("listSanPham", list);
            req.setAttribute("listDanhMuc", theLoaiGiayRepository.getAll());
            req.getRequestDispatcher("/quan-ly/san-pham.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // SẢN PHẨM — thêm
    // ─────────────────────────────────────────────────────────────────────────
    private void spThem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String ten        = req.getParameter("ten");
            String thuongHieu = req.getParameter("thuongHieu");
            Double gia        = Double.parseDouble(req.getParameter("gia"));
            int    danhMucId  = Integer.parseInt(req.getParameter("danhMucId"));

            // Thực hiện validate
            String error = validateSanPham(ten, thuongHieu);

            if (error != null) {
                req.setAttribute("errorMessage", error);
                sphienThi(req, resp); // Quay lại trang hiển thị với thông báo lỗi
                return;
            }

            TheLoaiGiay theLoai = theLoaiGiayRepository.getById(danhMucId);

            Giay giay = new Giay();
            giay.setTenGiay(ten);
            giay.setThuongHieu(thuongHieu);
            giay.setGia(gia);
            giay.setTheLoaiGiay(theLoai);

            // Xử lý upload hình ảnh
            String tenFile = xuLyUploadAnh(req, "hinhAnh");
            if (tenFile != null) giay.setHinhAnh(tenFile);

            giayRepository.them(giay);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/san-pham?error=true");
        }
        resp.sendRedirect(req.getContextPath() + "/san-pham");
    }

    // ─────────────────────────────────────────────────────────────────────────
    // SẢN PHẨM — sửa
    // ─────────────────────────────────────────────────────────────────────────
    private void spSua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int    id         = Integer.parseInt(req.getParameter("id"));
            String ten        = req.getParameter("ten");
            String thuongHieu = req.getParameter("thuongHieu");
            Double gia        = Double.parseDouble(req.getParameter("gia"));
            int    danhMucId  = Integer.parseInt(req.getParameter("danhMucId"));

            // Thực hiện validate
            String error = validateSanPham(ten, thuongHieu);

            if (error != null) {
                req.setAttribute("errorMessage", error);
                sphienThi(req, resp); // Quay lại trang hiển thị với thông báo lỗi
                return;
            }

            Giay giay = giayRepository.getById(id);
            if (giay == null) { resp.sendError(404); return; }

            TheLoaiGiay theLoai = theLoaiGiayRepository.getById(danhMucId);
            giay.setTenGiay(ten);
            giay.setThuongHieu(thuongHieu);
            giay.setGia(gia);
            giay.setTheLoaiGiay(theLoai);

            // Chỉ cập nhật ảnh nếu người dùng chọn ảnh mới
            String tenFile = xuLyUploadAnh(req, "hinhAnh");
            if (tenFile != null) giay.setHinhAnh(tenFile);

            giayRepository.sua(giay);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/san-pham");
    }

    // ─────────────────────────────────────────────────────────────────────────
    // SẢN PHẨM — xóa  (GET: /san-pham/delete?id=...)
    // ─────────────────────────────────────────────────────────────────────────
    private void spXoa(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));

            // 1. Xóa tất cả các size thuộc về sản phẩm này trước
            sizeGiayRepository.xoaTatCaSizeCuaGiay(id); // Bạn cần viết thêm hàm này trong Repository

            // 2. Sau đó mới xóa sản phẩm
            boolean ok = giayRepository.xoa(id);

            if (!ok) System.out.println(">>> Không tìm thấy sản phẩm id=" + id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/san-pham");
    }

    // ─────────────────────────────────────────────────────────────────────────
    // Upload helper — trả về tên file đã lưu, hoặc null nếu không có file
    // ─────────────────────────────────────────────────────────────────────────
    private String xuLyUploadAnh(HttpServletRequest req, String fieldName) {
        try {
            Part part = req.getPart(fieldName);
            if (part == null || part.getSize() == 0) return null;

            String fileName = part.getSubmittedFileName();
            if (fileName == null || fileName.isBlank()) return null;

            // Thư mục lưu ảnh: webapp/images/
            String uploadDir = getServletContext().getRealPath("/images");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            String savePath = uploadDir + File.separator + fileName;
            part.write(savePath);

            // Trả về đường dẫn tương đối để lưu vào DB
            return req.getContextPath() + "/images/" + fileName;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // SIZE
    // ─────────────────────────────────────────────────────────────────────────
    private void spGetSizes(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int giayId = Integer.parseInt(req.getParameter("giayId"));
        List<SizeGiay> list = sizeGiayRepository.getByGiayId(giayId);

        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            SizeGiay s = list.get(i);
            if (i > 0) sb.append(",");
            sb.append("{")
                    .append("\"id\":").append(s.getId()).append(",")
                    .append("\"soSize\":").append(s.getSoSize()).append(",")
                    .append("\"soLuong\":").append(s.getSoLuong())
                    .append("}");
        }
        sb.append("]");

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(sb.toString());
    }

    private void spThemSize(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int giayId  = Integer.parseInt(req.getParameter("giayId"));
            int soSize  = Integer.parseInt(req.getParameter("soSize"));
            int soLuong = Integer.parseInt(req.getParameter("soLuong"));

            Giay giay = giayRepository.getById(giayId);
            if (giay == null) { resp.sendError(404); return; }

            SizeGiay size = new SizeGiay();
            size.setGiay(giay);
            size.setSoSize(soSize);
            size.setSoLuong(soLuong);
            sizeGiayRepository.them(size);

            resp.setContentType("text/plain");
            resp.getWriter().write("OK");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

    private void spCapNhatSize(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int sizeId  = Integer.parseInt(req.getParameter("sizeId"));
            int soLuong = Integer.parseInt(req.getParameter("soLuong"));

            SizeGiay size = sizeGiayRepository.getById(sizeId);
            if (size == null) { resp.sendError(404); return; }

            size.setSoLuong(soLuong);
            sizeGiayRepository.capNhat(size);

            resp.setContentType("text/plain");
            resp.getWriter().write("OK");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

    private void spXoaSize(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int sizeId = Integer.parseInt(req.getParameter("sizeId"));
            boolean ok = sizeGiayRepository.xoa(sizeId);
            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(ok ? "OK" : "ERROR_FK");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // DANH MỤC
    // ─────────────────────────────────────────────────────────────────────────
    private void dmhienThi(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("listTheLoai", theLoaiGiayRepository.getAll());
        req.getRequestDispatcher("/quan-ly/danh-muc.jsp").forward(req, resp);
    }

    private void dmThem(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String ten = req.getParameter("tenTheLoai");

        // Kiểm tra trống hoặc chỉ có khoảng trắng
        if (ten == null || ten.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Tên danh mục không được để trống!");
            dmhienThi(req, resp); // Quay lại trang hiển thị để hiện thông báo lỗi
            return;
        }

        TheLoaiGiay tlg = new TheLoaiGiay();
        tlg.setTenTheLoai(ten.trim());
        theLoaiGiayRepository.themTheLoai(tlg);
        resp.sendRedirect(req.getContextPath() + "/danh-muc");
    }

    private void dmXoa(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idStr = req.getParameter("id");
            if (idStr != null) theLoaiGiayRepository.xoaTheLoai(Integer.parseInt(idStr));
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/danh-muc");
    }

    private void dmSua(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idStr = req.getParameter("id");
            String tenMoi = req.getParameter("tenTheLoai");

            // Kiểm tra trống
            if (tenMoi == null || tenMoi.trim().isEmpty()) {
                req.setAttribute("errorMessage", "Tên danh mục cập nhật không được để trống!");
                dmhienThi(req, resp);
                return;
            }

            Integer id = Integer.parseInt(idStr);
            TheLoaiGiay tlg = theLoaiGiayRepository.getById(id);
            if (tlg != null) {
                tlg.setTenTheLoai(tenMoi.trim());
                theLoaiGiayRepository.suaTheLoai(tlg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/danh-muc");
    }

    // ─────────────────────────────────────────────────────────────────────────
    // KHÁCH HÀNG / ĐƠN HÀNG / TRANG CHỦ
    // ─────────────────────────────────────────────────────────────────────────
    private void khhienThi(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("listKhachHang", khachHangRepository.getAll());
        req.getRequestDispatcher("/quan-ly/khach-hang.jsp").forward(req, resp);
    }

    private void hdhienThi(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("listHoaDon", hoaDonRepository.getAll());
        req.getRequestDispatcher("/quan-ly/don-hang.jsp").forward(req, resp);
    }

    private void trangChuAdmin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/quan-ly/trang-chu-admin.jsp").forward(req, resp);
    }

    private void hdChiTiet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Integer id = Integer.parseInt(req.getParameter("id"));

            // 1. Lấy thông tin hóa đơn
            req.setAttribute("hoaDon", hoaDonRepository.getById(id));

            // 2. Lấy danh sách sản phẩm (Chi tiết hóa đơn)
            // Lưu ý: Bạn cần đảm bảo trong HoaDonRepository đã có hàm getChiTietByHoaDonId
            req.setAttribute("dsChiTiet", hoaDonRepository.getChiTietByHoaDonId(id));

            req.getRequestDispatcher("/quan-ly/chi-tiet-don-hang.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/don-hang");
        }
    }

    private void hdXacNhan(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Integer id = Integer.parseInt(req.getParameter("id"));
            hoaDonRepository.updateTrangThai(id, "Đã xác nhận");
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect(req.getContextPath() + "/don-hang");
    }
}