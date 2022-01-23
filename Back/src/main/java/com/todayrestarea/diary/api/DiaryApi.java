package com.todayrestarea.diary.api;


import com.todayrestarea.diary.model.*;
import com.todayrestarea.diary.entity.Diary;
import com.todayrestarea.diary.service.DiaryService;
import com.todayrestarea.user.util.jwt.JwtAuthTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import com.todayrestarea.common.dto.ComResponseDto;

import java.util.List;
import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.todayrestarea.common.dto.BaseException;
import static com.todayrestarea.common.ErrorCode.*;

@RequiredArgsConstructor
@RestController
@RequestMapping("/diarys")
public class DiaryApi {

    final private DiaryService diaryService;
    final private JwtAuthTokenProvider jwtAuthTokenProvider;
    final private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

    /**
     * 일기작성 API
     * [POST] /diarys
     */
    @PostMapping("")
    public ComResponseDto<DiaryRes> createDiary(@RequestHeader("Authorization") String jwtToken, @Valid @RequestBody PostDiaryRequest postDiaryRequest, BindingResult bindingResult){
        try {
            // jwt 복호화 => user정보 얻기
            Long userId = jwtAuthTokenProvider.getPayload(jwtToken).getUserId();

            if (bindingResult.hasErrors())
                throw new BaseException(BAD_REQUEST_PARAMS);

            //date validate
            Date date = format.parse(postDiaryRequest.getCreatedDate());
            Date today = new Date();
            if (date.after(today))
                throw new BaseException(BAD_REQUEST_WRONG_DATE);

            // 일기 생성
            Diary diary = diaryService.createDiary(userId, date, postDiaryRequest);
            DiaryRes  diaryRes = new DiaryRes(diary.getDiaryId());
            return ComResponseDto.success(diaryRes);

        } catch (BaseException exception)
        {
            return ComResponseDto.error(exception.getErrorCode());
        } catch (ParseException exception)
        {
            return ComResponseDto.error(DATE_PARSE_FAIL);
        }
    }

    /**
     * 일기 수정 API
     * [PUT] /diarys/{diaryId}
     */
    @PutMapping("/{diaryId}")
    public ComResponseDto<DiaryRes> updateDiary(@RequestHeader("Authorization") String jwtToken, @PathVariable("diaryId") Long diaryId,
                                                @Valid @RequestBody PutDiaryRequest putDiaryRequest, BindingResult bindingResult){
        try {
            // jwt 복호화 => user정보 얻기
            Long userId = jwtAuthTokenProvider.getPayload(jwtToken).getUserId();

            if (bindingResult.hasErrors())
                throw new BaseException(BAD_REQUEST_PARAMS);

            // 일기 수정
            Diary diary = diaryService.updateDiary(diaryId, userId, putDiaryRequest);
            DiaryRes  diaryRes = new DiaryRes(diary.getDiaryId());
            return ComResponseDto.success(diaryRes);

        } catch (BaseException exception)
        {
            return ComResponseDto.error(exception.getErrorCode());
        }
    }

    /**
     * 일기상세 조회 API
     * [GET] /diarys/{diaryId}/details
     */
    @GetMapping("/{diaryId}/details")
    public ComResponseDto<GetDiaryDetail> getDiaryDetail(@RequestHeader("Authorization") String jwtToken, @PathVariable("diaryId") Long diaryId){
        try {
            // jwt 복호화 => user정보 얻기
            Long userId = jwtAuthTokenProvider.getPayload(jwtToken).getUserId();

            // 일기 수정
            GetDiaryDetail diaryDetailRes = diaryService.getDiaryDetail(diaryId, userId);
            return ComResponseDto.success(diaryDetailRes);
        } catch (BaseException exception)
        {
            return ComResponseDto.error(exception.getErrorCode());
        }
    }

    /**
     * 일기 삭제 API
     * [DELETE] /diarys/{diaryId}
     */
    @DeleteMapping("/{diaryId}")
    public ComResponseDto<DiaryRes> deleteDiary(@RequestHeader("Authorization") String jwtToken, @PathVariable("diaryId") Long diaryId){
        try {
            // jwt 복호화 => user정보 얻기
            Long userId = jwtAuthTokenProvider.getPayload(jwtToken).getUserId();

            // 일기 수정
            DiaryRes deleteDiaryRes = diaryService.deleteDiary(diaryId, userId);
            return ComResponseDto.success(deleteDiaryRes);
        } catch (BaseException exception)
        {
            return ComResponseDto.error(exception.getErrorCode());
        }
    }

    /**
     * 일기 월별 조회 API
     * [GET] /diarys
     */
    @GetMapping("/{year-month}")
    public ComResponseDto<List<DiaryListRes>> getDiaryList(@RequestHeader("Authorization") String jwtToken, @PathVariable("year-month") String yearMonth){
        try {
            // jwt 복호화 => user정보 얻기
            Long userId = jwtAuthTokenProvider.getPayload(jwtToken).getUserId();

            // 일기 리스트 생성
            List<DiaryListRes> diaryList = diaryService.getDiaryList(userId, yearMonth);
            return ComResponseDto.success(diaryList);

        } catch (BaseException exception)
        {
            return ComResponseDto.error(exception.getErrorCode());
        }
    }
}

