//
//  CoffeeShop.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import Foundation

struct CoffeeShop: Decodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
}

struct CoffeeShopWithDistance {
    let coffeeShop: CoffeeShop
    let distance: Double
}
