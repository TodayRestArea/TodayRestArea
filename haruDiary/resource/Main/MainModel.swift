//
//  MainModel.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/16.
//

import Foundation

struct ReponseCalendar : Codable {
    let isSuccess: Bool
    let code : Int
    let message : String
    let result : [Diary]?
}

struct Diary : Codable {
    let createdDate : String?
    let emotionId : Int?
    let diaryId : Int?
}

struct ReponseDetailCalendar : Codable {
    let isSuccess: Bool?
    let code : Int?
    let message : String?
    let result : DetailDiary?
}

struct DetailDiary: Codable {
    let emotionId : Int?
    let weatherId : Int?
    let createdDate : String?
    let contents : String?
    
    
    init(emotionId: Int, weatherId: Int, createdDate: String, contents: String){
        self.emotionId = emotionId
        self.weatherId = weatherId
        self.createdDate = createdDate
        self.contents = contents
    }
    
}


