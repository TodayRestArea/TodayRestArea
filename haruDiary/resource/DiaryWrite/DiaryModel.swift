//
//  DiaryModel.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/16.
//

import Foundation

struct SaveDiary: Codable {
    let weatherIdx: Int?
    let contents, cratedAt: String?
}

struct DiaryWriteResponse: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: ResultDiary?
}

struct ResultDiary: Codable {
    let diaryId: Int?
}

struct AnalyzeDiaryResponse: Codable {
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: contentResponse?
}

// MARK: - Result
struct contentResponse: Codable {
    let createdDate: String?
    let emotionId: Int?
    let emotionName: String?
    let recommendMusics: [RecommendMusicList]?
    let recommendMovies: [RecommendMovieList]?
}


// MARK: - RecommendMovieList
struct RecommendMovieList: Codable {
    let title, director, plot, posterUrl, infoUrl: String?
}

// MARK: - RecommendMusicList
struct RecommendMusicList: Codable {
    let title, artist, posterUrl, infoUrl: String?
}
