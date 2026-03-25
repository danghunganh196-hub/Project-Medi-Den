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
@Table(name = "chi_tiet_hoa_don")
public class HoaDonChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "so_luong")
    private Integer soLuong;

    @Column(name = "don_gia")
    private Double donGia;

    @Column(name = "thanh_tien")
    private Double thanhTien;

    @ManyToOne
    @JoinColumn(name = "hoa_don_id",referencedColumnName = "id")
    private HoaDon hoaDon;
    @ManyToOne
    @JoinColumn(name = "giay_id",referencedColumnName = "id")
    private Giay giay;
}
