package com.todayrestarea.admin.repository;

import com.todayrestarea.admin.model.entity.Emotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface JpaEmotionRepository extends JpaRepository<Emotion,Long> {
    Optional<Emotion> findEmotionByName(@Param("emotion_name")String name);
}
