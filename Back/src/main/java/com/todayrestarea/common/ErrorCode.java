package com.todayrestarea.common;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {

    // Bad Request
    BAD_REQUEST_EXCEPTION(400, "잘못된 요청입니다"),
    BAD_REQUEST_MISSING_REQUIRED_VALUE_EXCEPTION(400,  "필수 값을 입력해주세요"),
    BAD_REQUEST_WRONG_FILE_EXTENSION_EXCEPTION(400,  "확장자가 없는 잘못된 파일의 형식입니다"),
    BAD_REQUEST_WRONG_EMAIL_FORMAT_EXCEPTION(400, "잘못된 이메일 포맷입니다"),
    BAD_REQUEST_WRONG_USER_DELETE_EXCEPTION(400, "잘못된 유저 삭제 요청입니다"),
    BAD_REQUEST_WRONG_DATE_FORMAT_EXCEPTION(400, "잘못된 날짜 포맷입니다"),
    BAD_REQUEST_PARAMS(400, "입력값을 확인해주세요"),
    BAD_REQUEST_WRONG_DATE(400, "미래의 일기는 쓸 수 없습니다"),

    // UnAuthorized
    UNAUTHORIZED_EXCEPTION(401,  "잘못된 토큰입니다. 다시 로그인해주세요"),
    TOKEN_EXPIRED_EXCEPTION(401,  "토큰이 만료되었습니다"),

    // Forbidden
    FORBIDDEN_EXCEPTION(403,  "허용되지 않은 접근입니다"),

    // NotFound
    NOT_FOUND_EXCEPTION(404, "존재하지 않습니다"),
    NOT_FOUND_USER_EXCEPTION(404,  "존재하지 않는 유저입니다"),
    NOT_FOUND_WEATHER_EXCEPTION(404,  "존재하지 않는 날씨입니다"),
    NOT_FOUND_DIARY_EXCEPTION(404,  "존재하지 않는 일기입니다"),

    // Method Not Allowed
    METHOD_NOT_ALLOWED_EXCEPTION(405,  "Method Not allowed"),
    DATE_PARSE_FAIL(405,  "데이터 파싱 오류"),

    // Conflict
    CONFLICT_EXCEPTION(409, "이미 존재합니다"),

    // Unsupported Media Type
    UNSUPPORTED_MEDIA_TYPE(415,  "Unsupported Media Type"),

    // Internal Server
    INTERNAL_SERVER_EXCEPTION(500, "서버 내부에서 에러가 발생하였습니다"),

    // Service Unavailable
    SERVICE_UNAVAILABLE_EXCEPTION(503, "점검중입니다"),
    ;

    private final Integer code;
    private final String message;
}
