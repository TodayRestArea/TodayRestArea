package com.todayrestarea.diary.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Date;

@Getter
@AllArgsConstructor
public class DiaryListRes {
    private Long diaryId;
    private Date createdDate;
    private Long emotionId;

    public static DiaryListRes of(Long diaryId, Date createdDate, Long emotionId) {
        return new DiaryListRes(diaryId, createdDate, emotionId);
    }
}
