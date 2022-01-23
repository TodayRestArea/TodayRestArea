package com.todayrestarea.user.service;

import com.todayrestarea.common.dto.BaseException;
import com.todayrestarea.user.entity.User;
import com.todayrestarea.user.service.dto.LoginRequest;
import com.todayrestarea.user.service.dto.LoginResponse;

import java.util.Optional;

public interface UserService {
    LoginResponse handleAuth(LoginRequest requestDto);
    Optional<User> findUserByToken(String jwtToken) throws BaseException;
    Optional<User> findById(Long userId);
}
