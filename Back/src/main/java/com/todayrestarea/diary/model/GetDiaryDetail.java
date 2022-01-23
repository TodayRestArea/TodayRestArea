package com.todayrestarea.diary.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class GetDiaryDetail {
    private Long emotionId;
    private Long weatherId;
    private String createdDate;
    private String contents;
}
