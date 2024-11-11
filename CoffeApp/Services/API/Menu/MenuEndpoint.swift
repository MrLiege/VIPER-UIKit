//
//  MenuEndpoint.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 31.10.2024.
//

import Foundation
import Moya

enum MenuEndpoint {
    case menu(locationId: Int)
}

extension MenuEndpoint: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://147.78.66.203:3210") else {
            fatalError("Incorrect \(self) baseURL!")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .menu(let locationId):
            return "/location/\(locationId)/menu"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .menu:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        if let token = UserStorage.shared.token {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
}
