//
//  ServerLoginEntity.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import Foundation

struct ServerLoginRequest: Codable {
    let login: String
    let password: String
}

struct ServerLoginResponse: Codable {
    let token: String
    let tokenLifetime: Int
}
