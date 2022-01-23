package com.todayrestarea.admin.api;

import com.todayrestarea.admin.model.dto.AdminResponse;
import com.todayrestarea.admin.model.dto.MovieListResponse;
import com.todayrestarea.admin.model.dto.MovieRequest;
import com.todayrestarea.admin.model.dto.MusicListResponse;
import com.todayrestarea.admin.model.entity.Movie;
import com.todayrestarea.admin.service.MovieService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/movies")
public class MovieApi {
    final private MovieService movieService;
    @GetMapping("")
    @ResponseBody
    public AdminResponse movieList(){
        AdminResponse res = new AdminResponse();
        try{
            List<Movie> movies = movieService.findMovies();
            if(movies.size()==0){
                res.setMessage("success but data empty");
            }
            MovieListResponse movieRes = new MovieListResponse(movies);
            res.setResult(movieRes.getDtoList());
        }catch(Exception e){
            res.setCode(404);
            res.setSuccess(false);
            res.setMessage(e.getMessage());
        }finally {
            return res;
        }
    }
    @PostMapping("")
    @ResponseBody
    public AdminResponse movieAdd(@RequestBody MovieRequest movieRequest) {
        AdminResponse res = new AdminResponse();
        try {
            Movie movie =new Movie();
            Optional<Movie> isExist = movieService.isExist(movieRequest.getMovieTitle(), movieRequest.getMovieDirector());
            if (isExist.isPresent()) {
                throw new Exception("이미 존재하는 영화-감독명 입니다");
            }else{
                Long idx=movieService.saveMovie(movieRequest);
                Map<String,Long> result=new HashMap<>();
                result.put("movieId",idx);
                res.setResult(result);
            }
        } catch (Exception e) {
            res.setCode(404);
            res.setSuccess(false);
            res.setMessage(e.getMessage());
        } finally {
            return res;
        }
    }
    @DeleteMapping("/{id}")
    @ResponseBody
    public AdminResponse movieDelete(@PathVariable(value = "id")Long movieIdx) {
        AdminResponse res = new AdminResponse();
        try {
            movieService.deleteMovie(movieIdx);
            //res.setResult();
        } catch (Exception e) {
            res.setCode(404);
            res.setSuccess(false);
            res.setMessage(e.getMessage());
        } finally {
            return res;
        }
    }
}
