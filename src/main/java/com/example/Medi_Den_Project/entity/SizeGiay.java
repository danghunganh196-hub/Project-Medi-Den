package com.example.Medi_Den_Project.entity;

import com.google.gson.annotations.Expose;
import jakarta.persistence.*;
import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "size_giay")
public class SizeGiay {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "so_size")
    private Integer soSize;

    @Column(name = "so_luong")
    private Integer soLuong;

    @ManyToOne
    @JoinColumn(name = "giay_id")
    private Giay giay;
}
