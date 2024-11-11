//
//  LocalLoginEntity.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 28.10.2024.
//

import Foundation

struct LocalLoginRequest {
    let login: String
    let password: String
}

struct LocalLoginResponse {
    let token: String
    let tokenLifetime: Int
}
