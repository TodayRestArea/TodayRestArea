package com.todayrestarea.admin.model.dto;

import com.todayrestarea.admin.model.entity.Movie;
import com.todayrestarea.admin.model.entity.Music;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class MovieListResponse {
    private List<MovieDto> dtoList=new ArrayList<>();
    public MovieListResponse(List<Movie> movieList) {
        for (Movie movie : movieList) {
            MovieDto movieItem=new MovieDto(
                    movie.getMovieId(),
                   (movie.getEmotion()==null?0: movie.getEmotion().getEmotionId()),
                  //  (music.getEmotion()==null?"none": music.getEmotion().getEmotionName()),
                    movie.getTitle(),
                    movie.getDirector(),
                    movie.getPlot(),
                    movie.getPosterUrl(),
                    movie.getInfoUrl()
            );
            this.dtoList.add(movieItem);
            System.out.println("musicItem = " + movieItem);
        }
    }
}

@Getter
@Setter
@AllArgsConstructor
class MovieDto {
    private Long musicId;
    private Long emotionId;
 //   private String emotionName;
    private String title;
    private String director;
    private String plot;
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