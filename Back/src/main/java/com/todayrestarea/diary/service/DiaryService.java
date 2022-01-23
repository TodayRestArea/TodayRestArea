package com.todayrestarea.diary.service;


import com.todayrestarea.common.dto.BaseException;
import com.todayrestarea.diary.entity.Diary;
import com.todayrestarea.diary.model.*;

import java.util.Date;
import java.util.List;

public interface DiaryService {
    Diary createDiary(Long userId, Date date, PostDiaryRequest postDiaryRequest) throws BaseException;
    Diary updateDiary(Long diaryId, Long userId, PutDiaryRequest putDiaryRequest) throws BaseException;
    GetDiaryDetail getDiaryDetail(Long diaryId,Long userId) throws BaseException;
    DiaryRes deleteDiary(Long diaryId,Long userId) throws BaseException;
    List<DiaryListRes> getDiaryList(Long userId, String yearMonth);
}
