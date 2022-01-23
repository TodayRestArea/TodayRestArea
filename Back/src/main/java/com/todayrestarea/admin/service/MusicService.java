package com.todayrestarea.admin.service;

import com.todayrestarea.admin.model.dto.MusicRequest;
import com.todayrestarea.admin.model.entity.Music;

import java.util.List;
import java.util.Optional;

public interface MusicService {
    //MUSIC service
    Optional<Music> findById(Long id);
    List<Music> findMusics();
    Long  saveMusic(MusicRequest musicRequest);
    void deleteMusic(Long musicIdx);
    Optional<Music> isExist(String title, String artist);
}
