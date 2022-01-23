package com.todayrestarea.user.service;

import com.todayrestarea.common.dto.BaseException;
import com.todayrestarea.user.entity.User;
import com.todayrestarea.user.repository.UserRepository;
import com.todayrestarea.user.service.dto.LoginRequest;
import com.todayrestarea.user.service.dto.LoginResponse;
import com.todayrestarea.user.util.jwt.JwtAuthTokenProvider;
import com.todayrestarea.user.util.jwt.dto.AuthTokenPayload;
import com.todayrestarea.user.util.kakao.KakaoClient;
import com.todayrestarea.user.util.kakao.dto.KakaoUserResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{

    private final UserRepository userRepository;
    private final KakaoClient kakaoClient;
    private final JwtAuthTokenProvider jwtAuthTokenProvider;

    public LoginResponse handleAuth(LoginRequest request) {
        KakaoUserResponse userInfo = kakaoClient.getUserInfo(request.getAccessToken());
        User user = userRepository.findByOauthId(userInfo.getId());
        if(user == null){
            user = signUpUser(userInfo);
        }
        String accessToken = jwtAuthTokenProvider.createAccessToken(AuthTokenPayload.of(user.getUserId()));
        String refreshToken = jwtAuthTokenProvider.createRefreshToken();
        user.updateRefreshToken(refreshToken);
        return LoginResponse.of(accessToken, refreshToken);
    }

    private User signUpUser(KakaoUserResponse userInfo) {
        User newUser = User.newKaKaoInstance(userInfo.getId(), userInfo.getNickName(), userInfo.getAge_range(), userInfo.getGender());
        return userRepository.save(newUser);
    }

    public Optional<User> findUserByToken(String jwtToken) throws BaseException {
        Long userId = jwtAuthTokenProvider.getPayload(jwtToken).getUserId();
        return userRepository.findById(userId);
    }

    public Optional<User> findById(Long userId){
        return userRepository.findById(userId);
    }
}
