package com.todayrestarea.admin.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
public class MovieRequest {
    final private String movieTitle;
    final private String movieDirector;
    final private Long emotionId;
}
