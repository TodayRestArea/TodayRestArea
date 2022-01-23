package com.todayrestarea.admin.common.music;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;
@Getter
@Setter
@ToString
@RequiredArgsConstructor
public class MusicInfoResponse{
    final private String name;
    final private String artist;
    final private String url;
    final private List<PosterImage> posterImage;
    public String getPosterUrl(){
        if (posterImage.size() == 0) {
            return "https://~";
        }else if(posterImage.size()<2){
            return posterImage.get(0).getText();
        }else{
            return posterImage.get(1).getText();
        }
    }
}

