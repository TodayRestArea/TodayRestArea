package com.todayrestarea.user.util.kakao;

import com.todayrestarea.user.util.kakao.dto.KakaoUserResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
public class KakaoClient {
    private final WebClient webClient;

    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public KakaoUserResponse getUserInfo(String accessToken) {
        return webClient.get()
                .uri("https://kapi.kakao.com/v2/user/me")
                .headers(headers -> headers.setBearerAuth(accessToken))
                .retrieve()
                .onStatus(HttpStatus::is4xxClientError, clientResponse -> Mono.error(new RuntimeException(String.format("잘못된 토큰 (%s) 입니다", accessToken))))
                .onStatus(HttpStatus::is5xxServerError, clientResponse -> Mono.error(new IllegalArgumentException(String.format("카카오 외부 API 연동 중 에러가 발생하였습니다 token: (%s)", accessToken))))
                .bodyToMono(KakaoUserResponse.class)
                .block();
    }
}
