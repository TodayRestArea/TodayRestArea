package com.todayrestarea.admin.service;

import com.todayrestarea.admin.model.entity.Weather;
import com.todayrestarea.admin.repository.WeatherRepository;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@Getter
@Setter
@RequiredArgsConstructor
public class WeatherServiceImpl implements WeatherService{
    final private WeatherRepository weatherRepository;

    @Override
    public Optional<Weather> findByWeatherId(Long weatherIdx){
        return weatherRepository.findById(weatherIdx);
    }
}
