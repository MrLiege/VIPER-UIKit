//
//  MenuEntity.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 31.10.2024.
//

import Foundation

struct MenuServer: Codable {
    let id: Int
    let name: String
    let imageURL: String
    let price: Double
}

struct MenuLocal: Hashable {
    let id: Int
    let name: String
    let imageURL: String
    let price: Double
    var quantity: Int = 0
    
    init(from menuServer: MenuServer, quantity: Int = 0) {
        self.id = menuServer.id
        self.name = menuServer.name
        self.imageURL = menuServer.imageURL
        self.price = menuServer.price
        self.quantity = quantity
    }
}

extension MenuLocal {
    var formattedPrice: String {
        return price.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", price) : String(format: "%.2f", price)
    }
}
