package com.todayrestarea.admin.service;

import com.todayrestarea.admin.model.dto.MovieRequest;
import com.todayrestarea.admin.model.entity.Movie;

import java.util.List;
import java.util.Optional;

public interface MovieService {
    //MOVIE service
    Optional<Movie> findById(Long id);
    List<Movie> findMovies();
    Long saveMovie(MovieRequest movieRequest) throws Exception;
    void deleteMovie(Long idx);
    Optional<Movie> isExist(String title,String director);
}
