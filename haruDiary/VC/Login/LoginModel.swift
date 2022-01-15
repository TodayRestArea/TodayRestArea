//
//  LoginModel.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/16.
//

import Foundation

struct UserData: Codable {
    let groups: [String]
    let id, name, email: String
    let profileImage: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case groups
        case id = "_id"
        case name, email, profileImage
        case v = "__v"
    }
}

struct LoginResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LoginData
}

struct LoginData: Codable {
    let user: UserData
    let token, accessToken, refreshToken: String

    enum CodingKeys: String, CodingKey {
        case user, token
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
