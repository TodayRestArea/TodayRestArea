package com.todayrestarea.admin.repository;

import com.todayrestarea.admin.model.entity.Weather;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WeatherRepository  extends JpaRepository<Weather,Long> {
}
