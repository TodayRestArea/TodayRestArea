package com.todayrestarea.admin.common.emotion;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.todayrestarea.admin.common.movie.MovieInfoResponse;
import com.todayrestarea.admin.model.entity.Emotion;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Component
public class EmotionAnalysisApi {

    public Optional<EmotionAnalysisResponse> getAnalysisResult(String contents) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type","application/json");
        ObjectMapper om=new ObjectMapper();
        Map<String,String > params = new HashMap<String, String>();
        params.put("contents",contents);
        String reqBody="";
        List<EmotionAnalysisResponse> result = new ArrayList<>();
        try {
            reqBody = om.writeValueAsString(params);
            System.out.println("reqBody = " + reqBody);
        } catch (Exception e) {
            System.out.println("on parse java.map to json e.getMessage() = " + e.getMessage());
        }
        JSONPObject jsonpObject = new JSONPObject(params.toString(), Map.class);
        headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
        HttpEntity<String> entity = new HttpEntity<String>(reqBody, headers);
        System.out.println("entity.getBody() = " + entity.getBody());
        List<MovieInfoResponse> movieInfoResponse=new ArrayList<>();
        try {
            ResponseEntity<String> s = restTemplate.exchange(
                    "http://3.37.122.216:5000/predict"
                    , HttpMethod.POST, entity, String.class);
            
            String res = s.getBody().toString();
            System.out.println("resrse+++"+res);
            Map<String, Integer> emotionJson = om.readValue(res, Map.class);
            Map<String, List<Map<String, String>>> contentJson = om.readValue(res, Map.class);
            
            //READY TO RETURN
            Long emotionIdx=new Long(emotionJson.get("emotionType")+1);
            List<Map<String, String>> movieList = contentJson.get("movieList");
            List<Map<String, String>> musicList = contentJson.get("musicList");


            EmotionAnalysisResponse er = new EmotionAnalysisResponse();
            er.setEmotionId(emotionIdx);
            for (Map<String, String> movie : movieList) {
                er.getMovieList().add(new MovieApiDto(movie.get("director"), movie.get("movieTitle")));
            }
            for (Map<String, String> music : musicList) {
                er.getMusicList().add(new MusicApiDto(music.get("musicTitle"), music.get("singer")));
            }
            result.add(er);

        } catch (Exception e) {
            System.out.println("on emotion API wiht ML-server e.getMessage() = " + e.getMessage());
        }
        return result.stream().findAny();
    }

    public static void main(String[] args) {
        EmotionAnalysisApi eApi = new EmotionAnalysisApi();
        Optional<EmotionAnalysisResponse> er = eApi.getAnalysisResult("나는 오늘 기뻤다.");
        if (er.isPresent()) {
            System.out.println("성공! " + er.get().toString());
        }
    }
}

