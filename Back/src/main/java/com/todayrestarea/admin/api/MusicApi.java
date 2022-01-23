package com.todayrestarea.admin.api;

import com.todayrestarea.admin.model.dto.AdminResponse;
import com.todayrestarea.admin.model.dto.MusicListResponse;
import com.todayrestarea.admin.model.dto.MusicRequest;
import com.todayrestarea.admin.model.entity.Emotion;
import com.todayrestarea.admin.model.entity.Music;
import com.todayrestarea.admin.service.EmotionService;
import com.todayrestarea.admin.service.MusicService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/musics")
public class MusicApi {
    final private MusicService musicService;
    final private EmotionService emotionService;
    @GetMapping("")
    @ResponseBody
    public AdminResponse musicList(){
        AdminResponse res = new AdminResponse();
        try{
            List<Music> musics = musicService.findMusics();
            System.out.println("musics = " + musics);
            MusicListResponse musicRes = new MusicListResponse(musics);
            if(musics.size()==0){
                res.setMessage("success but data empty");
            }
            System.out.println("musicRes = " + musicRes);
            res.setResult(musicRes.getDtoList());
        }catch(Exception e){
            res.setCode(404);
            res.setSuccess(false);
            res.setMessage(e.getMessage());
        }finally {
            return res;
        }
    }

    /**
     * @param musicRequest
     * @return
     */
    @PostMapping("")
    @ResponseBody
    public AdminResponse musicAdd(@RequestBody MusicRequest musicRequest) {
        AdminResponse res = new AdminResponse();
        try {
            Optional<Music> existEntity=musicService.isExist(
                    musicRequest.getMusicTitle(),
                    musicRequest.getMusicArtist()
            );
            if(existEntity.isPresent()){
               // res.setResult(existEntity.get());
               throw new Exception("이미 존재하는 제목-아티스트 입니다") ;
            }else{
                Optional<Emotion> emotion=emotionService.findEmotionById(musicRequest.getEmotionId());
                if(emotion.isEmpty()){
                    throw new Exception("존재하지 않는 감정 아이디 입니다") ;
                }
                Long resultIdx = musicService.saveMusic(musicRequest);
                Map<String,Long> result=new HashMap<>();
                result.put("musicId",resultIdx);
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
    public AdminResponse musicDelete(@PathVariable(value = "id")Long musicIdx) {
        AdminResponse res = new AdminResponse();
        try {
            musicService.deleteMusic(musicIdx);
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
