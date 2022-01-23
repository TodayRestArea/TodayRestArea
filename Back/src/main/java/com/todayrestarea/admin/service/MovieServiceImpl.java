package com.todayrestarea.admin.service;
import com.todayrestarea.admin.common.emotion.EmotionAnalysisApi;
import com.todayrestarea.admin.common.movie.MovieInfoApi;
import com.todayrestarea.admin.common.movie.MovieInfoResponse;
import com.todayrestarea.admin.common.music.MusicInfoApi;
import com.todayrestarea.admin.common.music.MusicInfoResponse;
import com.todayrestarea.admin.model.dto.MovieRequest;
import com.todayrestarea.admin.model.entity.Emotion;
import com.todayrestarea.admin.model.entity.Movie;
import com.todayrestarea.admin.model.entity.Music;
import com.todayrestarea.admin.repository.JpaEmotionRepository;
import com.todayrestarea.admin.repository.JpaMovieRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Getter
@Setter
@RequiredArgsConstructor
public class MovieServiceImpl implements MovieService {
    final private JpaMovieRepository movieRepo;
    final private JpaEmotionRepository emotionRepo;
    final private MovieInfoApi movieInfoApi;
    //MOVIE serviceImple
    @Override
    public List<Movie> findMovies(){
        return movieRepo.findAll();
    }
    @Override
    public Optional<Movie> findById(Long id){
        return movieRepo.findById(id);
    }
    @Override
    public Optional<Movie> isExist(String title,String director){
        Optional<MovieInfoResponse> movieInfoResponse=movieInfoApi.getMovieInfo(title,director);
        /**
         * "요청이 영어로 들어올수도 있다. 한국영화도 영어제목으로 " -최예림-
         * 영어제목과 한국어제목 동기화
         */
        if(movieInfoResponse.isEmpty()){
            return movieRepo.checkExistence(title, director);
        }else{
            System.out.println("movieInfoResponse.get().getTitle()+\"\\n\"+movieInfoResponse.get().getDirector() = " + movieInfoResponse.get().getTitle()+"\n"+movieInfoResponse.get().getDirector());
            return movieRepo.checkExistence(movieInfoResponse.get().getTitle(), movieInfoResponse.get().getDirector());
        }
    }
    @Override
    public Long saveMovie(MovieRequest movieRequest)throws Exception{

        Optional<Movie> checkExistence = this.isExist(movieRequest.getMovieTitle(), movieRequest.getMovieDirector());
        //이미 존재시 인덱스 반환
        if (checkExistence.isPresent()) {
            return checkExistence.get().getMovieId();
        }


        Optional<MovieInfoResponse> miResponse=movieInfoApi.getMovieInfo(
                movieRequest.getMovieTitle(),
                movieRequest.getMovieDirector()
        );
        //검색결과 없을시 -1반환
        System.out.println("miResponse.toString() = " + miResponse.toString());
        if(miResponse.isEmpty()){
            return -1l;
        }else{
            Movie movie=new Movie();
            Optional<Emotion> emotion=emotionRepo.findById(movieRequest.getEmotionId());
            if(emotion.isPresent()){
                movie.setTitle(miResponse.get().getTitle());
                movie.setDirector(miResponse.get().getDirector());
                movie.setPlot(miResponse.get().getPlot());
                movie.setPosterUrl(miResponse.get().getPosterUrl());
                movie.setInfoUrl(miResponse.get().getInfoUrl());
                movie.setEmotion(emotion.get());
                Movie resIdx=movieRepo.save(movie);
            }else{
                return null;
            }
            //받은 정보 이용한 entity 초기화
            System.out.println("musicEntity.toString() = " + movie.toString());
            return movie.getMovieId();
        }
    }
    @Override
    public void deleteMovie(Long idx){
        movieRepo.delete(movieRepo.findById(idx).get());
    }
}
