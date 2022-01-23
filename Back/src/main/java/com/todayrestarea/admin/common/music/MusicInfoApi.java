package com.todayrestarea.admin.common.music;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Component
public class MusicInfoApi {

    /**
     * 20220115 yts
     * @param title : 노래 제목
     * @param artist : 가수 이름
     * @return {
     *     제목,
     *     가수,
     *     노래 url,
     *     [포스터 리스트 -> 없으면 빈거 , 있으면 ( size , post url)]
     * }
     */
    public Optional<MusicInfoResponse> getMusicInfo(String title,String artist){
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
        HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
        List<MusicInfoResponse> resultList=new ArrayList<>();
        try {
            ResponseEntity<String> s = restTemplate
                    .exchange(
                            "https://ws.audioscrobbler.com/2.0/"
                                    + "?limit="+3
                                    + "&method=track.getInfo"
                                    + "&artist="+artist
                                    + "&track="+title
                                    + "&api_key=92bb2a282b598563622ecc43dc4d14ac" //TODO env에 key 저장
                                    + "&format=json"
                            , HttpMethod.GET, entity, String.class);
            //convert response json to HASH MAP<string,obj>
            String res = s.getBody().toString();
            System.out.println("++++++++music api res\n"+res+"\n++++++++++");

            //json을 instance로 바꾸는게 잘안돼서 깡으로함~
            ObjectMapper om = new ObjectMapper();
            Map<String,Map<String,Object>> trackObj=om.readValue(res, Map.class);
            Map<String,Map<String,Map<String,String>>> artistObj=om.readValue(res, Map.class);
            Map<String,Map<String,Map<String,String>>> albumObj = om.readValue(res, Map.class);
            Map<String,Map<String,Map<String,List<Map<String,String>>>>> imgObj = om.readValue(res, Map.class);

            //@YTS 혹시 나중에 엘범정보가 필요할수 있을것같아 선언
            Map<String,String> album=albumObj.get("track").get("album");
            Map<String,Object> track=trackObj.get("track");
            List<Map<String, String>> albumImage = new ArrayList<>();
            try{
                albumImage=imgObj.get("track").get("album").getOrDefault("image",new ArrayList<>());

            }catch (Exception e){
                System.out.println("####yts#### [on load music info] no album info in last fm"+e.getMessage());
            }
            //json을 instance로 바꾸는게 잘안돼서 깡으로함~end

                List<PosterImage> posterImageList=new ArrayList<>();
               // posterImageList.add(new PosterImage("empty","empty"));
                for (Map<String,String> poster:albumImage){
                    String posterSize=poster.get("size").toString();
                    String posterUrl=poster.get("#text").toString();
                    posterImageList.add(new PosterImage(posterUrl,posterSize));
                }

                String att=artistObj.get("track").get("artist").get("name");
                String url=track.get("url").toString();
                String nm=track.get("name").toString();
                MusicInfoResponse cur=new MusicInfoResponse(nm,att,url,posterImageList);
                resultList.add(cur);
        } catch (Exception e) {
            System.out.println("At MusicInfoApi.getMusicInfo"+" \nreq ERROR message: "+e.getMessage());
        }finally {
            return resultList.stream().findFirst();
        }

    }

    public static void main(String[] args) {
        MusicInfoApi m=new MusicInfoApi();
        Optional<MusicInfoResponse> musicInfo = m.getMusicInfo("0310", "백예린");
        System.out.println("#########\n#######\nmusicInfo = " + musicInfo.toString());
    }
}
