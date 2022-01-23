package com.todayrestarea.admin.common.emotion;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class EmotionAnalysisResponse {
    private Long emotionId;
    private List<MovieApiDto> movieList=new ArrayList<>();
    private List<MusicApiDto> musicList=new ArrayList<>();
}
/**
 * {
 *     "emotionType": 5,
 *     "movieList": [
 *         {
 *             "director": "Todd Graff",
 *             "movieTitle": "Camp"
 *         },
 *         {
 *             "director": "Harold Ramis",
 *             "movieTitle": "Analyze This"
 *         },
 *         {
 *             "director": "Russell Mulcahy",
 *             "movieTitle": "Jules Verne's Mysterious Island"
 *         }
 *     ],
 *     "musicList": [
 *         {
 *             "musicTitle": "Falling in Love (Rework)",
 *             "singer": "Stevie King"
 *         },
 *         {
 *             "musicTitle": "Persistance",
 *             "singer": "Steve Ellington Band"
 *         },
 *         {
 *             "musicTitle": "Sequel",
 *             "singer": "Steve Ellington Band"
 *         }
 *     ]
 * }
 */