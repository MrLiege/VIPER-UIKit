//
//  LocationEndpoint.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import Moya
import Foundation

enum LocationEndpoint {
    case locations
}

extension LocationEndpoint: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "http://147.78.66.203:3210") else {
            fatalError("Incorrect \(self) baseURL!")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .locations:
            return "/locations"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .locations:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        if let token = UserStorage.shared.token {
            print("Using token: \(token)")
            headers["Authorization"] = "Bearer \(token)"
        } else {
            print("No token available")
        }
        return headers
    }
}
