package com.todayrestarea.user.util.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.todayrestarea.common.dto.BaseException;

import com.todayrestarea.user.util.jwt.dto.AuthTokenPayload;
import org.springframework.stereotype.Component;

import java.util.Date;

import static com.todayrestarea.common.ErrorCode.TOKEN_EXPIRED_EXCEPTION;
import static com.todayrestarea.common.ErrorCode.UNAUTHORIZED_EXCEPTION;

@Component
public class JwtAuthTokenProvider {

    private static final String JWT_SECRET = "secretKey";

    private static final int JWT_EXPIRATION_MS = 604800000;


    public String createAccessToken(AuthTokenPayload payload) {
        try {
            Date now = new Date();
            Date expiresAt = new Date(now.getTime() + JWT_EXPIRATION_MS);

            return JWT.create()
                    .withIssuer("test")
                    .withClaim("user_id", payload.getUserId())
                    .withIssuedAt(now)
                    .withExpiresAt(expiresAt)
                    .sign(Algorithm.HMAC256(JWT_SECRET));
        } catch (JWTCreationException exception) {
            throw new IllegalArgumentException("액세스 토큰을 만드는 중 에러가 발생하였습니다");
        }
    }


    public AuthTokenPayload getPayload(String accessToken) throws BaseException {
        JWTVerifier verifier = JWT.require(Algorithm.HMAC256(JWT_SECRET))
                .withIssuer("test")
                .build();
        try {
            DecodedJWT jwt = verifier.verify(accessToken);
            return AuthTokenPayload.of(jwt.getClaim("user_id").asLong());
        }  catch (TokenExpiredException exception) {
            throw new BaseException(TOKEN_EXPIRED_EXCEPTION);
        } catch (JWTVerificationException exception) {
            throw new BaseException(UNAUTHORIZED_EXCEPTION);
        }
    }

    public String createRefreshToken() {
        try {
            Date now = new Date();
            Date expiresAt = new Date(now.getTime() + JWT_EXPIRATION_MS);

            return JWT.create()
                    .withIssuer("test")
                    .withIssuedAt(now)
                    .withExpiresAt(expiresAt)
                    .sign(Algorithm.HMAC256(JWT_SECRET));
        } catch (JWTCreationException exception) {
            throw new IllegalArgumentException("refresh 토큰을 만드는 중 에러가 발생하였습니다");
        }
    }
}
