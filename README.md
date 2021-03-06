### 목차
1. [🗓️ 서비스 소개](#%EF%B8%8F-서비스-소개)
2. [🌞 Flow](#flow)
3. [⏰ 개발 기간](#-개발-기간-20220108--20220123)
4. [✨ 주요기능 소개](#-주요기능-소개)
5. [🛠️ 기술스택](#%EF%B8%8F-기술스택)
6. [📚 Readme 모음집](#-readme-모음집)
7. [✏️ 기획 및 설계](#%EF%B8%8F-기획-및-설계)
8. [👨‍👩‍👦‍👦 휴게소직원들 소개](#-팀-소개-휴게소-직원들)
---
# 2022 슈퍼챌린지 SW 해커톤
[💻 해커톤 설명페이지](https://flannel-partridge-7fc.notion.site/2022-SW-074561ff13cf4541906eb6767e7e4706)
본 프로젝트는 인하대학교 2022 슈퍼챌린지 SW 해커톤 프로젝트임을 밝힙니다.

# 🗓️ 서비스 소개

![](https://user-images.githubusercontent.com/70425378/150645689-85ac38ad-7d78-448b-a069-bb6cf9171fa2.PNG)

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
![](https://user-images.githubusercontent.com/70425378/150645708-1cff9062-182f-47eb-aab9-400b5ae00c27.png)

## ⏰ 개발 기간 (2022.01.08 ~ 2022.01.23)      
기획 및 디자인 : 2022.01.08 ~ 2022.01.13    
개발 : 2022.01.14 ~ 2022.01.23

## ✨ 주요기능 소개
<img src="https://user-images.githubusercontent.com/70425378/150646104-a18cd634-48a8-4db3-b874-b6a0486c4625.gif"  width="200" height="420"/>

### 1️⃣ 로그인
카카오 소셜로그인을 이용하여 사용자의 편리함을 제공하였고 로그인 후에 JWT를 반환하였습니다.   
로그인 시 DB에 조회하여 DB에 없는 경우 추가시켰습니다.
   
<img src="https://user-images.githubusercontent.com/70425378/150645692-33b88b49-7104-4046-8a4e-5d6f94b492b5.png"  width="200" height="420"/>

### 2️⃣ 월별 일기조회
월별 일기조회페이지는 메인페이지로 해당 월에 작성한 일기들이 보입니다.   
 분석완료한 일기는 해당 감정의 이모지가 노출되고 일기작성은 완료하였지만 분석하지 않은 일기는 "?" 이모지가 노출되도록 했습니다.   
 <img src="https://user-images.githubusercontent.com/70425378/150645697-216cd34b-78b3-40e2-802c-18ecd5c20e67.png"  width="200" height="420"/>
 
 
 ### 3️⃣ 일기 작성 및 조회
메인페이지에서 날짜를 선택하면 해당 페이지로 넘어오게 됩니다. 
일기를 작성하지 않았다면 빈 텍스트뷰와 "Save"버튼이 보이고  
이미 일기를 작성했다면 저장된 일기와 "Analyze"버튼이 보입니다.  
<img src="https://user-images.githubusercontent.com/70425378/150645703-27443d56-f4ca-481b-a7d5-bd01e9c63f40.png"  width="200" height="420"/>
 
 ### 4️⃣ 일기 분석
 작성한 일기 상세보기 페이지에서 "Analyze"버튼을 누르면 작성된 일기를 분석하여
 감정을 정의해 주고 감정에 맞는 음악, 영화컨텐츠를 추천하여 감정해소 기회를 제공합니다. 영화와 음악은 모두 리뷰의 감정을 분석하여 분류했습니다. 또한 음악, 영화 컨텐트를 누르면 컨텐츠 상세페이지로 넘어가게 되고 이는 모두 Open API를 사용했습니다.   
<img src="https://user-images.githubusercontent.com/70425378/150645704-21c32eb5-387e-4fde-9ac8-9bd65cc806ce.png"  width="200" height="420"/>


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
- AI   
    - keras
    - pytorch
    - tensorflow
    - wandb
    - matplotlib
    - aws (ec2)
    
## 📚 Readme 모음집
IOS :  https://github.com/TodayRestArea/TodayRestArea_IOS/blob/main/README.md     
BackEnd : https://github.com/TodayRestArea/TodayRestArea_backend  
AI : https://github.com/TodayRestArea/TodayRestArea_AI

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

