//
//  LocationResponse.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import Foundation

struct LocationResponse: Codable {
    let id: Int
    let name: String
    let point: Point
}
