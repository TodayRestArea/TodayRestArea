package com.todayrestarea.user.util.kakao.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.todayrestarea.user.util.kakao.KakaoClient;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@Getter
@NoArgsConstructor
public class KakaoUserResponse {
    private String id;
    private Properties properties;
    private Kakao_account kakao_account;

    @ToString
    @Getter
    @NoArgsConstructor
    @JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
    private static class Properties {
        private String nickname;
    }
    @ToString
    @Getter
    @NoArgsConstructor
    @JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
    private static class Kakao_account {
        private String age_range;
        private String gender;
    }

    public String getNickName() {
        return this.properties.getNickname();
    }

    public String getAge_range() {
        return this.kakao_account.getAge_range();
    }

    public String getGender() {
        return this.kakao_account.getGender();
    }
}
