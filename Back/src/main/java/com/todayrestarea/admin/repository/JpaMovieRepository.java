package com.todayrestarea.admin.repository;

import com.todayrestarea.admin.model.entity.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface JpaMovieRepository extends JpaRepository<Movie,Long> {
    Optional<Movie> checkExistence(@Param("title")String title, @Param("director")String director);
}
