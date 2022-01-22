![](https://images.velog.io/images/tlsrlgkrry/post/a05c66e2-ac85-45c1-855c-84840affe4dc/%ED%95%98%EB%A3%A8%ED%9C%B4%EA%B2%8C%EC%86%8C.PNG)

# 	🏠하루의 마무리, 하루 휴게소🏠 

##  💊 일기를 작성하고 감정상태를 진단받으세요!

- 일기를 작성하면 감정을 진단해줘요!    
    ➡ `객관적인 시각`으로 자신의 감정을 인지하게 해줍니다

- 감정에 맞는 음악, 영화 컨텐츠를 추천해줘요!  
	➡ `감정해소`의 기회를 제공합니다

- 감정이모티콘을 통일화하여 보여줍니다!  
	➡ `긍정적인 감정과 부정적인 감정을 구분 짓지 않았습니다`   

    
    
      
##  🏃 서비스의 시작
> 저희 "**하루휴게소**"는 코로나 장기화에 따른  사회활동  위축으로 우울감이 높아진 반면      
개인의 감정해소의 기회가 부족한 현재 오늘날의 사회에 대한 관심에서 시작된 서비스입니다.   
이러한 문제에 직면한 현대사회에 어떻게 하면 긍정적인 영향을 줄 수 있을까 
고민하였고       
결과적으로 저희는 `감정을 파악`해주고 그에 맞는 `콘텐츠를 추천`하여 감정해소의 기회를 제공하는 서비스인 하루 휴게소를 만들게 되었습니다.
   
## 🌞Flow
![](https://images.velog.io/images/tlsrlgkrry/post/7fd5cd60-2bce-4210-9b2c-abb5324c3608/%ED%95%98%EB%A3%A8%20%ED%9C%B4%EA%B2%8C%EC%86%8C%20%EC%9C%A0%EC%A0%80%ED%94%8C%EB%A1%9C%EC%9A%B0.png)

## ⏰ 개발 기간 (2022.01.08 ~ 2022.01.23)      
기획 및 디자인 : 2022.01.08 ~ 2022.01.13    
개발 : 2022.01.14 ~ 2022.01.23

## ✨ 주요기능 소개
### 1️⃣ 로그인
카카오 소셜로그인을 이용하여 사용자의 편리함을 제공하였고 로그인 후에 JWT를 반환하였습니다.   
로그인 시 DB에 조회하여 DB에 없는 경우 추가시켰습니다.
   
<img src="https://images.velog.io/images/tlsrlgkrry/post/ed01b088-e64d-4465-a102-cf4e35892eb0/KakaoTalk_20220122_233807104.png"  width="200" height="420"/>

### 2️⃣ 월별 일기조회
월별 일기조회페이지는 메인페이지로 해당 월에 작성한 일기들이 보입니다.   
 분석완료한 일기는 해당 감정의 이모지가 노출되고 일기작성은 완료하였지만 분석하지 않은 일기는 "?" 이모지가 노출되도록 했습니다.   
 <img src="https://images.velog.io/images/tlsrlgkrry/post/7e3fa315-8149-430c-b91b-012781306601/KakaoTalk_20220122_233807104_02.png"  width="200" height="420"/>
 
 
 ### 3️⃣ 일기 작성 및 조회
메인페이지에서 날짜를 선택하면 해당 페이지로 넘어오게 됩니다. 
일기를 작성하지 않았다면 빈 텍스트뷰와 "Save"버튼이 보이고  
이미 일기를 작성했다면 저장된 일기와 "Analyze"버튼이 보입니다.  
<img src="https://images.velog.io/images/tlsrlgkrry/post/c45d8e43-054a-44a0-a1af-41e332b019c9/%ED%96%89%EB%B3%B5.png"  width="200" height="420"/>
 
 ### 4️⃣ 일기 분석
 작성한 일기 상세보기 페이지에서 "Analyze"버튼을 누르면 작성된 일기를 분석하여
 감정을 정의해 주고 감정에 맞는 음악, 영화컨텐츠를 추천하여 감정해소 기회를 제공합니다. 영화와 음악은 모두 리뷰의 감정을 분석하여 분류했습니다. 또한 음악, 영화 컨텐트를 누르면 컨텐츠 상세페이지로 넘어가게 되고 이는 모두 Open API를 사용했습니다.   
<img src="https://images.velog.io/images/tlsrlgkrry/post/9b9cde1b-08c2-4379-96fb-907d5869bebb/%EB%A7%88%EC%A7%80%EB%A7%89.png"  width="200" height="420"/>


## 🛠️ 기술스택
- IOS   
   - swift
    - pakages
        - kakao API
        - Alamofire
        - SnapKit
        - Rxswift (다음 업데이트 진행시 데이터 비동기화 예정) 
- BackEnd   
   - spring
    - Mysql
    - JPA
    - aws (ec2, RDS)
    - Oauth
    - JWT
    - OPEN API
- ML   
   - keras
    - pytorch
    - tensorflow
    - wandb
    - matplotlib
    - aws (ec2)
    
## 📚 Readme 모음집
IOS :  https://github.com/TodayRestArea/TodayRestArea_IOS/blob/main/README.md   
BackEnd : https://github.com/TodayRestArea/TodayRestArea_backend  
ML : 

## ✏️ 기획 및 설계

[📌 API 명세서](https://military-wildcat-495.notion.site/API-6d692255a9f54a978caf54de4764e5f9)
[📌 ERD](https://www.erdcloud.com/d/9ZnEyAaCZRZPKS3y9)

## 👨‍👩‍👦‍👦 팀 소개 (휴게소 직원들)
|이름|포지션|깃허브 주소|
|:---:|:---:|:---:|
|최예림|ML|https://github.com/yerimch|
|서창교|IOS|https://github.com/UIMAPH|
|홍민주|Spring|https://github.com/HONGMINJU|
|윤태성|Spring|https://github.com/taesung320|
|박병준|Spring|https://github.com/pjoon357|

