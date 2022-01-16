//
//  LoginModel.swift
//  haruDiary
//
//  Created by changgyo seo on 2022/01/16.
//

import Foundation


struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

struct Result: Codable {
    let accessToken: String
}
