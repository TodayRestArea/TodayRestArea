package com.todayrestarea.admin.service;

import com.todayrestarea.admin.model.entity.Emotion;

import java.util.List;
import java.util.Optional;

public interface EmotionService {
    //EMOTION service

    List<Emotion> findEmotions();
    Long saveEmotion(Emotion emotion);
    void deleteEmotion(Long idx);
    Optional<Emotion> findEmotionByName(String name);
    Optional<Emotion> findEmotionById(Long id);
}
