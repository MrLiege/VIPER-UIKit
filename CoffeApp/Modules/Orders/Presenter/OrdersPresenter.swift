//
//  OrdersPresenter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 01.11.2024.
//

import Foundation

protocol OrdersPresenterProtocol: AnyObject {
    func viewDidLoad()
    func updateOrderQuantity(order: MenuLocal, quantity: Int)
    var orders: [MenuLocal] { get }
}

class OrdersPresenter: OrdersPresenterProtocol {
    weak var view: OrdersViewProtocol?
    var interactor: OrdersInteractorInputProtocol?
    var router: OrdersRouterProtocol?
    var orders: [MenuLocal] = []
    
    func viewDidLoad() {
        view?.showOrders(orders)
    }
    
    func updateOrderQuantity(order: MenuLocal, quantity: Int) {
        if let index = orders.firstIndex(where: { $0.id == order.id }) {
            if quantity == 0 {
                removeOrder(order: order)
            } else {
                orders[index].quantity = quantity 
                view?.showOrders(orders)
            }
        }
    }
    
    func removeOrder(order: MenuLocal) {
        if let index = orders.firstIndex(where: { $0.id == order.id }) {
            orders.remove(at: index)
            view?.showOrders(orders)
        }
    }
}

extension OrdersPresenter: OrdersInteractorOutputProtocol {}

