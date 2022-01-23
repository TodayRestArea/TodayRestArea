package com.todayrestarea.common.dto;

import com.todayrestarea.common.ErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ComResponseDto <T>{
    private Boolean isSuccess;
    private Integer code;
    private String message;
    private T result;

    public static <T> ComResponseDto<T> success(T result) {
        return new ComResponseDto<>(true, 200,"성공", result);
    }

    public static <T> ComResponseDto<T> error(ErrorCode errorCode) {
        return new ComResponseDto<>(false, errorCode.getCode(), errorCode.getMessage(), null);
    }
}
