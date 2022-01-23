package com.todayrestarea.admin.service;

import com.todayrestarea.admin.model.entity.Weather;
import java.util.Optional;

public interface WeatherService {
    Optional<Weather> findByWeatherId(Long weatherIdx);
}
