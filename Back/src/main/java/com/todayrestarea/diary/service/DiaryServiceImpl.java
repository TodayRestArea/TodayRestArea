package com.todayrestarea.diary.service;


import com.todayrestarea.diary.entity.Diary;
import com.todayrestarea.diary.model.*;
import com.todayrestarea.admin.model.entity.Emotion;
import com.todayrestarea.admin.model.entity.Weather;

import com.todayrestarea.common.dto.BaseException;
import com.todayrestarea.user.entity.User;
import com.todayrestarea.user.repository.UserRepository;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import com.todayrestarea.admin.repository.JpaEmotionRepository;
import com.todayrestarea.admin.repository.WeatherRepository;
import com.todayrestarea.diary.repository.DiaryRepository;


import java.util.ArrayList;
import java.util.List;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

import static com.todayrestarea.common.ErrorCode.*;


@Getter
@Setter
@Service
@RequiredArgsConstructor
public class DiaryServiceImpl implements DiaryService{

    final private DiaryRepository diaryRepository;
    final private UserRepository userRepository;
    final private WeatherRepository weatherRepository;
    final private JpaEmotionRepository emotionRepository;
    final private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

    public Diary createDiary(Long userId, Date date, PostDiaryRequest postDiaryRequest) throws BaseException{
        Optional<User> user = userRepository.findById(userId);
        Optional<Weather> weather = weatherRepository.findById(postDiaryRequest.getWeatherId());
        Optional<Emotion> emotion = emotionRepository.findById(0L);

        if (user.isEmpty())
            throw new BaseException(NOT_FOUND_USER_EXCEPTION);
        if (weather.isEmpty())
            throw new BaseException(NOT_FOUND_WEATHER_EXCEPTION);

        Diary diary = new Diary();
        diary.setCreatedDate(date);
        diary.setContents(postDiaryRequest.getContents());
        diary.setWriter(user.get());
        diary.setWeather(weather.get());
        diary.setEmotion(emotion.get());
        diaryRepository.save(diary);

        return diary;
    }

    public Diary updateDiary(Long diaryId, Long userId, PutDiaryRequest putDiaryRequest) throws BaseException{
        Optional<User> user = userRepository.findById(userId);
        Optional<Weather> weather = weatherRepository.findById(putDiaryRequest.getWeatherId());
        Optional<Emotion> emotion = emotionRepository.findById(0L);
        Optional<Diary> diary = diaryRepository.findById(diaryId);

        if (user.isEmpty())
            throw new BaseException(NOT_FOUND_USER_EXCEPTION);
        if (diary.isEmpty())
            throw new BaseException(NOT_FOUND_DIARY_EXCEPTION);
        if (weather.isEmpty())
            throw new BaseException(NOT_FOUND_WEATHER_EXCEPTION);
        if (user.get() != diary.get().getWriter())
            throw new BaseException(FORBIDDEN_EXCEPTION);

        diary.get().setContents(putDiaryRequest.getContents());
        diary.get().setWeather(weather.get());
        diary.get().setEmotion(emotion.get());
        diaryRepository.save(diary.get());
        return diary.get();
    }

    public GetDiaryDetail getDiaryDetail(Long diaryId, Long userId) throws BaseException{

        Optional<User> user = userRepository.findById(userId);
        Optional<Diary> diary = diaryRepository.findById(diaryId);

        if (user.isEmpty())
            throw new BaseException(NOT_FOUND_USER_EXCEPTION);
        if (diary.isEmpty())
            throw new BaseException(NOT_FOUND_DIARY_EXCEPTION);
        if (user.get() != diary.get().getWriter())
            throw new BaseException(FORBIDDEN_EXCEPTION);
        String date = format.format(diary.get().getCreatedDate());

        return new GetDiaryDetail(diary.get().getEmotion().getEmotionId(), diary.get().getWeather().getWeatherId(),
                date,diary.get().getContents());
    }

    public DiaryRes deleteDiary(Long diaryId, Long userId) throws BaseException{
        Optional<User> user = userRepository.findById(userId);
        Optional<Diary> diary = diaryRepository.findById(diaryId);

        if (user.isEmpty())
            throw new BaseException(NOT_FOUND_USER_EXCEPTION);
        if (diary.isEmpty())
            throw new BaseException(NOT_FOUND_DIARY_EXCEPTION);
        if (user.get() != diary.get().getWriter())
            throw new BaseException(FORBIDDEN_EXCEPTION);

        DiaryRes deleteDiaryRes = new DiaryRes(diary.get().getDiaryId());
        diaryRepository.delete(diary.get());
        return deleteDiaryRes;
    }

    @Override
    public List<DiaryListRes> getDiaryList(Long userId, String yearMonth) {

        List<Diary> diaryList = diaryRepository.findDiariesByCreatedDate(userId, yearMonth);
        List<DiaryListRes> diaryResList = new ArrayList<DiaryListRes>();

        for (Diary diary : diaryList) {
            diaryResList.add(DiaryListRes.of(diary.getDiaryId(), diary.getCreatedDate(), diary.getEmotion().getEmotionId()));
        }

        return diaryResList;

    }



}
