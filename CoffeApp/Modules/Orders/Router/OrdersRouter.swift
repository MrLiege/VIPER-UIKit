//
//  OrdersRouter.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 01.11.2024.
//

import Foundation
import UIKit

protocol OrdersRouterProtocol: AnyObject {
    static func createModule(with orders: [MenuLocal]) -> UIViewController
}

class OrdersRouter: OrdersRouterProtocol {
    static func createModule(with orders: [MenuLocal]) -> UIViewController {
        let view = OrdersViewController()
        let presenter = OrdersPresenter()
        let interactor = OrdersInteractor()
        let router = OrdersRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        presenter.orders = orders

        return view
    }
}

