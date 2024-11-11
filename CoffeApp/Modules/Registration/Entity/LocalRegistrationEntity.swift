//
//  LocalRegistrationEntity.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 07.11.2024.
//

import Foundation

struct LocalRegistrationRequest {
    let login: String
    let password: String
}

struct LocalRegistrationResponse {
    let token: String
    let tokenLifetime: Int
}
