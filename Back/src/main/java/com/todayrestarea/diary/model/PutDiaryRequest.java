package com.todayrestarea.diary.model;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PutDiaryRequest {
    @NotNull(message = "weatherId를 입력해주세요")
    private Long weatherId;

    @NotNull(message = "contents를 입력해주세요")
    @NotEmpty
    private String contents;
}
