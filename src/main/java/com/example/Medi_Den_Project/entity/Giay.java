package com.example.Medi_Den_Project.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;
import java.util.stream.Collectors;

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

    @Column(name = "gia")
    private Double gia;

    @Column(name = "thuong_hieu")
    private String thuongHieu;

    @Column(name = "hinh_anh")
    private String hinhAnh;

    @Column(name = "mo_ta")
    private String moTa;

    @ManyToOne
    @JoinColumn(name = "the_loai_id")
    private TheLoaiGiay theLoaiGiay;

    @OneToMany(mappedBy = "giay", fetch = FetchType.EAGER)
    private List<SizeGiay> listSize;

    @Transient
    public String getSizeString() {
        if (listSize == null || listSize.isEmpty()) return "";

        return listSize.stream()
                .map(s -> String.valueOf(s.getSoSize()))
                .collect(Collectors.joining(","));
    }

    @Transient
    public String getSizeIdString() {
        if (listSize == null || listSize.isEmpty()) return "";

        return listSize.stream()
                .map(s -> String.valueOf(s.getId()))
                .collect(Collectors.joining(","));
    }
    @Transient
    public String getSizeStockString() {
        if (listSize == null || listSize.isEmpty()) return "";
        return listSize.stream()
                .map(s -> String.valueOf(s.getSoLuong()))
                .collect(Collectors.joining(","));
    }
}
