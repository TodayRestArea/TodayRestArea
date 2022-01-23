package com.todayrestarea.diary.repository;

import com.todayrestarea.diary.entity.Diary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface DiaryRepository extends JpaRepository<Diary,Long> {
    @Query(value = "select * from diary where date_format(created_date, '%Y-%m') = :yearMonth and user_id = :userId", nativeQuery = true)
    List<Diary> findDiariesByCreatedDate(@Param("userId") Long userId, @Param("yearMonth") String yearMonth);
}
