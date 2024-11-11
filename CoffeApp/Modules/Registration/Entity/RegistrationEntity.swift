//
//  RegistrationEntity.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 06.11.2024.
//

import Foundation

struct ServerRegistrationRequest: Codable {
    let login: String
    let password: String
}

struct ServerRegistrationResponse: Codable {
    let token: String
    let tokenLifetime: Int
}
