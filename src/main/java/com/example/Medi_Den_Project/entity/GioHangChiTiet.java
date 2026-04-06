package com.example.Medi_Den_Project.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name = "gio_hang_chi_tiet",
        uniqueConstraints = @UniqueConstraint(columnNames = {"gio_hang_id", "giay_id", "size_id"}))
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GioHangChiTiet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "so_luong", nullable = false)
    private Integer soLuong;

    @Column(name = "don_gia", nullable = false)
    private BigDecimal donGia;

    // =========================
    // RELATION
    // =========================

    @ManyToOne
    @JoinColumn(name = "gio_hang_id", nullable = false)
    private GioHang gioHang;

    @ManyToOne
    @JoinColumn(name = "giay_id", nullable = false)
    private Giay giay;

    @ManyToOne
    @JoinColumn(name = "size_id", nullable = false)
    private SizeGiay sizeGiay;
}