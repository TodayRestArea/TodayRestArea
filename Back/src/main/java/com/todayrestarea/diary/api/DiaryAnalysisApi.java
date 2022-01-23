package com.todayrestarea.diary.api;

import com.todayrestarea.common.dto.BaseException;
import com.todayrestarea.common.dto.ComResponseDto;
import com.todayrestarea.diary.model.DiaryAnalysis;
import com.todayrestarea.diary.model.DiaryRes;
import com.todayrestarea.diary.model.PostDiaryRequest;
import com.todayrestarea.diary.service.DiaryAnalysisService;
import com.todayrestarea.diary.service.DiaryService;
import com.todayrestarea.user.entity.User;
import com.todayrestarea.user.service.UserService;
import com.todayrestarea.user.util.jwt.JwtAuthTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

import static com.todayrestarea.common.ErrorCode.*;
import static com.todayrestarea.utils.ValidationRegex.isRegexDate;

@RequiredArgsConstructor
@RestController
@RequestMapping("/diarys")
public class DiaryAnalysisApi {

    final private DiaryService diaryService;
    final private DiaryAnalysisService diaryAnalysisService;
    final private UserService userService;
    final private JwtAuthTokenProvider jwtAuthTokenProvider;

    /**
     * 일기작성 API
     * [POST] /diarys
     */
    @PutMapping("/{id}/analysis")
    public ComResponseDto<DiaryAnalysis> createDiary(@RequestHeader("Authorization") String jwtToken,
                                                @PathVariable(value = "id") Long diaryId
    )throws Exception{
        try {
            // jwt 복호화 => user정보 얻기
            //  Long userId = jwtAuthTokenProvider.getPayload(jwtToken).getUserId();
            Optional<User> user = userService.findById(2l);

            // 유저가 존재하지 않음
            if (user.isEmpty())
                throw new BaseException(NOT_FOUND_USER_EXCEPTION);
            /**
             * TODO 여러 검증 및 (일기-사용자 매칭 검증)
             */
            DiaryAnalysis result = diaryAnalysisService.tempAnalyze(diaryId);

            return ComResponseDto.success(result);

        } catch (BaseException exception) {
            return ComResponseDto.error(exception.getErrorCode());
        } catch (Exception e) {
            e.printStackTrace();
            return ComResponseDto.error(BAD_REQUEST_EXCEPTION);
        }
    }

//    /**
//     * 일기상세 조회 API
//     * [GET] /diarys
//     */
//    @GetMapping("/{diaryIdx}/details")
//    public ComResponseDto<DiaryRes> getDiaryDetail(@PathVariable("diaryIdx") int diaryIdx){
//        // TODO : accessToken 복호화 => userIdx정보 얻기
//
////        try {
////
////
////        } catch (BaseException exception)
////        {
////            return ComResponseDto.error(exception.getErrorCode());
////        }
//
//    }
}
