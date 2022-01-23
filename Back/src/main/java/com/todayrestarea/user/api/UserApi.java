package com.todayrestarea.user.api;

import com.todayrestarea.common.dto.ComResponseDto;
import com.todayrestarea.user.service.UserService;
import com.todayrestarea.user.service.dto.LoginRequest;
import com.todayrestarea.user.service.dto.LoginResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class UserApi {
    private final UserService userService;

    @PostMapping("/oauth/kakao")
    public ComResponseDto<LoginResponse> kakaoLogin(@RequestBody LoginRequest request) {
        return ComResponseDto.success(userService.handleAuth(request));
    }
}
