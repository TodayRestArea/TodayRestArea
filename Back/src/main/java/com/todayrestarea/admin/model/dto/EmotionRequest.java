package com.todayrestarea.admin.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@RequiredArgsConstructor
public class EmotionRequest {
    final private String emotionName;
   // final private String emotionName2;
    // string 필드 하나만 존재하는경우 json 으로 스트링만 보내야 인식하는듯,,;; @윤태성

}
