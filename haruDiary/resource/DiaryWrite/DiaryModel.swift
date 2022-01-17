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
    let diaryIdx: Int?
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
    let emotionID: Int?
    let recommendMusicList: [RecommendMusicList]?
    let recommendMovieList: [RecommendMovieList]?

    enum CodingKeys: String, CodingKey {
        case createdDate
        case emotionID
        case recommendMusicList, recommendMovieList
    }
}


// MARK: - RecommendMovieList
struct RecommendMovieList: Codable {
    let title, poster, url: String?
}

// MARK: - RecommendMusicList
struct RecommendMusicList: Codable {
    let title, artist, poster: String?
}
