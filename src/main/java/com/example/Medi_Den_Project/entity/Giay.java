package com.example.Medi_Den_Project.entity;
import jakarta.persistence.*;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "Giay")
public class Giay {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ten_giay")
    private String tenGiay;

    @Column(name = "the_loai")
    private Boolean theLoai;

    @Column(name = "gia")
    private Double gia;

    @Column(name = "size")
    private Integer size;

    @Column(name = "thuong_hieu")
    private String thuongHieu;

    @Column(name = "so_luong")
    private Integer soLuong;

    @Column(name = "mo_ta")
    private String moTa;

    @Column(name = "hinh_anh")
    private String hinhAnh;
}
