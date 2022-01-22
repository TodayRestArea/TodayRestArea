# TodayRestArea_IOS
## ⏰ 개발 기간
 - 2021.01.14 ~ 2021.01.21
 - 계속해서 업데이트 예정
 
## ⚙️ 기술 스택
- swift
- pakages
  - kakao API
  - Alamofire
  - SnapKit
  - Rxswift (다음 업데이트 진행시 데이터 비동기화 예정)

## 🤓 기획 및 설계
> Font

- 온글잎 보현체
- NotCliche OTF
- CookieRun Bold
- JalnanOTF
- SANGJU-Gotgam

>Resource


 # Network
 - APIConstants 
   - 네트워크에 사용되는 변수 저장
   - http 요청에 header 형식 저장
   - URL 명시
   - ketchain을 통한 로그인 정보 로컬 저장
# Login
- LoginVC
  - 로그인 화면 UI구성
  - 로그인 관련 메소드 호출
  - 토큰 정보 확인 후 자동 로그인
- LoginService
  - 로그인 관련 메소드 정의
  - 호출된 인자를 파라미터 형태로 변환
  - response를 로그인 모델로 json parsing
  - statuscode로 오류 검출
- LoginModel
  - 로그인 request 모델 정의
  - 로그인 response 모델 정의
# Main
- MainVC
  - 메인 화면인 달력 화면 UI구성
  - 달력 관련 메소드 호출
  - 계획서를 통해 특정 행동 제약조건 호출 및 정의
- MainSevice
  - 달력 관련 메소드 정의
  - 호출된 인자를 파라미터 형태로 변환
  - response를 달력 모델로 json parsing
  - statuscode로 오류 검출
- MainModel
  - 달력 request 모델 정의
  - 달력 reponse 모델 정의
# DiaryWrite
- DiaryWriteVC
  - 일기 쓰기 화면 UI구성
  - 일기 쓰기 관련 메소드 호출
  - 계획서를 통해 특정 행동 제약조건 호출 및 정의
- DiaryWriteService
  - 일기 쓰기 관련 메소드 정의
  - 호출된 인자를 파라미터 형태로 변환
  - response를 일기 모델로 json parsing
  - statuscode로 오류 검출
- DiaryWriteModel
  - 일기쓰기 request 모델 정의
  - 일기쓰기 reponse 모델 정의
  - 일기분석 reponse 모델 정의
# EmotionContent
- EmotionContentCell
  - recommandMovieCell
    - 추천 영화 UI 구성
  - recommandMusicCell
    - 추천 음악 UI 구성
- EmotionContentVC
  - 일기 분석 결과 화면 UI 구성 
  - 일기 분석 관련 메소드 호출
  - 계획서를 통해 특정 행동 제약조건 호출 및 정의
