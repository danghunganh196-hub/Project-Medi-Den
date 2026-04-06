package com.example.Medi_Den_Project.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "gio_hang")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GioHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    // 1 khách hàng = 1 giỏ hàng
    @OneToOne
    @JoinColumn(name = "khach_hang_id", nullable = false, unique = true)
    private KhachHang khachHang;

    @Column(name = "ngay_tao", nullable = false, updatable = false)
    private LocalDateTime ngayTao = LocalDateTime.now();

    @Column(name = "tong_tien", nullable = false)
    private BigDecimal tongTien = BigDecimal.ZERO;

    // Danh sách sản phẩm trong giỏ
    @OneToMany(mappedBy = "gioHang", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<GioHangChiTiet> chiTietList = new ArrayList<>();}