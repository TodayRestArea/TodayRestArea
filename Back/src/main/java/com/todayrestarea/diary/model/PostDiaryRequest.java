package com.todayrestarea.diary.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PostDiaryRequest {
    @NotNull(message = "weatherId를 입력해주세요")
    private Long weatherId;

    @NotNull(message = "contents를 입력해주세요")
    @NotEmpty
    private String contents;

    @NotNull(message = "createdDate를 입력해주세요")
    @Pattern(regexp = "^([12]\\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\\d|3[01]))$",message = "날짜형식을 확인해주세요")
    private String createdDate; //2021-01-14 형식
}

