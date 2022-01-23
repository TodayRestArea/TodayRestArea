package com.todayrestarea.admin.model.dto;

import com.todayrestarea.admin.model.entity.Music;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class MusicListResponse {
    private List<MusicDto> dtoList=new ArrayList<>();
    public MusicListResponse(List<Music> musicList) {
        for (Music music : musicList) {
            MusicDto musicItem=new MusicDto(
                    music.getMusicId(),
                   (music.getEmotion()==null?0: music.getEmotion().getEmotionId()),
                  //  (music.getEmotion()==null?"none": music.getEmotion().getEmotionName()),
                    music.getTitle(),
                    music.getArtist(),
                    music.getPosterUrl(),
                    music.getInfoUrl()
            );
            this.dtoList.add(musicItem);
            System.out.println("musicItem = " + musicItem);
        }
    }
}

@Getter
@Setter
@AllArgsConstructor
class MusicDto {
    private Long musicId;
    private Long emotionId;
 //   private String emotionName;
    private String title;
    private String artist;
    private String posterUrl;
    private String infoUrl;
}
/**
 *  			"emotionId" : int,
 * 			"musicId" : int,
 * 			"title" : string,
 * 			"artist" : string,
 * 			"posterUrl" : string,
 * 			"infoUrl" : string,
 */