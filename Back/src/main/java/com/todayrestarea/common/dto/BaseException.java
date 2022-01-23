package com.todayrestarea.common.dto;

import com.todayrestarea.common.ErrorCode;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class BaseException extends Exception {
    private ErrorCode errorCode;
}