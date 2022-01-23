package com.todayrestarea.diary.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DiaryAnalysis {
    private Date createdData;
    private Long emotionId;
    private String emotionName;

    private List<RecommendMusic> recommendMusics = new ArrayList<>();
    private List<RecommendMovie> recommendMovies = new ArrayList<>();

}
/***
 * {
 *     "createdDate": "string",
 *     "emotionId": "int",
 *     "recommendMusicList": [
 *       {
 *         "title": "string",
 *         "artist": "string",
 *         "poster": "string"
 *       }
 *     ],
 *     "recommendMovieList": [
 *       {
 *         "title": "string",
 *         "poster": "string",
 *         "url": "string"
 *       }
 *     ]
 *   }
 */