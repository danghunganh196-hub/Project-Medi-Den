package com.example.Medi_Den_Project.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "hoa_don")
public class HoaDon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ngay_dat")
    private LocalDate ngayDat;

    @Column(name = "tong_tien")
    private Double tongTien;

    @Column(name = "trang_thai")
    private String trangThai;

    @Column(name = "dia_chi_giao")
    private String diaChi;

    @Column(name = "ghi_chu")
    private String ghiChu;

    @ManyToOne
    @JoinColumn(name = "khach_hang_id",referencedColumnName = "id")
    private KhachHang khachHang;
}
