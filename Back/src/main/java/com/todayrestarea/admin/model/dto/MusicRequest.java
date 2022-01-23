package com.todayrestarea.admin.model.dto;

import lombok.*;

@Getter
@Setter
@RequiredArgsConstructor
public class MusicRequest {
    final private String musicTitle;
    final private String musicArtist;
    final private Long emotionId;
}
