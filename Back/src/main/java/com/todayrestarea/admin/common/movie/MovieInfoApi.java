package com.todayrestarea.admin.common.movie;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.todayrestarea.admin.common.music.MusicInfoResponse;
import com.todayrestarea.admin.common.music.PosterImage;
import com.todayrestarea.admin.model.entity.Movie;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.transaction.Transactional;
import java.util.*;

@Component
@Transactional
public class MovieInfoApi {

    public Optional<MovieInfoResponse> getMovieInfo(String title,String director){
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
        HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
        List<MovieInfoResponse> movieInfoResponse=new ArrayList<>();
        try {
            ResponseEntity<String> s = restTemplate.exchange(
                            "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=5188A741E08K7NG7W9NG" +
                                    "&detail=Y" +
                                    "&query="+title+" "+director +
                                    "&listCount=1" //TODO env에 key 저장
                            , HttpMethod.GET, entity, String.class);
            /**
             * parse json
             */
            String res = s.getBody().toString();
            ObjectMapper om = new ObjectMapper();

            Map<String, String> APIresult = om.readValue(res, Map.class);
            if(APIresult.get("TotalCount")=="0"){
                System.out.println("noValue for = " + APIresult.toString());
                return null;
            }
            System.out.println(1);
                    //json을 instance로 바꾸는게 잘안돼서 깡으로함~

            Map<String, List<//Data[{
                    Map<String,List//Result[{
                            <Map<String, String>>>>>
                    infoJson=om.readValue(res, HashMap.class);
            Map<String, List<//Data[{
                            Map<String,List//Result[{
                                    <Map<String,//plots{
                                            Map<String, List//plot[{
                                                    <Map<String,String>>>>>>>> //{plotLang:"",plotText:""}
                    plotJson=om.readValue(res, HashMap.class);

            Map<String,String> movieInfo=infoJson.get("Data").stream().findFirst().get().get("Result").stream().findFirst().get();
            List<Map<String,String>> plotInfo=plotJson.get("Data").stream().findFirst().get().get("Result").stream().findFirst().get().get("plots").get("plot");

            /**
             * ready to init res
             */
            String movieDirector=plotJson.get("Data").stream().findFirst().get()
                    .get("Result").stream().findFirst().get()
                    .get("directors").get("director").stream().findFirst().get()
                    .get("directorNm").replace("!HE","").replace("!HS","").trim();
            String movieTitle= movieInfo.get("title").replace("!HE"," ").replace("!HS"," ").trim();
            String moviePosterUrl[]= movieInfo.get("posters").replace("|","").split("http://");
            String movieInfoUrl=movieInfo.get("kmdbUrl");
            String moviePlot=plotInfo.stream().findFirst().get().get("plotText");

            /**
             * init res
             */
            movieInfoResponse.add(new MovieInfoResponse(movieTitle,movieDirector,"http://"+moviePosterUrl[1], movieInfoUrl, moviePlot));

            System.out.println("movieInfoResponse.toString() = " + movieInfoResponse.toString());
          } catch (Exception e) {
            System.out.println("At MovieAPI"+" \nreq ERROR message: "+"No movie in KMDB");
            System.out.println("director = " + director);
            System.out.println("title = " + title);

        }finally {
            //return resultList.stream().findFirst();
            return movieInfoResponse.stream().findAny();
        }
        
    }

    public static void main(String[] args) {
        MovieInfoApi movApi=new MovieInfoApi();
        Optional<MovieInfoResponse> ms=movApi.getMovieInfo("Special Delivery","teuk-song");
        if(ms.isPresent())
        System.out.println("ms.get().toString() = " + ms.get().toString());
        else{
            System.out.println("\"NULL\" = " + "NULL");
        }
    }
}
