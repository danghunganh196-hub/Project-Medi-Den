package com.example.Medi_Den_Project.entity;
import jakarta.persistence.*;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "khach_hang")
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ma")
    private String ma;

    @Column(name = "ten")
    private String ten;

    @Column(name = "gioi_tinh")
    private Boolean gioiTinh;

    @Column(name = "tuoi")
    private Integer tuoi;

    @Column(name = "dia_chi")
    private String diaChi;

    @Column(name = "email")
    private String email;

    @Column(name = "mat_khau")
    private String matKhau;
}
