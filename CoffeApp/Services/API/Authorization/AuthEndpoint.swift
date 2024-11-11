//
//  AuthEndpoint.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import Moya
import Foundation

enum AuthEndpoint {
    case login(login: String, password: String)
    case registration(login: String, password: String)
}

extension AuthEndpoint: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://147.78.66.203:3210") else {
            fatalError("Incorrect \(self) baseURL!")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .registration:
            return "auth/register"
        }
    }
    
    var method: Moya.Method {
        .post
    }
    
    var task: Moya.Task {
        switch self {
        case let .login(login, password),
            let .registration(login, password):
            return .requestParameters(
                parameters: ["login": login, "password": password],
                encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
}
