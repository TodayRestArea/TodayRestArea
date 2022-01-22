# 하루 휴게소 Backend

## 🪜 디렉토리 구조

```
.
└─src
    └─main
       ├─java
       │  └─com
       │      └─todayrestarea
       │          │  TodayrestareaApplication.java
       │          │
       │          ├─admin
       │          │  ├─api
       │          │  │      EmotionApi.java
       │          │  │      MovieApi.java
       │          │  │      MusicApi.java
       │          │  │
       │          │  ├─common
       │          │  │  ├─emotion
       │          │  │  │      EmotionAnalysisApi.java
       │          │  │  │      EmotionAnalysisResponse.java
       │          │  │  │      MovieApiDto.java
       │          │  │  │      MusicApiDto.java
       │          │  │  │
       │          │  │  ├─movie
       │          │  │  │      .keep
       │          │  │  │      MovieInfoApi.java
       │          │  │  │      MovieInfoResponse.java
       │          │  │  │
       │          │  │  └─music
       │          │  │          MusicInfoApi.java
       │          │  │          MusicInfoResponse.java
       │          │  │          PosterImage.java
       │          │  │
       │          │  ├─model
       │          │  │  ├─dto
       │          │  │  │      AdminResponse.java
       │          │  │  │      EmotionRequest.java
       │          │  │  │      EmotionResponse.java
       │          │  │  │      MovieListResponse.java
       │          │  │  │      MovieRequest.java
       │          │  │  │      MusicListResponse.java
       │          │  │  │      MusicRequest.java
       │          │  │  │
       │          │  │  └─entity
       │          │  │          Emotion.java
       │          │  │          Movie.java
       │          │  │          Music.java
       │          │  │          Weather.java
       │          │  │
       │          │  ├─repository
       │          │  │      JpaEmotionRepository.java
       │          │  │      JpaMovieRepository.java
       │          │  │      JpaMusicRepository.java
       │          │  │      WeatherRepository.java
       │          │  │
       │          │  └─service
       │          │          EmotionService.java
       │          │          EmotionServiceImpl.java
       │          │          MovieService.java
       │          │          MovieServiceImpl.java
       │          │          MusicService.java
       │          │          MusicServiceImpl.java
       │          │          WeatherService.java
       │          │          WeatherServiceImpl.java
       │          │
       │          ├─common
       │          │  │  ErrorCode.java
       │          │  │
       │          │  └─dto
       │          │          BaseException.java
       │          │          ComResponseDto.java
       │          │
       │          ├─config
       │          │      WebClientConfig.java
       │          │
       │          ├─diary
       │          │  ├─api
       │          │  │      DiaryAnalysisApi.java
       │          │  │      DiaryApi.java
       │          │  │
       │          │  ├─entity
       │          │  │      Diary.java
       │          │  │
       │          │  ├─model
       │          │  │      DiaryAnalysis.java
       │          │  │      DiaryListRes.java
       │          │  │      DiaryRes.java
       │          │  │      GetDiaryDetail.java
       │          │  │      PostDiaryRequest.java
       │          │  │      PutDiaryRequest.java
       │          │  │      RecommendMovie.java
       │          │  │      RecommendMusic.java
       │          │  │
       │          │  ├─repository
       │          │  │      DiaryRepository.java
       │          │  │
       │          │  └─service
       │          │          DiaryAnalysisService.java
       │          │          DiaryAnalysisServiceImpl.java
       │          │          DiaryService.java
       │          │          DiaryServiceImpl.java
       │          │
       │          ├─user
       │          │  ├─api
       │          │  │      UserApi.java
       │          │  │
       │          │  ├─entity
       │          │  │      User.java
       │          │  │
       │          │  ├─repository
       │          │  │      UserRepository.java
       │          │  │
       │          │  ├─service
       │          │  │  │  UserService.java
       │          │  │  │  UserServiceImpl.java
       │          │  │  │
       │          │  │  └─dto
       │          │  │          LoginRequest.java
       │          │  │          LoginResponse.java
       │          │  │
       │          │  └─util
       │          │      ├─jwt
       │          │      │  │  JwtAuthTokenProvider.java
       │          │      │  │
       │          │      │  └─dto
       │          │      │          AuthTokenPayload.java
       │          │      │
       │          │      └─kakao
       │          │          │  KakaoClient.java
       │          │          │
       │          │          └─dto
       │          │                  KakaoUserResponse.java
       │          │
       │          └─utils
       │                  ValidationRegex.java
       │
       └─resources
               application.properties
```
## 📑 기획 및 설계
- [API 명세서](https://documenter.getpostman.com/view/18937607/UVXjJbJ8)

- DB erd
![](https://images.velog.io/images/pjoon357/post/6db83814-486b-4eca-b619-e6135085483e/image.png)
