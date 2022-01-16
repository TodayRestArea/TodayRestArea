//
//  MainModel.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/16.
//

import Foundation

struct ReponseCalendar : Codable {
    let isSuccess: Bool?
    let code : Int?
    let message : String?
    let result : [Diary]?
}

struct Diary : Codable {
    let createdAt : String?
    let isanalyzed : String?
    let emotionIdx : String?
    let diaryIdx : Int?
    let weatherIdx: Int?
    let contents: String?
}

struct ReponseDetailCalendar : Codable {
    let isSuccess: Bool?
    let code : Int?
    let message : String?
    let result : Diary?
}


