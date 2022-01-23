package com.todayrestarea.admin.model.dto;

import com.todayrestarea.admin.model.entity.Emotion;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class EmotionResponse {
    private List<EmotionDto> emotionListDto=new ArrayList<>();
    public EmotionResponse(List<Emotion> emotionList) {
        for (Emotion emotion:emotionList){
            MusicListResponse musicListResponse = new MusicListResponse(emotion.getMusics());

            EmotionDto emotionDto=new EmotionDto(
                    emotion.getEmotionId(),
                    emotion.getEmotionName()
            );
            this.emotionListDto.add(emotionDto);
        }
    }
}
@Getter
@Setter
@AllArgsConstructor
class EmotionDto{
    private Long emotionId;
    private String emotionName;
}