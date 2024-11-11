//
//  OrdersInteractor.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 01.11.2024.
//

import Foundation

protocol OrdersInteractorInputProtocol: AnyObject { }

protocol OrdersInteractorOutputProtocol: AnyObject { }

class OrdersInteractor: OrdersInteractorInputProtocol {
    weak var presenter: OrdersInteractorOutputProtocol?
    init() { 
        
    }
}
