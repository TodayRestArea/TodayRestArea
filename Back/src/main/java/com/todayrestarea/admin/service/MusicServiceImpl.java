package com.todayrestarea.admin.service;

import com.todayrestarea.admin.common.music.MusicInfoApi;
import com.todayrestarea.admin.common.music.MusicInfoResponse;
import com.todayrestarea.admin.model.dto.MusicRequest;
import com.todayrestarea.admin.model.entity.Emotion;
import com.todayrestarea.admin.model.entity.Music;
import com.todayrestarea.admin.repository.JpaEmotionRepository;
import com.todayrestarea.admin.repository.JpaMovieRepository;
import com.todayrestarea.admin.repository.JpaMusicRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

@Service
@Getter
@Setter
@RequiredArgsConstructor
public class MusicServiceImpl implements MusicService {
    final private JpaEmotionRepository emotionRepo;
    final private JpaMusicRepository musicRepo;
    final private MusicInfoApi mi;

    //MUSIC serviceImple
    @Override
    public List<Music> findMusics(){
        return musicRepo.findAll();
    }
    @Override
    public Optional<Music> findById(Long id) {
        return musicRepo.findById(id);
    }
    /**
     *
     * @param musicRequest
     * @return
     */
    @Override
    public Long saveMusic(MusicRequest musicRequest){
        //mi : music Api
        Optional<Music> checkExistence = this.isExist(musicRequest.getMusicTitle(), musicRequest.getMusicArtist());
        if (checkExistence.isPresent()) {
            return checkExistence.get().getMusicId();
        }

        Optional<MusicInfoResponse> miResponse=mi.getMusicInfo(
                musicRequest.getMusicTitle(),
                musicRequest.getMusicArtist()
        );
        System.out.println("miResponse.toString() = " + miResponse.toString());
        if(miResponse.isEmpty()){
            return -1l;
        }else{
            Music music =new Music();
            Optional<Emotion> emotion=emotionRepo.findById(musicRequest.getEmotionId());
            if(emotion.isPresent()){
                music.setEmotion(emotion.get());
            }else{
              return null;
            }
            //받은 정보 이용한 entity 초기화
            music.setTitle(miResponse.get().getName());
            music.setArtist(miResponse.get().getArtist());
            music.setInfoUrl(miResponse.get().getUrl());
            music.setPosterUrl(miResponse.get().getPosterUrl());
            System.out.println("musicEntity.toString() = " + music.toString());
            return musicRepo.save(music).getMusicId();
        }
    }

    @Override
    public void deleteMusic(Long musicIdx) {
        Optional<Music> byId = musicRepo.findById(musicIdx);
         musicRepo.delete(byId.get());
    }

    @Override
    public Optional<Music> isExist(String title, String artist) {
        return musicRepo.checkExistence(title,artist);
    }



}
