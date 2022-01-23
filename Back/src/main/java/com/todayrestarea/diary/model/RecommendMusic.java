package com.todayrestarea.diary.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class RecommendMusic{
    private String title;
    private String artist;
    private String posterUrl;
    private String infoUrl;
}