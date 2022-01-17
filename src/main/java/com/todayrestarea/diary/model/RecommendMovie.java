package com.todayrestarea.diary.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class RecommendMovie {
    private String title;
    private String posterUrl;
    private String infoUrl;
}