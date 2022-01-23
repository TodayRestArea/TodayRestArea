package com.todayrestarea.admin.model.entity;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@RequiredArgsConstructor
@Entity @Table(name="weather")
public class Weather {

    @Id @Column(name="weather_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long weatherId;

    @Column(name="weather")
    private String weather;

}
