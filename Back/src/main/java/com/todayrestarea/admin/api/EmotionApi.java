package com.todayrestarea.admin.api;

import com.todayrestarea.admin.model.dto.AdminResponse;
import com.todayrestarea.admin.model.dto.EmotionRequest;
import com.todayrestarea.admin.model.dto.EmotionResponse;
import com.todayrestarea.admin.model.entity.Emotion;
import com.todayrestarea.admin.service.EmotionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/emotions")
public class EmotionApi {
    final private EmotionService emotionService;
    @GetMapping("")
    @ResponseBody
    public AdminResponse emotionList(){
        AdminResponse res = new AdminResponse();
        try{
            List<Emotion> emotions = emotionService.findEmotions();
            if(emotions.size()==0){
                res.setMessage("success but data empty");
            }
            EmotionResponse emotionResponse = new EmotionResponse(emotions);
            res.setResult(emotionResponse.getEmotionListDto());
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
    public AdminResponse emotionAdd(@RequestBody EmotionRequest emotionRequest) {
        System.out.println("emotionRequest.toString() = " + emotionRequest.toString());
        AdminResponse res = new AdminResponse();
        try {
            Optional<Emotion> existEntity=emotionService.findEmotionByName(
                    emotionRequest.getEmotionName()
            );

            if(existEntity.isPresent()){
                res.setResult(existEntity.get());
                throw new Exception("이미 존재하는 감정 입니다") ;
            }else{
                Emotion emotion =new Emotion();
                emotion.setEmotionName(emotionRequest.getEmotionName());
                Long resultIdx = emotionService.saveEmotion(emotion);
                Map<String,Long> result=new HashMap<>();
                result.put("emotionId",resultIdx);
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
    public AdminResponse emotionDelete(@PathVariable(value = "id")Long emotionIdx) {
        AdminResponse res = new AdminResponse();
        try {
            emotionService.deleteEmotion(emotionIdx);
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